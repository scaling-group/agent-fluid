function target_policy_params()
    return (
        control_period=0.90,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        steering_bias_limit=8.0 * pi / 180,
        bearing_scale=25.0 * pi / 180,
        bearing_rate_scale=0.35,
        bearing_rate_damping=0.35,
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

    # The oscillator phase remains encoded in joint state rather than time. At
    # this period its nominal speed and acceleration fit inside the episode's
    # documented actuator envelope.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    raw_a1 = vdp_drive - omega^2 * q1

    # Keep the evidence-backed positive bearing sign, but oppose a growing
    # bearing with bounded rate feedback before the mean bend builds into the
    # sampled broad loop.  Steering remains wholly in the posterior target.
    bearing_command = tanh(state.bearing / params.bearing_scale) -
        params.bearing_rate_damping * tanh(
            state.bearing_window_rate / params.bearing_rate_scale,
        )
    bounded_bearing_command = clamp(bearing_command, -1.0, 1.0)

    # Fade inside the final body length, where bearing is poorly conditioned
    # and the first-crossing capture will terminate anyway.
    fade_coordinate = clamp(
        (state.distance_L - params.steering_fade_distance_L) /
            max(params.steering_fade_width_L, eps(params.steering_fade_width_L)),
        0.0,
        1.0,
    )
    steering_fade = fade_coordinate^2 * (3 - 2 * fade_coordinate)
    steering_bias = params.steering_bias_limit * steering_fade *
        bounded_bearing_command

    # Preserve the sampled seed's traveling bend while steering through the
    # mean tail tangent q1 + q2 rather than shifting the propulsion oscillator.
    tail_tangent_target = steering_bias -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    q2_target = tail_tangent_target - q1
    raw_a2 = omega^2 * (q2_target - q2) -
        2 * params.tail_damping * omega * qd2

    limit = params.acceleration_command_limit
    a1 = clamp(raw_a1, -limit, limit)
    a2 = clamp(raw_a2, -limit, limit)

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
