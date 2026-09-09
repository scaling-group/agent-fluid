# Direction-gated posterior half-cycle steering around the evidenced
# bounded-curvature carrier. Oscillation phase remains entirely in measured
# joint state.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        maximum_mean_curvature=7.0 * pi / 180,
        direction_error_scale=0.45,
        direction_limit=1.0,
        heading_rate_damping=0.18,
        heading_rate_limit=4.0,
        tail_curvature_share=0.8,
        alignment_direction_scale=0.60,
        posterior_wave_floor=0.35,
        half_cycle_direction_scale=0.75,
        half_cycle_phase_scale=0.18,
        posterior_half_cycle_asymmetry=0.45,
        command_limit=28.0,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

    # The spine's forward axis is negative body x. Full direction preserves
    # target-ahead versus target-behind while remaining body-relative.
    target_x = Float64(state.target_body_L[1])
    target_y = Float64(state.target_body_L[2])
    # Exactly rearward geometry has no equivariant left/right choice. Keep it
    # neutral until any signed lateral error appears instead of accepting the
    # arbitrary +pi branch selected by two-argument atan.
    direction_error = target_x > 0.0 && target_y == 0.0 ?
        0.0 : atan(target_y, -target_x)
    bounded_direction = clamp(
        direction_error,
        -params.direction_limit,
        params.direction_limit,
    )
    heading_rate = clamp(
        Float64(state.heading_rate),
        -params.heading_rate_limit,
        params.heading_rate_limit,
    )
    steering_error = bounded_direction -
        params.heading_rate_damping * heading_rate
    turn_request = tanh(steering_error / params.direction_error_scale)
    mean_curvature = params.maximum_mean_curvature *
        turn_request

    # Preserve the sampled anterior state-feedback carrier and move only its
    # equilibrium. No clock, world coordinate, route, or case identity enters.
    centered_q1 = q1 - mean_curvature
    vdp_drive = params.oscillator_mu *
        (1 - (centered_q1 / amp)^2) * qd1
    raw_a1 = vdp_drive - omega^2 * centered_q1

    # Gross misalignment retains the parent's posterior-thrust relief. Within
    # that envelope, measured lag-wave phase biases the two half-cycles: bends
    # toward the requested turn are strengthened while opposite bends weaken.
    # The construction is bounded and reflection-equivariant, and it vanishes
    # continuously as full target direction returns to the body axis.
    normalized_direction =
        direction_error / params.alignment_direction_scale
    posterior_wave_authority = params.posterior_wave_floor +
        (1 - params.posterior_wave_floor) /
        (1 + normalized_direction^2)
    tail_mean = params.tail_curvature_share * mean_curvature
    posterior_wave = -centered_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    half_cycle_direction_weight = tanh(
        abs(direction_error) / params.half_cycle_direction_scale,
    )^2
    half_cycle_side = tanh(
        turn_request * posterior_wave / params.half_cycle_phase_scale,
    )
    posterior_wave_gain = 1 +
        params.posterior_half_cycle_asymmetry *
        half_cycle_direction_weight * half_cycle_side
    phase_lag_target = tail_mean +
        posterior_wave_authority * posterior_wave_gain * posterior_wave
    raw_a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Keep deterministic reserve below the 1800 deg/T^2 episode hard limit.
    a1 = clamp(raw_a1, -params.command_limit, params.command_limit)
    a2 = clamp(raw_a2, -params.command_limit, params.command_limit)

    return (phi_ddot=(a1, a2),)
end
