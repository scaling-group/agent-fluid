# Target-referenced half-cycle steering around the demonstrated joint-state
# traveling-bend carrier.  No clock, route, or world-frame direction is used.

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
        half_cycle_asymmetry_limit=0.35,
        phase_switch_width=0.20,
        acceleration_limit=1800.0 * pi / 180,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Preserve the strongest sampled anterior carrier.  Its phase remains in
    # observed joint angle and velocity rather than elapsed time.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    raw_a1 = vdp_drive - omega^2 * q1

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

    # The lagged posterior wave supplies its own observable phase.  Scaling it
    # by a smooth beat-side sign strengthens the requested half-cycle and
    # weakens the opposite one; zero turn request recovers symmetric cruise.
    base_tail_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(Float64))
    switch_scale = max(
        params.phase_switch_width * amp,
        eps(Float64),
    )
    beat_side = tanh(base_tail_target / switch_scale)
    half_cycle_scale = 1 +
        params.half_cycle_asymmetry_limit * turn_request * beat_side
    tail_target = half_cycle_scale * base_tail_target

    raw_a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Match the public actuator envelope at the policy boundary.  The episode
    # retains final authority, but no raw candidate request is bang-bang beyond
    # the declared acceleration limit.
    a1 = clamp(raw_a1, -params.acceleration_limit, params.acceleration_limit)
    a2 = clamp(raw_a2, -params.acceleration_limit, params.acceleration_limit)

    return (phi_ddot=(a1, a2),)
end
