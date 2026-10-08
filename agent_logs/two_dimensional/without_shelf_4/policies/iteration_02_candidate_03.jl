function target_policy_params()
    return (
        control_period=0.65,
        oscillator_amplitude=18.0 * pi / 180,
        oscillator_energy_gain=0.85,
        tail_lag_gain=0.70,
        tail_damping=0.80,
        steering_bias_limit=8.0 * pi / 180,
        steering_bearing_scale=0.30,
        steering_rate_lookahead=0.20,
        steering_rate_limit=0.35,
        acceleration_limit=30.0,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Keep target steering out of the anterior oscillator state so the initial
    # joint pose cannot become an accidental zero-energy equilibrium.
    phase_radius_sq = (q1 / amp)^2 + (qd1 / (omega * amp))^2
    energy_drive = params.oscillator_energy_gain *
                   tanh(1 - phase_radius_sq) * qd1
    a1_raw = energy_drive - omega^2 * q1

    # Test a negative posterior tangent bias for positive body-frame bearing.
    # A clipped recent rate provides bounded lead as the target line rotates.
    bearing_rate = clamp(
        state.bearing_window_rate,
        -params.steering_rate_limit,
        params.steering_rate_limit,
    )
    steering_error = state.bearing + params.steering_rate_lookahead * bearing_rate
    steering_bias = -params.steering_bias_limit * tanh(
        steering_error / params.steering_bearing_scale,
    )

    # The posterior joint supplies both traveling-wave lag and the small mean
    # steering bend. The policy-local clamp guards transients below the episode
    # hard envelope; it is not intended to define the nominal oscillation.
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
