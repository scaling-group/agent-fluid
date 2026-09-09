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
        crossflow_rejection_gain=0.15,
        crossflow_scale=0.15,
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
    # is the strongest demonstrated fixed-prewarm capture below the hard cap.
    phase_radius_sq = (q1 / amp)^2 + (qd1 / (omega * amp))^2
    energy_drive = params.oscillator_energy_gain * tanh(1 - phase_radius_sq) * qd1
    a1_raw = energy_drive - omega^2 * q1

    # Preserve the demonstrated bearing loop: isolated 0.20 and 0.30 rate-lead
    # probes both lengthened the route relative to the 0.25 anchor.
    bearing_rate = clamp(
        state.bearing_window_rate,
        -params.bearing_rate_limit,
        params.bearing_rate_limit,
    )
    predicted_bearing = state.bearing + params.bearing_rate_lead * bearing_rate

    # Add a small body-frame counter-bend against water-relative crossflow.
    # Its tanh is separately bounded, and the combined signal remains inside
    # the existing steering saturator, so wake rejection cannot add authority.
    relative_crossflow = state.relative_flow_velocity_body_U[2]
    crossflow_rejection = params.crossflow_rejection_gain * tanh(
        relative_crossflow / params.crossflow_scale,
    )
    steering_signal = predicted_bearing / params.bearing_scale -
                      crossflow_rejection
    steering_bias = -params.steering_limit * tanh(steering_signal)

    # Put the mean curvature only in the posterior target, leaving the anterior
    # propulsion shell symmetric. The velocity term supplies the traveling lag.
    phase_lag_target = -q1 -
                       params.tail_lag_gain * qd1 / max(omega, eps(omega)) +
                       steering_bias
    a2_raw = omega^2 * (phase_lag_target - q2) -
             2 * params.tail_damping * omega * qd2

    # Keep unexpected coupled transients below the episode hard envelope. The
    # demonstrated maximum stayed below this guard, so it should remain idle.
    a1 = clamp(a1_raw, -params.acceleration_limit, params.acceleration_limit)
    a2 = clamp(a2_raw, -params.acceleration_limit, params.acceleration_limit)

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
