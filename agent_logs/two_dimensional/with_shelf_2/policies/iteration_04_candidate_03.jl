function target_policy_params()
    return (
        control_period=0.68,
        oscillator_amplitude=22.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.65,
        tail_damping=0.75,
        bearing_scale=0.35,
        bearing_rate_horizon=4.0,
        bearing_prediction_limit=0.35,
        anterior_half_cycle_asymmetry=0.45,
        posterior_steer_limit=8.0 * pi / 180,
        acceleration_soft_limit=29.0,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Preserve the zero-centered anterior rhythm that recovered upstream
    # travel. Bearing changes half-cycle strength without moving the oscillator
    # equilibrium, and zero bearing recovers the symmetric propulsive scaffold.
    bearing = clamp(Float64(state.bearing), -pi / 2, pi / 2)
    anterior_turn = tanh(
        bearing / max(params.bearing_scale, eps(Float64)),
    )
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    symmetric_a1 = vdp_drive - omega^2 * q1
    asymmetric_a1 = symmetric_a1 +
        params.anterior_half_cycle_asymmetry * anterior_turn * abs(symmetric_a1)

    # Bias the total posterior tangent separately from anterior propulsion.
    # A clamped body-frame bearing-rate lead releases a turn that is already
    # correcting and reinforces one that target-relative wake motion reverses.
    bearing_rate = hasproperty(state, :bearing_rate) ?
        Float64(state.bearing_rate) : 0.0
    bearing_lead = clamp(
        params.bearing_rate_horizon * bearing_rate,
        -params.bearing_prediction_limit,
        params.bearing_prediction_limit,
    )
    posterior_turn = tanh(
        (bearing + bearing_lead) /
        max(params.bearing_scale, eps(Float64)),
    )
    tail_wave_target = -params.tail_lag_gain * qd1 /
        max(omega, eps(omega))
    tail_total_target = tail_wave_target +
        params.posterior_steer_limit * posterior_turn
    q2_target = tail_total_target - q1
    symmetric_a2 = omega^2 * (q2_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Stay inside the formal episode acceleration envelope smoothly so this
    # test isolates steering composition rather than hard-clip bang-bang action.
    limit = params.acceleration_soft_limit
    a1 = limit * tanh(asymmetric_a1 / limit)
    a2 = limit * tanh(symmetric_a2 / limit)

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
