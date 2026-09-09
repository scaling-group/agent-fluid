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
        approach_distance_L=2.5,
        approach_amplitude_floor=0.75,
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

    # Preserve the demonstrated bounded body-frame route command throughout
    # the approach; sampled terminal steering blends did not improve capture.
    bearing = Float64(state.bearing)
    turn_request = tanh(
        bearing / max(params.turn_bearing_scale, eps(Float64)),
    )
    head_bias = params.head_turn_limit * turn_request

    # The oscillator phase remains encoded in joint state. Centering it on the
    # requested curvature preserves the propulsive rhythm during a turn.
    head_wave = q1 - head_bias
    vdp_drive = params.oscillator_mu * (1 - (head_wave / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * head_wave

    # Estimate the realized two-joint carrier phase before allocating the
    # target-favored posterior half-cycle. The incumbent head-only gate first
    # removes the known steering center from q2; posterior angle and normalized
    # rate are then mapped back through the configured traveling-wave lag. A
    # tracked harmonic bend reconstructs head_wave exactly, while wake- or
    # saturation-induced tail phase error can retime the bias without a clock.
    phase_width = max(params.halfcycle_phase_width, eps(Float64))
    head_phase_rate = qd1 / max(omega, eps(omega))
    provisional_half = 0.5 * (1 + tanh(
        turn_request * head_wave / phase_width,
    ))
    provisional_tail_center = params.tail_turn_ratio * head_bias +
        params.halfcycle_tail_boost * turn_request * provisional_half
    tail_wave = q2 - provisional_tail_center
    tail_phase_rate = qd2 / max(omega, eps(omega))
    phase_denominator = 2 + params.tail_lag_gain^2
    collective_phase_position = (
        head_wave - tail_wave + params.tail_lag_gain * tail_phase_rate
    ) / phase_denominator
    collective_phase_rate = (
        head_phase_rate - params.tail_lag_gain * tail_wave - tail_phase_rate
    ) / phase_denominator
    head_phase_radius = hypot(head_wave, head_phase_rate)
    collective_phase_radius = hypot(
        collective_phase_position,
        collective_phase_rate,
    )
    realized_phase = clamp(
        head_phase_radius * collective_phase_position /
        max(collective_phase_radius, phase_width),
        -amp,
        amp,
    )
    preferred_half = 0.5 * (1 + tanh(
        turn_request * realized_phase / phase_width,
    ))
    halfcycle_bias = params.halfcycle_tail_boost *
        turn_request * preferred_half
    tail_bias = params.tail_turn_ratio * head_bias + halfcycle_bias

    # The posterior oscillation retains the demonstrated velocity-dependent
    # lag, so the new asymmetry changes steering allocation rather than phase.
    phase_lag_target = tail_bias - head_wave -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
