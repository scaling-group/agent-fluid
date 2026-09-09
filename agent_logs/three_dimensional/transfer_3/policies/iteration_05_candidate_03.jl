# Phase-2 candidate: course-response release on the evidenced joint-state
# traveling bend. Target and actual course use only normalized body-frame
# observations; joint state supplies carrier phase without a hidden clock.

function target_policy_params()
    return (
        version="dogfish3d_course_response_release_v1",
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.80,
        tail_damping=0.65,
        los_forward_floor=0.25,
        course_forward_floor=0.10,
        course_speed_scale=0.25,
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

@inline function _wrap_angle(value)
    return atan(sin(value), cos(value))
end

function course_guidance(state, qd1, params)
    distance = max(_finite_or(state.distance_L, 1.0), 1.0e-6)
    target_x = _finite_or(state.target_body_L[1], -distance)
    target_y = _finite_or(state.target_body_L[2], 0.0)

    # Material body -x is forward. The target angle is range-normalized and
    # remains reflection-equivariant after moving-window translations.
    target_forward = -target_x / distance
    target_lateral = target_y / distance
    target_course = atan(
        target_lateral,
        max(target_forward, params.los_forward_floor),
    )

    velocity_x = _finite_or(state.velocity_body_U[1], 0.0)
    velocity_y = _finite_or(state.velocity_body_U[2], 0.0)
    speed = hypot(velocity_x, velocity_y)
    measured_course = atan(
        velocity_y,
        max(-velocity_x, params.course_forward_floor),
    )

    # At release the velocity direction is noisy and should not override body
    # geometry. As self-propulsion develops, smoothly close the loop on actual
    # course so hydrodynamic slip releases/countersteers before LOS overshoot.
    course_authority = tanh(speed / max(params.course_speed_scale, 1.0e-6))
    course_error = _wrap_angle(target_course - course_authority * measured_course)
    target_turn_rate =
        -params.target_turn_rate_limit *
        tanh(course_error / max(params.course_error_scale, 1.0e-6))

    # Retain the strongest sampled policy's carrier-phase compensation so
    # oscillatory recoil is not mistaken for a persistent route response.
    measured_turn_rate = _finite_or(state.heading_rate, 0.0)
    phase_conditioned_turn_rate =
        measured_turn_rate + params.phase_yaw_velocity_gain * qd1
    turn_rate_error = target_turn_rate - phase_conditioned_turn_rate
    mean_tail_curvature =
        params.mean_tail_curvature_limit *
        tanh(turn_rate_error / max(params.turn_rate_error_scale, 1.0e-6))

    return (
        target_course=target_course,
        measured_course=measured_course,
        course_authority=course_authority,
        course_error=course_error,
        target_turn_rate=target_turn_rate,
        phase_conditioned_turn_rate=phase_conditioned_turn_rate,
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

    # Preserve the sampled self-sustaining propulsive carrier exactly.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amplitude)^2) * qd1
    anterior_accel = vdp_drive - omega^2 * q1

    guidance = course_guidance(state, qd1, params)
    posterior_target =
        guidance.mean_tail_curvature - q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(Float64))
    posterior_accel =
        omega^2 * (posterior_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(anterior_accel, posterior_accel),)
end
