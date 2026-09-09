function target_policy_params()
    return (
        control_period=0.90,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        steering_bias_limit=11.0 * pi / 180,
        bearing_scale=25.0 * pi / 180,
        turn_rate_scale=0.35,
        turn_rate_damping=0.70,
        steering_full_distance_L=6.0,
        steering_relief_width_L=1.5,
        steering_approach_floor=0.70,
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

    # Restore the strongest sampled static-bias and direct-body-rate anchor.
    # It supplies the far-field upstream motion without reacting to target
    # translation as failed bearing-rate variants did.
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

    # The 11 degree sample made the best approach but its persistent mean bend
    # then curled out of the domain. Preserve full authority until that
    # sampled approach region, then smoothly release only the steering bias.
    # Propulsive oscillator and traveling-wave lag remain untouched.
    full_steering_coordinate = clamp(
        (state.distance_L - (
            params.steering_full_distance_L -
                params.steering_relief_width_L
        )) / max(
            params.steering_relief_width_L,
            eps(params.steering_relief_width_L),
        ),
        0.0,
        1.0,
    )
    approach_fade = full_steering_coordinate^2 *
        (3 - 2 * full_steering_coordinate)
    approach_gain = params.steering_approach_floor +
        (1 - params.steering_approach_floor) * approach_fade
    steering_bias = params.steering_bias_limit * steering_fade *
        approach_gain * bounded_steering_command

    # Preserve the sampled traveling bend while steering only through the mean
    # posterior tangent q1 + q2. Steering remains out of the anterior
    # oscillator.
    tail_tangent_target = steering_bias -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    q2_target = tail_tangent_target - q1
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
