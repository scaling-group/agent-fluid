function target_policy_params()
    return (
        control_period=0.68,
        oscillator_amplitude=22.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.65,
        tail_damping=0.75,
        bearing_scale=0.35,
        bearing_rate_horizon=0.30,
        bearing_rate_offset_limit=12.0 * pi / 180,
        half_cycle_asymmetry=0.45,
        tail_curvature_limit=10.0 * pi / 180,
        steering_joint_soft_limit=34.0 * pi / 180,
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

    # Predict a bounded body-frame direction error over only a fraction of a
    # beat. A closing bearing therefore releases steering before target
    # crossover, while a wake-driven growing error receives an earlier reply.
    bearing = clamp(Float64(state.bearing), -pi / 2, pi / 2)
    bearing_rate_offset = clamp(
        params.bearing_rate_horizon * Float64(state.bearing_window_rate),
        -params.bearing_rate_offset_limit,
        params.bearing_rate_offset_limit,
    )
    steering_error = clamp(bearing + bearing_rate_offset, -pi / 2, pi / 2)
    turn_fraction = tanh(steering_error / params.bearing_scale)

    # Retain the evaluated zero-centered anterior oscillator. Its half-cycle
    # asymmetry recovered upstream travel without subtracting the initialized
    # bend, but taper that extra authority before it pushes against the joint
    # envelope; the symmetric restoring acceleration remains active there.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    symmetric_a1 = vdp_drive - omega^2 * q1
    head_ratio = abs(q1) / max(params.steering_joint_soft_limit, eps(Float64))
    head_steering_envelope = clamp(1 - head_ratio^4, 0.0, 1.0)
    raw_a1 = symmetric_a1 + head_steering_envelope *
        params.half_cycle_asymmetry * turn_fraction * abs(symmetric_a1)

    # Separate steering from propulsion at the posterior joint. The total-tail
    # tangent keeps the velocity-lagged wave, while target response enters as a
    # bounded mean curvature instead of a second acceleration asymmetry.
    tail_ratio = abs(q2) / max(params.steering_joint_soft_limit, eps(Float64))
    tail_steering_envelope = clamp(1 - tail_ratio^4, 0.0, 1.0)
    tail_mean_curvature = tail_steering_envelope *
        params.tail_curvature_limit * turn_fraction
    q2_target = tail_mean_curvature - q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    raw_a2 = omega^2 * (q2_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Candidate-owned smooth limiting keeps steering transients inside the
    # episode's harder acceleration envelope.
    limit = params.acceleration_soft_limit
    a1 = limit * tanh(raw_a1 / limit)
    a2 = limit * tanh(raw_a2 / limit)

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
