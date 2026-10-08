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
        route_history_blend=0.50,
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

    # Use a circular history mean to expose persistent body-frame route error
    # without creating a clock or a world-frame waypoint. Early history is
    # padded by the testbed, so release retains the full observed redirect.
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
    route_bearing = bearing +
        clamp(params.route_history_blend, 0.0, 1.0) * history_offset
    route_turn_request = tanh(
        route_bearing / max(params.turn_bearing_scale, eps(Float64)),
    )
    head_bias = params.head_turn_limit * route_turn_request

    # The oscillator phase remains encoded in joint state. Centering it on the
    # requested curvature preserves the propulsive rhythm during a turn.
    head_wave = q1 - head_bias
    vdp_drive = params.oscillator_mu * (1 - (head_wave / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * head_wave

    # Redistribute part of posterior steering onto the target-favored
    # half-cycle. The smooth joint-state gate supplies phase without a clock;
    # the reduced always-on share approximately preserves cycle-average bias.
    # Keep high-authority posterior steering on the current target error. This
    # separates slow route curvature from immediate half-cycle release instead
    # of prolonging both roles with the history filter.
    halfcycle_turn_request = tanh(
        bearing / max(params.turn_bearing_scale, eps(Float64)),
    )
    preferred_half = 0.5 * (1 + tanh(
        halfcycle_turn_request * head_wave /
        max(params.halfcycle_phase_width, eps(Float64)),
    ))
    halfcycle_bias = params.halfcycle_tail_boost *
        halfcycle_turn_request * preferred_half
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
