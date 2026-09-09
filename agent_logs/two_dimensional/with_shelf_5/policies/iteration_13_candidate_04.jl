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
        joint_rate_envelope=260.0 * pi / 180,
        posterior_wave_compression_start=0.85,
        wave_compression_turn_request_start=0.75,
        posterior_wave_floor=0.75,
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

    # Preserve the complete evaluated posterior target during large-error
    # redirect. Once aligned, compress only its oscillatory traveling-wave
    # component as posterior rate approaches the owned actuator envelope.
    # This adapts the rhythmic target before hard saturation; mean steering
    # bias and posterior damping remain active throughout.
    compression_alignment_fraction = clamp(
        (params.wave_compression_turn_request_start - abs(turn_request)) /
        max(params.wave_compression_turn_request_start, eps(Float64)),
        0.0,
        1.0,
    )
    compression_alignment_gate = compression_alignment_fraction^2 *
        (3 - 2 * compression_alignment_fraction)
    posterior_rate_fraction = abs(qd2) /
        max(params.joint_rate_envelope, eps(Float64))
    compression_fraction = clamp(
        (posterior_rate_fraction - params.posterior_wave_compression_start) /
        max(1 - params.posterior_wave_compression_start, eps(Float64)),
        0.0,
        1.0,
    )
    compression_gate = compression_fraction^2 *
        (3 - 2 * compression_fraction)
    posterior_wave_scale = 1 -
        compression_alignment_gate * compression_gate *
        (1 - params.posterior_wave_floor)
    posterior_wave_target = -head_wave -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    phase_lag_target = tail_bias + posterior_wave_scale * posterior_wave_target
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
