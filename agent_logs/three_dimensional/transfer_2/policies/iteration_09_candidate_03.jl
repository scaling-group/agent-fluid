# Compact L64 target controller: retain the best sampled half-cycle carrier
# and lead its bounded course redirect with observed line-of-sight rotation.

function target_policy_params()
    return (
        version="dogfish3d_half_cycle_los_lead_redirect_v1",
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
    # line-of-sight rotation. During closing it provides a bounded lead term,
    # so the redirect responds before a rotating collision course becomes a
    # geometric miss; it adds no authority outside the existing C-bend map.
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
    redirect_weight =
        approach_weight * course_authority * redirect_magnitude
    redirect_command = tanh(
        redirect_signal,
    )

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

    # Preserve the evaluated phase allocation: route steering is stronger on
    # the anterior half-stroke aligned with the requested turn and weaker on
    # its return. Joint velocity supplies phase without a clock or route state.
    phase_velocity = qd1 / max(omega * active_amplitude, eps(Float64))
    turn_phase_alignment =
        turn_command * phase_velocity /
        max(params.half_cycle_velocity_scale, eps(Float64))
    half_cycle_scale =
        1.0 + params.half_cycle_asymmetry * tanh(turn_phase_alignment)

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
        q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(Float64))
    tail_drive =
        omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2
    raw_head_accel =
        head_drive +
        params.head_steer_accel * turn_command * half_cycle_scale

    return (
        phi_ddot=(
            _policy_soft_limit(raw_head_accel, params.command_accel_limit),
            _policy_soft_limit(tail_drive, params.command_accel_limit),
        ),
    )
end
