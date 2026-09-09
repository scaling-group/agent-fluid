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
        redirect_turn_start=0.20,
        redirect_turn_full=0.50,
        redirect_tail_contrast=4.0 * pi / 180,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Persistent body-frame target error supplies only the turn sign and
    # magnitude; joint state, rather than a clock, supplies oscillator phase.
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

    # For a large bearing error only, increase favored-versus-opposing
    # posterior contrast without changing its approximate cycle mean. The
    # smooth gate releases back to the evaluated clean incumbent as alignment
    # improves, avoiding the failed strategy of adding persistent curvature.
    redirect_fraction = clamp(
        (abs(turn_request) - params.redirect_turn_start) /
        max(
            params.redirect_turn_full - params.redirect_turn_start,
            eps(Float64),
        ),
        0.0,
        1.0,
    )
    redirect_blend = redirect_fraction^2 * (3 - 2 * redirect_fraction)
    redirect_bias = params.redirect_tail_contrast * turn_request *
        redirect_blend * (preferred_half - 0.5)
    tail_bias = params.tail_turn_ratio * head_bias + halfcycle_bias +
        redirect_bias

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
