function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        turn_bearing_scale=20.0 * pi / 180,
        bearing_prediction_horizon=0.12,
        bearing_rate_term_limit=5.0 * pi / 180,
        head_turn_limit=8.0 * pi / 180,
        tail_turn_ratio=0.65,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Predict the body-frame bearing over a short horizon. The history-derived
    # rate damps a turn whose error is already closing and reinforces a growing
    # error, while smooth saturation prevents a fast wake event from becoming
    # the route command.
    bearing = Float64(state.bearing)
    bearing_rate = hasproperty(state, :bearing_window_rate) ?
        Float64(state.bearing_window_rate) :
        (hasproperty(state, :bearing_rate) ? Float64(state.bearing_rate) : 0.0)
    rate_term_limit = params.bearing_rate_term_limit
    rate_term = rate_term_limit * tanh(
        params.bearing_prediction_horizon * bearing_rate /
        max(rate_term_limit, eps(Float64)),
    )
    predicted_bearing = bearing + rate_term
    turn_request = tanh(
        predicted_bearing / max(params.turn_bearing_scale, eps(Float64)),
    )
    head_bias = params.head_turn_limit * turn_request

    # Preserve the successful joint-state oscillator and run it around the
    # requested mean curvature; its phase remains encoded in observed state.
    head_wave = q1 - head_bias
    vdp_drive = params.oscillator_mu * (1 - (head_wave / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * head_wave

    # Steering changes only the mean component. The posterior oscillation keeps
    # the evaluated velocity-dependent lag that supplies the traveling bend.
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
