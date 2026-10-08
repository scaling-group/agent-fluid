# L64 3D phase-selective posterior commitment candidate. Preserve the
# evaluated carrier, anterior collision-course hold, predicted-miss corridor,
# posterior stroke reserve, and terminal phase allocation. Inside a safe
# intercept, release posterior additive route steering only on the observed
# lagged-wave half-cycle opposed to the geometric turn request; no clock,
# route, or world-frame direction enters the policy.

function target_policy_params(; L::Int=64)
    return (
        version="dogfish_target_control_v45_posterior_phase_commitment",
        L=Float64(L),
        drive_period=0.55,
        control_period=0.55,
        drive_amplitude=28.0 * pi / 180,
        drive_mu=0.35,
        drive_tail_lag_gain=0.80,
        drive_tail_damping=0.65,
        far_drive_frequency_gain=0.114,
        far_drive_turn_relief=0.36,
        progress_drive_frequency_gain=0.034,
        progress_closing_speed_scale=0.16,
        bearing_gain=3.2,
        vector_angle_gain=2.4,
        target_lateral_velocity_gain=0.20,
        bearing_trend_gain=0.70,
        bearing_trend_scale=0.110,
        turn_rate_target_gain=0.75,
        turn_rate_feedback_gain=1.25,
        turn_rate_request_scale=1.80,
        turn_rate_scale=0.22,
        redirect_request_scale=0.90,
        redirect_rate_scale=0.55,
        redirect_release_gain=0.92,
        negative_turn_request_gain=0.78,
        curvature_request_scale=2.20,
        negative_turn_curvature_gain=-10.5 * pi / 180,
        positive_turn_curvature_gain=-3.6 * pi / 180,
        curvature_veto_bearing_weight=0.50,
        curvature_veto_vector_weight=0.50,
        curvature_veto_angle_start=0.45,
        curvature_veto_angle_full=0.85,
        curvature_veto_polarity_scale=0.030,
        curvature_veto_release_gain=0.96,
        opposing_halfcycle_relief=0.68,
        intercept_forward_start=0.72,
        intercept_forward_full=0.28,
        intercept_posterior_release_start=0.45,
        intercept_posterior_release_full=0.82,
        intercept_lateral_start=0.45,
        intercept_lateral_full=0.72,
        intercept_lateral_scale=0.35,
        intercept_closing_speed_scale=0.16,
        intercept_tail_curvature_gain=-7.0 * pi / 180,
        course_preview_start_L=6.50,
        course_preview_full_L=3.50,
        course_preview_gain=0.65,
        course_speed_scale=0.20,
        course_error_scale=0.45,
        terminal_miss_safe_L=0.60,
        terminal_miss_full_L=0.90,
        terminal_course_turn_gain=1.00,
        posterior_route_direction_scale=0.20,
        posterior_route_release=0.75,
        joint_accel_priority_limit=1800.0 * pi / 180,
        tail_rate_guard_start=250.0 * pi / 180,
        tail_rate_guard_full=260.0 * pi / 180,
        tail_stroke_guard_start=36.0 * pi / 180,
        tail_stroke_guard_full=44.0 * pi / 180,
        tail_stroke_steering_scale=0.35,
        tail_stroke_priority_floor=0.85,
        recapture_behind_start=0.04,
        recapture_behind_full=0.30,
        recapture_lateral_scale=0.35,
        recapture_tail_curvature_gain=-7.0 * pi / 180,
        recapture_tail_wave_floor=0.40,
        approach_distance_L=2.10,
        approach_min_gain=0.36,
        positive_approach_min_gain=0.66,
        centerline_bearing_band=0.105,
        centerline_vector_band=0.120,
        centerline_min_turn_gain=0.31,
        sweep_bearing_band=0.35,
        sweep_rate_scale=0.12,
        sweep_damping_gain=0.45,
        positive_recovery_gain=0.64,
        positive_recovery_scale=0.24,
        positive_recovery_rate_scale=0.22,
        centerline_rate_brake_gain=0.43,
        centerline_rate_brake_scale=0.24,
        centerline_rate_brake_bearing_band=0.30,
        centerline_rate_brake_lateral_band=0.26,
        recovery_tail_curvature_gain=-5.1 * pi / 180,
        recovery_tail_curvature_scale=0.70,
        turn_request_limit=6.0,
        head_turn_share=0.70,
        tail_turn_share=1.00,
        halfcycle_tail_bias=0.25,
        halfcycle_velocity_gain=0.20,
        tail_tangent_scale=34.0 * pi / 180,
        body_angular_damping_gain=0.0,
    )
