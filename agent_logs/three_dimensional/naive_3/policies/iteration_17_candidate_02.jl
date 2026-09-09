# Closure-gated anterior burst redirect around the evidenced response-selected
# posterior brake. Oscillation phase remains entirely in measured joint state.

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
        approach_distance_scale=3.2,
        approach_distance_power=8.0,
        lateral_direction_threshold=0.60,
        lateral_direction_scale=0.15,
        wrong_way_yaw_threshold=0.75,
        wrong_way_yaw_scale=0.25,
        posterior_brake_floor=0.35,
        redirect_closing_threshold=0.30,
        redirect_closing_scale=0.10,
        closing_speed_limit=2.0,
        maximum_redirect_residual=8.0 * pi / 180,
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

    # Full target direction retains the ahead/behind distinction hidden by the
    # acute bearing. The normalized distance envelope leaves cruise unchanged.
    target_x = Float64(state.target_body_L[1])
    target_y = Float64(state.target_body_L[2])
    distance = max(Float64(state.distance_L), eps(Float64))
    direction_error = atan(target_y, -target_x)
    direction_sign = tanh(
        direction_error / params.curvature_error_scale,
    )
    lateral_weight = 0.5 * (1 + tanh(
        (abs(direction_error) - params.lateral_direction_threshold) /
            params.lateral_direction_scale,
    ))
    approach_weight = 1 / (1 +
        (distance / params.approach_distance_scale)^params.approach_distance_power)

    # The completed traces keep useful closure outside approach, but lose it
    # while the target remains strongly lateral. Agreement among approach,
    # full direction, and measured closure gates a bounded burst redirect.
    closing_speed = clamp(
        Float64(state.closing_speed_L),
        -params.closing_speed_limit,
        params.closing_speed_limit,
    )
    closing_deficit = 0.5 * (1 + tanh(
        (params.redirect_closing_threshold - closing_speed) /
            params.redirect_closing_scale,
    ))
    redirect_weight = approach_weight * lateral_weight * closing_deficit

    # Raw yaw is beat-locked in the sampled near miss, but remains the evidenced
    # selector for counterproductive posterior half-cycles.
    raw_heading_rate = clamp(
        Float64(state.heading_rate),
        -params.heading_rate_limit,
        params.heading_rate_limit,
    )

    # Preserve cruise mean curvature. Only a stalled, lateral approach adds a
    # signed anterior equilibrium residual, released continuously by recovered
    # closure or direction. The total remains far inside the 45 degree limit.
    bearing = clamp(
        Float64(state.bearing),
        -params.bearing_limit,
        params.bearing_limit,
    )
    steering_error = bearing -
        params.heading_rate_damping * raw_heading_rate
    cruise_mean_curvature = params.maximum_mean_curvature *
        tanh(steering_error / params.curvature_error_scale)
    redirect_residual = params.maximum_redirect_residual *
        redirect_weight * direction_sign
    maximum_total_curvature = params.maximum_mean_curvature +
        params.maximum_redirect_residual
    mean_curvature = clamp(
        cruise_mean_curvature + redirect_residual,
        -maximum_total_curvature,
        maximum_total_curvature,
    )

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
    # Keep the redirect anterior-only: allowing it into either posterior term
    # would recreate the static tail residual rejected by inherited evidence.
    cruise_centered_q1 = q1 - cruise_mean_curvature
    tail_mean = params.tail_curvature_share * cruise_mean_curvature
    posterior_wave = -cruise_centered_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))

    # Preserve the strongest sampled terminal mechanism: measured yaw selects
    # only response intervals that grow the signed full-direction error. The
    # selected posterior wave is attenuated, while corrective yaw is untouched.
    wrong_way_yaw = max(direction_sign * raw_heading_rate, 0.0)
    wrong_way_weight = 0.5 * (1 + tanh(
        (wrong_way_yaw - params.wrong_way_yaw_threshold) /
            params.wrong_way_yaw_scale,
    ))
    response_weight = approach_weight * lateral_weight * wrong_way_weight
    propulsion_scale = 1 -
        (1 - params.posterior_brake_floor) * response_weight

    phase_lag_target = tail_mean +
        propulsion_scale * posterior_wave_authority * posterior_wave
    raw_a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Keep deterministic reserve below the 1800 deg/T^2 episode hard limit.
    a1 = clamp(raw_a1, -params.command_limit, params.command_limit)
    a2 = clamp(raw_a2, -params.command_limit, params.command_limit)
    return (phi_ddot=(a1, a2),)
end
