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

    # Use a bounded prediction of body-frame bearing after the already-observed
    # heading response. Same-sign turn rate releases steering before overshoot;
    # an opposing wake-induced turn increases correction without a clock or
    # memorized route.
    bearing = clamp(Float64(state.bearing), -pi / 2, pi / 2)
    heading_response = clamp(
        params.heading_response_horizon * Float64(state.heading_rate),
        -params.heading_response_limit,
        params.heading_response_limit,
    )
    predicted_bearing = bearing - heading_response
    turn_fraction = tanh(
        predicted_bearing / max(params.bearing_scale, eps(Float64)),
    )

    # Acceleration half-cycle asymmetry preserves the propulsive equilibrium
    # while converting the response-damped turn request into anterior bending.
    asymmetric_a1 = symmetric_a1 +
        params.half_cycle_asymmetry * turn_fraction * abs(symmetric_a1)

    # Keep the seed's lagged posterior wave dominant, using only a smaller
    # share of the same bounded steering asymmetry at the second joint.
    tail_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    symmetric_a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2
    asymmetric_a2 = symmetric_a2 + params.posterior_asymmetry_share *
        params.half_cycle_asymmetry * turn_fraction * abs(symmetric_a2)

    # A smooth candidate-owned limit avoids handing the experiment hard clip a
    # persistent bang-bang command while leaving the evaluated envelope intact.
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
