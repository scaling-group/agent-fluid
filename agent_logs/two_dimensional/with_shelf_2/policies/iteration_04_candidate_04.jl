function target_policy_params()
    return (
        control_period=0.68,
        oscillator_amplitude=22.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.65,
        tail_damping=0.75,
        bearing_scale=0.35,
        bearing_response_horizon=3.0,
        bearing_response_limit=0.25,
        posterior_curvature_limit=10.0 * pi / 180,
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

    # Predict the slow body-frame target error from the recent observation
    # window. A bearing already returning toward zero releases steering, while
    # a growing error requests more curvature. The fallback keeps the public
    # policy callable with compact states that omit temporal observations.
    bearing = clamp(Float64(state.bearing), -pi / 2, pi / 2)
    raw_bearing_rate = hasproperty(state, :bearing_window_rate) ?
        Float64(state.bearing_window_rate) : 0.0
    bearing_rate = isfinite(raw_bearing_rate) ? raw_bearing_rate : 0.0
    response = clamp(
        params.bearing_response_horizon * bearing_rate,
        -params.bearing_response_limit,
        params.bearing_response_limit,
    )
    predicted_bearing = clamp(bearing + response, -pi / 2, pi / 2)
    turn_fraction = tanh(
        predicted_bearing / max(params.bearing_scale, eps(Float64)),
    )

    # Leave anterior propulsion zero-centered. Steering instead biases the
    # desired total tail tangent, so the posterior joint carries a bounded
    # mean curvature while retaining the velocity-lagged traveling bend.
    tail_tangent_wave = -params.tail_lag_gain * qd1 / max(omega, eps(omega))
    tail_tangent_steer = params.posterior_curvature_limit * turn_fraction
    q2_target = tail_tangent_wave + tail_tangent_steer - q1
    posterior_a2 = omega^2 * (q2_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Smooth candidate-owned limiting avoids a persistent hard-clipped command.
    limit = params.acceleration_soft_limit
    a1 = limit * tanh(symmetric_a1 / limit)
    a2 = limit * tanh(posterior_a2 / limit)

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
