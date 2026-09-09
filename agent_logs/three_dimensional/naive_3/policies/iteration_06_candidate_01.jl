# Joint-state phase-separated yaw release around the evidenced full-direction
# bounded-curvature carrier. The navigation request remains body-relative.

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
        joint1_yaw_rate_coupling=0.70,
        joint2_yaw_rate_coupling=0.19,
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

    # The spine's forward axis is negative body x. Unlike the adapter's acute
    # bearing, this direction preserves whether the target has passed behind.
    target_x = Float64(state.target_body_L[1])
    target_y = Float64(state.target_body_L[2])
    direction_error = atan(target_y, -target_x)
    bounded_direction = clamp(
        direction_error,
        -params.direction_limit,
        params.direction_limit,
    )
    # Across the sampled powered approaches, joint-rate kinematics explain
    # nearly all beat-scale yaw. Remove that repeatable rhythmic component so
    # it cannot reverse the slow target-turn request; retain residual yaw as
    # the response that releases curvature after an actual body redirect.
    rhythmic_yaw_rate = -params.joint1_yaw_rate_coupling * qd1 -
        params.joint2_yaw_rate_coupling * qd2
    residual_heading_rate = clamp(
        Float64(state.heading_rate) - rhythmic_yaw_rate,
        -params.heading_rate_limit,
        params.heading_rate_limit,
    )
    steering_error = bounded_direction -
        params.heading_rate_damping * residual_heading_rate
    mean_curvature = params.maximum_mean_curvature *
        tanh(steering_error / params.direction_error_scale)

    # Preserve the sampled anterior state-feedback carrier and move only its
    # equilibrium. No clock, world coordinate, route, or case identity enters.
    centered_q1 = q1 - mean_curvature
    vdp_drive = params.oscillator_mu *
        (1 - (centered_q1 / amp)^2) * qd1
    raw_a1 = vdp_drive - omega^2 * centered_q1

    # Full direction, rather than acute bearing, keeps thrust low during a
    # pass-behind redirect. Alignment continuously restores the lagged wave.
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

    # Keep deterministic reserve below the 1800 deg/T^2 episode hard limit.
    a1 = clamp(raw_a1, -params.command_limit, params.command_limit)
    a2 = clamp(raw_a2, -params.command_limit, params.command_limit)
    return (phi_ddot=(a1, a2),)
end
