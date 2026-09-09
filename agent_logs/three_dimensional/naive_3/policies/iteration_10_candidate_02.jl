# Observation-gated terminal C-bend around the evidenced alignment-gated
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
        terminal_direction_threshold=0.65,
        terminal_direction_transition=0.14,
        terminal_closing_threshold=0.70,
        terminal_closing_transition=0.12,
        terminal_distance_scale=3.5,
        terminal_distance_power=8.0,
        redirect_direction_scale=0.60,
        maximum_redirect_curvature=20.0 * pi / 180,
        redirect_damping=0.90,
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
    steering_error = bearing - params.heading_rate_damping * heading_rate
    mean_curvature = params.maximum_mean_curvature *
        tanh(steering_error / params.curvature_error_scale)

    # Preserve the sampled anterior state-feedback carrier and move only its
    # equilibrium during the ordinary cruise and middle approach.
    centered_q1 = q1 - mean_curvature
    vdp_drive = params.oscillator_mu *
        (1 - (centered_q1 / amp)^2) * qd1
    cruise_a1 = vdp_drive - omega^2 * centered_q1

    normalized_bearing = bearing / params.alignment_bearing_scale
    posterior_wave_authority = params.posterior_wave_floor +
        (1 - params.posterior_wave_floor) / (1 + normalized_bearing^2)
    tail_mean = params.tail_curvature_share * mean_curvature
    posterior_wave = -centered_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    phase_lag_target = tail_mean + posterior_wave_authority * posterior_wave
    cruise_a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    # The acute bearing intentionally supports cruise but cannot distinguish a
    # target that has moved behind the transverse plane. Full body-frame target
    # direction supplies only the terminal redirect gate and bend sign.
    target_x = Float64(state.target_body_L[1])
    target_y = Float64(state.target_body_L[2])
    distance = max(Float64(state.distance_L), eps(Float64))
    direction_error = atan(target_y, -target_x)
    closing_speed = Float64(state.closing_speed_L)

    direction_weight = 0.5 * (1 + tanh(
        (abs(direction_error) - params.terminal_direction_threshold) /
            params.terminal_direction_transition,
    ))
    closing_weight = 0.5 * (1 + tanh(
        (params.terminal_closing_threshold - closing_speed) /
            params.terminal_closing_transition,
    ))
    approach_weight = 1 / (1 +
        (distance / params.terminal_distance_scale)^params.terminal_distance_power)
    redirect_weight = direction_weight * closing_weight * approach_weight

    # A stalled, strongly off-axis terminal approach replaces rather than
    # stacks onto the propulsive wave. Same-sign joint equilibria form a
    # bounded C-bend; the FSI-calibrated sign turns toward direction_error.
    # Realignment or restored closure continuously returns authority to cruise.
    redirect_curvature = params.maximum_redirect_curvature * tanh(
        direction_error / params.redirect_direction_scale,
    )
    redirect_a1 = omega^2 * (redirect_curvature - q1) -
        2 * params.redirect_damping * omega * qd1
    redirect_a2 = omega^2 * (redirect_curvature - q2) -
        2 * params.redirect_damping * omega * qd2

    raw_a1 = (1 - redirect_weight) * cruise_a1 +
        redirect_weight * redirect_a1
    raw_a2 = (1 - redirect_weight) * cruise_a2 +
        redirect_weight * redirect_a2

    # Keep deterministic reserve below the 1800 deg/T^2 episode hard limit.
    a1 = clamp(raw_a1, -params.command_limit, params.command_limit)
    a2 = clamp(raw_a2, -params.command_limit, params.command_limit)
    return (phi_ddot=(a1, a2),)
end
