function target_policy_params()
    return (
        control_period=0.8,
        oscillator_amplitude=22.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.7,
        bearing_scale=20.0 * pi / 180,
        max_head_bias=8.0 * pi / 180,
        tail_bias_ratio=0.5,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # A body-frame bearing request shifts the mean bend but cannot prescribe a
    # world-frame route. The smooth bound protects the alternating propulsive
    # wave when the target is far off the current heading.
    bearing = Float64(state.bearing)
    turn_request = tanh(bearing / params.bearing_scale)
    head_bias = params.max_head_bias * turn_request
    tail_bias = params.tail_bias_ratio * head_bias

    # State-only reflex oscillator: phase remains encoded in joint state. Run
    # the alternating head component about the requested mean curvature.
    centered_q1 = q1 - head_bias
    vdp_drive = params.oscillator_mu * (1 - (centered_q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * centered_q1

    # Preserve the posterior lag while giving the tail its compatible share of
    # mean curvature; use the centered head motion so steering is not cancelled.
    phase_lag_target = tail_bias - centered_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
