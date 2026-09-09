# Phase-2 candidate: speed-gated course-response release on the coherent
# joint-state carrier. Target and velocity directions are compared in the body
# frame; joint rates remove fast lateral recoil before course closes the turn.

function target_policy_params()
    return (
        version="dogfish3d_phase_separated_course_release_v1",
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.80,
        tail_damping=0.65,
        los_forward_floor=0.25,
        course_activation_speed=0.35,
        lateral_recoil_q1_gain=0.11,
        lateral_recoil_q2_gain=-0.035,
        course_error_scale=0.35,
        target_turn_rate_limit=0.45,
        phase_yaw_velocity_gain=0.47,
        turn_rate_error_scale=0.25,
        mean_tail_curvature_limit=10.0 * pi / 180,
    )
end

@inline function _finite_or(value, fallback)
    parsed = Float64(value)
    return isfinite(parsed) ? parsed : fallback
end

function target_guidance(state, qd1, qd2, params)
    distance = max(_finite_or(state.distance_L, 1.0), 1.0e-6)
    target_x = _finite_or(state.target_body_L[1], -distance)
    target_y = _finite_or(state.target_body_L[2], 0.0)
    target_norm = max(hypot(target_x, target_y), 1.0e-6)

    # Material body -x is forward and body +y is the evidenced turn-positive
    # side. Normalize direction independently of grid scale and target range.
    target_forward = -target_x / target_norm
    target_lateral = target_y / target_norm
    los_error = atan(
        target_lateral,
        max(target_forward, params.los_forward_floor),
    )

    velocity_x = _finite_or(state.velocity_body_U[1], 0.0)
    raw_lateral_velocity = _finite_or(state.velocity_body_U[2], 0.0)
    forward_speed = max(-velocity_x, 0.0)

    # The sampled carrier produces repeatable lateral recoil at joint phase.
    # Project that component out so course release follows persistent motion.
    course_lateral_velocity =
        raw_lateral_velocity +
        params.lateral_recoil_q1_gain * qd1 +
        params.lateral_recoil_q2_gain * qd2
    course_speed = hypot(forward_speed, course_lateral_velocity)
    course_forward = course_speed > 1.0e-6 ? forward_speed / course_speed : 1.0
    course_lateral = course_speed > 1.0e-6 ?
        course_lateral_velocity / course_speed : 0.0

    # Signed target-course error is the angle from observed velocity direction
    # to target direction. Unlike an attenuated slip correction, it reverses
    # the turn as soon as the route crosses the target course.
    course_cross =
        target_lateral * course_forward -
        target_forward * course_lateral
    course_dot =
        target_forward * course_forward +
        target_lateral * course_lateral
    course_error = atan(course_cross, course_dot)
    course_gate = tanh(
        forward_speed / max(params.course_activation_speed, 1.0e-6),
    )
    guidance_error =
        (1 - course_gate) * los_error + course_gate * course_error
    target_turn_rate =
        -params.target_turn_rate_limit *
        tanh(guidance_error / max(params.course_error_scale, 1.0e-6))

    # Preserve the assigned parent's phase-conditioned rigid-yaw residual.
    measured_turn_rate = _finite_or(state.heading_rate, 0.0)
    phase_conditioned_turn_rate =
        measured_turn_rate + params.phase_yaw_velocity_gain * qd1
    turn_rate_error = target_turn_rate - phase_conditioned_turn_rate
    mean_tail_curvature =
        params.mean_tail_curvature_limit *
        tanh(turn_rate_error / max(params.turn_rate_error_scale, 1.0e-6))

    return (
        los_error=los_error,
        raw_lateral_velocity=raw_lateral_velocity,
        course_lateral_velocity=course_lateral_velocity,
        course_error=course_error,
        course_gate=course_gate,
        guidance_error=guidance_error,
        target_turn_rate=target_turn_rate,
        measured_turn_rate=measured_turn_rate,
        phase_conditioned_turn_rate=phase_conditioned_turn_rate,
        turn_rate_error=turn_rate_error,
        mean_tail_curvature=mean_tail_curvature,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amplitude = params.oscillator_amplitude
    q1 = _finite_or(state.phi[1], 0.0)
    q2 = _finite_or(state.phi[2], 0.0)
    qd1 = _finite_or(state.phi_dot[1], 0.0)
    qd2 = _finite_or(state.phi_dot[2], 0.0)

    # Preserve the sampled self-propelled traveling-bend carrier exactly.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amplitude)^2) * qd1
    anterior_accel = vdp_drive - omega^2 * q1

    guidance = target_guidance(state, qd1, qd2, params)
    posterior_target =
        guidance.mean_tail_curvature - q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(Float64))
    posterior_accel =
        omega^2 * (posterior_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(anterior_accel, posterior_accel),)
end
