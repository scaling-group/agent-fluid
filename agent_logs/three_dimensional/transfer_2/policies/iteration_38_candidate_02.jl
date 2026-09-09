# Compact L64 target controller: preserve redirect-priority targeting while a
# course-resolved rate-margin transfer allocates spare work to the posterior.

function target_policy_params()
    return (
        version="dogfish3d_course_resolved_posterior_margin_transfer_v1",
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.80,
        tail_damping=0.65,
        target_angle_limit=1.20,
        target_angle_gain=1.00,
        turn_rate_gain=0.42,
        turn_rate_scale=0.45,
        turn_request_scale=0.30,
        tail_curvature_limit=8.0 * pi / 180,
        head_steer_accel=3.0,
        approach_outer_distance=6.0,
        approach_inner_distance=2.0,
        closing_speed_scale=0.35,
        approach_amplitude_floor=0.58,
        approach_damping=3.0,
        approach_head_bias_limit=5.0 * pi / 180,
        approach_tail_curvature_boost=6.0 * pi / 180,
        course_speed_scale=0.12,
        course_error_scale=0.55,
        line_of_sight_lead_gain=0.30,
        redirect_head_bias_boost=9.0 * pi / 180,
        redirect_curvature_boost=14.0 * pi / 180,
        half_cycle_asymmetry=0.22,
        half_cycle_velocity_scale=0.35,
        posterior_amplitude_asymmetry=0.08,
        posterior_lag_asymmetry=0.10,
        wave_handoff_completion=0.50,
        response_handoff_gain=4.0,
        joint_rate_guard_scale=260.0 * pi / 180,
        rate_guard_onset_fraction=0.98,
        rate_guard_preview_fraction=0.02,
        rate_guard_strength=0.75,
        rate_guard_power_scale=0.25,
        posterior_margin_transfer=0.10,
        command_accel_limit=31.0,
    )
end

@inline function _policy_safe(value, fallback)
    parsed = Float64(value)
    return isfinite(parsed) ? parsed : fallback
end

@inline function _policy_soft_limit(value, limit)
    safe_limit = max(_policy_safe(limit, 1.0), eps(Float64))
    return safe_limit * tanh(_policy_safe(value, 0.0) / safe_limit)
end

