function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        turn_bearing_scale=20.0 * pi / 180,
        head_turn_limit=8.0 * pi / 180,
        tail_turn_ratio=0.65,
        approach_distance_L=3.5,
        approach_duty_asymmetry=0.12,
        half_cycle_phase_scale=6.0 * pi / 180,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Preserve the demonstrated carrier outside the approach. Smoothstep makes
    # the half-cycle mechanism exactly inactive at and beyond the range gate.
    distance_L = hasproperty(state, :distance_L) ?
        max(Float64(state.distance_L), 0.0) : params.approach_distance_L
    approach_fraction = clamp(
        distance_L / max(params.approach_distance_L, eps(Float64)),
        0.0,
        1.0,
    )
    approach_blend = approach_fraction^2 * (3 - 2 * approach_fraction)
    approach_weight = 1 - approach_blend

    # Persistent target error changes mean curvature, while tanh bounds the
    # redirect and leaves alternating wake motion out of the route command.
    bearing = Float64(state.bearing)
    turn_request = tanh(bearing / max(params.turn_bearing_scale, eps(Float64)))
    head_bias = params.head_turn_limit * turn_request

    # The oscillator phase remains encoded in joint state. Centering it on the
    # requested curvature preserves the propulsive rhythm during a turn.
    head_wave = q1 - head_bias
    beat_side = tanh(
        head_wave / max(params.half_cycle_phase_scale, eps(Float64)),
    )
    duty_scale = 1 - approach_weight * params.approach_duty_asymmetry *
        turn_request * beat_side
    local_omega = omega * clamp(
        duty_scale,
        1 - params.approach_duty_asymmetry,
        1 + params.approach_duty_asymmetry,
    )
    vdp_drive = params.oscillator_mu * (1 - (head_wave / amp)^2) * qd1
    a1 = vdp_drive - local_omega^2 * head_wave

    # Apply posterior steering to the mean component only. The oscillatory
    # component follows the same local half-cycle timing so posterior lag is
    # retained rather than turning into an independent tail-frequency command.
    tail_bias = params.tail_turn_ratio * head_bias
    phase_lag_target = tail_bias - head_wave -
        params.tail_lag_gain * qd1 / max(local_omega, eps(Float64))
    a2 = local_omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * local_omega * qd2

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
