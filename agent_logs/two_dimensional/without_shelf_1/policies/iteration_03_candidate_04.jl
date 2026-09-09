function target_policy_params()
    return (
        control_period=0.90,
        oscillator_amplitude=22.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.70,
        tail_damping=0.80,
        steering_bias_limit=9.0 * pi / 180,
        bearing_scale=25.0 * pi / 180,
        bearing_rate_time=0.08,
        bearing_rate_limit=1.0,
        steering_argument_limit=60.0 * pi / 180,
        steering_fade_distance_L=0.75,
        steering_fade_width_L=0.75,
        acceleration_command_limit=1450.0 * pi / 180,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Keep propulsion state-driven and centered at zero. The reduced amplitude
    # retains the sampled upstream-capable period while leaving room for the
    # posterior steering bend inside the joint and rate envelopes.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    raw_a1 = vdp_drive - omega^2 * q1

    # Positive bearing-to-posterior-tail bias is the only sampled sign that
    # produced upstream target progress. A clipped short-window rate term eases
    # that bias while bearing is already closing and adds lead while it grows.
    bearing_rate = clamp(
        state.bearing_window_rate,
        -params.bearing_rate_limit,
        params.bearing_rate_limit,
    )
    steering_argument = clamp(
        state.bearing + params.bearing_rate_time * bearing_rate,
        -params.steering_argument_limit,
        params.steering_argument_limit,
    )
    fade_coordinate = clamp(
        (state.distance_L - params.steering_fade_distance_L) /
            max(params.steering_fade_width_L, eps(params.steering_fade_width_L)),
        0.0,
        1.0,
    )
    steering_fade = fade_coordinate^2 * (3 - 2 * fade_coordinate)
    steering_bias = params.steering_bias_limit * steering_fade *
        tanh(steering_argument / params.bearing_scale)

    # Steer only through the cumulative posterior tangent. Do not move the
    # anterior oscillator equilibrium: that sampled architecture curled and
    # became unstable immediately.
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
