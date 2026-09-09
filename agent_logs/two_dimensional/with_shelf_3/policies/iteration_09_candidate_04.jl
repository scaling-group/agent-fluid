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
        joint_velocity_limit=260.0 * pi / 180,
        joint_acceleration_limit=1800.0 * pi / 180,
        residual_velocity_soft_fraction=0.80,
        residual_acceleration_soft_fraction=0.80,
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
    turn_activation = tanh(
        persistent_bearing / max(params.bearing_scale, eps(params.bearing_scale)),
    )
    turn_curvature = params.max_turn_curvature * turn_activation
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

    # Saturation is evidence that the extra steering residual has run out of
    # actuator headroom, not a reason to attenuate the propulsive scaffold.
    # Normalize posterior velocity and the previously realized acceleration by
    # their physical envelopes, then use a C1 smoothstep to yield only the
    # incremental half-cycle gain as either signal approaches its limit.
    previous_a2 = hasproperty(state, :previous_action) ?
        Float64(state.previous_action[2]) : 0.0
    velocity_usage = abs(qd2) / max(
        params.joint_velocity_limit,
        eps(params.joint_velocity_limit),
    )
    acceleration_usage = abs(previous_a2) / max(
        params.joint_acceleration_limit,
        eps(params.joint_acceleration_limit),
    )
    velocity_headroom = clamp(
        (1 - velocity_usage) /
        max(1 - params.residual_velocity_soft_fraction, eps(Float64)),
        0.0,
        1.0,
    )
    acceleration_headroom = clamp(
        (1 - acceleration_usage) /
        max(1 - params.residual_acceleration_soft_fraction, eps(Float64)),
        0.0,
        1.0,
    )
    residual_headroom = min(velocity_headroom, acceleration_headroom)
    residual_headroom_gate = residual_headroom^2 * (3 - 2 * residual_headroom)
    posterior_wave_gain = 1 +
        clamp(params.max_helpful_half_cycle_gain, 0.0, 0.25) *
        abs(turn_activation) * helpful_half_cycle * residual_headroom_gate
    phase_lag_target = q2_center + posterior_wave_gain * posterior_wave
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
