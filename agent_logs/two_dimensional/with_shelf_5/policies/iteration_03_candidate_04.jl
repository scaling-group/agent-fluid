function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        turn_bearing_scale=20.0 * pi / 180,
        head_turn_limit=8.0 * pi / 180,
        tail_turn_ratio=0.65,
        terminal_relief_start_L=2.5,
        terminal_relief_full_L=0.75,
        terminal_closing_speed_scale_L=0.04,
        terminal_accel_soft_limit=1200.0 * pi / 180,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Persistent target error changes mean curvature, while tanh bounds the
    # redirect and leaves alternating wake motion out of the route command.
    bearing = Float64(state.bearing)
    turn_request = tanh(bearing / max(params.turn_bearing_scale, eps(Float64)))
    head_bias = params.head_turn_limit * turn_request

    # Preserve the sampled successful state-feedback carrier and its steering
    # topology throughout the far and middle approach.
    head_wave = q1 - head_bias
    vdp_drive = params.oscillator_mu * (1 - (head_wave / amp)^2) * qd1
    raw_a1 = vdp_drive - omega^2 * head_wave

    tail_bias = params.tail_turn_ratio * head_bias
    phase_lag_target = tail_bias - head_wave -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    raw_a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Directly relieve terminal command clipping only while range is small and
    # the body-frame target history confirms positive closing progress. The
    # gate is exactly zero outside the terminal range or while losing ground.
    distance_L = max(Float64(state.distance_L), 0.0)
    relief_span_L = max(
        params.terminal_relief_start_L - params.terminal_relief_full_L,
        eps(Float64),
    )
    relief_fraction = clamp(
        (params.terminal_relief_start_L - distance_L) / relief_span_L,
        0.0,
        1.0,
    )
    range_gate = relief_fraction^2 * (3 - 2 * relief_fraction)
    closing_speed_L = max(Float64(state.window_closing_speed_L), 0.0)
    closing_gate = tanh(
        closing_speed_L /
        max(params.terminal_closing_speed_scale_L, eps(Float64)),
    )
    relief_gate = range_gate * closing_gate

    soft_limit = max(params.terminal_accel_soft_limit, eps(Float64))
    soft_a1 = soft_limit * tanh(raw_a1 / soft_limit)
    soft_a2 = soft_limit * tanh(raw_a2 / soft_limit)
    a1 = raw_a1 + relief_gate * (soft_a1 - raw_a1)
    a2 = raw_a2 + relief_gate * (soft_a2 - raw_a2)

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
