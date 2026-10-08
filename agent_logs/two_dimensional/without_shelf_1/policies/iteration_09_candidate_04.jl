function target_policy_params()
    return (
        control_period=0.90,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        posterior_target_limit=42.0 * pi / 180,
        steering_bias_limit=10.0 * pi / 180,
        bearing_scale=25.0 * pi / 180,
        turn_rate_scale=0.35,
        turn_rate_damping=0.70,
        steering_fade_distance_L=0.75,
        steering_fade_width_L=0.75,
        acceleration_command_limit=1650.0 * pi / 180,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Preserve the complete sampled upstream-capable propulsion gait. Its
    # phase remains encoded in joint state rather than elapsed time.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    raw_a1 = vdp_drive - omega^2 * q1

    # Keep the evidence-backed positive bearing sign, but give actual body
    # rotation enough authority to release the persistent posterior bend. The
    # turn-rate term remains bounded and cannot react to target translation as
    # the failed bearing-window-rate variants did.
    steering_command = tanh(state.bearing / params.bearing_scale) -
        params.turn_rate_damping * tanh(
            state.heading_rate / params.turn_rate_scale,
        )
    bounded_steering_command = clamp(steering_command, -1.0, 1.0)

    # Fade inside the final body length, where bearing is poorly conditioned
    # and first-crossing capture will terminate anyway.
    fade_coordinate = clamp(
        (state.distance_L - params.steering_fade_distance_L) /
            max(params.steering_fade_width_L, eps(params.steering_fade_width_L)),
        0.0,
        1.0,
    )
    steering_fade = fade_coordinate^2 * (3 - 2 * fade_coordinate)
    steering_bias = params.steering_bias_limit * steering_fade *
        bounded_steering_command

    # Allocate steering within the posterior joint's phase-dependent target
    # headroom. This preserves the sampled propulsion phase and keeps steering
    # out of the anterior oscillator, while preventing steering from asking an
    # already extreme posterior target to move farther into hard saturation.
    propulsive_q2_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    posterior_limit = params.posterior_target_limit
    bounded_propulsive_q2_target = clamp(
        propulsive_q2_target,
        -posterior_limit,
        posterior_limit,
    )
    steering_lower = -posterior_limit - bounded_propulsive_q2_target
    steering_upper = posterior_limit - bounded_propulsive_q2_target
    allocated_steering_bias = clamp(
        steering_bias,
        steering_lower,
        steering_upper,
    )
    q2_target = bounded_propulsive_q2_target + allocated_steering_bias
    raw_a2 = omega^2 * (q2_target - q2) -
        2 * params.tail_damping * omega * qd2

    limit = params.acceleration_command_limit
    return (
        phi_ddot=(
            clamp(raw_a1, -limit, limit),
            clamp(raw_a2, -limit, limit),
        ),
    )
end