@inline function _policy_wrap_angle(value)
    safe_value = _policy_safe(value, 0.0)
    return atan(sin(safe_value), cos(safe_value))
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    base_amplitude = params.oscillator_amplitude
    q1 = _policy_safe(state.phi[1], 0.0)
    q2 = _policy_safe(state.phi[2], 0.0)
    qd1 = _policy_safe(state.phi_dot[1], 0.0)
    qd2 = _policy_safe(state.phi_dot[2], 0.0)

    # Preserve fore/aft target sense. The fish advances along negative body x.
    target_x = _policy_safe(state.target_body_L[1], -1.0)
    target_y = _policy_safe(state.target_body_L[2], 0.0)
    target_angle = clamp(
        atan(target_y, -target_x),
        -params.target_angle_limit,
        params.target_angle_limit,
    )
    turn_rate = hasproperty(state, :turn_rate_recent) ?
        _policy_safe(state.turn_rate_recent, 0.0) :
        _policy_safe(state.heading_rate, 0.0)
    route_request = -params.target_angle_gain * target_angle
    rate_brake = -params.turn_rate_gain * tanh(
        turn_rate / max(params.turn_rate_scale, eps(Float64)),
    )
    turn_command = tanh(
        (route_request + rate_brake) /
        max(params.turn_request_scale, eps(Float64)),
    )

    # Reuse the sampled distance/closing allocation: it preserved propulsion
    # when far and removed beat-scale action during the closest approach.
    distance = max(
        _policy_safe(state.distance_L, params.approach_outer_distance),
        0.0,
    )
    approach_span = max(
        params.approach_outer_distance - params.approach_inner_distance,
        eps(Float64),
    )
    approach_weight = clamp(
        (params.approach_outer_distance - distance) / approach_span,
        0.0,
        1.0,
    )
    closing_speed = hasproperty(state, :closing_speed_L) ?
        _policy_safe(state.closing_speed_L, 0.0) :
        0.0
    closing_gate = tanh(
        max(closing_speed, 0.0) /
        max(params.closing_speed_scale, eps(Float64)),
    )
    drive_relief = approach_weight * closing_gate

    # Terminal redirect compares target direction with actual velocity course.
    # Recent body-frame bearing rate plus body yaw rate reconstructs inertial
    # line-of-sight rotation and leads the bounded C-bend while closing.
    velocity_x = _policy_safe(state.velocity_body_U[1], 0.0)
    velocity_y = _policy_safe(state.velocity_body_U[2], 0.0)
    course_speed = hypot(velocity_x, velocity_y)
    course_angle = atan(velocity_y, -velocity_x)
    course_error = _policy_wrap_angle(target_angle - course_angle)
    course_authority = tanh(
        course_speed / max(params.course_speed_scale, eps(Float64)),
    )
    bearing_rate = hasproperty(state, :bearing_window_rate) ?
        _policy_safe(state.bearing_window_rate, 0.0) :
        (hasproperty(state, :bearing_rate) ?
            _policy_safe(state.bearing_rate, 0.0) : 0.0)
    line_of_sight_rate = bearing_rate + turn_rate
    redirect_signal =
        -course_error / max(params.course_error_scale, eps(Float64)) +
        closing_gate * params.line_of_sight_lead_gain *
        line_of_sight_rate / max(params.turn_rate_scale, eps(Float64))
    redirect_magnitude = tanh(abs(redirect_signal))
    redirect_command = tanh(redirect_signal)
    redirect_weight =
        approach_weight * course_authority * redirect_magnitude

    amplitude_fraction =
        1.0 - drive_relief * (1.0 - params.approach_amplitude_floor)
    active_amplitude = max(
        base_amplitude * amplitude_fraction,
        eps(Float64),
    )
    head_bias =
        params.approach_head_bias_limit * approach_weight * turn_command +
        params.redirect_head_bias_boost * redirect_weight * redirect_command
    centered_q1 = q1 - head_bias

    # State-derived half-cycle asymmetry: route steering is stronger on the
    # anterior stroke aligned with the requested turn and weaker on its return.
    # Joint velocity supplies phase without a clock or route state.
    phase_velocity = qd1 / max(omega * active_amplitude, eps(Float64))
    turn_phase_alignment =
        turn_command * phase_velocity /
        max(params.half_cycle_velocity_scale, eps(Float64))
    half_cycle_scale =
        1.0 + params.half_cycle_asymmetry * tanh(turn_phase_alignment)
    # Use the sampled lower-effort posterior amplitude allocation while far,
    # then hand off to the shorter-path posterior lag allocation. Advance the
    # distance handoff only when measured yaw already follows the signed route
    # request. This state response keeps the allocation from feeding a turn
    # that is already established, without adding a clock or mean bend.
    phase_allocation = tanh(turn_phase_alignment)
    distance_wave_weight = clamp(
        approach_weight /
        max(params.wave_handoff_completion, eps(Float64)),
        0.0,
        1.0,
    )
    normalized_turn_response = tanh(
        turn_rate / max(params.turn_rate_scale, eps(Float64)),
    )
    aligned_turn_response = max(
        turn_command * normalized_turn_response,
        0.0,
    )
    # C-start-like allocation without a hidden stage: a large velocity-course
    # redirect has priority only until measured yaw follows the route request.
    # This bounded response signal later governs rhythmic carrier work while
    # leaving the target-conditioned steering residual available.
    unfulfilled_redirect =
        course_authority *
        redirect_magnitude *
        (1.0 - clamp(aligned_turn_response, 0.0, 1.0))
    response_handoff_weight = clamp(
        params.response_handoff_gain *
        approach_weight *
        (1.0 - distance_wave_weight) *
        aligned_turn_response,
        0.0,
        1.0,
    )
    near_wave_weight = clamp(
        distance_wave_weight + response_handoff_weight,
        0.0,
        1.0,
    )
    posterior_carrier_scale =
        1.0 + params.posterior_amplitude_asymmetry *
        (1.0 - near_wave_weight) * phase_allocation
    active_tail_lag = params.tail_lag_gain * (
        1.0 + params.posterior_lag_asymmetry *
        near_wave_weight * phase_allocation
    )

    vdp_drive =
        params.oscillator_mu *
        (1 - (centered_q1 / active_amplitude)^2) *
        qd1
    head_drive =
        vdp_drive -
        omega^2 * centered_q1 -
        params.approach_damping * drive_relief * qd1

    curvature_authority =
        params.tail_curvature_limit +
        params.approach_tail_curvature_boost * approach_weight
    mean_tail_tangent =
        curvature_authority * turn_command * half_cycle_scale +
        params.redirect_curvature_boost * redirect_weight * redirect_command
    tail_target =
        mean_tail_tangent -
        posterior_carrier_scale * q1 -
        active_tail_lag * qd1 / max(omega, eps(Float64))
    tail_drive =
        omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2
    raw_head_accel =
        head_drive +
        params.head_steer_accel * turn_command * half_cycle_scale

    # Separate the exact commands into a zero-mean traveling carrier and the
    # remaining target-conditioned steering. This lets the governor distinguish
    # outward rhythmic work from reversal; the residuals preserve the existing
    # mean bend, response-aware redirect, and approach feedback.
    carrier_vdp_drive =
        params.oscillator_mu *
        (1 - (q1 / active_amplitude)^2) *
        qd1
    carrier_head_accel =
        carrier_vdp_drive -
        omega^2 * q1 -
        params.approach_damping * drive_relief * qd1
    steering_head_accel = raw_head_accel - carrier_head_accel
    carrier_tail_target =
        -posterior_carrier_scale * q1 -
        active_tail_lag * qd1 / max(omega, eps(Float64))
    carrier_tail_accel =
        omega^2 * (carrier_tail_target - q2) -
        2 * params.tail_damping * omega * qd2
    steering_tail_accel = tail_drive - carrier_tail_accel

    # Anticipate rate-envelope contact from state and same-sign carrier action.
    # The preview is phase-space feedback rather than a lower scalar onset:
    # only bounded positive-work acceleration advances the projected rate.
    rate_scale = max(params.joint_rate_guard_scale, eps(Float64))
    onset_fraction = clamp(
        params.rate_guard_onset_fraction,
        0.0,
        1.0 - eps(Float64),
    )
    preview_time =
        clamp(params.rate_guard_preview_fraction, 0.0, 0.25) *
        max(params.control_period, eps(Float64))
    bounded_head_outward_accel = carrier_head_accel * qd1 > 0.0 ?
        min(abs(carrier_head_accel), params.command_accel_limit) : 0.0
    bounded_tail_outward_accel = carrier_tail_accel * qd2 > 0.0 ?
        min(abs(carrier_tail_accel), params.command_accel_limit) : 0.0
    projected_head_rate =
        abs(qd1) + preview_time * bounded_head_outward_accel
    projected_tail_rate =
        abs(qd2) + preview_time * bounded_tail_outward_accel
    head_rate_fraction =
        max(abs(qd1), projected_head_rate) / rate_scale
    tail_rate_fraction =
        max(abs(qd2), projected_tail_rate) / rate_scale
    head_rate_progress = clamp(
        (head_rate_fraction - onset_fraction) /
        max(1.0 - onset_fraction, eps(Float64)),
        0.0,
        1.0,
    )
    tail_rate_progress = clamp(
        (tail_rate_fraction - onset_fraction) /
        max(1.0 - onset_fraction, eps(Float64)),
        0.0,
        1.0,
    )
    head_rate_gate =
        head_rate_progress^2 * (3.0 - 2.0 * head_rate_progress)
    tail_rate_gate =
        tail_rate_progress^2 * (3.0 - 2.0 * tail_rate_progress)
    normalized_head_power =
        max(carrier_head_accel * qd1, 0.0) /
        max(params.command_accel_limit * rate_scale, eps(Float64))
    normalized_tail_power =
        max(carrier_tail_accel * qd2, 0.0) /
        max(params.command_accel_limit * rate_scale, eps(Float64))
    head_outward_alignment = tanh(
        normalized_head_power /
        max(params.rate_guard_power_scale, eps(Float64)),
    )
    tail_outward_alignment = tanh(
        normalized_tail_power /
        max(params.rate_guard_power_scale, eps(Float64)),
    )
    guard_strength = clamp(params.rate_guard_strength, 0.0, 1.0)
    redirect_guard =
        guard_strength *
        max(head_rate_gate, tail_rate_gate) *
        unfulfilled_redirect
    head_positive_work_guard =
        guard_strength * head_rate_gate * head_outward_alignment
    tail_positive_work_guard =
        guard_strength * tail_rate_gate * tail_outward_alignment
    head_outward_scale = 1.0 - max(
        redirect_guard,
        head_positive_work_guard,
    )

    # The sampled anterior joint is the persistent rate bottleneck while the
    # posterior retains hard-rate margin. When measured velocity course has
    # resolved the target redirect, allocate a small bounded share of the
    # throttled anterior positive-work demand to posterior carrier work. The
    # transfer vanishes at posterior guard onset and cannot alter steering.
    posterior_rate_spare = clamp(
        (onset_fraction - tail_rate_fraction) /
        max(onset_fraction, eps(Float64)),
        0.0,
        1.0,
    )
    course_resolution = 1.0 - clamp(redirect_magnitude, 0.0, 1.0)
    transfer_limit = clamp(params.posterior_margin_transfer, 0.0, 0.25)
    posterior_transfer =
        transfer_limit *
        head_rate_gate *
        head_outward_alignment *
        posterior_rate_spare *
        course_resolution
    tail_outward_scale = clamp(
        1.0 - max(redirect_guard, tail_positive_work_guard) +
            posterior_transfer,
        0.0,
        1.0 + transfer_limit,
    )

    # Decompose direction before governing. Each joint's rate/power trigger
    # withdraws its own outward carrier work. Negative-work reversal remains
    # coupled and is attenuated only by the inherited redirect-priority request.
    outward_head_carrier = carrier_head_accel * qd1 > 0.0 ?
        carrier_head_accel : 0.0
    outward_tail_carrier = carrier_tail_accel * qd2 > 0.0 ?
        carrier_tail_accel : 0.0
    reversing_head_carrier = carrier_head_accel - outward_head_carrier
    reversing_tail_carrier = carrier_tail_accel - outward_tail_carrier
    reversal_release =
        (1.0 - distance_wave_weight) *
        clamp(aligned_turn_response, 0.0, 1.0)
    reversing_carrier_scale =
        1.0 - redirect_guard * (1.0 - reversal_release)
    governed_head_accel =
        reversing_carrier_scale * reversing_head_carrier +
        head_outward_scale * outward_head_carrier +
        steering_head_accel
    governed_tail_accel =
        reversing_carrier_scale * reversing_tail_carrier +
        tail_outward_scale * outward_tail_carrier +
        steering_tail_accel

    return (
        phi_ddot=(
            _policy_soft_limit(governed_head_accel, params.command_accel_limit),
            _policy_soft_limit(governed_tail_accel, params.command_accel_limit),
        ),
    )
end
