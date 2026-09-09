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
        closing_speed_scale=0.05,
        closing_steering_relief=0.06666666666666667,
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
    # is the demonstrated fixed-prewarm anchor below the acceleration cap.
    phase_radius_sq = (q1 / amp)^2 + (qd1 / (omega * amp))^2
    energy_drive = params.oscillator_energy_gain * tanh(1 - phase_radius_sq) * qd1
    a1_raw = energy_drive - omega^2 * q1

    # A short, bounded bearing lookahead corrects the gross one-sided turn
    # without relying on coordinates, a route, or an external phase clock.
    bearing_rate = clamp(
        state.bearing_window_rate,
        -params.bearing_rate_limit,
        params.bearing_rate_limit,
    )
    predicted_bearing = state.bearing + params.bearing_rate_lead * bearing_rate

    # Preserve the evaluated response while stalled or receding. Once the
    # rolling target window shows useful closure, soften only moderate bearing
    # corrections toward a 0.32 scale so the wake corridor is not abandoned by
    # another broad turn. The bounded gate cannot amplify steering.
    closing_fraction = clamp(
        state.window_closing_speed_L /
        max(params.closing_speed_scale, eps(params.closing_speed_scale)),
        0.0,
        1.0,
    )
    effective_bearing_scale = params.bearing_scale * (
        1 + params.closing_steering_relief * closing_fraction
    )
    steering_bias = -params.steering_limit * tanh(
        predicted_bearing / effective_bearing_scale,
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
