# Response-released anterior burst redirect around the evidenced
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
        burst_distance_scale=3.6,
        burst_distance_power=8.0,
        burst_direction_threshold=0.55,
        burst_direction_scale=0.15,
        burst_lateral_scale=0.45,
        burst_response_scale=0.75,
        maximum_anterior_burst=12.0 * pi / 180,
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

    # Persistent target error asks for bounded cruise curvature. Measured yaw
    # damps this baseline request as the body turns.
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
    cruise_curvature = params.maximum_mean_curvature *
        tanh(steering_error / params.curvature_error_scale)

    # The full target direction retains the ahead/behind distinction hidden by
    # the acute bearing. Near a strongly lateral target, lack of corrective
    # bearing response requests a bounded nonsteady anterior curvature burst.
    # Corrective response continuously releases it back to the cruise rhythm.
    target_x = Float64(state.target_body_L[1])
    target_y = Float64(state.target_body_L[2])
    distance = max(Float64(state.distance_L), eps(Float64))
    direction_error = atan(target_y, -target_x)
    lateral_fraction = clamp(target_y / distance, -1.0, 1.0)
    turn_request = tanh(lateral_fraction / params.burst_lateral_scale)
    direction_weight = 0.5 * (1 + tanh(
        (abs(direction_error) - params.burst_direction_threshold) /
            params.burst_direction_scale,
    ))
    approach_weight = 1 / (1 +
        (distance / params.burst_distance_scale)^params.burst_distance_power)
    bearing_trend = clamp(
        Float64(state.bearing_window_rate),
        -params.heading_rate_limit,
        params.heading_rate_limit,
    )
    corrective_bearing_rate = max(-turn_request * bearing_trend, 0.0)
    response_release = 1 / (1 +
        (corrective_bearing_rate / params.burst_response_scale)^2)
    burst_curvature = params.maximum_anterior_burst * approach_weight *
        direction_weight * response_release * turn_request
    anterior_curvature = cruise_curvature + burst_curvature

    # Move only the anterior equilibrium. This gives the burst a distinct
    # steering role without increasing carrier frequency, amplitude, or raw
    # drive gain. No clock, route, or case identity enters the oscillator.
    centered_q1 = q1 - anterior_curvature
    vdp_drive = params.oscillator_mu *
        (1 - (centered_q1 / amp)^2) * qd1
    raw_a1 = vdp_drive - omega^2 * centered_q1

    # Alignment retains a nonzero posterior traveling wave during redirection.
    normalized_bearing = bearing / params.alignment_bearing_scale
    posterior_wave_authority = params.posterior_wave_floor +
        (1 - params.posterior_wave_floor) / (1 + normalized_bearing^2)
    # The tail keeps the cruise mean and lagged wave: it does not inherit the
    # burst offset, so posterior propulsion remains separate from redirection.
    tail_mean = params.tail_curvature_share * cruise_curvature
    posterior_wave = -centered_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    phase_lag_target = tail_mean +
        posterior_wave_authority * posterior_wave
    raw_a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Keep deterministic reserve below the 1800 deg/T^2 episode hard limit.
    a1 = clamp(raw_a1, -params.command_limit, params.command_limit)
    a2 = clamp(raw_a2, -params.command_limit, params.command_limit)
    return (phi_ddot=(a1, a2),)
end
