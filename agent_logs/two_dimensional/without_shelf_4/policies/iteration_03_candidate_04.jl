function target_policy_params()
    return (
        control_period=0.69,
        oscillator_amplitude=21.0 * pi / 180,
        oscillator_energy_gain=1.0,
        tail_lag_gain=0.65,
        tail_damping=0.80,
        steering_limit=10.0 * pi / 180,
        bearing_scale=0.38,
        bearing_rate_lead=0.25,
        bearing_rate_limit=0.30,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Keep propulsion independent of steering and regulate the clock-free
    # oscillator on a bounded phase-space energy shell. The nominal anterior
    # rate and acceleration scales remain below the episode hard limits.
    phase_radius_sq = (q1 / amp)^2 + (qd1 / (omega * amp))^2
    energy_drive = params.oscillator_energy_gain * tanh(1 - phase_radius_sq) * qd1
    a1 = energy_drive - omega^2 * q1

    # Use only target-relative body-frame feedback. Clipped bearing-rate lead
    # unwinds broad turns, and the softened near-axis scale preserves a strong
    # bounded command far from alignment without hard-coding a route.
    bearing_rate = clamp(
        state.bearing_window_rate,
        -params.bearing_rate_limit,
        params.bearing_rate_limit,
    )
    predicted_bearing = state.bearing + params.bearing_rate_lead * bearing_rate
    steering_bias = -params.steering_limit * tanh(
        predicted_bearing / params.bearing_scale,
    )

    # Put mean curvature only in the posterior target so bearing correction
    # cannot extinguish or offset the anterior propulsion oscillator.
    phase_lag_target = -q1 -
                       params.tail_lag_gain * qd1 / max(omega, eps(omega)) +
                       steering_bias
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
