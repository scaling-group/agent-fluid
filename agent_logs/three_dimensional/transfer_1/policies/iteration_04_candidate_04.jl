# L64 3D candidate: direct achieved-course steering preserves the sampled
# target-directed arc, while a continuous terminal allocator reserves bounded
# joint acceleration for redirection when the fish is near, closing, and
# course-misaligned. There is no clock, world route, or mutable controller state.

function target_policy_params()
    return (
        version="dogfish3d_course_terminal_allocator_v1",
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
        terminal_start_distance_L=4.00,
        terminal_full_distance_L=0.90,
        terminal_course_error_scale=0.45,
        terminal_closing_speed_scale=0.18,
        terminal_drive_authority_floor=0.25,
        steering_accel_limit=12.0,
        head_steering_share=0.45,
        tail_steering_share=1.00,
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

function terminal_guidance_module(state, params)
    distance_L = max(abs(_safe(state.distance_L, 1.0)), 1.0e-6)
    target_x = _safe(state.target_body_L[1], -distance_L)
    target_y = _safe(state.target_body_L[2], 0.0)

    # Body-frame -x is forward. At release the target angle supplies the route
    # request; once translation is measurable, achieved course closes the loop.
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
    route_request =
        tanh(route_error / max(params.route_error_scale, 1.0e-6))

    turn_command = route_request

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
    terminal_span = max(
        params.terminal_start_distance_L -
            params.terminal_full_distance_L,
        1.0e-6,
    )
    terminal_distance_gate = _clamp01(
        (params.terminal_start_distance_L - distance_L) /
            terminal_span,
    )
    terminal_course_gate = tanh(
        abs(course_error) /
        max(params.terminal_course_error_scale, 1.0e-6),
    )^2
    terminal_closing_gate = tanh(
        max(closing_speed, 0.0) /
        max(params.terminal_closing_speed_scale, 1.0e-6),
    )^2
    terminal_allocation_gate =
        terminal_distance_gate *
        terminal_course_gate *
        terminal_closing_gate
    drive_authority_floor = clamp(
        params.terminal_drive_authority_floor,
        0.0,
        1.0,
    )
    drive_authority =
        1.0 -
        (1.0 - drive_authority_floor) * terminal_allocation_gate
    return (
        distance_L=distance_L,
        target_angle=target_angle,
        course_angle=course_angle,
        course_speed=course_speed,
        course_gate=course_gate,
        course_error=course_error,
        route_error=route_error,
        route_request=route_request,
        turn_command=turn_command,
        closing_speed_L=closing_speed,
        closing_deficit=closing_deficit,
        far_drive_gate=far_drive_gate,
        terminal_distance_gate=terminal_distance_gate,
        terminal_course_gate=terminal_course_gate,
        terminal_closing_gate=terminal_closing_gate,
        terminal_allocation_gate=terminal_allocation_gate,
        drive_authority=drive_authority,
    )
end

function terminal_drive_module(
    state,
    params,
    drive_frequency_scale=1.0,
    drive_authority=1.0,
)
    omega =
        (2 * pi / params.drive_period) *
        max(_safe(drive_frequency_scale, 1.0), 0.50)
    amp = max(abs(params.drive_amplitude), eps(Float64))
    q1 = _safe(state.phi[1], 0.0)
    q2 = _safe(state.phi[2], 0.0)
    qd1 = _safe(state.phi_dot[1], 0.0)
    qd2 = _safe(state.phi_dot[2], 0.0)

    vdp_drive = params.drive_mu * (1 - (q1 / amp)^2) * qd1
    raw_head_accel = vdp_drive - omega^2 * q1
    tail_target =
        -q1 -
        params.drive_tail_lag_gain * qd1 / max(omega, eps(Float64))
    raw_tail_accel =
        omega^2 * (tail_target - q2) -
        2 * params.drive_tail_damping * omega * qd2
    bounded_drive_authority =
        clamp(_safe(drive_authority, 1.0), 0.0, 1.0)
    head_accel = bounded_drive_authority * raw_head_accel
    tail_accel = bounded_drive_authority * raw_tail_accel
    return (
        head_accel=head_accel,
        tail_accel=tail_accel,
        omega=omega,
        drive_authority=bounded_drive_authority,
    )
end

function target_policy(state, params)
    guidance = terminal_guidance_module(state, params)
    turn_load = abs(guidance.turn_command)
    cadence_gain =
        params.far_drive_frequency_gain +
        params.progress_drive_frequency_gain * guidance.closing_deficit
    drive_frequency_scale =
        1.0 +
        cadence_gain *
        guidance.far_drive_gate *
        (1.0 - params.far_drive_turn_relief * turn_load)
    drive = terminal_drive_module(
        state,
        params,
        drive_frequency_scale,
        guidance.drive_authority,
    )
    steering_accel =
        params.steering_accel_limit * guidance.turn_command
    return (
        phi_ddot=(
            clamp(
                drive.head_accel +
                    params.head_steering_share * steering_accel,
                -params.acceleration_limit,
                params.acceleration_limit,
            ),
            clamp(
                drive.tail_accel +
                    params.tail_steering_share * steering_accel,
                -params.acceleration_limit,
                params.acceleration_limit,
            ),
        ),
    )
end