end
@inline function _clamp_unit(value)
    return clamp(value, -1.0, 1.0)
end

@inline function _clamp01(value)
    return clamp(value, 0.0, 1.0)
end

@inline function _safe(value, fallback)
    parsed = Float64(value)
    return isfinite(parsed) ? parsed : fallback
end

function drive_module(
    state,
    params,
    turn_request=0.0,
    drive_frequency_scale=1.0,
    recovery_request=0.0,
    route_error=0.0,
    curvature_veto_gate=0.0,
    intercept_request=0.0,
    recapture_request=0.0,
)
    omega =
        (2 * pi / params.drive_period) *
        max(_safe(drive_frequency_scale, 1.0), 0.50)
    amp = params.drive_amplitude
    q1 = _safe(state.phi[1], 0.0)
    q2 = _safe(state.phi[2], 0.0)
    qd1 = _safe(state.phi_dot[1], 0.0)
    qd2 = _safe(state.phi_dot[2], 0.0)

    # State-feedback drive: phase comes from joint state, not from a hidden clock.
    vdp_drive = params.drive_mu * (1 - (q1 / amp)^2) * qd1
    head_accel = vdp_drive - omega^2 * q1

    # Posterior joint follows the anterior bend with lag to create a traveling wave.
    # Bounded target-curvature feedback lets negative requests oppose the seed's
    # positive-turn drift without adding a hidden clock or target-specific mode.
    turn_command = tanh(_safe(turn_request, 0.0) / max(params.curvature_request_scale, 1.0e-6))
    recovery_command =
        tanh(max(_safe(recovery_request, 0.0), 0.0) / max(params.recovery_tail_curvature_scale, 1.0e-6))
    base_mean_tail_tangent =
        params.negative_turn_curvature_gain * min(turn_command, 0.0) +
        params.positive_turn_curvature_gain * max(turn_command, 0.0) +
        params.recovery_tail_curvature_gain * recovery_command

    # Release only a mean tangent whose sign remains contradicted by material
    # body-frame route error.  The evaluated parent showed that this preserves
    # early progress but does not by itself recover the late downward sweep.
    polarity_product =
        _safe(route_error, 0.0) * base_mean_tail_tangent
    contradicted_polarity = max(
        tanh(
            polarity_product /
            max(params.curvature_veto_polarity_scale, 1.0e-6),
        ),
        0.0,
    )
    curvature_release =
        params.curvature_veto_release_gain *
        _clamp01(_safe(curvature_veto_gate, 0.0)) *
        contradicted_polarity
    released_mean_tail_tangent =
        base_mean_tail_tangent * (1 - _clamp01(curvature_release))
    intercept_mean_tail_tangent =
        params.intercept_tail_curvature_gain *
        _safe(intercept_request, 0.0)

    # Once the target is definitely behind, switch from interception to the
    # separately sampled pivot primitive. Its signed bend produces the turn;
    # request magnitude reallocates the posterior carrier without choosing a
    # world-frame side.
    recapture_mean_tail_tangent =
        params.recapture_tail_curvature_gain *
        _safe(recapture_request, 0.0)
    mean_tail_tangent =
        released_mean_tail_tangent +
        intercept_mean_tail_tangent +
        recapture_mean_tail_tangent

    base_tail_wave =
        -q1 - params.drive_tail_lag_gain * qd1 / max(omega, eps(omega))
    tail_wave_side = tanh(
        base_tail_wave / max(params.tail_tangent_scale, 1.0e-6),
    )

    # Asymmetric-flapping transfer: once the contradicted mean curvature has
    # been released, reduce only the posterior target-wave half-cycle opposing
    # the signed request.  The complementary half-cycle is untouched, so this
    # reallocates existing carrier authority without increasing its magnitude.
    opposing_halfcycle = max(-turn_command * tail_wave_side, 0.0)
    halfcycle_relief = clamp(
        params.opposing_halfcycle_relief *
        _clamp01(curvature_release) *
        opposing_halfcycle,
        0.0,
        params.opposing_halfcycle_relief,
    )
    recapture_carrier_gate = _clamp01(abs(_safe(recapture_request, 0.0)))
    recapture_tail_wave_scale =
        1.0 -
        (1.0 - _clamp01(params.recapture_tail_wave_floor)) *
        recapture_carrier_gate
    tail_wave =
        recapture_tail_wave_scale *
        (1 - halfcycle_relief) *
        base_tail_wave
    tail_target = mean_tail_tangent + tail_wave
    tail_carrier_accel =
        omega^2 * (tail_wave - q2) -
        2 * params.drive_tail_damping * omega * qd2
    tail_curvature_accel = omega^2 * mean_tail_tangent
    tail_accel =
        omega^2 * (tail_target - q2) -
        2 * params.drive_tail_damping * omega * qd2
    return (
        head_accel=head_accel,
        tail_accel=tail_accel,
        omega=omega,
        q1=q1,
        q2=q2,
        qd1=qd1,
        qd2=qd2,
        turn_command=turn_command,
        recovery_command=recovery_command,
        base_mean_tail_tangent=base_mean_tail_tangent,
        contradicted_polarity=contradicted_polarity,
        curvature_release=curvature_release,
        released_mean_tail_tangent=released_mean_tail_tangent,
        intercept_mean_tail_tangent=intercept_mean_tail_tangent,
        recapture_mean_tail_tangent=recapture_mean_tail_tangent,
        mean_tail_tangent=mean_tail_tangent,
        base_tail_wave=base_tail_wave,
        tail_wave_side=tail_wave_side,
        opposing_halfcycle=opposing_halfcycle,
        halfcycle_relief=halfcycle_relief,
        recapture_carrier_gate=recapture_carrier_gate,
        recapture_tail_wave_scale=recapture_tail_wave_scale,
        tail_wave=tail_wave,
        tail_carrier_accel=tail_carrier_accel,
        tail_curvature_accel=tail_curvature_accel,
    )
