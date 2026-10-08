function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        bearing_gain=2.0,
        max_turn_bias=10.0 * pi / 180,
        tail_turn_share=0.5,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Convert normalized body-frame target geometry to a bounded mean bend.
    # Recentring the oscillator preserves a state-encoded propulsive phase while
    # giving persistent target error direct steering authority.
    bearing = clamp(Float64(state.bearing), -pi / 2, pi / 2)
    turn_bias = params.max_turn_bias * tanh(params.bearing_gain * bearing)
    q1_wave = q1 - turn_bias

    # State-only reflex oscillator: the phase remains encoded in (q1, qd1).
    vdp_drive = params.oscillator_mu * (1 - (q1_wave / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1_wave

    # Retain the seed's velocity-dependent posterior lag, but add a smaller
    # same-sign mean bend so steering does not cancel at the tail.
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
