# Course-aware mean-curvature steering around the evidenced posterior-gated
# traveling-wave carrier. Phase remains entirely in measured joint state.

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
        slip_compensation_fraction=0.35,
        slip_speed_scale=0.30,
        slip_angle_limit=1.0,
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
    # the ahead/behind distinction that the adapter's acute bearing aliases.
    target_x = Float64(state.target_body_L[1])
    target_y = Float64(state.target_body_L[2])
    direction_error = atan(target_y, -target_x)
    bounded_direction = clamp(
        direction_error,
        -params.direction_limit,
        params.direction_limit,
    )

    # Translational velocity is smoother than beat-scale yaw. Once speed is
    # established, compensate a bounded part of its angle from the body axis:
    # drift opposite the target increases the turn request, while corrective
    # drift releases it. The rational weight makes startup direction-free.
    velocity_x = Float64(state.velocity_body_U[1])
    velocity_y = Float64(state.velocity_body_U[2])
    speed_squared = velocity_x^2 + velocity_y^2
    speed_scale_squared = params.slip_speed_scale^2
    velocity_authority = speed_squared /
        (speed_squared + speed_scale_squared)
    slip_angle = clamp(
        atan(velocity_y, -velocity_x),
        -params.slip_angle_limit,
        params.slip_angle_limit,
    )
    steering_error = bounded_direction -
        params.slip_compensation_fraction * velocity_authority * slip_angle
    turn_request = tanh(steering_error / params.direction_error_scale)
    mean_curvature = params.maximum_mean_curvature * turn_request

    # Preserve the anterior state-feedback oscillator and move only its
    # equilibrium. No clock, coordinate, route, or hidden controller state is
    # used.
    centered_q1 = q1 - mean_curvature
    vdp_drive = params.oscillator_mu *
        (1 - (centered_q1 / amp)^2) * qd1
    raw_a1 = vdp_drive - omega^2 * centered_q1

    # Gross body-axis misalignment attenuates posterior thrust without
    # suppressing the slow mean bend requested by course-aware steering.
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