end

function guidance_module(state, params)
    distance = max(_safe(state.distance_L * params.L, params.L), 1.0e-6)
    distance_L = distance / params.L
    scale = max(distance, 0.25 * params.L)
    # `target_body` is the target vector already rotated into the fish body frame.
    target_x = _safe(state.target_body_L[1] * params.L, -distance)
    target_y = _safe(state.target_body_L[2] * params.L, 0.0)
    forward_component = -target_x / scale
    lateral_component = target_y / scale
    vector_angle = atan(lateral_component, max(forward_component, 0.15))
    vector_angle = clamp(vector_angle, -1.25, 1.25)
    bearing = _clamp_unit(_safe(state.bearing, 0.0))
    bearing_trend = hasproperty(state, :bearing_window_rate) ?
        _safe(state.bearing_window_rate, 0.0) :
        _safe(state.bearing_rate, 0.0)
    closing_speed = hasproperty(state, :window_closing_speed_L) ?
        _safe(state.window_closing_speed_L, 0.0) :
        _safe(state.closing_speed_L, 0.0)
    closing_deficit =
        0.5 * (1 - tanh(closing_speed / max(params.progress_closing_speed_scale, 1.0e-6)))
    velocity_forward = -_safe(state.velocity_body_U[1], 0.0)
    velocity_lateral = _safe(state.velocity_body_U[2], 0.0)
    # Preserve the inherited historical adapter for its geometric steering
    # term; the new course calculation uses the evaluator's already normalized
    # velocity observation directly so only direction, not L, sets its error.
    slip_y = velocity_lateral / params.L

    route_error =
        params.curvature_veto_bearing_weight * bearing +
        params.curvature_veto_vector_weight * vector_angle
    curvature_alignment = max(abs(bearing), abs(vector_angle))
    curvature_veto_gate = _clamp01(
        (curvature_alignment - params.curvature_veto_angle_start) /
        max(
            params.curvature_veto_angle_full - params.curvature_veto_angle_start,
            1.0e-6,
        ),
    )
    # The band-pass pulse starts during the final closing/abeam segment,
    # remains mirror-equivariant through lateral sign, and is forced to zero
    # once approach reverses or the target moves deeply posterior. A lateral
    # deadband preserves centered approaches and prevents an arbitrary side.
    intercept_entry_gate = _clamp01(
        (params.intercept_forward_start - forward_component) /
        max(
            params.intercept_forward_start - params.intercept_forward_full,
            1.0e-6,
        ),
    )
    posterior_component = -forward_component
    intercept_release_gate = 1 - _clamp01(
        (posterior_component - params.intercept_posterior_release_start) /
        max(
            params.intercept_posterior_release_full -
            params.intercept_posterior_release_start,
            1.0e-6,
        ),
    )
    intercept_lateral_gate = _clamp01(
        (abs(lateral_component) - params.intercept_lateral_start) /
        max(
            params.intercept_lateral_full - params.intercept_lateral_start,
            1.0e-6,
        ),
    )
    intercept_closing_gate = _clamp01(
        closing_speed /
        max(params.intercept_closing_speed_scale, 1.0e-6),
    )
    sector_intercept_request =
        intercept_entry_gate *
        intercept_release_gate *
        intercept_lateral_gate *
        intercept_closing_gate *
        tanh(
            lateral_component /
            max(params.intercept_lateral_scale, 1.0e-6),
        )

    # Course preview separates the inertial direction of travel from the
    # oscillating body bearing.  The normalized 2D cross product is invariant
    # to world rotation and reverses sign under lateral reflection.  It is
    # exactly zero on a collision course, and speed/closing/range gates keep it
    # dormant before a route has formed and outside the evidenced terminal
    # intercept window.
    course_speed = hypot(velocity_forward, velocity_lateral)
    target_direction_norm = max(
        hypot(forward_component, lateral_component),
        1.0e-6,
    )
    course_error =
        (velocity_forward * lateral_component -
         velocity_lateral * forward_component) /
        max(course_speed * target_direction_norm, 1.0e-6)
    course_error = _clamp_unit(course_error)
    course_speed_gate = _clamp01(
        course_speed / max(params.course_speed_scale, 1.0e-6),
    )
    course_range_gate = _clamp01(
        (params.course_preview_start_L - distance_L) /
        max(
            params.course_preview_start_L - params.course_preview_full_L,
            1.0e-6,
        ),
    )
    approach = _clamp01(distance_L / max(params.approach_distance_L, 1.0e-6))
    near_course_gate = 1.0 - approach
    # A large course angle does not require alignment when current velocity
    # already intersects the target neighborhood.  Constant-velocity
    # perpendicular miss is range times the normalized course cross product.
    # Continue post-passage course support only outside a smooth miss corridor;
    # the established release remains exact outside the approach neighborhood.
    predicted_miss_L = distance_L * course_error
    miss_safe = max(_safe(params.terminal_miss_safe_L, 0.0), 0.0)
    miss_full = max(
        _safe(params.terminal_miss_full_L, miss_safe),
        miss_safe + 1.0e-6,
    )
    miss_corridor_gate = _clamp01(
        (abs(predicted_miss_L) - miss_safe) /
        max(miss_full - miss_safe, 1.0e-6),
    )
    course_release_gate =
        intercept_release_gate +
        (1.0 - intercept_release_gate) * near_course_gate * miss_corridor_gate
    course_preview_request =
        params.course_preview_gain *
        course_speed_gate *
        course_range_gate *
        course_release_gate *
        intercept_closing_gate *
        tanh(course_error / max(params.course_error_scale, 1.0e-6))
    # Admit the preview only through unused signed request headroom so the
    # inherited sector bound and steering-priority envelope cannot increase.
    intercept_request = clamp(
        sector_intercept_request +
        course_preview_request * (1 - abs(sector_intercept_request)),
        -1.0,
        1.0,
    )

    # Body-frame passage is distinct from the closing-speed pulse. Lateral
    # sign selects the mirrored pivot direction; the gate vanishes when the
    # target returns ahead or closes laterally.
    recapture_behind_gate = _clamp01(
        (-forward_component - params.recapture_behind_start) /
        max(
            params.recapture_behind_full - params.recapture_behind_start,
            1.0e-6,
        ),
    )
    recapture_request =
        recapture_behind_gate *
        tanh(
            lateral_component /
            max(params.recapture_lateral_scale, 1.0e-6),
        )

    approach_gain = params.approach_min_gain + (1 - params.approach_min_gain) * approach

    geometric_request = -(
        params.bearing_gain * bearing +
        params.vector_angle_gain * vector_angle
    ) -
        params.target_lateral_velocity_gain * slip_y -
        params.bearing_trend_gain *
            tanh(bearing_trend / max(params.bearing_trend_scale, 1.0e-6))
    turn_rate = hasproperty(state, :turn_rate_recent) ?
        _safe(state.turn_rate_recent, 0.0) :
        _safe(state.heading_rate, 0.0)
    target_turn_rate =
        params.turn_rate_target_gain *
        tanh(geometric_request / max(params.turn_rate_request_scale, 1.0e-6))
    rate_error = target_turn_rate - turn_rate
    rate_correction =
        params.turn_rate_feedback_gain *
        tanh(rate_error / max(params.turn_rate_scale, 1.0e-6))
    close_gate = 1 - approach

    # Target geometry initiates a redirect; aligned observed yaw releases only
    # that route bias while rate feedback remains available to brake overshoot.
    desired_turn_sign = tanh(
        geometric_request / max(params.redirect_request_scale, 1.0e-6),
    )
    aligned_turn_response = max(
        tanh(
            desired_turn_sign * turn_rate /
            max(params.redirect_rate_scale, 1.0e-6),
        ),
        0.0,
    )
    redirect_gate = clamp(
        1.0 - params.redirect_release_gain * aligned_turn_response,
        1.0 - params.redirect_release_gain,
        1.0,
    )
    request = geometric_request * redirect_gate + rate_correction

    centerline_alignment = max(
        abs(bearing) / max(params.centerline_bearing_band, 1.0e-6),
        abs(vector_angle) / max(params.centerline_vector_band, 1.0e-6),
    )
    centerline_alignment = _clamp01(centerline_alignment)
    centerline_gain =
        params.centerline_min_turn_gain +
        (1 - params.centerline_min_turn_gain) * centerline_alignment

    sweeping_to_center = bearing * bearing_trend < 0.0 ? 1.0 : 0.0
    sweep_window =
        _clamp01((params.sweep_bearing_band - abs(bearing)) / max(params.sweep_bearing_band, 1.0e-6))
    sweep_rate = tanh(abs(bearing_trend) / max(params.sweep_rate_scale, 1.0e-6))
    sweep_damping =
        params.sweep_damping_gain * close_gate * sweep_window * sweep_rate * sweeping_to_center

    request *= centerline_gain * (1 - sweep_damping)
    request = max(request, 0.0) + params.negative_turn_request_gain * min(request, 0.0)

    crossed_below = max(-bearing, 0.0) + 0.6 * max(-vector_angle, 0.0)
    negative_spin = max(-tanh(turn_rate / max(params.positive_recovery_rate_scale, 1.0e-6)), 0.0)
    positive_recovery =
        params.positive_recovery_gain *
        close_gate *
        tanh(crossed_below / max(params.positive_recovery_scale, 1.0e-6)) *
        negative_spin
    request += positive_recovery

    centerline_rate_alignment = max(
        abs(bearing) / max(params.centerline_rate_brake_bearing_band, 1.0e-6),
        abs(lateral_component) / max(params.centerline_rate_brake_lateral_band, 1.0e-6),
    )
    centerline_rate_window = 1 - _clamp01(centerline_rate_alignment)
    centerline_rate_brake =
        params.centerline_rate_brake_gain *
        close_gate *
        centerline_rate_window *
        tanh(-turn_rate / max(params.centerline_rate_brake_scale, 1.0e-6))
    request += centerline_rate_brake
    recovery_curvature_request =
        max(positive_recovery, 0.0) + max(centerline_rate_brake, 0.0)
    positive_approach_gain =
        params.positive_approach_min_gain +
        (1 - params.positive_approach_min_gain) * approach
    effective_approach_gain =
        request > 0.0 ? max(approach_gain, positive_approach_gain) : approach_gain
    request *= effective_approach_gain

    # Keep the collision-corridor course signal separate from route-scale mean
    # curvature. The actuator allocates this residual within the observed tail
    # cycle so it cannot bias the state-feedback oscillator continuously.
    route_turn_request = clamp(
        request,
        -params.turn_request_limit,
        params.turn_request_limit,
    )
    terminal_course_residual_raw =
        -params.terminal_course_turn_gain *
        near_course_gate *
        miss_corridor_gate *
        course_preview_request
    terminal_course_headroom = max(
        params.turn_request_limit - abs(route_turn_request),
        0.0,
    )
    terminal_course_residual = clamp(
        terminal_course_residual_raw,
        -terminal_course_headroom,
        terminal_course_headroom,
    )
    # Once the inertial course already crosses the safe target corridor,
    # heading-chasing by the anterior steering residual is unnecessary.  Use
    # only normalized body-frame course/range/closing observations, and grow
    # the hold continuously inside the established approach neighborhood.
    # The actuator applies this to additive head steering, not to the anterior
    # oscillator that anchors the traveling wave.
    collision_course_commit_gate =
        near_course_gate *
        course_speed_gate *
        intercept_closing_gate *
        (1.0 - miss_corridor_gate)
    return (
        turn_request=route_turn_request,
        combined_turn_request=route_turn_request + terminal_course_residual,
        geometric_request=geometric_request,
        target_turn_rate=target_turn_rate,
        turn_rate=turn_rate,
        rate_correction=rate_correction,
        desired_turn_sign=desired_turn_sign,
        aligned_turn_response=aligned_turn_response,
        redirect_gate=redirect_gate,
        bearing=bearing,
        bearing_trend=bearing_trend,
        vector_angle=vector_angle,
        forward_component=forward_component,
        lateral_component=lateral_component,
        distance_L=distance_L,
        approach_gain=effective_approach_gain,
        base_approach_gain=approach_gain,
        positive_approach_gain=positive_approach_gain,
        far_drive_gate=approach,
        drive_progress_boost=closing_deficit,
        route_error=route_error,
        curvature_alignment=curvature_alignment,
        curvature_veto_gate=curvature_veto_gate,
        intercept_entry_gate=intercept_entry_gate,
        posterior_component=posterior_component,
        intercept_release_gate=intercept_release_gate,
        intercept_lateral_gate=intercept_lateral_gate,
        intercept_closing_gate=intercept_closing_gate,
        sector_intercept_request=sector_intercept_request,
        velocity_forward_L=velocity_forward,
        course_speed_L=course_speed,
        course_error=course_error,
        course_speed_gate=course_speed_gate,
        course_range_gate=course_range_gate,
        near_course_gate=near_course_gate,
        predicted_miss_L=predicted_miss_L,
        miss_corridor_gate=miss_corridor_gate,
        course_release_gate=course_release_gate,
        course_preview_request=course_preview_request,
        intercept_request=intercept_request,
        recapture_behind_gate=recapture_behind_gate,
        recapture_request=recapture_request,
        closing_speed_L=closing_speed,
        centerline_gain=centerline_gain,
        sweep_damping=sweep_damping,
        positive_recovery=positive_recovery,
        centerline_rate_brake=centerline_rate_brake,
        recovery_curvature_request=recovery_curvature_request,
        terminal_course_residual_raw=terminal_course_residual_raw,
        terminal_course_headroom=terminal_course_headroom,
        terminal_course_residual=terminal_course_residual,
        collision_course_commit_gate=collision_course_commit_gate,
    )
