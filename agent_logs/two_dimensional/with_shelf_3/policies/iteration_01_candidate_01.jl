function target_policy_params()
    return (
        control_period=0.9,
        oscillator_amplitude=20.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        turn_bearing_scale=25.0 * pi / 180,
        curvature_bias_max=12.0 * pi / 180,
        tail_bias_ratio=0.75,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Convert body-frame target error into bounded mean curvature. The smooth
    # saturation prevents a large wake-induced bearing error from demanding a
    # static bend that consumes the full joint envelope.
    bearing = Float64(state.bearing)
    turn_bias = params.curvature_bias_max * tanh(
        bearing / max(params.turn_bearing_scale, eps(params.turn_bearing_scale)),
    )

    # The joint state still carries oscillator phase; centering it on the turn
    # bias superposes target steering without introducing a clock or route.
    q1_centered = q1 - turn_bias
    vdp_drive = params.oscillator_mu * (1 - (q1_centered / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1_centered

    # Retain the posterior traveling-bend lag around a same-sign, slightly
    # smaller mean bias so steering does not erase the propulsive wave.
    tail_bias = params.tail_bias_ratio * turn_bias
    phase_lag_target = tail_bias - q1_centered -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
