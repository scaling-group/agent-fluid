# Target-relative mean-curvature candidate for the 3D moving-window EvE lane.
# Propulsive phase remains entirely in joint state; only the observed body-frame
# target bearing and its short-window trend modulate posterior mean curvature.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        turn_curvature_limit=12.0 * pi / 180,
        bearing_limit=pi / 2,
        bearing_scale=0.20,
        bearing_trend_lead=0.15,
        bearing_trend_limit=2.0,
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

    # The seed rollout crossed the target centerline and then continued into a
    # domain-exit hook.  Lead the bounded bearing command by only the observed
    # short-window trend, so curvature changes sign near a crossing without a
    # clock, route, or world-frame direction.
    raw_bearing = Float64(state.bearing)
    raw_bearing_trend = Float64(state.bearing_window_rate)
    bearing = isfinite(raw_bearing) ?
        clamp(raw_bearing, -params.bearing_limit, params.bearing_limit) : 0.0
    bearing_trend = isfinite(raw_bearing_trend) ?
        clamp(raw_bearing_trend, -params.bearing_trend_limit, params.bearing_trend_limit) : 0.0
    predicted_bearing = bearing + params.bearing_trend_lead * bearing_trend
    turn_curvature = params.turn_curvature_limit *
        tanh(predicted_bearing / max(params.bearing_scale, eps(Float64)))

    phase_lag_target = turn_curvature - q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
