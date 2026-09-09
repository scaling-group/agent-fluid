# Response-released redirect around the evidenced posterior-gated carrier.
# Target geometry and motion response are normalized and body-relative;
# oscillator phase remains entirely in measured joint state.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        cruise_curvature_limit=7.0 * pi / 180,
        redirect_curvature_limit=12.0 * pi / 180,
        direction_error_scale=0.45,
        direction_limit=1.0,
        heading_rate_limit=4.0,
        corrective_rate_scale=1.5,
        steering_authority_floor=0.35,
        redirect_direction_scale=0.9,
        redirect_closing_threshold=0.30,
        closing_response_scale=0.15,
        tail_curvature_share=0.8,
        alignment_direction_scale=0.60,
        posterior_wave_floor=0.35,
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
    # the target-ahead/target-behind distinction that acute bearing aliases.
    target_x = Float64(state.target_body_L[1])
    target_y = Float64(state.target_body_L[2])
    distance = max(Float64(state.distance_L), eps(Float64))
    direction_error = atan(target_y, -target_x)
    bounded_direction = clamp(
        direction_error,
        -params.direction_limit,
        params.direction_limit,
    )
    direction_command = tanh(
        bounded_direction / params.direction_error_scale,
    )
    heading_rate = clamp(
        Float64(state.heading_rate),
        -params.heading_rate_limit,
        params.heading_rate_limit,
    )

    # In the measured convention, a positive target direction produces
    # corrective negative yaw. Release curvature only when target request and
    # yaw have that opposite sign; wrong-sign response retains full authority.
    # The product is reflection-invariant and the positive floor prevents a
    # corrective response from reversing the requested turn.
    corrective_rate = max(-direction_command * heading_rate, 0.0)
    response_release = tanh(
        corrective_rate / params.corrective_rate_scale,
    )
    steering_authority = 1 -
        (1 - params.steering_authority_floor) * response_release
    turn_request = direction_command * steering_authority

    # Project measured body velocity onto the normalized target ray. Extra
    # redirect envelope is recruited only when large direction error combines
    # with inadequate closing response. Corrective yaw can release the actual
    # curvature inside that envelope without a clock or hidden mode.
    velocity_x = Float64(state.velocity_body_U[1])
    velocity_y = Float64(state.velocity_body_U[2])
    closing_response = (velocity_x * target_x + velocity_y * target_y) /
        distance
    closing_deficit = 0.5 * (
        1 - tanh(
            (closing_response - params.redirect_closing_threshold) /
            params.closing_response_scale,
        )
    )
    direction_weight = tanh(
        abs(direction_error) / params.redirect_direction_scale,
    )^2
    redirect_weight = closing_deficit * direction_weight
    curvature_limit = params.cruise_curvature_limit +
        redirect_weight * (
            params.redirect_curvature_limit - params.cruise_curvature_limit
        )
    mean_curvature = curvature_limit * turn_request

    # Preserve the anterior state-feedback phase carrier and move only its
    # equilibrium. All active propulsion and steering terms remain in params.
    centered_q1 = q1 - mean_curvature
    vdp_drive = params.oscillator_mu *
        (1 - (centered_q1 / amp)^2) * qd1
    raw_a1 = vdp_drive - omega^2 * centered_q1

    # Gross full-direction error attenuates posterior thrust while retaining
    # the slow tail bend needed for the response-gated redirect.
    normalized_direction =
        direction_error / params.alignment_direction_scale
    posterior_wave_authority = params.posterior_wave_floor +
        (1 - params.posterior_wave_floor) /
        (1 + normalized_direction^2)
    tail_mean = params.tail_curvature_share * mean_curvature
    posterior_wave = -centered_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    phase_lag_target = tail_mean +
        posterior_wave_authority * posterior_wave
    raw_a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Keep deterministic reserve below the episode acceleration hard limit.
    a1 = clamp(raw_a1, -params.command_limit, params.command_limit)
    a2 = clamp(raw_a2, -params.command_limit, params.command_limit)
    return (phi_ddot=(a1, a2),)
end
