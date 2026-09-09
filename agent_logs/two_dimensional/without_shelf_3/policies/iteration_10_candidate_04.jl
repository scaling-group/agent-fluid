function target_policy_params()
    return (
        control_period=0.75,
        oscillator_amplitude=22.0 * pi / 180,
        oscillator_mu=0.5,
        tail_lag_gain=0.55,
        tail_damping=0.95,
        steering_gain=0.60,
        turn_rate_damping_gain=0.04,
        steering_limit=12.0 * pi / 180,
        opening_speed_scale=0.02,
        opening_steering_floor=0.35,
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

    # Preserve the strongest finite sample's bearing and recent-turn law. Its
    # useful upstream leg ends in an opening-range upper return, so release the
    # saturated mean curvature only after the smoothed range begins opening.
    steering_request =
        params.steering_gain * Float64(state.bearing) -
        params.turn_rate_damping_gain * Float64(state.turn_rate_recent)
    anchor_steering = params.steering_limit * tanh(
        steering_request /
        max(params.steering_limit, eps(params.steering_limit)),
    )
    opening_speed = max(-Float64(state.window_closing_speed_L), 0.0)
    opening_gate = tanh(
        opening_speed /
        max(params.opening_speed_scale, eps(params.opening_speed_scale)),
    )
    steering_scale = 1 -
        (1 - params.opening_steering_floor) * opening_gate
    steering = steering_scale * anchor_steering
    anterior_bias = params.anterior_steering_fraction * steering
    posterior_bias = (1 - params.anterior_steering_fraction) * steering

    # Keep the angle-only Van der Pol drive that supplied active upstream
    # motion; sampled full-orbit radial regulators were finite but advected.
    centered_q1 = q1 - anterior_bias
    vdp_drive = params.oscillator_mu * (1 - (centered_q1 / amp)^2) * qd1
    raw_a1 = vdp_drive - omega^2 * centered_q1

    # The posterior joint retains the velocity-dependent lag that supplied the
    # demonstrated traveling bend while carrying most of the bounded bias.
    phase_lag_target = posterior_bias - centered_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    raw_a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Preserve the local guards that kept the anchor finite and opposed the
    # high-angle/high-speed route to cap contact and folded-body instability.
    angle_excess1 = max(abs(q1) - params.joint_angle_guard, 0.0)
    angle_excess2 = max(abs(q2) - params.joint_angle_guard, 0.0)
    speed_excess1 = max(abs(qd1) - params.joint_speed_guard, 0.0)
    speed_excess2 = max(abs(qd2) - params.joint_speed_guard, 0.0)
    raw_a1 -= params.overangle_stiffness * angle_excess1 * sign(q1) +
        params.overspeed_damping * speed_excess1 * sign(qd1)
    raw_a2 -= params.overangle_stiffness * angle_excess2 * sign(q2) +
        params.overspeed_damping * speed_excess2 * sign(qd2)

    # Smoothly keep policy demand below the evaluator's hard acceleration cap.
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
