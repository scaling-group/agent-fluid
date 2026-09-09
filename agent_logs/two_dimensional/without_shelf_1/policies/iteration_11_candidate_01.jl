function target_policy_params()
    return (
        control_period=0.90,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        steering_bias_limit=10.0 * pi / 180,
        bearing_scale=25.0 * pi / 180,
        turn_rate_scale=0.35,
        turn_rate_damping=0.70,
        phase_relief_scale=12.0 * pi / 180,
        phase_relief_floor=0.80,
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
    base_steering_bias = params.steering_bias_limit * steering_fade *
        bounded_steering_command

    # Anticipate the posterior traveling-wave target before steering is added.
    # Relieve bias only on the half-cycle where its signed request reinforces
    # that excursion; unlike the failed measured soft stop, this acts before
    # the joint reaches its boundary. Full bias remains available when it
    # opposes the nominal excursion.
    nominal_q2_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    reinforcing_excursion = bounded_steering_command * nominal_q2_target
    reinforcement_coordinate = clamp(
        reinforcing_excursion /
            max(params.phase_relief_scale, eps(params.phase_relief_scale)),
        0.0,
        1.0,
    )
    reinforcement_gate = reinforcement_coordinate^2 *
        (3 - 2 * reinforcement_coordinate)
    phase_gain = 1 -
        (1 - params.phase_relief_floor) * reinforcement_gate
    steering_bias = phase_gain * base_steering_bias

    # Preserve the sampled traveling bend while steering only through the
    # posterior tangent q1 + q2. Steering remains out of the anterior
    # oscillator and gait phase is encoded entirely in joint state.
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