end

function turn_actuator_module(drive, guidance, params)
    tail_tangent = drive.q1 + drive.q2
    tail_velocity = drive.qd1 + drive.qd2
    tail_side = tanh(tail_tangent / max(params.tail_tangent_scale, 1.0e-6))
    tail_motion = tanh(tail_velocity / max(params.drive_amplitude * drive.omega, 1.0e-6))

    # Steering biases the currently observed bend/velocity cycle without an
    # explicit period, keeping parameter tuning on active state-feedback terms.
    halfcycle_gate =
        1.0 +
        params.halfcycle_tail_bias * guidance.turn_request * tail_side +
        params.halfcycle_velocity_gain * guidance.turn_request * tail_motion
    halfcycle_gate = clamp(halfcycle_gate, 0.55, 1.45)
    route_steer = guidance.turn_request * halfcycle_gate
    head_route_steer =
        route_steer * (1.0 - guidance.collision_course_commit_gate)

    # Once measured velocity intersects the safe corridor, infer the desired
    # geometric turn side and compare it with the observed lagged-wave phase.
    # Release only a bounded share of posterior additive steering on the
    # opposed half-cycle. Both signs reverse under lateral reflection, leaving
    # the phase gate even; mean curvature, carrier motion, and the aligned
    # posterior steering half-cycle remain intact.
    route_direction = tanh(
        -guidance.route_error /
        max(params.posterior_route_direction_scale, 1.0e-6),
    )
    nominal_omega = 2 * pi / max(params.drive_period, 1.0e-6)
    posterior_route_phase = tanh(
        (-drive.q1 - params.drive_tail_lag_gain * drive.qd1 / nominal_omega) /
        max(params.tail_tangent_scale, 1.0e-6),
    )
    posterior_opposed_phase = max(
        -route_direction * posterior_route_phase,
        0.0,
    )
    posterior_course_commit_gate =
        _clamp01(params.posterior_route_release) *
        guidance.collision_course_commit_gate *
        posterior_opposed_phase
    tail_route_steer =
        route_steer * (1.0 - _clamp01(posterior_course_commit_gate))

    # Half-cycle steering transfer: infer phase from the observed anterior
    # oscillator's lagged tail-wave state rather than total tail tangent, which
    # can remain one-sided while the posterior joint is near its stroke reserve.
    # Under reflection the residual and wave phase both change sign, leaving
    # this gate even and the allocated steering odd. The pulse is zero on the
    # opposed half-cycle and never exceeds the inherited residual.
    terminal_turn_sign = sign(guidance.terminal_course_residual)
    terminal_phase = drive.tail_wave_side
    terminal_phase_alignment = terminal_turn_sign * terminal_phase
    terminal_phase_gate = _clamp01(terminal_phase_alignment)
    terminal_phase_steer =
        guidance.terminal_course_residual * terminal_phase_gate
    steer_limit = 1.45 * max(params.turn_request_limit, 1.0e-6)
    terminal_steer_headroom = max(steer_limit - abs(route_steer), 0.0)
    allocated_terminal_steer = clamp(
        terminal_phase_steer,
        -terminal_steer_headroom,
        terminal_steer_headroom,
    )
    steer = tail_route_steer + allocated_terminal_steer
    head_steer = head_route_steer + allocated_terminal_steer
    return (
        head_delta=params.head_turn_share * head_steer,
        tail_delta=params.tail_turn_share * steer,
        halfcycle_gate=halfcycle_gate,
        route_steer=route_steer,
        head_route_steer=head_route_steer,
        route_direction=route_direction,
        posterior_route_phase=posterior_route_phase,
        posterior_opposed_phase=posterior_opposed_phase,
        posterior_course_commit_gate=posterior_course_commit_gate,
        tail_route_steer=tail_route_steer,
        terminal_phase=terminal_phase,
        terminal_phase_alignment=terminal_phase_alignment,
        terminal_phase_gate=terminal_phase_gate,
        terminal_phase_steer=terminal_phase_steer,
        terminal_steer_headroom=terminal_steer_headroom,
        allocated_terminal_steer=allocated_terminal_steer,
        head_steer=head_steer,
        steer=steer,
    )
