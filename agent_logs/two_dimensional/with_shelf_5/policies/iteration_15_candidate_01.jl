function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        turn_bearing_scale=20.0 * pi / 180,
        head_turn_limit=8.0 * pi / 180,
        tail_turn_ratio=0.40,
        halfcycle_tail_boost=4.0 * pi / 180,
        halfcycle_phase_width=6.0 * pi / 180,
        bearing_history_blend=0.50,
        approach_distance_L=2.5,
        approach_amplitude_floor=0.75,
        joint_rate_envelope=260.0 * pi / 180,
        joint_rate_guard_start=0.95,
        rate_guard_turn_request_start=0.75,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Keep the proven carrier unchanged outside the terminal neighborhood, then
    # ease only its envelope as normalized range closes. Smoothstep gives zero
    # slope at both ends, avoiding a range-triggered acceleration discontinuity.
    distance_L = max(Float64(state.distance_L), 0.0)
    approach_fraction = clamp(
        distance_L / max(params.approach_distance_L, eps(Float64)),
        0.0,
        1.0,
    )
    approach_blend = approach_fraction^2 * (3 - 2 * approach_fraction)
    amplitude_scale = params.approach_amplitude_floor +
        (1 - params.approach_amplitude_floor) * approach_blend
    amp = params.oscillator_amplitude * amplitude_scale

    # Extract the persistent route component from the short body-frame bearing
    # history. A circular mean remains well-defined across angle wrapping, and
    # the current-bearing blend keeps immediate target feedback. The testbed
    # pads early history with the current observation, so release has full
    # redirect authority without a clock or discrete controller mode.
    bearing = Float64(state.bearing)
    bearing_sin = 0.0
    bearing_cos = 0.0
    bearing_count = 0
    for bearing_sample in state.bearing_history
        sample = Float64(bearing_sample)
        bearing_sin += sin(sample)
        bearing_cos += cos(sample)
        bearing_count += 1
    end
    persistent_bearing = if bearing_count > 0
        atan(bearing_sin, bearing_cos)
    else
        bearing
    end
    history_offset = atan(
        sin(persistent_bearing - bearing),
        cos(persistent_bearing - bearing),
    )
    filtered_bearing = bearing +
        clamp(params.bearing_history_blend, 0.0, 1.0) * history_offset

    # Preserve the demonstrated bounded body-frame route command throughout
    # the approach; only its fast observation feedthrough changes.
    turn_request = tanh(
        filtered_bearing /
            max(params.turn_bearing_scale, eps(Float64)),
    )
    head_bias = params.head_turn_limit * turn_request

    # The oscillator phase remains encoded in joint state. Centering it on the
    # requested curvature preserves the propulsive rhythm during a turn.
    head_wave = q1 - head_bias
    vdp_drive = params.oscillator_mu * (1 - (head_wave / amp)^2) * qd1
    raw_a1 = vdp_drive - omega^2 * head_wave

    # Redistribute part of posterior steering onto the target-favored
    # half-cycle. The smooth joint-state gate supplies phase without a clock;
    # the reduced always-on share approximately preserves cycle-average bias.
    preferred_half = 0.5 * (1 + tanh(
        turn_request * head_wave /
        max(params.halfcycle_phase_width, eps(Float64)),
    ))
    halfcycle_bias = params.halfcycle_tail_boost *
        turn_request * preferred_half
    tail_bias = params.tail_turn_ratio * head_bias + halfcycle_bias

    # The posterior oscillation retains the demonstrated velocity-dependent
    # lag, so response shaping does not change its target or phase.
    phase_lag_target = tail_bias - head_wave -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    raw_a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Preserve the full history-filtered redirect at large body-frame error.
    # Once aligned, remove only acceleration that pushes a near-envelope joint
    # rate farther outward. Reversal acceleration is exactly unchanged, so the
    # traveling bend and useful wake-induced lateral motion remain available.
    alignment_fraction = clamp(
        (params.rate_guard_turn_request_start - abs(turn_request)) /
        max(params.rate_guard_turn_request_start, eps(Float64)),
        0.0,
        1.0,
    )
    alignment_gate = alignment_fraction^2 * (3 - 2 * alignment_fraction)

    head_rate_fraction = abs(qd1) /
        max(params.joint_rate_envelope, eps(Float64))
    head_guard_fraction = clamp(
        (head_rate_fraction - params.joint_rate_guard_start) /
        max(1 - params.joint_rate_guard_start, eps(Float64)),
        0.0,
        1.0,
    )
    head_rate_guard = head_guard_fraction^2 * (3 - 2 * head_guard_fraction)
    head_velocity_sign = sign(qd1)
    outward_a1 = head_velocity_sign *
        max(head_velocity_sign * raw_a1, 0.0)
    a1 = raw_a1 - alignment_gate * head_rate_guard * outward_a1

    tail_rate_fraction = abs(qd2) /
        max(params.joint_rate_envelope, eps(Float64))
    tail_guard_fraction = clamp(
        (tail_rate_fraction - params.joint_rate_guard_start) /
        max(1 - params.joint_rate_guard_start, eps(Float64)),
        0.0,
        1.0,
    )
    tail_rate_guard = tail_guard_fraction^2 * (3 - 2 * tail_guard_fraction)
    tail_velocity_sign = sign(qd2)
    outward_a2 = tail_velocity_sign *
        max(tail_velocity_sign * raw_a2, 0.0)
    a2 = raw_a2 - alignment_gate * tail_rate_guard * outward_a2

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
