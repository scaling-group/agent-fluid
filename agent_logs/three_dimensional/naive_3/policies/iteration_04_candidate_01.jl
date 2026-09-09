# Full-direction course tracking around the evidenced bounded-curvature
# carrier. Oscillation phase remains entirely in measured joint state.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        maximum_mean_curvature=7.0 * pi / 180,
        course_error_scale=0.45,
        direction_limit=1.0,
        course_angle_limit=1.0,
        course_speed_floor=0.15,
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

    # The spine's forward axis is negative body x. Full target direction keeps
    # target-ahead and target-behind geometry distinct.
    target_x = Float64(state.target_body_L[1])
    target_y = Float64(state.target_body_L[2])
    direction_error = atan(target_y, -target_x)
    bounded_direction = clamp(
        direction_error,
        -params.direction_limit,
        params.direction_limit,
    )

    # Compare the target direction with the measured translation course. This
    # avoids injecting tailbeat-scale yaw into the slow curvature equilibrium.
    velocity_x = Float64(state.velocity_body_U[1])
    velocity_y = Float64(state.velocity_body_U[2])
    forward_speed = max(-velocity_x, params.course_speed_floor)
    course_angle = clamp(
        atan(velocity_y, forward_speed),
        -params.course_angle_limit,
        params.course_angle_limit,
    )
    steering_error = bounded_direction - course_angle
    mean_curvature = params.maximum_mean_curvature *
        tanh(steering_error / params.course_error_scale)

    # Preserve the sampled anterior state-feedback carrier and move only its
    # equilibrium. No clock, world coordinate, route, or case identity enters.
    centered_q1 = q1 - mean_curvature
    vdp_drive = params.oscillator_mu *
        (1 - (centered_q1 / amp)^2) * qd1
    raw_a1 = vdp_drive - omega^2 * centered_q1

    # Gross misalignment attenuates posterior thrust without removing its mean
    # steering curvature. Alignment continuously restores the full lagged wave.
    normalized_direction =
        direction_error / params.alignment_direction_scale
    posterior_wave_authority = params.posterior_wave_floor +
        (1 - params.posterior_wave_floor) / (1 + normalized_direction^2)
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
