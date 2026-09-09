function target_policy_params()
    return (
        control_period=0.80,
        oscillator_amplitude=15.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.80,
        tail_damping=0.75,
        bearing_width=0.25,
        max_turn_bias=12.0 * pi / 180,
        tail_turn_ratio=0.50,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # A smooth body-frame bearing reflex supplies the mean curvature that the
    # target-blind seed lacked. The saturation bounds steering without using a
    # route, target identity, elapsed time, or wake phase.
    turn_command = tanh(Float64(state.bearing) / params.bearing_width)
    head_bias = params.max_turn_bias * turn_command
    tail_bias = params.tail_turn_ratio * head_bias

    # Preserve an autonomous state-feedback rhythm around the requested mean
    # bend. Its moderated scale leaves actuator headroom for the steering bias.
    q1_wave = q1 - head_bias
    vdp_drive = params.oscillator_mu * (1 - (q1_wave / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1_wave

    # Track a posteriorly lagged wave around a compatible tail mean bend, so
    # steering changes the mean shape without replacing propulsive phase lag.
    tail_target = tail_bias - q1_wave -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
