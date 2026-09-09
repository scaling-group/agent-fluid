function target_policy_params()
    return (
        control_period=0.68,
        oscillator_amplitude=17.0 * pi / 180,
        oscillator_energy_gain=2.0,
        tail_lag_gain=0.45,
        tail_damping=1.05,
        steering_limit=8.0 * pi / 180,
        bearing_scale=0.24,
        bearing_rate_lead=0.55,
        bearing_rate_limit=0.40,
        acceleration_limit=27.0,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Regulate the oscillator's phase-space radius instead of using the hard
    # actuator limits to define its wave.  The shorter period restores authority
    # lost by the sampled low-energy gaits; bounded energy correction and an
    # internal acceleration limit retain a finite response after wake impulses.
    phase_radius_sq =
        (q1 / max(amp, eps(amp)))^2 +
        (qd1 / max(omega * amp, eps(omega * amp)))^2
    energy_drive = params.oscillator_energy_gain *
                   tanh(1 - phase_radius_sq) * qd1
    a1_raw = energy_drive - omega^2 * q1

    # Forward is body -x, so positive bearing calls for a negative tail-tangent
    # bias.  Window-rate anticipation unwinds the turn before bearing crosses
    # zero, while its clamp prevents one noisy history window from dominating.
    bearing_rate = clamp(
        state.bearing_window_rate,
        -params.bearing_rate_limit,
        params.bearing_rate_limit,
    )
    predicted_bearing = state.bearing + params.bearing_rate_lead * bearing_rate
    steering_bias = -params.steering_limit * tanh(
        predicted_bearing / params.bearing_scale,
    )

    # Keep steering out of the anterior oscillator.  The posterior joint alone
    # carries the bounded mean tangent bias on top of a traveling-wave lag.
    phase_lag_target =
        -q1 - params.tail_lag_gain * qd1 / max(omega, eps(omega)) +
        steering_bias
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
