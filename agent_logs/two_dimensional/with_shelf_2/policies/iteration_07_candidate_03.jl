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
        yaw_moment_scale=1.0,
        minimum_steering_fraction=0.20,
        acceleration_soft_limit=29.0,
        steering_headroom_fraction=0.65,
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

    # Follow the anterior state with a velocity lag so posterior motion remains
    # a traveling bend. A smaller share of the same half-cycle residual avoids
    # cancelling the requested turn through an equal anti-phase bias.
    tail_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    symmetric_a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Give the propulsive traveling wave first claim on the acceleration
    # envelope.  The old sum-then-limit composition let a reinforcing steering
    # residual flatten both components together near the soft limit.  Recover
    # the residual that composition requested, but allocate it only inside a
    # reserved fraction of same-direction headroom.  A residual which reduces
    # the base magnitude retains full authority.
    limit = params.acceleration_soft_limit
    base_a1 = limit * tanh(symmetric_a1 / limit)
    requested_a1 = limit * tanh((
        symmetric_a1 +
        params.half_cycle_asymmetry * turn_fraction * abs(symmetric_a1)
    ) / limit) - base_a1
    reinforces_a1 = base_a1 * requested_a1 > 0
    headroom_a1 = reinforces_a1 ?
        limit - abs(base_a1) :
        limit + abs(base_a1)
    budget_a1 = (reinforces_a1 ? params.steering_headroom_fraction : 1.0) *
        max(headroom_a1, 0.0)
    allocated_a1 = sign(requested_a1) * min(abs(requested_a1), budget_a1)
    a1 = base_a1 + allocated_a1

    base_a2 = limit * tanh(symmetric_a2 / limit)
    requested_a2 = limit * tanh((
        symmetric_a2 + params.posterior_asymmetry_share *
        params.half_cycle_asymmetry * turn_fraction * abs(symmetric_a2)
    ) / limit) - base_a2
    reinforces_a2 = base_a2 * requested_a2 > 0
    headroom_a2 = reinforces_a2 ?
        limit - abs(base_a2) :
        limit + abs(base_a2)
    budget_a2 = (reinforces_a2 ? params.steering_headroom_fraction : 1.0) *
        max(headroom_a2, 0.0)
    allocated_a2 = sign(requested_a2) * min(abs(requested_a2), budget_a2)
    a2 = base_a2 + allocated_a2

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
