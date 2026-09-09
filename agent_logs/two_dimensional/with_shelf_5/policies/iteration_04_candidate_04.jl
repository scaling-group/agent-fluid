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
        approach_distance_L=2.5,
        approach_bearing_rate_limit=4.0 * pi / 180,
        approach_bearing_rate_scale=0.5,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Preserve the demonstrated carrier and route outside the terminal
    # neighborhood. Smoothstep makes the rate correction exactly zero there.
    distance_L = max(Float64(state.distance_L), 0.0)
    approach_fraction = clamp(
        distance_L / max(params.approach_distance_L, eps(Float64)),
        0.0,
        1.0,
    )
    approach_blend = approach_fraction^2 * (3 - 2 * approach_fraction)
    approach_weight = 1 - approach_blend

    # Add only a bounded body-frame bearing lead near capture. Improving
    # alignment releases mean curvature; worsening alignment reinforces it.
    bearing = Float64(state.bearing)
    bearing_window_rate = Float64(state.bearing_window_rate)
    bounded_rate_bearing = params.approach_bearing_rate_limit * tanh(
        bearing_window_rate /
        max(params.approach_bearing_rate_scale, eps(Float64)),
    )
    predicted_bearing = bearing + approach_weight * bounded_rate_bearing
    turn_request = tanh(
        predicted_bearing / max(params.turn_bearing_scale, eps(Float64)),
    )
    head_bias = params.head_turn_limit * turn_request

    # The oscillator phase remains encoded in joint state. Centering it on the
    # requested curvature preserves the propulsive rhythm during a turn.
    head_wave = q1 - head_bias
    vdp_drive = params.oscillator_mu * (1 - (head_wave / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * head_wave

    # Apply posterior steering to the mean component only. The oscillatory
    # component still follows the anterior joint with a velocity-dependent lag.
    tail_bias = params.tail_turn_ratio * head_bias
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
