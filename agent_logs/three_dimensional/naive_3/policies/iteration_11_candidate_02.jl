# Windowed-closure approach hold around the evidenced alignment-gated
# counterbend carrier. Phase remains entirely in measured joint state.

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
        target_lateral_scale=0.20,
        opposing_lateral_speed_scale=0.25,
        terminal_course_residual_scale=0.30,
        terminal_approach_distance_scale=4.0,
        terminal_approach_power=4.0,
        maximum_posterior_counterbend=7.0 * pi / 180,
        hold_distance_scale=2.8,
        hold_distance_power=8.0,
        hold_course_scale=0.35,
        hold_closing_threshold=0.25,
        hold_closing_scale=0.12,
        hold_closing_speed_limit=2.0,
        hold_posterior_wave_fraction=0.20,
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

    # Retain the inherited bounded S-bend: instantaneous wrong-side translation
    # and a target-ray course residual share one posterior equilibrium envelope.
    target_x = Float64(state.target_body_L[1])
    target_y = Float64(state.target_body_L[2])
    distance = max(Float64(state.distance_L), eps(Float64))
    longitudinal_target_fraction = clamp(target_x / distance, -1.0, 1.0)
    lateral_target_fraction = clamp(target_y / distance, -1.0, 1.0)
    target_side = tanh(
        lateral_target_fraction / params.target_lateral_scale,
    )
    forward_velocity = Float64(state.velocity_body_U[1])
    lateral_velocity = Float64(state.velocity_body_U[2])
    opposing_lateral_speed = max(0.0, -target_side * lateral_velocity)
    wrong_side_guard = target_side * tanh(
        opposing_lateral_speed / params.opposing_lateral_speed_scale,
    )^2
    target_ray_course_residual =
        longitudinal_target_fraction * lateral_velocity -
        lateral_target_fraction * forward_velocity
    terminal_approach_weight = 1 / (1 +
        (distance / params.terminal_approach_distance_scale)^
            params.terminal_approach_power)
    terminal_course_guard = terminal_approach_weight * tanh(
        target_ray_course_residual / params.terminal_course_residual_scale,
    )
    counterbend_guard = clamp(
        wrong_side_guard + terminal_course_guard,
        -1.0,
        1.0,
    )
    posterior_counterbend =
        params.maximum_posterior_counterbend * counterbend_guard

    # In a near, cross-track, non-closing approach, reduce only the posterior
    # traveling wave. Windowed distance closure avoids interpreting one
    # oscillatory velocity sample as a recovered approach. The anterior carrier
    # and posterior mean steering remain active, and the nonzero floor avoids
    # an uncontrolled coast.
    windowed_closing_speed = clamp(
        Float64(state.window_closing_speed_L),
        -params.hold_closing_speed_limit,
        params.hold_closing_speed_limit,
    )
    hold_approach_weight = 1 / (1 +
        (distance / params.hold_distance_scale)^params.hold_distance_power)
    hold_course_weight = tanh(
        abs(target_ray_course_residual) / params.hold_course_scale,
    )^2
    hold_closing_weight = 0.5 * (1 + tanh(
        (params.hold_closing_threshold - windowed_closing_speed) /
            params.hold_closing_scale,
    ))
    hold_weight = hold_approach_weight * hold_course_weight *
        hold_closing_weight
    posterior_wave_fraction = 1 -
        (1 - params.hold_posterior_wave_fraction) * hold_weight

    tail_mean = params.tail_curvature_share * mean_curvature -
        posterior_counterbend
    posterior_wave = -centered_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    phase_lag_target = tail_mean + posterior_wave_authority *
        posterior_wave_fraction * posterior_wave
    raw_a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Keep deterministic reserve below the 1800 deg/T^2 episode hard limit.
    a1 = clamp(raw_a1, -params.command_limit, params.command_limit)
    a2 = clamp(raw_a2, -params.command_limit, params.command_limit)

    return (phi_ddot=(a1, a2),)
end
