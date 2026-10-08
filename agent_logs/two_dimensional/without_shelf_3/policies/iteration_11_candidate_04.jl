function target_policy_params()
    return (
        control_period=0.75,
        oscillator_amplitude=22.0 * pi / 180,
        oscillator_mu=0.5,
        tail_lag_gain=0.55,
        tail_damping=0.95,
        steering_gain=0.60,
        turn_rate_damping_gain=0.04,
        terminal_turn_damping_boost=0.02,
        terminal_distance_L=7.25,
        terminal_distance_transition_L=0.25,
        opening_speed_scale=0.02,
        steering_limit=12.0 * pi / 180,
        anterior_steering_fraction=0.35,
        joint_angle_guard=34.0 * pi / 180,
        joint_speed_guard=200.0 * pi / 180,
        overangle_stiffness=30.0,
        overspeed_damping=6.0,
        acceleration_soft_limit=1600.0 * pi / 180,
        acceleration_softness=8.0,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Preserve the strongest finite sample throughout its useful closing leg.
    # Increase turn damping only after the fish is both inside its demonstrated
    # closest-approach band and moving away over the observation window.
    opening_speed = max(-Float64(state.window_closing_speed_L), 0.0)
    opening_gate = tanh(
        opening_speed /
        max(params.opening_speed_scale, eps(params.opening_speed_scale)),
    )
    distance_gate = 0.5 * (1 - tanh(
        (Float64(state.distance_L) - params.terminal_distance_L) /
        max(
            params.terminal_distance_transition_L,
            eps(params.terminal_distance_transition_L),
        ),
    ))
    terminal_gate = opening_gate * distance_gate
    turn_damping = params.turn_rate_damping_gain +
        params.terminal_turn_damping_boost * terminal_gate
    steering_request =
        params.steering_gain * Float64(state.bearing) -
        turn_damping * Float64(state.turn_rate_recent)
    steering = params.steering_limit * tanh(
        steering_request /
        max(params.steering_limit, eps(params.steering_limit)),
    )
    anterior_bias = params.anterior_steering_fraction * steering
    posterior_bias = (1 - params.anterior_steering_fraction) * steering

    # Run the state-encoded oscillator about the moving steering equilibrium.
    centered_q1 = q1 - anterior_bias
    vdp_drive = params.oscillator_mu * (1 - (centered_q1 / amp)^2) * qd1
    raw_a1 = vdp_drive - omega^2 * centered_q1

    # Retain the posterior traveling lag that supplies the upstream body wave.
    phase_lag_target = posterior_bias - centered_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    raw_a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Local guards oppose only high-angle/high-speed excursions toward the
    # evaluator caps while leaving the demonstrated nominal gait intact.
    angle_excess1 = max(abs(q1) - params.joint_angle_guard, 0.0)
    angle_excess2 = max(abs(q2) - params.joint_angle_guard, 0.0)
    speed_excess1 = max(abs(qd1) - params.joint_speed_guard, 0.0)
    speed_excess2 = max(abs(qd2) - params.joint_speed_guard, 0.0)
    raw_a1 -= params.overangle_stiffness * angle_excess1 * sign(q1) +
        params.overspeed_damping * speed_excess1 * sign(qd1)
    raw_a2 -= params.overangle_stiffness * angle_excess2 * sign(q2) +
        params.overspeed_damping * speed_excess2 * sign(qd2)

    # Smoothly keep policy demand below the hard acceleration envelope.
    accel_limit = params.acceleration_soft_limit
    softness = params.acceleration_softness
    a1 = raw_a1 /
        (1 + (abs(raw_a1) / accel_limit)^softness)^(1 / softness)
    a2 = raw_a2 /
        (1 + (abs(raw_a2) / accel_limit)^softness)^(1 / softness)

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
