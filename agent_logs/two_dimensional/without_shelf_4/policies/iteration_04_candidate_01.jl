function target_policy_params()
    return (
        control_period=0.67,
        oscillator_amplitude=20.0 * pi / 180,
        oscillator_energy_gain=1.0,
        tail_lag_gain=0.65,
        tail_damping=0.80,
        steering_bias_limit=10.0 * pi / 180,
        steering_bearing_scale=0.30,
        steering_rate_lookahead=0.25,
        steering_rate_limit=0.30,
        acceleration_limit=30.8,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Keep propulsion phase independent of steering. The sampled 20-degree
    # shell crossed the target after the otherwise matched 19-degree shell
    # remained a longitudinal miss.
    phase_radius_sq = (q1 / amp)^2 + (qd1 / (omega * amp))^2
    energy_drive = params.oscillator_energy_gain *
                   tanh(1 - phase_radius_sq) * qd1
    a1_raw = energy_drive - omega^2 * q1

    # Retain the finite example's bounded posterior bearing sign and short
    # rate lead so steering does not introduce a route or external clock.
    bearing_rate = clamp(
        state.bearing_window_rate,
        -params.steering_rate_limit,
        params.steering_rate_limit,
    )
    steering_error = state.bearing + params.steering_rate_lookahead * bearing_rate
    steering_bias = -params.steering_bias_limit * tanh(
        steering_error / params.steering_bearing_scale,
    )

    # Put mean curvature only in the posterior target. The local guard remains
    # just above the sampled gait maximum and below the episode hard envelope.
    phase_lag_target = steering_bias - q1 -
                       params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2_raw = omega^2 * (phase_lag_target - q2) -
             2 * params.tail_damping * omega * qd2
    a1 = clamp(a1_raw, -params.acceleration_limit, params.acceleration_limit)
    a2 = clamp(a2_raw, -params.acceleration_limit, params.acceleration_limit)

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
