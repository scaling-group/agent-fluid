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
        anterior_bias_fraction=0.40,
        max_posterior_bias_shift=0.05,
        posterior_shift_bearing_scale=20.0 * pi / 180,
        max_helpful_half_cycle_gain=0.08,
        half_cycle_transition_fraction=0.20,
        max_alignment_curvature_release=0.15,
        alignment_response_scale=0.35,
        alignment_bearing_floor=5.0 * pi / 180,
        oscillator_activity_start=0.55,
        oscillator_activity_width=0.20,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Extract persistent route error from the short body-frame history so
    # beat-scale yaw does not move the oscillator centers on every control call.
    # The episode pads early history with the current value; the fallback keeps
    # the public policy usable by callers that provide only current bearing.
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
        bearing_sample = bearing_history[index]
        bounded_sample = clamp(Float64(bearing_sample), -pi / 2, pi / 2)
        history_offset = index <= length(history_offsets) ?
            min(Float64(history_offsets[index]), 0.0) : 0.0
        sample_weight = exp(max(history_offset / filter_horizon, -20.0))
        bearing_sin += sample_weight * sin(bounded_sample)
        bearing_cos += sample_weight * cos(bounded_sample)
        bearing_weight += sample_weight
    end
    persistent_bearing = bearing_weight <= eps(Float64) ?
        bearing_now : atan(bearing_sin, bearing_cos)

    # Preserve the sampled bounded total-curvature schedule: at large target
    # error a little more of the unchanged request moves posteriorly, while
    # alignment recovers the successful 40/60 allocation.
    turn_activation = tanh(
        persistent_bearing / max(params.bearing_scale, eps(params.bearing_scale)),
    )
    base_turn_curvature = params.max_turn_curvature * turn_activation
    posterior_shift = clamp(params.max_posterior_bias_shift, 0.0, 1.0) * tanh(
        abs(persistent_bearing) / max(
            params.posterior_shift_bearing_scale,
            eps(params.posterior_shift_bearing_scale),
        ),
    )
    anterior_fraction = clamp(
        params.anterior_bias_fraction - posterior_shift,
        0.0,
        1.0,
    )

    # A persistent direction error requests the full evidenced curvature until
    # the observed body-frame bearing starts closing. Once the anterior
    # oscillator is established, smoothly release only part of that mean bias
    # in proportion to the fraction of remaining bearing closed per owned
    # control period. This response path cannot change the turn sign or attenuate
    # the base traveling wave.
    bearing_window_rate = hasproperty(state, :bearing_window_rate) ?
        Float64(state.bearing_window_rate) : 0.0
    helpful_alignment_rate = max(
        -sign(persistent_bearing) * bearing_window_rate,
        0.0,
    )
    response_bearing = max(
        abs(persistent_bearing),
        max(params.alignment_bearing_floor, eps(Float64)),
    )
    alignment_fraction = helpful_alignment_rate * params.control_period /
        response_bearing
    response_z = clamp(
        alignment_fraction /
        max(params.alignment_response_scale, eps(Float64)),
        0.0,
        1.0,
    )
    response_gate = response_z^2 * (3 - 2 * response_z)

    reference_q1_center = anterior_fraction * base_turn_curvature
    reference_q1_wave = q1 - reference_q1_center
    phase_radius = hypot(
        reference_q1_wave / max(amp, eps(Float64)),
        qd1 / max(amp * omega, eps(Float64)),
    )
    activity_z = clamp(
        (phase_radius - params.oscillator_activity_start) /
        max(params.oscillator_activity_width, eps(Float64)),
        0.0,
        1.0,
    )
    activity_gate = activity_z^2 * (3 - 2 * activity_z)
    curvature_release =
        clamp(params.max_alignment_curvature_release, 0.0, 0.5) *
        response_gate * activity_gate
    turn_curvature = base_turn_curvature * (1 - curvature_release)
    q1_center = anterior_fraction * turn_curvature
    q2_center = (1 - anterior_fraction) * turn_curvature

    # Preserve the seed's state-only reflex oscillator, but center the traveling
    # bend on the requested curvature instead of remaining target-blind.
    q1_wave = q1 - q1_center
    vdp_drive = params.oscillator_mu * (1 - (q1_wave / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1_wave

    # Infer posterior wave phase from joint state, not time. Smoothly strengthen
    # only the target-helping half-cycle while bearing error is present; the
    # sampled symmetric traveling wave is recovered exactly at alignment.
    posterior_wave = -q1_wave -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    half_cycle_width = max(
        params.half_cycle_transition_fraction * max(amp, eps(Float64)),
        eps(Float64),
    )
    helpful_half_cycle = 0.5 * (
        1 + tanh(turn_activation * posterior_wave / half_cycle_width)
    )
    posterior_wave_gain = 1 +
        clamp(params.max_helpful_half_cycle_gain, 0.0, 0.25) *
        abs(turn_activation) * helpful_half_cycle
    phase_lag_target = q2_center + posterior_wave_gain * posterior_wave
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
