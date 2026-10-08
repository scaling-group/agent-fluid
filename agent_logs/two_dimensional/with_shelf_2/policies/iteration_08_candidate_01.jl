function target_policy_params()
    return (
        control_period=0.68,
        oscillator_amplitude=22.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.65,
        tail_damping=0.75,
        bearing_scale=0.35,
        heading_response_horizon=6.0,
        heading_response_limit=0.35,
        half_cycle_asymmetry=0.45,
        posterior_asymmetry_share=0.55,
        posterior_base_emphasis=0.05,
        progress_deficit_emphasis=0.10,
        closing_speed_scale=0.20,
        yaw_moment_scale=1.0,
        minimum_steering_fraction=0.20,
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

    # Predict the remaining body-frame error after the observed turn response.
    # This releases steering as the heading begins correcting, while the
    # fallback preserves the compact-state policy contract.
    bearing = clamp(Float64(state.bearing), -pi / 2, pi / 2)
    heading_rate = hasproperty(state, :heading_rate) ?
        Float64(getproperty(state, :heading_rate)) : 0.0
    heading_response = clamp(
        params.heading_response_horizon * heading_rate,
        -params.heading_response_limit,
        params.heading_response_limit,
    )
    predicted_bearing = bearing - heading_response
    route_turn = tanh(
        predicted_bearing / max(params.bearing_scale, eps(Float64)),
    )

    # Large normalized yaw moment means the wake/body interaction is already
    # turning the fish. Reduce only the target-steering residual, retaining a
    # small authority floor and leaving the propulsive wave intact.
    yaw_load_ratio = abs(Float64(state.moment_z_L2)) /
        max(params.yaw_moment_scale, eps(Float64))
    steering_gate = params.minimum_steering_fraction +
        (1 - params.minimum_steering_fraction) /
        (1 + yaw_load_ratio * yaw_load_ratio)
    turn_fraction = steering_gate * route_turn
    asymmetric_a1 = symmetric_a1 +
        params.half_cycle_asymmetry * turn_fraction * abs(symmetric_a1)

    # Preserve the lagged traveling bend while reserving extra posterior motion
    # for aligned periods in which observed target closing is weak.  This keeps
    # a small evidenced emphasis during fast progress, but puts the additional
    # propulsive envelope into wake-induced stalls rather than every tailbeat.
    route_alignment = 1 /
        (1 + (predicted_bearing / max(params.bearing_scale, eps(Float64)))^2)
    closing_speed = Float64(state.window_closing_speed_L)
    positive_closing_ratio = max(closing_speed, 0.0) /
        max(params.closing_speed_scale, eps(Float64))
    progress_deficit = 1 / (1 + positive_closing_ratio^2)
    posterior_emphasis = params.posterior_base_emphasis +
        params.progress_deficit_emphasis * progress_deficit
    posterior_wave_scale = 1 +
        posterior_emphasis * route_alignment
    tail_target = posterior_wave_scale * (
        -q1 - params.tail_lag_gain * qd1 / max(omega, eps(omega))
    )
    symmetric_a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2
    # A smaller share of the same half-cycle residual avoids cancelling the
    # requested turn through an equal anti-phase bias.
    asymmetric_a2 = symmetric_a2 + params.posterior_asymmetry_share *
        params.half_cycle_asymmetry * turn_fraction * abs(symmetric_a2)

    # Smooth candidate-owned limiting avoids a persistent hard-clipped command.
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
