function target_policy_params()
    return (
        control_period=0.67,
        oscillator_amplitude=20.25 * pi / 180,
        oscillator_energy_gain=1.0,
        tail_lag_gain=0.65,
        tail_damping=0.80,
        steering_limit=10.0 * pi / 180,
        bearing_scale=0.30,
        bearing_rate_lead=0.25,
        bearing_rate_limit=0.30,
        heading_rate_lead=0.05,
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

    # Keep propulsion phase independent of steering and regulate the clock-free
    # oscillator on a bounded phase-space energy shell. The 20.25-degree shell
    # is a conservative interpolation above the replicated 20-degree capture.
    phase_radius_sq = (q1 / amp)^2 + (qd1 / (omega * amp))^2
    energy_drive = params.oscillator_energy_gain * tanh(1 - phase_radius_sq) * qd1
    a1_raw = energy_drive - omega^2 * q1

    # Keep the demonstrated bearing lookahead. Add a separately bounded body-
    # rotation correction only while the fish is turning away from the target;
    # useful targetward turns remain exactly on the sampled anchor.
    bearing_rate = clamp(
        state.bearing_window_rate,
        -params.bearing_rate_limit,
        params.bearing_rate_limit,
    )
    heading_rate = clamp(
        state.heading_rate,
        -params.heading_rate_limit,
        params.heading_rate_limit,
    )
    turn_away = max(-state.bearing * heading_rate, zero(heading_rate))
    turn_away_scale = params.bearing_scale * params.heading_rate_limit
    turn_away_weight = tanh(
        turn_away / max(turn_away_scale, eps(turn_away_scale)),
    )
    predicted_bearing = state.bearing +
                        params.bearing_rate_lead * bearing_rate -
                        params.heading_rate_lead * turn_away_weight * heading_rate
    steering_bias = -params.steering_limit * tanh(
        predicted_bearing / params.bearing_scale,
    )

    # Put the mean curvature only in the posterior target, leaving the anterior
    # propulsion shell symmetric. The velocity term supplies the traveling lag.
    phase_lag_target = -q1 -
                       params.tail_lag_gain * qd1 / max(omega, eps(omega)) +
                       steering_bias
    a2_raw = omega^2 * (phase_lag_target - q2) -
             2 * params.tail_damping * omega * qd2

    # Keep unexpected coupled transients below the episode hard envelope. The
    # guard remains above the 31.08 nominal anterior scale and should stay idle.
    a1 = clamp(a1_raw, -params.acceleration_limit, params.acceleration_limit)
    a2 = clamp(a2_raw, -params.acceleration_limit, params.acceleration_limit)

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
