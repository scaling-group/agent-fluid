# Slip-gated posterior phase modulation around the evidenced bounded-curvature
# carrier. Oscillator phase remains entirely in measured joint state.

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
        desired_lateral_speed=0.35,
        lateral_slip_scale=0.30,
        maximum_lag_relief=0.35,
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

    # Preserve the best sampled target-error-to-curvature reflex. Measured yaw
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
    turn_request = tanh(steering_error / params.curvature_error_scale)
    mean_curvature = params.maximum_mean_curvature * turn_request

    # Keep the evidenced anterior state-feedback carrier unchanged apart from
    # its signed equilibrium. No clock, coordinate, or route enters the phase.
    centered_q1 = q1 - mean_curvature
    vdp_drive = params.oscillator_mu *
        (1 - (centered_q1 / amp)^2) * qd1
    raw_a1 = vdp_drive - omega^2 * centered_q1

    # Compare rigid-body lateral motion with a bounded lateral target-ray
    # velocity. A persistent residual rotates the posterior angle/rate basis
    # toward anti-phase. Renormalization holds its state-wave amplitude fixed,
    # separating this experiment from the failed distance/drive relief.
    target_y = Float64(state.target_body_L[2])
    distance = max(Float64(state.distance_L), eps(Float64))
    lateral_target_fraction = clamp(target_y / distance, -1.0, 1.0)
    desired_lateral_velocity =
        params.desired_lateral_speed * lateral_target_fraction
    lateral_velocity = Float64(state.velocity_body_U[2])
    lateral_slip_residual = desired_lateral_velocity - lateral_velocity
    slip_weight = tanh(
        abs(lateral_slip_residual) / params.lateral_slip_scale,
    )^2
    effective_lag_gain = params.tail_lag_gain *
        (1 - params.maximum_lag_relief * slip_weight)
    phase_amplitude_scale = sqrt(
        (1 + params.tail_lag_gain^2) / (1 + effective_lag_gain^2),
    )

    # Preserve alignment-gated posterior authority and the signed tail mean.
    # The slip gate is even, so reflection changes only the steering side.
    normalized_bearing = bearing / params.alignment_bearing_scale
    posterior_wave_authority = params.posterior_wave_floor +
        (1 - params.posterior_wave_floor) / (1 + normalized_bearing^2)
    tail_mean = params.tail_curvature_share * mean_curvature
    posterior_wave = phase_amplitude_scale * (
        -centered_q1 -
        effective_lag_gain * qd1 / max(omega, eps(omega))
    )
    phase_lag_target = tail_mean + posterior_wave_authority * posterior_wave
    raw_a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Keep deterministic reserve below the 1800 deg/T^2 episode hard limit.
    a1 = clamp(raw_a1, -params.command_limit, params.command_limit)
    a2 = clamp(raw_a2, -params.command_limit, params.command_limit)
    return (phi_ddot=(a1, a2),)
end
