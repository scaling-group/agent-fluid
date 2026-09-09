# Distance-conditioned approach hold around the evidenced bounded-curvature
# carrier. Oscillation phase remains entirely in measured joint state.

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
        approach_distance=4.0,
        approach_power=4.0,
        approach_energy_floor=0.25,
        command_limit=28.0,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Persistent target error asks for bounded average curvature. Measured yaw
    # releases the request as the body turns; all geometry is body-relative.
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

    # Relax wave energy only in the evidenced approach neighborhood. Far away
    # this tends smoothly to the parent carrier; at the target it retains a
    # bounded limit cycle rather than introducing a stop or a hidden mode.
    distance = max(Float64(state.distance_L), 0.0)
    normalized_distance = distance / params.approach_distance
    approach_weight = 1 / (1 + normalized_distance^params.approach_power)
    carrier_energy = 1 -
        (1 - params.approach_energy_floor) * approach_weight
    carrier_amplitude_scale = sqrt(carrier_energy)

    # Preserve joint-state phase while moving the oscillator equilibrium to the
    # requested mean bend and shrinking only its terminal amplitude envelope.
    centered_q1 = q1 - mean_curvature
    approach_amplitude = amp * carrier_amplitude_scale
    vdp_drive = params.oscillator_mu *
        (1 - (centered_q1 / approach_amplitude)^2) * qd1
    raw_a1 = vdp_drive - omega^2 * centered_q1

    # Alignment and proximity attenuate only the posterior traveling wave. The
    # retained tail mean combines with the anterior mean for a bounded redirect.
    normalized_bearing = bearing / params.alignment_bearing_scale
    alignment_authority = params.posterior_wave_floor +
        (1 - params.posterior_wave_floor) / (1 + normalized_bearing^2)
    posterior_wave_authority =
        carrier_amplitude_scale * alignment_authority
    tail_mean = params.tail_curvature_share * mean_curvature
    posterior_wave = -centered_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    phase_lag_target = tail_mean + posterior_wave_authority * posterior_wave
    raw_a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Keep deterministic reserve below the 1800 deg/T^2 episode hard limit.
    a1 = clamp(raw_a1, -params.command_limit, params.command_limit)
    a2 = clamp(raw_a2, -params.command_limit, params.command_limit)

    return (phi_ddot=(a1, a2),)
end
