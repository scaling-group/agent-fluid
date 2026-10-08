# Target-relative half-cycle steering for the 3D moving-window EvE lane.
# The anterior state-feedback oscillator is unchanged. Target geometry only
# modulates the two halves of its lagged posterior wave.

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
        tail_half_cycle_asymmetry=0.50,
        tail_phase_softening=4.0 * pi / 180,
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

    # Van der Pol drive: propulsion phase remains in observed joint state.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1

    raw_bearing = Float64(state.bearing)
    raw_bearing_trend = Float64(state.bearing_window_rate)
    bearing = isfinite(raw_bearing) ?
        clamp(raw_bearing, -params.bearing_limit, params.bearing_limit) : 0.0
    bearing_trend = isfinite(raw_bearing_trend) ?
        clamp(raw_bearing_trend, -params.bearing_trend_limit, params.bearing_trend_limit) : 0.0
    predicted_bearing = bearing + params.bearing_trend_lead * bearing_trend
    turn_request = tanh(
        predicted_bearing / max(params.bearing_scale, eps(Float64)),
    )

    # Preserve the parent's posterior traveling-wave target, but create mean
    # turning moment through phase-aware amplitude asymmetry rather than a
    # static joint offset. Positive requests strengthen the positive target
    # half-cycle and weaken the negative one; reflection reverses both roles.
    base_tail_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(Float64))
    beat_side = tanh(
        base_tail_target / max(params.tail_phase_softening, eps(Float64)),
    )
    half_cycle_scale = 1 +
        params.tail_half_cycle_asymmetry * turn_request * beat_side
    tail_target = clamp(
        base_tail_target * half_cycle_scale,
        -params.tail_target_limit,
        params.tail_target_limit,
    )
    a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
