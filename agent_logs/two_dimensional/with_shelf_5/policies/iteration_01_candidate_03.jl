function target_policy_params()
    return (
        control_period=1.1,
        oscillator_amplitude=14.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.75,
        bearing_gain=2.5,
        heading_rate_gain=0.18,
        turn_bias_limit=12.0 * pi / 180,
        tail_turn_share=0.55,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Convert persistent body-frame target error into bounded mean curvature.
    # Heading-rate feedback opposes an already developing turn without using a
    # clock, world-frame direction, or a sampled wake phase.
    heading_rate = hasproperty(state, :heading_rate) ? Float64(state.heading_rate) : 0.0
    turn_request = params.bearing_gain * clamp(Float64(state.bearing), -pi / 2, pi / 2) -
        params.heading_rate_gain * heading_rate
    turn_bias = params.turn_bias_limit * tanh(turn_request)

    # The phase remains encoded in observed joint state.  Centering the rhythm
    # on turn_bias retains propulsion while making target steering persistent.
    q1_wave = q1 - turn_bias
    vdp_drive = params.oscillator_mu * (1 - (q1_wave / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1_wave

    # Give the tail a smaller same-sign mean bias while retaining the seed's
    # velocity-dependent posterior lag and its smooth traveling bend.
    phase_lag_target = params.tail_turn_share * turn_bias - q1_wave -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
