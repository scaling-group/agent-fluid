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
        aligned_posterior_emphasis=0.10,
        progress_posterior_emphasis=0.05,
        progress_tail_lag_shift=0.08,
        body_speed_floor=0.05,
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

    # Preserve the lagged traveling bend while using modest extra posterior
    # motion when the predicted body-frame route is aligned. Admit a second,
    # smaller envelope only when recent observed motion actually closes target
    # distance. Normalizing by body speed makes this a bounded progress ratio
    # rather than a dimensional closing-speed threshold.
    route_alignment = 1 /
        (1 + (predicted_bearing / max(params.bearing_scale, eps(Float64)))^2)
    body_speed = hasproperty(state, :velocity_body_U) ?
        hypot(
            Float64(getproperty(state, :velocity_body_U)[1]),
            Float64(getproperty(state, :velocity_body_U)[2]),
        ) : 0.0
    closing_speed = hasproperty(state, :window_closing_speed_L) ?
        Float64(getproperty(state, :window_closing_speed_L)) :
        (hasproperty(state, :closing_speed_L) ?
            Float64(getproperty(state, :closing_speed_L)) : 0.0)
    closure_efficiency = clamp(
        max(closing_speed, 0.0) / max(body_speed, params.body_speed_floor),
        0.0,
        1.0,
    )
    phase_gate = route_alignment * closure_efficiency
    posterior_wave_scale = 1 + route_alignment * (
        params.aligned_posterior_emphasis +
        params.progress_posterior_emphasis * closure_efficiency
    )
    # Once observed motion is aligned and closing, rotate the posterior wave
    # slightly farther in its existing quadrature direction. Compensating the
    # ideal sinusoidal norm isolates timing from another amplitude increase;
    # with no useful closure this reduces exactly to the inherited lag.
    effective_tail_lag = params.tail_lag_gain +
        params.progress_tail_lag_shift * phase_gate
    lag_norm_compensation = sqrt(
        (1 + params.tail_lag_gain^2) /
        (1 + effective_tail_lag^2),
    )
    tail_target = posterior_wave_scale * lag_norm_compensation * (
        -q1 - effective_tail_lag * qd1 / max(omega, eps(omega))
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
