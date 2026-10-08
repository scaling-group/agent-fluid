function target_policy_params()
    return (
        control_period=0.9,
        oscillator_amplitude=18.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.75,
        tail_damping=0.8,
        turn_bias_limit=12.0 * pi / 180,
        turn_bearing_scale=25.0 * pi / 180,
        tail_turn_ratio=0.6,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Convert body-frame target error into a bounded mean-curvature request.
    # The smooth limit prevents a large wake-induced bearing transient from
    # replacing the propulsive bend with a static actuator-saturating turn.
    bearing = clamp(Float64(state.bearing), -pi / 2, pi / 2)
    bearing_scale = max(params.turn_bearing_scale, eps(Float64))
    turn_fraction = tanh(bearing / bearing_scale)
    head_bias = params.turn_bias_limit * turn_fraction
    tail_bias = params.tail_turn_ratio * head_bias

    # State-only reflex oscillator about the requested mean bend. Its phase
    # remains encoded in joint angle and velocity rather than elapsed time.
    head_wave = q1 - head_bias
    vdp_drive = params.oscillator_mu * (1 - (head_wave / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * head_wave

    # Preserve a lagged posterior wave around its share of the curvature bias.
    # This separates mean target steering from the oscillatory tail component.
    phase_lag_target = tail_bias - head_wave -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
