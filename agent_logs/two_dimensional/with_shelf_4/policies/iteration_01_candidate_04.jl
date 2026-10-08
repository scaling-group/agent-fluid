function target_policy_params()
    return (
        control_period=0.85,
        oscillator_amplitude=20.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.75,
        tail_damping=0.6,
        steer_gain=2.5,
        turn_damping=0.35,
        bearing_rate_scale=1.0,
        max_curvature_bias=9.0 * pi / 180,
        tail_steer_gain=0.5,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Persistent target error requests a bounded mean bend.  The windowed rate
    # term releases the bias as the bearing converges, without a hidden mode or
    # clock.  Positive bend produces the measured negative-yaw response of this
    # body, matching the sign of the episode's body-frame bearing convention.
    bearing_error = tanh(Float64(state.bearing))
    bearing_rate = tanh(
        params.bearing_rate_scale * Float64(state.bearing_window_rate),
    )
    turn_request = params.steer_gain * bearing_error +
        params.turn_damping * bearing_rate
    curvature_bias = params.max_curvature_bias * tanh(turn_request)

    # The oscillator phase remains encoded in joint state.  Regulating its
    # normalized phase-plane radius keeps the requested amplitude finite and
    # leaves headroom for the curvature bias inside the joint envelope.
    q1_wave = q1 - curvature_bias
    normalized_position = q1_wave / amp
    normalized_velocity = qd1 / (omega * amp)
    radius_squared = normalized_position^2 + normalized_velocity^2
    radial_drive = params.oscillator_mu * omega *
        (1 - clamp(radius_squared, 0.0, 4.0)) * qd1
    a1 = radial_drive - omega^2 * q1_wave

    # Preserve a posterior traveling bend around the same steering curvature;
    # the second joint receives only a share of the mean bias so turning does
    # not replace its propulsive lagged motion.
    tail_wave_target = -q1_wave -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    tail_target = tail_wave_target + params.tail_steer_gain * curvature_bias
    a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
