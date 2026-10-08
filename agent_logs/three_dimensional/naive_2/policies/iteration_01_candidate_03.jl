# Target-bearing mean-curvature steering around the naive state-feedback gait.
# The carrier remains clock-free; target geometry only moves its bounded center.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        max_curvature_bias=9.0 * pi / 180,
        bearing_scale=0.35,
        heading_rate_damping=0.10,
        heading_rate_limit=2.0,
        tail_bias_ratio=0.8,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Positive bias produces negative yaw for this body's calibrated FSI sign.
    # Heading-rate damping increases authority against wrong-way yaw and
    # releases it once the requested yaw response develops.
    bearing = clamp(Float64(state.bearing), -1.4, 1.4)
    heading_rate = clamp(
        Float64(state.heading_rate),
        -params.heading_rate_limit,
        params.heading_rate_limit,
    )
    turn_request = bearing + params.heading_rate_damping * heading_rate
    curvature_bias = params.max_curvature_bias * tanh(
        turn_request / max(params.bearing_scale, eps(Float64)),
    )

    # Van der Pol phase remains in observed joint state.  Shifting its center
    # creates mean curvature without replacing the propulsive limit cycle.
    q1_centered = q1 - curvature_bias
    vdp_drive = params.oscillator_mu * (1 - (q1_centered / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1_centered

    phase_lag_target = params.tail_bias_ratio * curvature_bias -
        q1_centered - params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
