function target_policy_params()
    return (
        control_period=0.67,
        oscillator_amplitude=20.25 * pi / 180,
        oscillator_energy_gain=1.0,
        tail_lag_gain=0.65,
        tail_damping=0.80,
        steering_bias_limit=10.0 * pi / 180,
        steering_bearing_scale=0.30,
        steering_rate_lookahead=0.25,
        steering_rate_limit=0.30,
        heading_rate_relief=0.025,
        heading_rate_limit=0.30,
        acceleration_limit=31.2,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Keep propulsion phase independent of steering. The sampled 20.25-degree
    # shell captured earlier than the otherwise matched 20-degree shell and
    # remains just below the acceleration envelope.
    phase_radius_sq = (q1 / amp)^2 + (qd1 / (omega * amp))^2
    energy_drive = params.oscillator_energy_gain *
                   tanh(1 - phase_radius_sq) * qd1
    a1_raw = energy_drive - omega^2 * q1

    # Preserve the demonstrated target-line lookahead. The small positive
    # heading-rate term tests less yaw damping after the opposite perturbation
    # delayed capture, without changing the target-line rate coefficient.
    bearing_rate = clamp(
        state.bearing_window_rate,
        -params.steering_rate_limit,
        params.steering_rate_limit,
    )
    heading_rate = clamp(
        state.heading_rate,
        -params.heading_rate_limit,
        params.heading_rate_limit,
    )
    steering_error = state.bearing +
                     params.steering_rate_lookahead * bearing_rate +
                     params.heading_rate_relief * heading_rate
    steering_bias = -params.steering_bias_limit * tanh(
        steering_error / params.steering_bearing_scale,
    )

    # Put mean curvature only in the posterior target. The guard remains above
    # the sampled 31.055 maximum and below the episode hard envelope.
    phase_lag_target = steering_bias - q1 -
                       params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2_raw = omega^2 * (phase_lag_target - q2) -
             2 * params.tail_damping * omega * qd2
    a1 = clamp(a1_raw, -params.acceleration_limit, params.acceleration_limit)
    a2 = clamp(a2_raw, -params.acceleration_limit, params.acceleration_limit)

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