end

@inline function _steering_priority_allocate(
    carrier,
    steering,
    baseline,
    gate,
    limit,
)
    safe_limit = max(_safe(limit, 0.0), 1.0e-6)
    safe_carrier = _safe(carrier, 0.0)
    safe_steering = _safe(steering, 0.0)
    safe_baseline = _safe(baseline, safe_carrier + safe_steering)
    bounded_steering = clamp(safe_steering, -safe_limit, safe_limit)
    carrier_headroom = max(safe_limit - abs(bounded_steering), 0.0)
    prioritized = bounded_steering + clamp(
        safe_carrier,
        -carrier_headroom,
        carrier_headroom,
    )
    priority_gate = _clamp01(abs(_safe(gate, 0.0)))
    return safe_baseline + priority_gate * (prioritized - safe_baseline)
end

@inline function _predictive_tail_priority_gate(
    q2,
    qd2,
    tail_steering,
    base_gate,
    params,
)
    guard_start = max(abs(_safe(params.tail_stroke_guard_start, 0.0)), 0.0)
    guard_full = max(
        abs(_safe(params.tail_stroke_guard_full, guard_start)),
        guard_start + 1.0e-6,
    )
    safe_limit = max(
        _safe(params.joint_accel_priority_limit, 0.0),
        1.0e-6,
    )
    safe_q2 = _safe(q2, 0.0)
    safe_qd2 = _safe(qd2, 0.0)
    joint_side = sign(safe_q2)
    outward_rate = max(joint_side * safe_qd2, 0.0)
    stopping_stroke = outward_rate^2 / (2 * safe_limit)
    projected_abs_q2 = abs(safe_q2) + stopping_stroke
    stroke_proximity = _clamp01(
        (projected_abs_q2 - guard_start) /
        max(guard_full - guard_start, 1.0e-6),
    )
    outward_steering = max(
        joint_side * _safe(tail_steering, 0.0),
        0.0,
    )
    steering_scale = max(
        params.tail_stroke_steering_scale * safe_limit,
        1.0e-6,
    )
    outward_pressure = _clamp01(outward_steering / steering_scale)

    # Anticipate finite stopping stroke and release only the evaluated bounded
    # share of posterior carrier priority when steering points farther outward.
    stroke_pressure = stroke_proximity * outward_pressure
    priority_floor = _clamp01(params.tail_stroke_priority_floor)
    return _safe(base_gate, 0.0) *
        (1.0 - (1.0 - priority_floor) * stroke_pressure)
