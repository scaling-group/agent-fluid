# Approach-localized bearing-trend brake around the evidenced bounded-curvature
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
        approach_distance_scale=3.0,
        approach_distance_power=8.0,
        approach_closing_threshold=0.30,
        approach_closing_scale=0.12,
        approach_bearing_rate_scale=0.75,
        maximum_approach_trend_brake=0.80,
        closing_speed_limit=2.0,
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

    # The sampled near misses retain a large bearing while its recent trend is
    # worsening and head-distance closure has collapsed. Apply that measured
    # response against the primary turn request only in the approach regime.
    # The signed trend makes this feedback reflection equivariant; improving
    # geometry releases the brake continuously instead of latching a stage.
    distance = max(Float64(state.distance_L), eps(Float64))
    closing_speed = clamp(
        Float64(state.closing_speed_L),
        -params.closing_speed_limit,
        params.closing_speed_limit,
    )
    bearing_trend = clamp(
        Float64(state.bearing_window_rate),
        -params.heading_rate_limit,
        params.heading_rate_limit,
    )
    approach_weight = 1 / (1 +
        (distance / params.approach_distance_scale)^params.approach_distance_power)
    closing_deficit = 0.5 * (1 + tanh(
        (params.approach_closing_threshold - closing_speed) /
            params.approach_closing_scale,
    ))
    trend_brake = params.maximum_approach_trend_brake *
        approach_weight * closing_deficit *
        tanh(bearing_trend / params.approach_bearing_rate_scale)
    steering_error = bearing -
        params.heading_rate_damping * heading_rate - trend_brake
    mean_curvature = params.maximum_mean_curvature *
        tanh(steering_error / params.curvature_error_scale)

    # Preserve the sampled anterior state-feedback carrier and move only its
    # equilibrium. No clock, world coordinate, route, or case identity enters.
    centered_q1 = q1 - mean_curvature
    vdp_drive = params.oscillator_mu *
        (1 - (centered_q1 / amp)^2) * qd1
    raw_a1 = vdp_drive - omega^2 * centered_q1

    # Gross misalignment attenuates posterior thrust without removing its mean
    # steering curvature. Alignment continuously restores the full lagged wave.
    normalized_bearing = bearing / params.alignment_bearing_scale
    posterior_wave_authority = params.posterior_wave_floor +
        (1 - params.posterior_wave_floor) / (1 + normalized_bearing^2)
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
