# Bearing-gated redirect around the evidenced traveling-bend carrier.
# Phase remains entirely in observed joint state.  Target steering uses only
# bounded body-frame geometry and measured yaw response.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        bearing_limit=1.0,
        curvature_error_scale=0.45,
        yaw_rate_scale=1.0,
        yaw_response_damping=0.45,
        redirect_bearing_scale=0.70,
        cruise_curvature_limit=7.0 * pi / 180,
        redirect_curvature_limit=12.0 * pi / 180,
        tail_curvature_share=0.8,
        command_limit=30.0,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

    # Positive curvature produces negative yaw for this spine convention.
    # Thus a measured negative yaw response releases a positive target request.
    bearing = clamp(
        Float64(state.bearing),
        -params.bearing_limit,
        params.bearing_limit,
    )
    yaw_rate = hasproperty(state, :turn_rate_recent) ?
        Float64(state.turn_rate_recent) :
        Float64(state.heading_rate)
    yaw_response = tanh(
        yaw_rate / max(params.yaw_rate_scale, eps(Float64)),
    )
    steering_error = bearing + params.yaw_response_damping * yaw_response

    # Keep the evidenced cruise authority at small errors.  Large observed
    # bearing continuously recruits a stronger bounded redirect; there is no
    # clock, hidden stage, fixed route, or world-frame direction.
    redirect_weight = tanh(
        abs(bearing) / max(params.redirect_bearing_scale, eps(Float64)),
    )^2
    curvature_authority =
        params.cruise_curvature_limit +
        redirect_weight *
        (params.redirect_curvature_limit - params.cruise_curvature_limit)
    mean_curvature = curvature_authority * tanh(
        steering_error / max(params.curvature_error_scale, eps(Float64)),
    )

    # Full anterior centering is retained because posterior-heavy siblings lost
    # propulsion and route authority.  Oscillator phase stays in (q1, qd1).
    centered_q1 = q1 - mean_curvature
    vdp_drive =
        params.oscillator_mu * (1 - (centered_q1 / amp)^2) * qd1
    raw_a1 = vdp_drive - omega^2 * centered_q1

    # Preserve the posterior lagged bend and distribute the slow mean curvature
    # without replacing the propulsive oscillation.
    phase_lag_target =
        params.tail_curvature_share * mean_curvature -
        centered_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    raw_a2 =
        omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Retain deterministic reserve below the 1800 deg/T^2 episode envelope.
    a1 = clamp(raw_a1, -params.command_limit, params.command_limit)
    a2 = clamp(raw_a2, -params.command_limit, params.command_limit)
    return (phi_ddot=(a1, a2),)
end