end

@inline function _tail_braking_reserve(
    q2,
    qd2,
    tail_command,
    params,
)
    guard_start = max(abs(_safe(params.tail_stroke_guard_start, 0.0)), 0.0)
    guard_full = max(
        abs(_safe(params.tail_stroke_guard_full, guard_start)),
        guard_start + 1.0e-6,
    )
    safe_limit = max(
        _safe(params.joint_accel_priority_limit, 0.0),
        1.0e-6,
    )
    safe_q2 = _safe(q2, 0.0)
    safe_qd2 = _safe(qd2, 0.0)
    safe_command = _safe(tail_command, 0.0)
    joint_side = sign(safe_q2)
    joint_side == 0.0 && return safe_command

    signed_rate = joint_side * safe_qd2
    signed_rate < 0.0 && abs(safe_q2) <= guard_full && return safe_command

    outward_rate = max(signed_rate, 0.0)
    stopping_stroke = outward_rate^2 / (2 * safe_limit)
    projected_abs_q2 = abs(safe_q2) + stopping_stroke
    stroke_pressure = _clamp01(
        (projected_abs_q2 - guard_start) /
        max(guard_full - guard_start, 1.0e-6),
    )
    stroke_pressure <= 0.0 && return safe_command

    remaining_stroke = max(guard_full - abs(safe_q2), 1.0e-6)
    stopping_brake = clamp(
        outward_rate^2 / (2 * remaining_stroke),
        0.0,
        safe_limit,
    )
    priority_floor = _clamp01(params.tail_stroke_priority_floor)
    recovery_brake =
        (1.0 - priority_floor) * safe_limit * stroke_pressure
    required_inward = max(stopping_brake, recovery_brake)
    outward_command = joint_side * safe_command
    safe_outward_command = min(outward_command, -required_inward)
    filtered_outward_command =
        outward_command +
        stroke_pressure * (safe_outward_command - outward_command)
    return joint_side * filtered_outward_command
