function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        max_curvature_bias=10.0 * pi / 180,
        bearing_scale=20.0 * pi / 180,
        tail_curvature_ratio=0.75,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Convert target-relative lateral error into a bounded mean bend. The
    # oscillator phase remains encoded only in observed joint state.
    turn_cmd = tanh(Float64(state.bearing) / params.bearing_scale)
    curvature_bias = params.max_curvature_bias * turn_cmd
    oscillatory_q1 = q1 - curvature_bias
    vdp_drive = params.oscillator_mu * (1 - (oscillatory_q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * oscillatory_q1

    # Preserve the lagged traveling bend around a compatible posterior
    # curvature center instead of allowing steering to erase propulsion.
    phase_lag_target =
        -oscillatory_q1 - params.tail_lag_gain * qd1 / max(omega, eps(omega)) +
        params.tail_curvature_ratio * curvature_bias
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
