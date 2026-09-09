# L64 3D candidate: retain the achieved-course servo and propulsive traveling
# bend, then anticipate the terminal intercept from the observed inertial
# line-of-sight rate. No carrier suppression, clock, world coordinate, route,
# or mutable phase is used.

function target_policy_params()
    return (
        version="dogfish3d_course_servo_terminal_los_feedforward_v1",
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
        terminal_intercept_start_distance_L=4.00,
        terminal_intercept_full_distance_L=1.25,
        terminal_los_rate_lookahead_T=0.75,
        terminal_los_rate_limit=0.80,
        target_angle_limit=1.25,
        course_angle_limit=1.25,
        course_forward_floor=0.08,
        course_speed_scale=0.25,
        route_error_scale=0.32,
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

function drive_module(state, params, drive_frequency_scale=1.0)
    omega =
        (2 * pi / params.drive_period) *
        max(_safe(drive_frequency_scale, 1.0), 0.50)
    amplitude = max(abs(params.drive_amplitude), eps(Float64))
    q1 = _safe(state.phi[1], 0.0)
    q2 = _safe(state.phi[2], 0.0)
    qd1 = _safe(state.phi_dot[1], 0.0)
    qd2 = _safe(state.phi_dot[2], 0.0)

    # Joint state carries the carrier phase. The posterior target retains the
    # lagged traveling bend associated with the sampled coherent 3D wakes.
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
        amplitude=amplitude,
        qd1=qd1,
        qd2=qd2,
    )
end

function guidance_module(state, params)
    distance_L = max(abs(_safe(state.distance_L, 1.0)), 1.0e-6)
    target_x = _safe(state.target_body_L[1], -distance_L)
    target_y = _safe(state.target_body_L[2], 0.0)

    # Body-frame -x is forward. At release target angle defines the request;
    # once translation is informative, achieved course closes the outer loop.
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
    base_route_error =
        (1 - course_gate) * target_angle +
        course_gate * course_error

    # With body +x pointing aft, bearing rate equals body-yaw rate minus
    # inertial line-of-sight rate. Their recent-window difference therefore
    # gives a reflection-odd intercept signal without reconstructing a world
    # heading or route. Clamp it before the target passes abeam.
    bearing_window_rate = hasproperty(state, :bearing_window_rate) ?
        _safe(state.bearing_window_rate, 0.0) :
        _safe(state.bearing_rate, 0.0)
    turn_rate_recent = hasproperty(state, :turn_rate_recent) ?
        _safe(state.turn_rate_recent, 0.0) :
        _safe(state.heading_rate, 0.0)
    inertial_los_rate = clamp(
        turn_rate_recent - bearing_window_rate,
        -abs(params.terminal_los_rate_limit),
        abs(params.terminal_los_rate_limit),
    )

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
        params.terminal_intercept_start_distance_L -
            params.terminal_intercept_full_distance_L,
        1.0e-6,
    )
    terminal_intercept_gate = _clamp01(
        (params.terminal_intercept_start_distance_L - distance_L) /
            terminal_span,
    )
    intercept_error = clamp(
        base_route_error -
        terminal_intercept_gate *
        params.terminal_los_rate_lookahead_T *
        inertial_los_rate,
        -params.course_angle_limit,
        params.course_angle_limit,
    )
    turn_command =
        tanh(intercept_error / max(params.route_error_scale, 1.0e-6))

    return (
        distance_L=distance_L,
        target_angle=target_angle,
        course_angle=course_angle,
        course_speed=course_speed,
        course_gate=course_gate,
        course_error=course_error,
        base_route_error=base_route_error,
        bearing_window_rate=bearing_window_rate,
        turn_rate_recent=turn_rate_recent,
        inertial_los_rate=inertial_los_rate,
        terminal_intercept_gate=terminal_intercept_gate,
        intercept_error=intercept_error,
        turn_command=turn_command,
        closing_speed_L=closing_speed,
        closing_deficit=closing_deficit,
        far_drive_gate=far_drive_gate,
    )
end

function target_policy(state, params)
    guidance = guidance_module(state, params)
    cadence_gain =
        params.far_drive_frequency_gain +
        params.progress_drive_frequency_gain * guidance.closing_deficit
    drive_frequency_scale =
        1.0 +
        cadence_gain *
        guidance.far_drive_gate *
        (1.0 - params.far_drive_turn_relief * abs(guidance.turn_command))
    drive = drive_module(state, params, drive_frequency_scale)

    # Keep the full evidenced carrier. The terminal mechanism changes only
    # the route request sent through the already bounded shared steering path.
    steering_accel =
        params.steering_accel_limit * guidance.turn_command
    head_accel =
        drive.head_accel +
        params.head_steering_share * steering_accel
    tail_accel =
        drive.tail_accel +
        params.tail_steering_share * steering_accel

    return (
        phi_ddot=(
            clamp(
                head_accel,
                -params.acceleration_limit,
                params.acceleration_limit,
            ),
            clamp(
                tail_accel,
                -params.acceleration_limit,
                params.acceleration_limit,
            ),
        ),
    )
end