end

@inline function _posterior_coast_rate_guard(
    qd2,
    tail_command,
    tail_steering,
    params,
)
    guard_start = max(abs(_safe(params.tail_rate_guard_start, 0.0)), 0.0)
    guard_full = max(
        abs(_safe(params.tail_rate_guard_full, guard_start)),
        guard_start + 1.0e-6,
    )
    safe_rate = _safe(qd2, 0.0)
    safe_command = _safe(tail_command, 0.0)
    safe_steering = _safe(tail_steering, 0.0)
    motion_side = sign(safe_rate)
    motion_side == 0.0 && return safe_command

    rate_pressure = _clamp01(
        (abs(safe_rate) - guard_start) /
        max(guard_full - guard_start, 1.0e-6),
    )
    outward_command = motion_side * safe_command
    (rate_pressure <= 0.0 || outward_command <= 0.0) && return safe_command

    # Keep v34's coast behavior when steering also pushes toward the boundary.
    # If target steering already opposes posterior velocity, retain only that
    # signed residual as the carrier is tapered away. This does not synthesize
    # the full inward brake that failed when applied across both joints.
    accel_limit = max(
        abs(_safe(params.joint_accel_priority_limit, 0.0)),
        1.0e-6,
    )
    steering_residual = clamp(
        min(motion_side * safe_steering, 0.0),
        -accel_limit,
        0.0,
    )
    permitted_command =
        (1.0 - rate_pressure) * accel_limit +
        rate_pressure * steering_residual
    return motion_side * min(outward_command, permitted_command)
