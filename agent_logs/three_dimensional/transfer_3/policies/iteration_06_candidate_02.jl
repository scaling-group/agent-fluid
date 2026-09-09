# Phase-2 candidate: course-guided whole-body mean bend on the evidenced
# joint-state traveling wave. Target and motion course use normalized
# body-frame observations; joint state supplies carrier phase without a clock.

function target_policy_params()
    return (
        version="dogfish3d_course_guided_whole_body_bend_v1",
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.80,
        tail_damping=0.65,
        los_forward_floor=0.25,
        course_forward_floor=0.10,
        course_speed_scale=0.25,
        course_error_scale=0.35,
        mean_bend_limit=10.0 * pi / 180,
        anterior_bend_share=0.40,
        posterior_bend_share=0.60,
    )
end

@inline function _finite_or(value, fallback)
    parsed = Float64(value)
    return isfinite(parsed) ? parsed : fallback
end

@inline function _wrap_angle(value)
    return atan(sin(value), cos(value))
end

function course_guidance(state, params)
    distance = max(_finite_or(state.distance_L, 1.0), 1.0e-6)
    target_x = _finite_or(state.target_body_L[1], -distance)
    target_y = _finite_or(state.target_body_L[2], 0.0)

    # Material body -x is forward. Both angles are translation-independent and
    # reflection-equivariant. Range normalization also bounds target geometry.
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

    # Velocity direction is unreliable at release. Introduce it continuously
    # as self-propulsion develops, then withdraw the bend at course alignment.
    course_authority = tanh(speed / max(params.course_speed_scale, 1.0e-6))
    course_error = _wrap_angle(
        target_course - course_authority * measured_course,
    )
    bend_request = -tanh(
        course_error / max(params.course_error_scale, 1.0e-6),
    )
    mean_bend = params.mean_bend_limit * bend_request

    return (
        target_course=target_course,
        measured_course=measured_course,
        course_authority=course_authority,
        course_error=course_error,
        bend_request=bend_request,
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

    guidance = course_guidance(state, params)
    anterior_mean = params.anterior_bend_share * guidance.mean_bend
    posterior_mean = params.posterior_bend_share * guidance.mean_bend

    # Recenter, rather than replace, the sampled self-sustaining carrier. The
    # oscillatory state retains its amplitude while persistent course error can
    # recruit the anterior joint instead of relying on posterior bias alone.
    anterior_wave = q1 - anterior_mean
    vdp_drive =
        params.oscillator_mu *
        (1.0 - (anterior_wave / amplitude)^2) *
        qd1
    anterior_accel = vdp_drive - omega^2 * anterior_wave

    posterior_wave_target =
        -anterior_wave -
        params.tail_lag_gain * qd1 / max(omega, eps(Float64))
    posterior_target = posterior_mean + posterior_wave_target
    posterior_accel =
        omega^2 * (posterior_target - q2) -
        2.0 * params.tail_damping * omega * qd2

    return (phi_ddot=(anterior_accel, posterior_accel),)
end
