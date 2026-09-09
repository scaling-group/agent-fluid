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
        max_half_cycle_amplitude_asymmetry=0.08,
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
    # Early history is padded by the episode; the fallback preserves the public
    # policy contract for callers that provide only the current bearing.
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

    # Apply the evidenced bounded total-curvature budget to the persistent
    # direction. Allocate a little more of that unchanged budget posteriorly
    # during a large turn, then recover the successful 40/60 split as the fish
    # aligns with the target. This changes wave shape without increasing the
    # total steering bias or inserting a bearing-rate path into the oscillator.
    turn_fraction = tanh(
        persistent_bearing / max(params.bearing_scale, eps(params.bearing_scale)),
    )
    turn_curvature = params.max_turn_curvature * turn_fraction
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
    q1_center = anterior_fraction * turn_curvature
    q2_center = (1 - anterior_fraction) * turn_curvature

    # Preserve the seed's state-only reflex oscillator, but center the traveling
    # bend on the requested curvature instead of remaining target-blind. A
    # small phase-local envelope asymmetry strengthens the half-cycle whose
    # displacement has the requested turn sign and weakens the opposite half.
    # It vanishes continuously with turn demand and uses joint state rather
    # than a clock or inferred wake phase.
    q1_wave = q1 - q1_center
    wave_side = tanh(q1_wave / max(amp, eps(amp)))
    asymmetry = clamp(params.max_half_cycle_amplitude_asymmetry, 0.0, 0.25)
    phase_amp = amp * (1 + asymmetry * turn_fraction * wave_side)
    vdp_drive = params.oscillator_mu * (1 - (q1_wave / phase_amp)^2) * qd1
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
