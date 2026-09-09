function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        max_turn_curvature=12.0 * pi / 180,
        bearing_scale=20.0 * pi / 180,
        bearing_filter_period_fraction=0.35,
        bearing_trend_limit=10.0 * pi / 180,
        route_trend_gain=0.35,
        rhythm_gate_level=0.25,
        anterior_bias_fraction=0.40,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Separate the persistent route error from beat-scale body yaw with the
    # short, gait-relative circular history filter supported by prior rollouts.
    bearing_now = clamp(Float64(state.bearing), -pi / 2, pi / 2)
    bearing_history = hasproperty(state, :bearing_history) ?
        state.bearing_history : (bearing_now,)
    history_offsets = hasproperty(state, :history_time_offsets) ?
        state.history_time_offsets : ntuple(_ -> 0.0, length(bearing_history))
    filter_horizon = max(
        params.bearing_filter_period_fraction * params.control_period,
        eps(Float64),
    )
    bearing_sin = 0.0
    bearing_cos = 0.0
    bearing_weight = 0.0
    for index in eachindex(bearing_history)
        bounded_sample = clamp(Float64(bearing_history[index]), -pi / 2, pi / 2)
        history_offset = index <= length(history_offsets) ?
            min(Float64(history_offsets[index]), 0.0) : 0.0
        sample_weight = exp(max(history_offset / filter_horizon, -20.0))
        bearing_sin += sample_weight * sin(bounded_sample)
        bearing_cos += sample_weight * cos(bounded_sample)
        bearing_weight += sample_weight
    end
    persistent_bearing = bearing_weight <= eps(Float64) ?
        bearing_now : atan(bearing_sin, bearing_cos)

    # A bearing trend can release curvature as the target direction converges,
    # but the inherited ungated form suppressed startup. Admit that response
    # only after normalized two-joint angle/velocity activity establishes the
    # propulsive rhythm. The energy-like gate is smooth and phase-robust.
    angle_scale = max(abs(amp), eps(Float64))
    rate_scale = max(abs(omega * amp), eps(Float64))
    rhythm_activity_sq = 0.5 * (
        (q1 / angle_scale)^2 + (q2 / angle_scale)^2 +
        (qd1 / rate_scale)^2 + (qd2 / rate_scale)^2
    )
    gate_level = max(params.rhythm_gate_level, eps(Float64))
    rhythm_gate = rhythm_activity_sq / (rhythm_activity_sq + gate_level^2)

    bearing_window_rate = hasproperty(state, :bearing_window_rate) ?
        Float64(state.bearing_window_rate) : 0.0
    trend_limit = max(params.bearing_trend_limit, eps(Float64))
    bearing_trend = trend_limit * tanh(
        bearing_window_rate * params.control_period / trend_limit,
    )
    route_bearing = clamp(
        persistent_bearing +
            rhythm_gate * params.route_trend_gain * bearing_trend,
        -pi / 2,
        pi / 2,
    )

    # Map the gated persistent route signal into the evidenced bounded total
    # curvature and slightly posterior-weighted joint allocation.
    turn_curvature = params.max_turn_curvature * tanh(
        route_bearing / max(params.bearing_scale, eps(params.bearing_scale)),
    )
    anterior_fraction = clamp(params.anterior_bias_fraction, 0.0, 1.0)
    q1_center = anterior_fraction * turn_curvature
    q2_center = (1 - anterior_fraction) * turn_curvature

    # Preserve the seed's state-only reflex oscillator, but center the traveling
    # bend on the requested curvature instead of remaining target-blind.
    q1_wave = q1 - q1_center
    vdp_drive = params.oscillator_mu * (1 - (q1_wave / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1_wave

    # Tail follows the first joint with a velocity-dependent lag, producing a
    # smooth traveling bend around the posterior share of the curvature bias.
    phase_lag_target = q2_center - q1_wave -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
