# Posterior half-cycle steering for the 3D moving-window lane. The strongest
# sampled bearing/trend mean-curvature carrier is retained, while only the
# turn-opposing posterior half-cycle is attenuated from observed joint phase.

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
        halfcycle_opposition_relief=0.35,
        halfcycle_phase_scale=8.0 * pi / 180,
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

    # Lead the body-frame target bearing by its measured short-window trend.
    # All fallbacks are neutral, and both the observation and turn command are
    # bounded before they alter the posterior target.
    raw_bearing = Float64(state.bearing)
    raw_bearing_trend = Float64(state.bearing_window_rate)
    bearing = isfinite(raw_bearing) ?
        clamp(raw_bearing, -params.bearing_limit, params.bearing_limit) : 0.0
    bearing_trend = isfinite(raw_bearing_trend) ?
        clamp(raw_bearing_trend, -params.bearing_trend_limit, params.bearing_trend_limit) : 0.0
    predicted_bearing = bearing + params.bearing_trend_lead * bearing_trend
    turn_command = tanh(
        predicted_bearing / max(params.bearing_scale, eps(Float64)),
    )
    mean_tail_tangent = params.turn_curvature_limit * turn_command

    # This carrier target contains the seed's posterior lag and no steering.
    # Its smooth sign is an observable phase coordinate.  When the carrier
    # points against the requested turn, `opposition` tends toward |turn|;
    # on the requested half-cycle it tends toward zero.  The multiplier is
    # therefore bounded in [1-relief, 1] and never raises the peak wave target.
    carrier_target = -q1 - params.tail_lag_gain * qd1 / max(omega, eps(omega))
    phase_side = tanh(
        carrier_target / max(params.halfcycle_phase_scale, eps(Float64)),
    )
    opposition = clamp(
        0.5 * (abs(turn_command) - turn_command * phase_side),
        0.0,
        1.0,
    )
    carrier_multiplier = 1.0 - params.halfcycle_opposition_relief * opposition
    phase_lag_target = mean_tail_tangent + carrier_multiplier * carrier_target
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