end

function target_policy(state, params)
    guidance = guidance_module(state, params)
    # Preserve v40's cadence scheduling even though its terminal residual is
    # now allocated outside the mean-curvature drive.
    turn_load = _clamp01(
        abs(guidance.combined_turn_request) /
        max(params.turn_request_limit, 1.0e-6),
    )
    cadence_gain =
        params.far_drive_frequency_gain +
        params.progress_drive_frequency_gain * guidance.drive_progress_boost
    drive_frequency_scale =
        1.0 +
        cadence_gain *
        guidance.far_drive_gate *
        (1.0 - params.far_drive_turn_relief * turn_load)
    drive = drive_module(
        state,
        params,
        guidance.turn_request,
        drive_frequency_scale,
        guidance.recovery_curvature_request,
        guidance.route_error,
        guidance.curvature_veto_gate,
        guidance.intercept_request,
        guidance.recapture_request,
    )
    turn = turn_actuator_module(drive, guidance, params)
    angular_damping =
        -params.body_angular_damping_gain * _safe(state.moment_z_L2, 0.0) / max(params.L^3, eps(Float64))
    head_steering = turn.head_delta + angular_damping
    tail_steering = drive.tail_curvature_accel + turn.tail_delta
    head_baseline = drive.head_accel + turn.head_delta + angular_damping
    tail_baseline = drive.tail_accel + turn.tail_delta
    tail_priority_gate = _predictive_tail_priority_gate(
        drive.q2,
        drive.qd2,
        tail_steering,
        guidance.intercept_request,
        params,
    )
    head_command = _steering_priority_allocate(
        drive.head_accel,
        head_steering,
        head_baseline,
        guidance.intercept_request,
        params.joint_accel_priority_limit,
    )
    allocated_tail_command = _steering_priority_allocate(
        drive.tail_carrier_accel,
        tail_steering,
        tail_baseline,
        tail_priority_gate,
        params.joint_accel_priority_limit,
    )
    stroke_safe_tail_command = _tail_braking_reserve(
        drive.q2,
        drive.qd2,
        allocated_tail_command,
        params,
    )
    tail_command = _posterior_coast_rate_guard(
        drive.qd2,
        stroke_safe_tail_command,
        tail_steering,
        params,
    )
    return (
        phi_ddot=(
            head_command,
            tail_command,
        ),
    )
end
