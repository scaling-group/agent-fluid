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
        lateral_velocity_lookahead=0.07,
        lateral_velocity_limit=0.10,
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
    # shell retained capture and improved arrival over the 20-degree parent.
    phase_radius_sq = (q1 / amp)^2 + (qd1 / (omega * amp))^2
    energy_drive = params.oscillator_energy_gain *
                   tanh(1 - phase_radius_sq) * qd1
    a1_raw = energy_drive - omega^2 * q1

    # Retain the sampled anchor's bounded bearing/rate response. Bracket just
    # below the successful counter-drift setting after the stronger inherited
    # continuation caused a late route regression; targetward translation
    # stays exactly on-anchor.
    bearing_rate = clamp(
        state.bearing_window_rate,
        -params.steering_rate_limit,
        params.steering_rate_limit,
    )
    lateral_velocity = clamp(
        state.velocity_body_U[2],
        -params.lateral_velocity_limit,
        params.lateral_velocity_limit,
    )
    away_drift = max(-state.bearing * lateral_velocity, zero(lateral_velocity))
    away_drift_scale = params.steering_bearing_scale *
                       params.lateral_velocity_limit
    away_drift_weight = tanh(
        away_drift / max(away_drift_scale, eps(away_drift_scale)),
    )
    steering_error = state.bearing +
                     params.steering_rate_lookahead * bearing_rate -
                     params.lateral_velocity_lookahead * away_drift_weight *
                     lateral_velocity
    steering_bias = -params.steering_bias_limit * tanh(
        steering_error / params.steering_bearing_scale,
    )

    # The posterior joint supplies traveling-wave lag and the mean steering
    # bend. The sampled local guard remained above the observed anterior
    # acceleration and below the episode envelope, so it should not define the
    # gait.
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
