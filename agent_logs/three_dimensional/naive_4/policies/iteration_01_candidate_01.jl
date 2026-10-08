# State-feedback traveling bend with bounded target-driven mean curvature.
# Oscillator phase remains entirely in joint state; steering uses only the
# normalized body-frame task observation and measured yaw response.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        steering_bearing_gain=1.0,
        steering_yaw_rate_gain=0.24,
        steering_scale=0.35,
        steering_rate_limit=3.0,
        max_tail_bias=10.0 * pi / 180,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Van der Pol drive: oscillation phase lives in (q1, qd1), not clock time.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1

    # Positive body-frame bearing calls for the negative-yaw bend observed in
    # this joint convention.  Adding yaw rate to the steering state supplies
    # damping: an established turn reduces its own requested curvature.
    bearing = clamp(Float64(state.bearing), -1.0, 1.0)
    yaw_rate = clamp(
        Float64(state.heading_rate),
        -params.steering_rate_limit,
        params.steering_rate_limit,
    )
    steering_state =
        params.steering_bearing_gain * bearing +
        params.steering_yaw_rate_gain * yaw_rate
    mean_tail_bias = params.max_tail_bias * tanh(
        steering_state / max(params.steering_scale, eps(params.steering_scale)),
    )

    phase_lag_target =
        mean_tail_bias - q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
