# Phase-2 candidate: phase-conditioned course feedback shifts the mean bend
# of both joints while preserving the evidenced state-feedback carrier.

function target_policy_params()
    return (
        version="dogfish3d_distributed_course_bend_v1",
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.80,
        tail_damping=0.65,
        los_forward_floor=0.25,
        velocity_forward_floor=0.10,
        course_speed_scale=0.25,
        lateral_recoil_q1_gain=0.11,
        lateral_recoil_q2_gain=-0.04,
        course_error_scale=0.45,
        mean_bend_limit=8.0 * pi / 180,
    )
end

@inline function _finite_or(value, fallback)
    parsed = Float64(value)
    return isfinite(parsed) ? parsed : fallback
end

@inline function _wrap_angle(value)
    return atan(sin(value), cos(value))
end

function course_guidance(state, qd1, qd2, params)
    distance = max(_finite_or(state.distance_L, 1.0), 1.0e-6)
    target_x = _finite_or(state.target_body_L[1], -distance)
    target_y = _finite_or(state.target_body_L[2], 0.0)

    # Material body -x is forward. Range normalization makes target course
    # independent of L and moving-window translation.
    target_forward = -target_x / distance
    target_lateral = target_y / distance
    target_course = atan(
        target_lateral,
        max(target_forward, params.los_forward_floor),
    )

    velocity_x = _finite_or(state.velocity_body_U[1], 0.0)
    velocity_y = _finite_or(state.velocity_body_U[2], 0.0)
    forward_speed = max(-velocity_x, 0.0)

    # Remove the joint-rate-correlated lateral recoil found consistently in
    # the sampled traces. The remaining direction is the slow motion response
    # that should release or reverse the mean bend.
    slow_lateral_speed =
        velocity_y +
        params.lateral_recoil_q1_gain * qd1 +
        params.lateral_recoil_q2_gain * qd2
    measured_course = atan(
        slow_lateral_speed,
        max(forward_speed, params.velocity_forward_floor),
    )
    course_authority = tanh(
        forward_speed / max(params.course_speed_scale, 1.0e-6),
    )
    course_error = _wrap_angle(
        target_course - course_authority * measured_course,
    )

    # Positive body-y error requires the calibrated positive mean bend, which
    # produces negative rigid yaw in the 3D turn-sanity contract.
    mean_bend =
        params.mean_bend_limit *
        tanh(course_error / max(params.course_error_scale, 1.0e-6))

    return (
        target_course=target_course,
        measured_course=measured_course,
        course_authority=course_authority,
        course_error=course_error,
        mean_bend=mean_bend,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amplitude = params.oscillator_amplitude
    q1 = _finite_or(state.phi[1], 0.0)
    q2 = _finite_or(state.phi[2], 0.0)
    qd1 = _finite_or(state.phi_dot[1], 0.0)
    qd2 = _finite_or(state.phi_dot[2], 0.0)

    guidance = course_guidance(state, qd1, qd2, params)

    # Center the same self-sustaining carrier on the requested anterior bend.
    centered_q1 = q1 - guidance.mean_bend
    vdp_drive =
        params.oscillator_mu *
        (1 - (centered_q1 / amplitude)^2) * qd1
    anterior_accel = vdp_drive - omega^2 * centered_q1

    # Give the posterior joint the same mean bend while retaining the sampled
    # anti-phase/velocity-lag traveling-wave relationship about that mean.
    posterior_target =
        guidance.mean_bend - centered_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(Float64))
    posterior_accel =
        omega^2 * (posterior_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(anterior_accel, posterior_accel),)
end
