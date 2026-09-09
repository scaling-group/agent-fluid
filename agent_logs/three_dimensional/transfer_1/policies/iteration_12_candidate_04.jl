# L64 3D candidate: retain the response-released achieved-course servo and
# propulsive traveling bend, but re-engage terminal steering when normalized
# target/velocity geometry shows a growing line-of-sight miss or normalized
# yaw load strongly opposes the requested turn. The carrier is never
# attenuated. No clock, world coordinate, route, or mutable phase is used.

function target_policy_params()
    return (
        version="dogfish3d_course_servo_los_load_guarded_release_v1",
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
        terminal_response_start_distance_L=4.00,
        terminal_response_full_distance_L=1.25,
        phase_yaw_qd1_gain=0.60,
        phase_yaw_qd2_gain=0.22,
        turn_response_release_start=0.08,
        turn_response_release_full=0.24,
        los_rate_distance_floor_L=1.00,
        los_miss_reengage_start=0.12,
        los_miss_reengage_full=0.45,
        adverse_yaw_moment_start=0.004,
        adverse_yaw_moment_full=0.010,
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
        q1=q1,
        q2=q2,
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
    terminal_span = max(
        params.terminal_response_start_distance_L -
            params.terminal_response_full_distance_L,
        1.0e-6,
    )
    terminal_response_gate = _clamp01(
        (params.terminal_response_start_distance_L - distance_L) /
            terminal_span,
    )

    # The body-frame cross product is invariant to the frame rotation. After
    # division by range squared it is the inertial line-of-sight angular rate,
    # without the beat-frequency body yaw that contaminates raw bearing rate.
    target_velocity_cross =
        target_x * velocity_y - target_y * velocity_x
    los_distance = max(
        distance_L,
        params.los_rate_distance_floor_L,
    )
    inertial_los_rate =
        -target_velocity_cross / max(los_distance^2, 1.0e-6)

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
        terminal_response_gate=terminal_response_gate,
        inertial_los_rate=inertial_los_rate,
    )
end

@inline function _smoothstep01(value)
    bounded = _clamp01(value)
    return bounded * bounded * (3 - 2 * bounded)
end

function turn_response_module(state, guidance, drive, params)
    # Joint velocities remove the evidenced beat component from measured body
    # yaw. Correct-sign slow yaw may release steering, but only while inertial
    # line-of-sight geometry and measured yaw load remain compatible.
    heading_rate = hasproperty(state, :heading_rate) ?
        _safe(state.heading_rate, 0.0) :
        _safe(state.turn_rate_recent, 0.0)
    phase_compensated_turn_rate =
        heading_rate +
        params.phase_yaw_qd1_gain * drive.qd1 +
        params.phase_yaw_qd2_gain * drive.qd2
    signed_turn_response = max(
        -guidance.turn_command * phase_compensated_turn_rate,
        0.0,
    )
    response_span = max(
        params.turn_response_release_full -
            params.turn_response_release_start,
        1.0e-6,
    )
    response_gate = _smoothstep01(
        (signed_turn_response - params.turn_response_release_start) /
            response_span,
    )
    signed_los_miss = max(
        -guidance.turn_command * guidance.inertial_los_rate,
        0.0,
    )
    los_span = max(
        params.los_miss_reengage_full -
            params.los_miss_reengage_start,
        1.0e-6,
    )
    los_miss_gate = _smoothstep01(
        (signed_los_miss - params.los_miss_reengage_start) /
            los_span,
    )

    # In this body-frame convention positive turn_command asks for negative
    # yaw response. A same-sign normalized yaw moment is therefore adverse.
    # Use that measured hydrodynamic disagreement only to veto release; it
    # cannot amplify steering or prescribe a route independently.
    yaw_moment = hasproperty(state, :moment_z_L2) ?
        _safe(state.moment_z_L2, 0.0) :
        0.0
    adverse_yaw_moment = max(
        guidance.turn_command * yaw_moment,
        0.0,
    )
    yaw_moment_span = max(
        params.adverse_yaw_moment_full -
            params.adverse_yaw_moment_start,
        1.0e-6,
    )
    adverse_yaw_moment_gate = _smoothstep01(
        (adverse_yaw_moment - params.adverse_yaw_moment_start) /
            yaw_moment_span,
    )
    release =
        guidance.terminal_response_gate *
        response_gate *
        (1.0 - los_miss_gate) *
        (1.0 - adverse_yaw_moment_gate)
    return (
        phase_compensated_turn_rate=phase_compensated_turn_rate,
        signed_turn_response=signed_turn_response,
        signed_los_miss=signed_los_miss,
        response_gate=response_gate,
        los_miss_gate=los_miss_gate,
        yaw_moment=yaw_moment,
        adverse_yaw_moment=adverse_yaw_moment,
        adverse_yaw_moment_gate=adverse_yaw_moment_gate,
        release=release,
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

    # Preserve the inherited response-triggered release unless translational
    # geometry shows a growing line-of-sight miss or hydrodynamic yaw load
    # strongly opposes the request. Then smoothly restore the existing course
    # steering; never add gain, reverse the request, or alter the carrier.
    response = turn_response_module(state, guidance, drive, params)
    steering_accel =
        params.steering_accel_limit *
        guidance.turn_command *
        (1.0 - response.release)
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
