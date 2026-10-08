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
        approach_distance_scale_L=1.5,
        minimum_approach_steering_fraction=0.40,
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

    # Retain the sampled response lookahead that produced the closest target
    # approach. The fallback preserves the public normalized-policy smoke
    # contract while the formal multi-wake observation supplies heading rate.
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

    # Large normalized yaw moment is evidence that the wake/body interaction
    # is already turning the fish. Smoothly reduce only the steering residual,
    # without assuming the moment sign or suppressing the propulsive wave.
    yaw_load_ratio = abs(Float64(state.moment_z_L2)) /
        max(params.yaw_moment_scale, eps(Float64))
    steering_gate = params.minimum_steering_fraction +
        (1 - params.minimum_steering_fraction) /
        (1 + yaw_load_ratio * yaw_load_ratio)

    # At route-scale distance this factor tends to one. Near the target it
    # relieves only the asymmetric steering residual, retaining a nonzero
    # authority floor while the symmetric traveling bend keeps propelling.
    distance_L = max(Float64(state.distance_L), 0.0)
    approach_ratio = distance_L /
        max(params.approach_distance_scale_L, eps(Float64))
    approach_gate = params.minimum_approach_steering_fraction +
        (1 - params.minimum_approach_steering_fraction) * tanh(approach_ratio)
    turn_fraction = approach_gate * steering_gate * route_turn
    asymmetric_a1 = symmetric_a1 +
        params.half_cycle_asymmetry * turn_fraction * abs(symmetric_a1)

    # The posterior joint follows the asymmetric head state with a velocity lag,
    # translating the steering bias into the existing traveling-bend contract.
    tail_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    symmetric_a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2
    # A smaller posterior share prevents its anti-phase mean from cancelling
    # the gated turn while leaving the lagged wave as the dominant target.
    asymmetric_a2 = symmetric_a2 + params.posterior_asymmetry_share *
        params.half_cycle_asymmetry * turn_fraction * abs(symmetric_a2)

    # Candidate-owned smooth limiting keeps the test focused on half-cycle
    # composition instead of persistent contact with the harder episode clip.
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
