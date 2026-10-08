function target_policy_params()
    return (
        control_period=1.00,
        oscillator_amplitude=24.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.70,
        tail_damping=0.85,
        steering_bias_limit=6.0 * pi / 180,
        bearing_scale=25.0 * pi / 180,
        heading_rate_horizon=0.30,
        steering_fade_distance_L=0.75,
        steering_fade_width_L=0.75,
        acceleration_command_limit=1200.0 * pi / 180,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Joint state carries propulsion phase.  The moderate period and amplitude
    # retain the upstream-producing gait while reducing nominal speed and
    # acceleration relative to the saturated best-progress sample.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    raw_a1 = vdp_drive - omega^2 * q1

    # Positive bearing-to-tail-tangent feedback is the only sampled steering
    # sign that approached the target.  Heading-rate damping reduces its mean
    # bend during a rapid turn, addressing the observed post-approach loop.
    steering_request = state.bearing -
        params.heading_rate_horizon * state.heading_rate
    fade_coordinate = clamp(
        (state.distance_L - params.steering_fade_distance_L) /
            max(params.steering_fade_width_L, eps(params.steering_fade_width_L)),
        0.0,
        1.0,
    )
    steering_fade = fade_coordinate^2 * (3 - 2 * fade_coordinate)
    steering_bias = params.steering_bias_limit * steering_fade *
        tanh(steering_request / params.bearing_scale)

    # Steer only through the posterior tail tangent; shifting the first-joint
    # oscillator equilibrium caused immediate unstable curling in prior data.
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
