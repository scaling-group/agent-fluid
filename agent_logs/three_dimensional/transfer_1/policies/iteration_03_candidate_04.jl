# L64 3D candidate: preserve the evidenced propulsive traveling bend and
# achieved-course steering, then release carrier cadence during a fast terminal
# approach so the steering loop retains acceleration headroom for capture.
# Phase remains entirely in observed joint state; there is no clock, route,
# world coordinate, or mutable controller state.

function target_policy_params()
    return (
        version="dogfish3d_course_terminal_capture_v1",
        drive_period=0.55,
        control_period=0.55,
        drive_amplitude=28.0 * pi / 180,
        drive_mu=0.35,
        drive_tail_lag_gain=0.80,
        drive_tail_damping=0.65,
        far_drive_frequency_gain=0.114,
        far_drive_turn_relief=0.36,
        progress_drive_frequency_gain=0.034,
        progress_closing_speed_scale=0.16,
        approach_distance_L=2.10,
        target_angle_limit=1.25,
        course_angle_limit=1.25,
        course_forward_floor=0.08,
        course_speed_scale=0.25,
        route_error_scale=0.32,
        steering_accel_limit=12.0,
        head_steering_share=0.45,
        tail_steering_share=1.00,
        terminal_relief_distance_L=4.0,
        terminal_proximity_power=2.0,
        terminal_closing_speed_scale=0.20,
        terminal_drive_frequency_floor=0.55,
        acceleration_limit=1800.0 * pi / 180,
    )
end

@inline function _clamp01(value)
    return clamp(value, 0.0, 1.0)
end

@inline function _safe(value, fallback)
    parsed = Float64(value)
    return isfinite(parsed) ? parsed : fallback
end

function drive_module(state, params, drive_frequency_scale=1.0)
    omega =
        (2 * pi / params.drive_period) *
        max(_safe(drive_frequency_scale, 1.0), 0.50)
    amplitude = max(abs(params.drive_amplitude), eps(Float64))
    q1 = _safe(state.phi[1], 0.0)
    q2 = _safe(state.phi[2], 0.0)
    qd1 = _safe(state.phi_dot[1], 0.0)
    qd2 = _safe(state.phi_dot[2], 0.0)

    # Joint-state phase and posterior lag retain the coherent carrier wake
    # observed in every finite sampled rollout.
    vdp_drive =
        params.drive_mu *
        (1 - (q1 / amplitude)^2) *
        qd1
    head_accel = vdp_drive - omega^2 * q1
    tail_target =
        -q1 -
        params.drive_tail_lag_gain * qd1 / max(omega, eps(Float64))
    tail_accel =
        omega^2 * (tail_target - q2) -
        2 * params.drive_tail_damping * omega * qd2

    return (
        head_accel=head_accel,
        tail_accel=tail_accel,
        omega=omega,
    )
end

function guidance_module(state, params)
    distance_L = max(abs(_safe(state.distance_L, 1.0)), 1.0e-6)
    target_x = _safe(state.target_body_L[1], -distance_L)
    target_y = _safe(state.target_body_L[2], 0.0)

    # Body-frame -x is forward. These angles are dimensionless and independent
    # of body length, moving-window origin, and world target coordinates.
    target_angle = atan(
        target_y,
        max(-target_x, params.course_forward_floor),
    )
    target_angle = clamp(
        target_angle,
        -params.target_angle_limit,
        params.target_angle_limit,
    )

    velocity_x = _safe(state.velocity_body_U[1], 0.0)
    velocity_y = _safe(state.velocity_body_U[2], 0.0)
    course_speed = hypot(velocity_x, velocity_y)
    course_angle = atan(
        velocity_y,
        max(-velocity_x, params.course_forward_floor),
    )
    course_angle = clamp(
        course_angle,
        -params.course_angle_limit,
        params.course_angle_limit,
    )

    # Use target angle at release, then close the loop on achieved direction of
    # travel once speed makes the body-frame course observable.
    course_gate =
        tanh(course_speed / max(params.course_speed_scale, 1.0e-6))^2
    course_error = clamp(
        target_angle - course_angle,
        -params.course_angle_limit,
        params.course_angle_limit,
    )
    route_error =
        (1 - course_gate) * target_angle +
        course_gate * course_error
    turn_command =
        tanh(route_error / max(params.route_error_scale, 1.0e-6))

    closing_speed = hasproperty(state, :window_closing_speed_L) ?
        _safe(state.window_closing_speed_L, 0.0) :
        _safe(state.closing_speed_L, 0.0)
    closing_deficit =
        0.5 *
        (1 - tanh(
            closing_speed /
            max(params.progress_closing_speed_scale, 1.0e-6),
        ))
    far_drive_gate =
        _clamp01(distance_L / max(params.approach_distance_L, 1.0e-6))

    return (
        distance_L=distance_L,
        target_angle=target_angle,
        course_angle=course_angle,
        course_speed=course_speed,
        course_gate=course_gate,
        course_error=course_error,
        route_error=route_error,
        turn_command=turn_command,
        closing_speed_L=closing_speed,
        closing_deficit=closing_deficit,
        far_drive_gate=far_drive_gate,
    )
end

function terminal_capture_module(guidance, params)
    distance_fraction = _clamp01(
        guidance.distance_L /
        max(params.terminal_relief_distance_L, 1.0e-6),
    )
    proximity =
        1 - distance_fraction^max(params.terminal_proximity_power, 1.0)
    closing_gate =
        0.5 *
        (1 + tanh(
            guidance.closing_speed_L /
            max(params.terminal_closing_speed_scale, 1.0e-6),
        ))
    relief = _clamp01(proximity * closing_gate)
    frequency_scale =
        1 -
        (1 - clamp(params.terminal_drive_frequency_floor, 0.50, 1.0)) *
        relief
    return (
        proximity=proximity,
        closing_gate=closing_gate,
        relief=relief,
        frequency_scale=frequency_scale,
    )
end

function target_policy(state, params)
    guidance = guidance_module(state, params)
    terminal = terminal_capture_module(guidance, params)
    cadence_gain =
        params.far_drive_frequency_gain +
        params.progress_drive_frequency_gain * guidance.closing_deficit
    cruise_frequency_scale =
        1.0 +
        cadence_gain *
        guidance.far_drive_gate *
        (1.0 - params.far_drive_turn_relief * abs(guidance.turn_command))
    drive_frequency_scale =
        cruise_frequency_scale * terminal.frequency_scale
    drive = drive_module(state, params, drive_frequency_scale)

    # Carrier relief is applied before this bounded shared acceleration bias:
    # near a fast closing approach, course correction keeps priority instead of
    # competing with a saturated propulsive command.
    steering_accel =
        params.steering_accel_limit * guidance.turn_command
    head_command =
        drive.head_accel +
        params.head_steering_share * steering_accel
    tail_command =
        drive.tail_accel +
        params.tail_steering_share * steering_accel
    return (
        phi_ddot=(
            clamp(
                head_command,
                -params.acceleration_limit,
                params.acceleration_limit,
            ),
            clamp(
                tail_command,
                -params.acceleration_limit,
                params.acceleration_limit,
            ),
        ),
    )
end
