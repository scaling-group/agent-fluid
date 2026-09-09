# Bearing-response-gated posterior S-bend around the evidenced alignment-gated
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
        redirect_direction_threshold=0.60,
        redirect_direction_scale=0.15,
        redirect_closing_threshold=0.40,
        redirect_closing_scale=0.12,
        closing_speed_limit=2.0,
        redirect_distance_scale=3.2,
        redirect_distance_power=8.0,
        redirect_bearing_response_scale=0.75,
        maximum_posterior_redirect=6.0 * pi / 180,
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

    # Full target direction retains the ahead/behind distinction hidden by the
    # acute bearing. Large misalignment and inadequate measured head-distance
    # closure must agree before the posterior equilibrium receives a redirect.
    # The approach envelope excludes the evidenced early-course failures.
    target_x = Float64(state.target_body_L[1])
    target_y = Float64(state.target_body_L[2])
    distance = max(Float64(state.distance_L), eps(Float64))
    direction_error = atan(target_y, -target_x)
    redirect_direction = tanh(
        direction_error / params.curvature_error_scale,
    )
    direction_weight = 0.5 * (1 + tanh(
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
    approach_weight = 1 / (1 +
        (distance / params.redirect_distance_scale)^params.redirect_distance_power)
    # Release only when target-relative geometry is actually correcting. This
    # includes head translation and yaw, unlike a center-velocity projection or
    # yaw-rate sign alone, and remains a bounded body-frame state signal.
    bearing_trend = clamp(
        Float64(state.bearing_window_rate),
        -params.heading_rate_limit,
        params.heading_rate_limit,
    )
    corrective_bearing_rate = max(
        -redirect_direction * bearing_trend,
        0.0,
    )
    response_release = 1 / (1 +
        (corrective_bearing_rate /
            params.redirect_bearing_response_scale)^2)
    redirect_weight = approach_weight * direction_weight *
        closing_deficit * response_release
    posterior_redirect = params.maximum_posterior_redirect *
        redirect_weight * redirect_direction

    # The completed same-sign redirect worsened the near miss. Allocate the
    # residual oppositely to form the evidenced posterior S-bend topology.
    tail_mean = params.tail_curvature_share * mean_curvature -
        posterior_redirect
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
