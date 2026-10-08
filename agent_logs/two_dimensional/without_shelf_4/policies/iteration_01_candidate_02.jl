function target_policy_params()
    return (
        control_period=0.80,
        oscillator_amplitude=14.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.55,
        tail_damping=0.90,
        steering_bias_limit=8.0 * pi / 180,
        steering_bearing_scale=0.25,
        steering_rate_lookahead=0.20,
        steering_rate_limit=0.35,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Body-frame bearing supplies a coordinate-free curvature offset. Recent
    # bearing motion anticipates alignment, while tanh keeps the offset small
    # enough to coexist with the propulsion oscillation.
    bearing_rate = clamp(
        state.bearing_window_rate,
        -params.steering_rate_limit,
        params.steering_rate_limit,
    )
    steering_error = state.bearing + params.steering_rate_lookahead * bearing_rate
    steering_bias = params.steering_bias_limit * tanh(
        steering_error / params.steering_bearing_scale,
    )

    # The oscillator phase remains encoded in joint state rather than time.
    # Centering it on the steering bias preserves the rhythmic drive while
    # allowing the mean body curvature to turn toward the target.
    q1_centered = q1 - steering_bias
    vdp_drive = params.oscillator_mu * (1 - (q1_centered / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1_centered

    # The posterior joint follows the centered anterior oscillation with a lag
    # and shares its mean steering curvature.
    phase_lag_target = steering_bias - q1_centered -
                       params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
