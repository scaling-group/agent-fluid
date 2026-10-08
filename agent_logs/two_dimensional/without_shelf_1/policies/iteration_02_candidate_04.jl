function target_policy_params()
    return (
        control_period=0.90,
        oscillator_amplitude=26.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.60,
        tail_damping=0.80,
        steering_bias_limit=8.0 * pi / 180,
        bearing_scale=30.0 * pi / 180,
        bearing_rate_lookahead_time=0.75,
        bearing_rate_correction_limit=12.0 * pi / 180,
        steering_fade_distance_L=0.75,
        steering_fade_width_L=0.75,
        acceleration_command_limit=1500.0 * pi / 180,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Keep steering out of the propulsion oscillator.  Joint state supplies
    # phase, while the slightly reduced amplitude and command cap leave margin
    # for wake-induced motion inside the episode's actuator envelope.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    raw_a1 = vdp_drive - omega^2 * q1

    # A positive body-frame bearing uses the evidence-supported positive mean
    # tail tangent.  Smoothed bearing-rate lead backs off a converging turn and
    # reinforces a diverging one; its independent clamp prevents wake noise
    # from dominating the geometric bearing request.
    rate_limit = params.bearing_rate_correction_limit
    rate_correction = clamp(
        params.bearing_rate_lookahead_time * state.bearing_window_rate,
        -rate_limit,
        rate_limit,
    )
    steering_error = state.bearing + rate_correction

    fade_coordinate = clamp(
        (state.distance_L - params.steering_fade_distance_L) /
            max(params.steering_fade_width_L, eps(params.steering_fade_width_L)),
        0.0,
        1.0,
    )
    steering_fade = fade_coordinate^2 * (3 - 2 * fade_coordinate)
    steering_bias = params.steering_bias_limit * steering_fade * tanh(
        steering_error / max(params.bearing_scale, eps(params.bearing_scale)),
    )

    # Apply the target bias only to the posterior mean tangent, preserving the
    # traveling bend while avoiding the unstable anterior-equilibrium shift in
    # the sampled failure.
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
