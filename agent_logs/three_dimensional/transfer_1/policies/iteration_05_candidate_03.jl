# L64 3D candidate: preserve the coherent state-feedback traveling bend and
# target-versus-achieved-course sensing, then blend large terminal course error
# into a response-released two-joint curvature redirect. No clock, world
# coordinate, route memory, or mutable controller state is used.

function target_policy_params()
    return (
        version="dogfish3d_course_cstart_capture_v1",
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
        redirect_start_distance_L=3.20,
        redirect_full_distance_L=1.60,
        redirect_error_release=0.22,
        redirect_error_full=0.75,
        redirect_head_bend=10.0 * pi / 180,
        redirect_tail_bend=28.0 * pi / 180,
        redirect_natural_frequency=5.0,
        redirect_damping=0.90,
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

    # Joint state supplies phase. Posterior lag retains the traveling bend and
    # alternating wake visible in every finite sampled rollout.
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

    # Body-frame -x is forward. Target geometry starts the controller; once
    # translation is measurable, achieved course supplies the route residual.
    target_angle = clamp(
        atan(
            target_y,
            max(-target_x, params.course_forward_floor),
        ),
        -params.target_angle_limit,
        params.target_angle_limit,
    )
    velocity_x = _safe(state.velocity_body_U[1], 0.0)
    velocity_y = _safe(state.velocity_body_U[2], 0.0)
    course_speed = hypot(velocity_x, velocity_y)
    course_angle = clamp(
        atan(
            velocity_y,
            max(-velocity_x, params.course_forward_floor),
        ),
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

    # A large course error inside the capture neighborhood activates the
    # redirect. Alignment continuously releases it back to the carrier, so
    # there is no hidden burst timer or stage variable.
    redirect_distance_span = max(
        params.redirect_start_distance_L -
            params.redirect_full_distance_L,
        1.0e-6,
    )
    redirect_distance_gate = _clamp01(
        (params.redirect_start_distance_L - distance_L) /
            redirect_distance_span,
    )
    redirect_error_span = max(
        params.redirect_error_full - params.redirect_error_release,
        1.0e-6,
    )
    redirect_error_gate = _clamp01(
        (abs(course_error) - params.redirect_error_release) /
            redirect_error_span,
    )
    redirect_strength =
        redirect_distance_gate * redirect_error_gate

    return (
        distance_L=distance_L,
        target_angle=target_angle,
        course_angle=course_angle,
        course_speed=course_speed,
        course_error=course_error,
        route_error=route_error,
        turn_command=turn_command,
        closing_speed_L=closing_speed,
        closing_deficit=closing_deficit,
        far_drive_gate=far_drive_gate,
        redirect_distance_gate=redirect_distance_gate,
        redirect_error_gate=redirect_error_gate,
        redirect_strength=redirect_strength,
    )
end

function redirect_module(drive, guidance, params)
    command = clamp(guidance.turn_command, -1.0, 1.0)
    q1_target = params.redirect_head_bend * command
    q2_target = params.redirect_tail_bend * command
    omega = max(abs(params.redirect_natural_frequency), 1.0e-6)
    damping = max(_safe(params.redirect_damping, 0.0), 0.0)
    position_gain = omega^2
    velocity_gain = 2 * damping * omega

    # Both joint targets have the requested curvature sign. The posterior
    # target is larger, preserving the shelf's qualitative tail emphasis
    # without copying a species-specific C-start shape or timing.
    return (
        head_accel=
            position_gain * (q1_target - drive.q1) -
            velocity_gain * drive.qd1,
        tail_accel=
            position_gain * (q2_target - drive.q2) -
            velocity_gain * drive.qd2,
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
        (1.0 -
         params.far_drive_turn_relief * abs(guidance.turn_command))
    drive = drive_module(state, params, drive_frequency_scale)

    steering_accel =
        params.steering_accel_limit * guidance.turn_command
    cruise_head_accel =
        drive.head_accel +
        params.head_steering_share * steering_accel
    cruise_tail_accel =
        drive.tail_accel +
        params.tail_steering_share * steering_accel
    redirect = redirect_module(drive, guidance, params)
    blend = guidance.redirect_strength
    head_accel =
        (1 - blend) * cruise_head_accel +
        blend * redirect.head_accel
    tail_accel =
        (1 - blend) * cruise_tail_accel +
        blend * redirect.tail_accel

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
