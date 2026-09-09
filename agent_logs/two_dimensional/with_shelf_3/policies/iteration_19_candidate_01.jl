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
        assisting_moment_scale_L2=0.22,
        assisting_lateral_force_scale_L=1.0,
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

    # Measure whether recent target-vector motion is coherent closure rather
    # than redirection or lateral wake displacement. This slow, dimensionless
    # supervisor restores the evaluated ungated residual when progress is lost
    # and permits actuator-state yielding only on a clean targetward segment.
    target_window_rate = hasproperty(state, :target_body_window_rate_L) ?
        state.target_body_window_rate_L : (0.0, 0.0)
    window_closing_speed = hasproperty(state, :window_closing_speed_L) ?
        max(Float64(state.window_closing_speed_L), 0.0) : 0.0
    target_window_rate_norm = hypot(
        Float64(target_window_rate[1]),
        Float64(target_window_rate[2]),
    )
    trajectory_efficiency = clamp(
        window_closing_speed /
        max(target_window_rate_norm, eps(Float64)),
        0.0,
        1.0,
    )
    progress_confidence = trajectory_efficiency^2 *
        (3 - 2 * trajectory_efficiency)

    # A body-frame fluid wrench directed toward the persistent target turn is
    # hydrodynamic assistance, not an error to cancel. A target-signed yaw
    # moment assists rotation and a target-signed lateral force assists route
    # translation. Projecting the same normalized force onto the instantaneous
    # body-frame target direction additionally recognizes direct targetward
    # translation without encoding a route or vortex phase. At the observed
    # force and moment scales, these cues may yield only the optional posterior
    # residual during coherent closure; opposing loads leave the evaluated
    # progress supervisor unchanged.
    moment_z_L2 = hasproperty(state, :moment_z_L2) ?
        Float64(state.moment_z_L2) : 0.0
    moment_scale = max(params.assisting_moment_scale_L2, eps(Float64))
    assisting_yaw_load = max(
        tanh(turn_activation * moment_z_L2 / moment_scale),
        0.0,
    )
    force_body_L = hasproperty(state, :force_body_L) ?
        state.force_body_L : (0.0, 0.0)
    force_x_L = Float64(force_body_L[1])
    force_y_L = Float64(force_body_L[2])
    lateral_force_scale = max(
        params.assisting_lateral_force_scale_L,
        eps(Float64),
    )
    assisting_lateral_load = max(
        tanh(turn_activation * force_y_L / lateral_force_scale),
        0.0,
    )

    target_body_L = hasproperty(state, :target_body_L) ?
        state.target_body_L : (-cos(bearing_now), sin(bearing_now))
    target_x_L = Float64(target_body_L[1])
    target_y_L = Float64(target_body_L[2])
    target_distance_L = max(hypot(target_x_L, target_y_L), eps(Float64))
    targetward_force_L = (
        force_x_L * target_x_L + force_y_L * target_y_L
    ) / target_distance_L
    assisting_targetward_load = max(
        tanh(targetward_force_L / lateral_force_scale),
        0.0,
    )
    hydrodynamic_assistance = max(
        assisting_yaw_load,
        assisting_lateral_load,
        assisting_targetward_load,
    )

    # Yield only the optional posterior asymmetry when observed motion already
    # reinforces it near the gait's own state scales. The target-signed mean
    # curvature and unit-gain lagged traveling wave remain untouched.
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
    posterior_pressure = max(
        speed_pressure * speed_reinforcement,
        accel_pressure * accel_reinforcement,
        hydrodynamic_assistance,
    )
    posterior_headroom = 1 - progress_confidence * posterior_pressure
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
