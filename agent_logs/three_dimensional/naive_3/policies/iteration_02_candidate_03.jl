# Target-relative half-cycle steering for the 3D moving-window lane.
# Oscillation phase remains entirely in observed joint state. Steering changes
# posterior bend amplitude by beat side without time or world coordinates.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        tail_asymmetry_limit=0.35,
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

    # Bearing and its observed short-window trend specify only a bounded turn
    # request. Non-finite startup measurements release steering safely.
    raw_bearing = Float64(state.bearing)
    raw_bearing_trend = Float64(state.bearing_window_rate)
    bearing = isfinite(raw_bearing) ?
        clamp(raw_bearing, -params.bearing_limit, params.bearing_limit) : 0.0
    bearing_trend = isfinite(raw_bearing_trend) ?
        clamp(raw_bearing_trend, -params.bearing_trend_limit, params.bearing_trend_limit) : 0.0
    predicted_bearing = bearing + params.bearing_trend_lead * bearing_trend
    turn_command = tanh(predicted_bearing / max(params.bearing_scale, eps(Float64)))

    # Infer beat side from the state-derived posterior wave. Strengthen the
    # requested-curvature half-cycle and weaken its opposite, avoiding the
    # held joint-center bias that suppressed propulsion in prior evidence.
    base_tail_target = -q1 - params.tail_lag_gain * qd1 / max(omega, eps(omega))
    posterior_side = tanh(base_tail_target / max(amp, eps(Float64)))
    half_cycle_gain = 1.0 +
        params.tail_asymmetry_limit * turn_command * posterior_side
    phase_lag_target = half_cycle_gain * base_tail_target
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
