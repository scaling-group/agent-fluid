function target_policy_params()
    return (
        control_period=0.75,
        oscillator_amplitude=22.0 * pi / 180,
        oscillator_mu=0.5,
        tail_lag_gain=0.55,
        tail_damping=0.95,
        steering_gain=0.60,
        turn_rate_damping_gain=0.05,
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

    # Interpolate uniformly between the 0.04 upper-U-turn result and the 0.06
    # downstream-return result. The evaluated range gate degraded the approach.
    steering_request =
        params.steering_gain * Float64(state.bearing) -
        params.turn_rate_damping_gain * Float64(state.turn_rate_recent)
    steering = params.steering_limit * tanh(
        steering_request /
        max(params.steering_limit, eps(params.steering_limit)),
    )
    anterior_bias = params.anterior_steering_fraction * steering
    posterior_bias = (1 - params.anterior_steering_fraction) * steering

    # Keep the angle-only Van der Pol drive that supplied active upstream
    # motion; sampled full-orbit radial regulators were finite but advected.
    centered_q1 = q1 - anterior_bias
    vdp_drive = params.oscillator_mu * (1 - (centered_q1 / amp)^2) * qd1
    raw_a1 = vdp_drive - omega^2 * centered_q1

    # The posterior joint carries most mean curvature while retaining the
    # velocity-dependent lag that supplied the demonstrated traveling bend.
    phase_lag_target = posterior_bias - centered_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    raw_a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Local guards oppose only the high-angle/high-speed route that preceded
    # cap contact and folded-body instability in the unguarded rollout.
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
