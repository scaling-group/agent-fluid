# Response-gated posterior redirect for the 3D moving-window lane. The best
# sampled bearing/trend cruise carrier is retained; only large predicted
# body-frame errors trade posterior beat amplitude for bounded curvature.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        bearing_limit=pi / 2,
        bearing_scale=0.20,
        bearing_trend_lead=0.15,
        bearing_trend_limit=2.0,
        cruise_curvature_limit=12.0 * pi / 180,
        redirect_curvature_limit=26.0 * pi / 180,
        redirect_onset=0.30,
        redirect_transition_width=0.08,
        redirect_carrier_scale=0.30,
        tail_target_limit=40.0 * pi / 180,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

    # Van der Pol drive: oscillation phase lives in (q1, qd1), not clock time.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1

    # Lead the body-frame bearing by its measured trend. Non-finite inputs are
    # neutral, and every geometry-to-actuation map remains bounded.
    raw_bearing = Float64(state.bearing)
    raw_bearing_trend = Float64(state.bearing_window_rate)
    bearing = isfinite(raw_bearing) ?
        clamp(raw_bearing, -params.bearing_limit, params.bearing_limit) : 0.0
    bearing_trend = isfinite(raw_bearing_trend) ?
        clamp(
            raw_bearing_trend,
            -params.bearing_trend_limit,
            params.bearing_trend_limit,
        ) : 0.0
    predicted_bearing = bearing + params.bearing_trend_lead * bearing_trend
    turn_request = tanh(
        predicted_bearing / max(params.bearing_scale, eps(Float64)),
    )

    # A smooth, observation-gated redirect leaves the proven small-error
    # cruise nearly unchanged. As predicted error grows, posterior mean bend
    # rises while both carrier half-cycles recede. Bearing-trend recovery moves
    # the same blend back toward full traveling-wave propulsion.
    redirect_weight = 0.5 * (
        1 + tanh(
            (abs(predicted_bearing) - params.redirect_onset) /
            max(params.redirect_transition_width, eps(Float64)),
        )
    )
    curvature_limit = params.cruise_curvature_limit + redirect_weight * (
        params.redirect_curvature_limit - params.cruise_curvature_limit
    )
    mean_tail_tangent = curvature_limit * turn_request

    carrier_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(Float64))
    carrier_scale = 1 - redirect_weight * (1 - params.redirect_carrier_scale)
    tail_target = clamp(
        mean_tail_tangent + carrier_scale * carrier_target,
        -params.tail_target_limit,
        params.tail_target_limit,
    )
    a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
