function target_policy_params()
    return (
        control_period=0.68,
        oscillator_amplitude=22.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.65,
        tail_damping=0.75,
        bearing_scale=0.35,
        bearing_prediction_horizon=0.45,
        bearing_rate_limit=0.24,
        half_cycle_asymmetry=0.45,
        posterior_asymmetry_share=0.55,
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

    # Preserve the initialized zero-centered traveling bend. Unlike a steering
    # equilibrium, this oscillator does not subtract the release bend before
    # it can generate upstream propulsion.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    symmetric_a1 = vdp_drive - omega^2 * q1

    # Predict the short-horizon body-frame bearing from its observed windowed
    # rate. The clamped lead releases steering as alignment approaches without
    # letting a fast wake-induced bearing change replace the route request.
    bearing = Float64(state.bearing)
    bearing_rate = Float64(state.bearing_window_rate)
    bearing_lead = clamp(
        params.bearing_prediction_horizon * bearing_rate,
        -params.bearing_rate_limit,
        params.bearing_rate_limit,
    )
    steering_bearing = clamp(bearing + bearing_lead, -pi / 2, pi / 2)
    turn_fraction = tanh(
        steering_bearing / max(params.bearing_scale, eps(Float64)),
    )
    asymmetric_a1 = symmetric_a1 +
        params.half_cycle_asymmetry * turn_fraction * abs(symmetric_a1)

    # Carry the same bounded bias into a smaller share of the posterior
    # follower while retaining the velocity-lagged traveling wave.
    tail_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    symmetric_a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2
    asymmetric_a2 = symmetric_a2 + params.posterior_asymmetry_share *
        params.half_cycle_asymmetry * turn_fraction * abs(symmetric_a2)

    # Candidate-owned smooth limiting avoids persistent contact with the
    # harder episode acceleration clip.
    limit = params.acceleration_soft_limit
    a1 = limit * tanh(asymmetric_a1 / limit)
    a2 = limit * tanh(asymmetric_a2 / limit)

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
