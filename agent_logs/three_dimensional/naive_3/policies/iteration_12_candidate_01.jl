# Terminal posterior half-cycle counterbend around the evidenced
# alignment-gated carrier. Oscillation phase remains entirely in joint state.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        maximum_mean_curvature=7.0 * pi / 180,
        curvature_error_scale=0.45,
        bearing_limit=1.0,
        heading_rate_damping=0.18,
        heading_rate_limit=4.0,
        tail_curvature_share=0.8,
        alignment_bearing_scale=0.60,
        posterior_wave_floor=0.35,
        half_cycle_distance_scale=3.2,
        half_cycle_distance_power=8.0,
        half_cycle_lateral_scale=0.45,
        half_cycle_phase_scale=0.12,
        maximum_posterior_half_cycle=8.0 * pi / 180,
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

    # Persistent target error asks for bounded average anterior curvature.
    # Measured yaw releases the request as the body turns.
    bearing = clamp(
        Float64(state.bearing),
        -params.bearing_limit,
        params.bearing_limit,
    )
    heading_rate = clamp(
        Float64(state.heading_rate),
        -params.heading_rate_limit,
        params.heading_rate_limit,
    )
    steering_error = bearing - params.heading_rate_damping * heading_rate
    mean_curvature = params.maximum_mean_curvature *
        tanh(steering_error / params.curvature_error_scale)

    # Preserve the sampled state-feedback carrier and move only its anterior
    # equilibrium. No clock, route, or case identity enters the oscillator.
    centered_q1 = q1 - mean_curvature
    vdp_drive = params.oscillator_mu *
        (1 - (centered_q1 / amp)^2) * qd1
    raw_a1 = vdp_drive - omega^2 * centered_q1

    # Alignment retains a nonzero posterior traveling wave during redirection.
    normalized_bearing = bearing / params.alignment_bearing_scale
    posterior_wave_authority = params.posterior_wave_floor +
        (1 - params.posterior_wave_floor) / (1 + normalized_bearing^2)
    tail_mean = params.tail_curvature_share * mean_curvature
    posterior_wave = -centered_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))

    # A near-target lateral error selects the turn side. Reinforce only the
    # posterior half-cycle already forming an opposite-sign S-bend, then fully
    # release the residual on the other half-cycle. The phase selector is
    # reconstructed from joint state and remains reflection equivariant.
    distance = max(Float64(state.distance_L), eps(Float64))
    lateral_fraction = clamp(
        Float64(state.target_body_L[2]) / distance,
        -1.0,
        1.0,
    )
    turn_request = tanh(
        lateral_fraction / params.half_cycle_lateral_scale,
    )
    approach_weight = 1 / (1 +
        (distance / params.half_cycle_distance_scale)^params.half_cycle_distance_power)
    counterbend_phase = -turn_request * posterior_wave
    selected_half_cycle = 0.5 * (1 + tanh(
        counterbend_phase / params.half_cycle_phase_scale,
    ))
    posterior_half_cycle_bias =
        -params.maximum_posterior_half_cycle * approach_weight *
        turn_request * selected_half_cycle

    phase_lag_target = tail_mean +
        posterior_wave_authority * posterior_wave +
        posterior_half_cycle_bias
    raw_a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Keep deterministic reserve below the 1800 deg/T^2 episode hard limit.
    a1 = clamp(raw_a1, -params.command_limit, params.command_limit)
    a2 = clamp(raw_a2, -params.command_limit, params.command_limit)
    return (phi_ddot=(a1, a2),)
end
