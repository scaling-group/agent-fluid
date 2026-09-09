# Geometry-gated redirect gait around the evidenced posterior-lag cruise.
# Oscillator phase remains entirely in measured joint state.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        maximum_cruise_curvature=7.0 * pi / 180,
        cruise_error_scale=0.45,
        bearing_limit=1.0,
        heading_rate_damping=0.18,
        heading_rate_limit=4.0,
        cruise_tail_curvature_share=0.8,
        alignment_bearing_scale=0.60,
        posterior_wave_floor=0.35,
        maximum_redirect_curvature=24.0 * pi / 180,
        redirect_direction_scale=0.12,
        redirect_direction_limit=1.2,
        redirect_weight_power=2.0,
        redirect_tail_curvature_share=0.9,
        redirect_frequency_ratio=0.65,
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

    # Preserve front/back target geometry for gait selection. The fish's
    # forward direction is negative body x, so atan(y, -x) is its signed
    # target-direction error without any world-frame route information.
    target_x = Float64(state.target_body_L[1])
    target_y = Float64(state.target_body_L[2])
    target_direction = atan(target_y, -target_x)
    bounded_direction = clamp(
        target_direction,
        -params.redirect_direction_limit,
        params.redirect_direction_limit,
    )
    redirect_command = tanh(
        bounded_direction / params.redirect_direction_scale,
    )
    redirect_weight = abs(redirect_command)^params.redirect_weight_power

    # Retain the strongest sampled cruise carrier when aligned. Measured yaw
    # and acute bearing affect only the inherited bounded cruise curvature.
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
    cruise_error = bearing - params.heading_rate_damping * heading_rate
    cruise_curvature = params.maximum_cruise_curvature *
        tanh(cruise_error / params.cruise_error_scale)
    centered_q1 = q1 - cruise_curvature
    cruise_drive = params.oscillator_mu *
        (1 - (centered_q1 / amp)^2) * qd1
    cruise_a1 = cruise_drive - omega^2 * centered_q1

    normalized_bearing = bearing / params.alignment_bearing_scale
    posterior_wave_authority = params.posterior_wave_floor +
        (1 - params.posterior_wave_floor) / (1 + normalized_bearing^2)
    cruise_tail_mean =
        params.cruise_tail_curvature_share * cruise_curvature
    posterior_wave = -centered_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    cruise_tail_target = cruise_tail_mean +
        posterior_wave_authority * posterior_wave
    cruise_a2 = omega^2 * (cruise_tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Material target misalignment replaces the propulsive wave with a
    # same-sign C-bend. The smooth geometry gate releases automatically as the
    # target returns to the forward body axis; no clock or hidden gait state is
    # needed. Joint damping prevents the redirect from becoming a new rhythm.
    redirect_curvature =
        params.maximum_redirect_curvature * redirect_command
    redirect_tail_target =
        params.redirect_tail_curvature_share * redirect_curvature
    redirect_omega = params.redirect_frequency_ratio * omega
    redirect_a1 = redirect_omega^2 * (redirect_curvature - q1) -
        2 * params.redirect_damping * redirect_omega * qd1
    redirect_a2 = redirect_omega^2 * (redirect_tail_target - q2) -
        2 * params.redirect_damping * redirect_omega * qd2

    cruise_weight = 1 - redirect_weight
    raw_a1 = cruise_weight * cruise_a1 + redirect_weight * redirect_a1
    raw_a2 = cruise_weight * cruise_a2 + redirect_weight * redirect_a2

    # Keep deterministic reserve below the 1800 deg/T^2 episode hard limit.
    a1 = clamp(raw_a1, -params.command_limit, params.command_limit)
    a2 = clamp(raw_a2, -params.command_limit, params.command_limit)
    return (phi_ddot=(a1, a2),)
end
