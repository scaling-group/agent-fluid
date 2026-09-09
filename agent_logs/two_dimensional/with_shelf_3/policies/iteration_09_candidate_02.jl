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
        posterior_speed_headroom_start=0.70,
        posterior_speed_headroom_width=0.12,
        posterior_accel_headroom_start=0.40,
        posterior_accel_headroom_width=0.10,
        headroom_direction_transition=0.08,
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
    # only the target-helping half-cycle while bearing error is present.
    posterior_wave = -q1_wave -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    half_cycle_width = max(
        params.half_cycle_transition_fraction * max(amp, eps(Float64)),
        eps(Float64),
    )
    helpful_half_cycle = 0.5 * (
        1 + tanh(turn_activation * posterior_wave / half_cycle_width)
    )

    # Preserve the completed half-cycle mechanism when the posterior joint has
    # headroom. If posterior speed or the previous applied acceleration is
    # already large on the side reinforced by the proposed wave increment,
    # withdraw only that increment. Normalizing by the oscillator's own state
    # scales avoids copying the episode's actuator limits into the policy.
    previous_action = hasproperty(state, :previous_action) ?
        state.previous_action : (0.0, 0.0)
    previous_a2 = Float64(previous_action[2])
    speed_scale = max(abs(amp * omega), eps(Float64))
    accel_scale = max(abs(amp * omega^2), eps(Float64))
    speed_ratio = abs(qd2) / speed_scale
    accel_ratio = abs(previous_a2) / accel_scale

    speed_width = max(params.posterior_speed_headroom_width, eps(Float64))
    accel_width = max(params.posterior_accel_headroom_width, eps(Float64))
    speed_z = clamp(
        (speed_ratio - params.posterior_speed_headroom_start) / speed_width,
        0.0,
        1.0,
    )
    accel_z = clamp(
        (accel_ratio - params.posterior_accel_headroom_start) / accel_width,
        0.0,
        1.0,
    )
    speed_pressure = speed_z^2 * (3 - 2 * speed_z)
    accel_pressure = accel_z^2 * (3 - 2 * accel_z)

    direction_fraction = max(
        params.headroom_direction_transition,
        eps(Float64),
    )
    speed_reinforcement = max(
        tanh(
            qd2 * posterior_wave /
            max(direction_fraction * amp^2 * omega, eps(Float64)),
        ),
        0.0,
    )
    accel_reinforcement = max(
        tanh(
            previous_a2 * posterior_wave /
            max(direction_fraction * amp^2 * omega^2, eps(Float64)),
        ),
        0.0,
    )
    posterior_headroom = 1 - max(
        speed_pressure * speed_reinforcement,
        accel_pressure * accel_reinforcement,
    )
    posterior_wave_gain = 1 +
        clamp(params.max_helpful_half_cycle_gain, 0.0, 0.25) *
        abs(turn_activation) * helpful_half_cycle * posterior_headroom
    phase_lag_target = q2_center + posterior_wave_gain * posterior_wave
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
