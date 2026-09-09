# Closing-response-gated burst redirect around the evidenced bounded-curvature
# carrier. Oscillation phase remains entirely in measured joint state.

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
        redirect_direction_threshold=0.55,
        redirect_direction_scale=0.15,
        redirect_closing_threshold=0.45,
        redirect_closing_scale=0.12,
        closing_speed_limit=2.0,
        redirect_curvature=6.0 * pi / 180,
        redirect_tail_share=0.35,
        redirect_response_scale=0.75,
        redirect_wave_relief=0.55,
        total_curvature_limit=13.0 * pi / 180,
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

    # The spine's forward axis is negative body x. This direction preserves
    # whether the target is ahead or behind, unlike the adapter's acute bearing.
    target_x = Float64(state.target_body_L[1])
    target_y = Float64(state.target_body_L[2])
    direction_error = atan(target_y, -target_x)
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

    # Retain the sampled far-field steering carrier without scalar gain changes.
    steering_error = bounded_direction -
        params.heading_rate_damping * heading_rate
    cruise_request = tanh(steering_error / params.direction_error_scale)
    cruise_curvature = params.maximum_mean_curvature * cruise_request

    # A continuous C-bend residual appears only when material full-direction
    # error coincides with inadequate closing response. Correct-sign measured
    # yaw releases the burst rather than relying on a clock or hidden mode.
    misalignment_weight = 0.5 * (1 + tanh(
        (abs(direction_error) - params.redirect_direction_threshold) /
        params.redirect_direction_scale,
    ))
    closing_speed = clamp(
        Float64(state.closing_speed_L),
        -params.closing_speed_limit,
        params.closing_speed_limit,
    )
    closing_deficit = 0.5 * (1 + tanh(
        (params.redirect_closing_threshold - closing_speed) /
        params.redirect_closing_scale,
    ))
    redirect_direction = tanh(direction_error / params.direction_error_scale)
    corrective_turn_rate = max(-redirect_direction * heading_rate, 0.0)
    response_release = 1 / (1 +
        (corrective_turn_rate / params.redirect_response_scale)^2)
    redirect_weight = misalignment_weight * closing_deficit * response_release
    redirect_curvature = params.redirect_curvature *
        redirect_weight * redirect_direction
    mean_curvature = clamp(
        cruise_curvature + redirect_curvature,
        -params.total_curvature_limit,
        params.total_curvature_limit,
    )

    # Preserve the anterior joint-state oscillator and move only its equilibrium.
    centered_q1 = q1 - mean_curvature
    vdp_drive = params.oscillator_mu *
        (1 - (centered_q1 / amp)^2) * qd1
    raw_a1 = vdp_drive - omega^2 * centered_q1

    # During a redirect, trade some posterior traveling-wave thrust for the
    # requested bend. Alignment or a corrective turn restores cruise smoothly.
    normalized_direction =
        direction_error / params.alignment_direction_scale
    alignment_authority = params.posterior_wave_floor +
        (1 - params.posterior_wave_floor) /
        (1 + normalized_direction^2)
    posterior_wave_authority = alignment_authority *
        (1 - params.redirect_wave_relief * redirect_weight)
    tail_mean = params.tail_curvature_share * cruise_curvature +
        params.redirect_tail_share * redirect_curvature
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
