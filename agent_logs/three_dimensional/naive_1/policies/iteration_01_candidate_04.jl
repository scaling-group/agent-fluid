# Target-bearing mean-curvature steering around the seed's state-feedback
# traveling bend.  Oscillator phase remains entirely in observed joint state.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        curvature_bias_limit=9.0 * pi / 180,
        curvature_bearing_scale=0.30,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # A smooth odd target-bearing map supplies bounded average curvature.  The
    # calibrated FSI convention is positive common bias -> negative yaw.
    bearing = clamp(Float64(state.bearing), -pi / 2, pi / 2)
    curvature_bias = params.curvature_bias_limit *
        tanh(bearing / max(params.curvature_bearing_scale, eps(Float64)))

    # Preserve the seed rhythm around the requested mean bend.  Phase lives in
    # observed (q1, qd1), never elapsed time or an external oscillator state.
    q1_centered = q1 - curvature_bias
    vdp_drive = params.oscillator_mu * (1 - (q1_centered / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1_centered

    # Centering the posterior target on the same curvature retains the seed's
    # lagged traveling wave instead of trading propulsion for a static turn.
    phase_lag_target = curvature_bias - q1_centered -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
