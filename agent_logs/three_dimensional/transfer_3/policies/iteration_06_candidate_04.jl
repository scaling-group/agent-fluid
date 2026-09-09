# Phase-2 candidate: phase-conditioned course pursuit through posterior
# half-cycle asymmetry on the evidenced fast joint-state traveling bend.

function target_policy_params()
    return (
        version="dogfish3d_course_gated_fast_halfcycle_v1",
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.80,
        tail_damping=0.65,
        los_forward_floor=0.25,
        course_forward_floor=0.20,
        course_activation_speed=0.35,
        lateral_recoil_qd1_gain=0.11,
        lateral_recoil_qd2_gain=-0.04,
        course_error_scale=0.30,
        halfcycle_asymmetry_gain=0.10,
        halfcycle_phase_scale=10.0 * pi / 180,
        halfcycle_scale_min=0.90,
        halfcycle_scale_max=1.10,
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

    # Material body -x is forward. Range-normalized target geometry is
    # reflection-equivariant and independent of moving-window translations.
    target_forward = -target_x / distance
    target_lateral = target_y / distance
    target_course = atan(
        target_lateral,
        max(target_forward, params.los_forward_floor),
    )

    velocity_x = _finite_or(state.velocity_body_U[1], 0.0)
    velocity_y = _finite_or(state.velocity_body_U[2], 0.0)
    forward_speed = max(-velocity_x, 0.0)

    # Project the evidenced carrier-scale lateral recoil out of velocity before
    # using course as a route signal. The speed gate leaves release guidance to
    # target geometry and closes the course loop only after propulsion develops.
    phase_conditioned_lateral_velocity =
        velocity_y +
        params.lateral_recoil_qd1_gain * qd1 +
        params.lateral_recoil_qd2_gain * qd2
    measured_course = atan(
        phase_conditioned_lateral_velocity,
        max(forward_speed, params.course_forward_floor),
    )
    course_authority = tanh(
        forward_speed / max(params.course_activation_speed, 1.0e-6),
    )
    course_error = _wrap_angle(
        target_course - course_authority * measured_course,
    )
    turn_request = tanh(
        course_error / max(params.course_error_scale, 1.0e-6),
    )

    return (
        target_course=target_course,
        measured_course=measured_course,
        course_authority=course_authority,
        course_error=course_error,
        turn_request=turn_request,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amplitude = params.oscillator_amplitude
    q1 = _finite_or(state.phi[1], 0.0)
    q2 = _finite_or(state.phi[2], 0.0)
    qd1 = _finite_or(state.phi_dot[1], 0.0)
    qd2 = _finite_or(state.phi_dot[2], 0.0)

    # Preserve the sampled self-sustaining anterior carrier exactly.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amplitude)^2) * qd1
    anterior_accel = vdp_drive - omega^2 * q1

    guidance = course_guidance(state, qd1, qd2, params)
    posterior_wave =
        -q1 - params.tail_lag_gain * qd1 / max(omega, eps(Float64))

    # State identifies beat side without a clock. Positive turn request makes
    # the positive posterior half-cycle slightly stronger, yielding the
    # calibrated positive-mean-bend / negative-yaw response while preserving
    # a traveling wave on both sides.
    wave_side = tanh(
        posterior_wave / max(params.halfcycle_phase_scale, 1.0e-6),
    )
    halfcycle_scale = clamp(
        1.0 +
        params.halfcycle_asymmetry_gain * guidance.turn_request * wave_side,
        params.halfcycle_scale_min,
        params.halfcycle_scale_max,
    )
    posterior_target = halfcycle_scale * posterior_wave
    posterior_accel =
        omega^2 * (posterior_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(anterior_accel, posterior_accel),)
end
