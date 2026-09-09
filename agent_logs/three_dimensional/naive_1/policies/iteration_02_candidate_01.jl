# Response-gated posterior-curvature steering for the 3D moving-window lane.
# Propulsive phase remains in joint state; target bearing and its observed
# response only shift the posterior mean bend, without a clock or world route.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        turn_curvature_limit=14.0 * pi / 180,
        turn_signal_scale=0.30,
        bearing_limit=1.0,
        bearing_rate_limit=2.0,
        bearing_trend_lead_T=0.35,
        turn_rate_limit=2.0,
        yaw_rate_damping_T=0.22,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Preserve the evidenced seed carrier without moving the anterior
    # oscillator's equilibrium or changing its scalar gait.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1

    # Positive posterior curvature produces negative yaw for this FSI body.
    # Bearing trend predicts a centerline crossing; recent yaw rate supplies
    # additional response damping. Both are short state histories exposed by
    # the adapter, not elapsed time or a hidden controller state.
    bearing = clamp(
        Float64(state.bearing),
        -params.bearing_limit,
        params.bearing_limit,
    )
    bearing_trend = clamp(
        Float64(state.bearing_window_rate),
        -params.bearing_rate_limit,
        params.bearing_rate_limit,
    )
    turn_rate = clamp(
        Float64(state.turn_rate_recent),
        -params.turn_rate_limit,
        params.turn_rate_limit,
    )
    predicted_bearing = bearing +
        params.bearing_trend_lead_T * bearing_trend +
        params.yaw_rate_damping_T * turn_rate
    mean_curvature = params.turn_curvature_limit * tanh(
        predicted_bearing / max(params.turn_signal_scale, eps(params.turn_signal_scale)),
    )

    phase_lag_target = mean_curvature - q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
