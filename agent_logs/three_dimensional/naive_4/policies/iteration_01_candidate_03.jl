# Target-directed mean-curvature steering around the naive state-feedback
# carrier. All task feedback is normalized and expressed in the body frame.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        curvature_bias_limit=10.0 * pi / 180,
        bearing_scale=20.0 * pi / 180,
        yaw_rate_damping=0.18,
        yaw_rate_limit=2.5,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Positive common curvature produces negative yaw in this actuator
    # convention, which matches the observation adapter's positive bearing.
    bearing = clamp(Float64(state.bearing), -pi / 2, pi / 2)
    yaw_rate = clamp(
        Float64(state.heading_rate),
        -params.yaw_rate_limit,
        params.yaw_rate_limit,
    )
    turn_error = bearing + params.yaw_rate_damping * yaw_rate
    curvature_bias = params.curvature_bias_limit * tanh(
        turn_error / params.bearing_scale,
    )

    # Keep the oscillator phase in joint state and move only its mean bend.
    oscillatory_q1 = q1 - curvature_bias
    vdp_drive = params.oscillator_mu *
        (1 - (oscillatory_q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * oscillatory_q1

    phase_lag_target = curvature_bias - oscillatory_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
