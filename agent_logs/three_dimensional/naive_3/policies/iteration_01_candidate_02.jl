# Target-locked mean-curvature extension of the naive traveling-bend carrier.
# Oscillator phase remains entirely in joint state; steering uses only
# normalized body-frame target geometry and measured body yaw rate.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        steering_curvature_limit=10.0 * pi / 180,
        steering_bearing_limit=pi / 2,
        steering_bearing_scale=0.35,
        steering_rate_limit=4.0,
        steering_rate_feedback_time=0.12,
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

    # A positive body-frame bearing asks for the negative-yaw correction needed
    # by the head-facing (-x) body convention. Positive mean tail tangent has
    # that response; measured yaw rate releases the bias as the turn develops.
    bearing = clamp(
        Float64(state.bearing),
        -params.steering_bearing_limit,
        params.steering_bearing_limit,
    )
    heading_rate = clamp(
        Float64(state.heading_rate),
        -params.steering_rate_limit,
        params.steering_rate_limit,
    )
    steering_signal =
        bearing + params.steering_rate_feedback_time * heading_rate
    mean_tail_tangent = params.steering_curvature_limit * tanh(
        steering_signal / max(params.steering_bearing_scale, eps(Float64)),
    )

    # Bias the mean posterior tangent without replacing the demonstrated
    # posterior lag, so steering is superposed on the propulsive body wave.
    phase_lag_target = mean_tail_tangent - q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
