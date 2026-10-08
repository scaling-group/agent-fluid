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
        posterior_rate_guard_quiet_start=0.98,
        posterior_rate_guard_crossflow_advance=0.05,
        posterior_rate_guard_crossflow_scale=0.21,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Persistent body-frame target error selects bounded mean curvature. Keep
    # the demonstrated carrier at full authority: sampled terminal amplitude
    # scheduling did not change its route, effort, actuator maxima, or loads.
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

    # The posterior oscillation retains the demonstrated velocity-dependent
    # lag, so the new asymmetry changes steering allocation rather than phase.
    phase_lag_target = tail_bias - head_wave -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    raw_a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Preserve posterior reversal authority in quiet flow, but become modestly
    # more compliant when normalized body-frame relative crossflow is large.
    # Crossflow changes only the onset of the outward high-rate guard; it does
    # not supply a turn sign or cancel wake-induced lateral motion.
    relative_crossflow = abs(Float64(
        state.relative_flow_velocity_body_U[2],
    ))
    crossflow_fraction = tanh(
        relative_crossflow /
        max(params.posterior_rate_guard_crossflow_scale, eps(Float64)),
    )
    rate_guard_start = clamp(
        params.posterior_rate_guard_quiet_start -
            params.posterior_rate_guard_crossflow_advance *
            crossflow_fraction,
        0.0,
        1.0,
    )
    posterior_rate_fraction = abs(qd2) /
        max(params.joint_rate_envelope, eps(Float64))
    rate_guard_fraction = clamp(
        (posterior_rate_fraction - rate_guard_start) /
        max(1 - rate_guard_start, eps(Float64)),
        0.0,
        1.0,
    )
    rate_guard = rate_guard_fraction^2 * (3 - 2 * rate_guard_fraction)
    velocity_sign = sign(qd2)
    outward_a2 = velocity_sign * max(velocity_sign * raw_a2, 0.0)
    a2 = raw_a2 - rate_guard * outward_a2

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
