# L64 3D candidate: preserve the sampled achieved-course carrier and give its
# bounded steering residual more authority per distance only during a closing
# near-target approach. No clock, world coordinate, route, or mutable state is
# used.

function target_policy_params()
    return (
        version="dogfish3d_course_servo_approach_authority_v1",
        drive_period=0.55,
        control_period=0.55,
        drive_amplitude=28.0 * pi / 180,
        drive_mu=0.35,
        drive_tail_lag_gain=0.80,
        drive_tail_damping=0.65,
        minimum_drive_frequency_scale=0.50,
        far_drive_frequency_gain=0.114,
        far_drive_turn_relief=0.36,
        progress_drive_frequency_gain=0.034,
        progress_closing_speed_scale=0.16,
        cadence_schedule_distance_L=2.10,
        target_angle_limit=1.25,
        course_angle_limit=1.25,
        course_forward_floor=0.08,
        course_speed_scale=0.25,
        route_error_scale=0.32,
        steering_accel_limit=12.0,
        head_steering_share=0.45,
        tail_steering_share=1.00,
        approach_relief_start_distance_L=4.0,
        approach_relief_full_distance_L=2.0,
        approach_frequency_relief=0.38,
        approach_closing_speed_scale=0.12,
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
        max(
            _safe(drive_frequency_scale, 1.0),
            params.minimum_drive_frequency_scale,
        )
    amplitude = max(abs(params.drive_amplitude), eps(Float64))
    q1 = _safe(state.phi[1], 0.0)
    q2 = _safe(state.phi[2], 0.0)
    qd1 = _safe(state.phi_dot[1], 0.0)
    qd2 = _safe(state.phi_dot[2], 0.0)

    # Phase remains in observed joint state. The posterior target retains the
    # traveling bend associated with both useful coherent sampled wakes.
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

    # Body-frame -x is forward. Both angles are dimensionless and independent
    # of the moving-window origin.
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

    # At release, target angle defines the turn. Once translation is
    # informative, achieved course closes the route loop and can reverse the
    # steering request after the trajectory responds.
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
        _clamp01(
            distance_L /
            max(params.cadence_schedule_distance_L, 1.0e-6),
        )

    # The sampled course servo nearly captures but remains fast and clipped.
    # Reduce only the carrier cadence during a near, still-closing approach;
    # steering is not attenuated, and reopening distance releases the relief.
    approach_span = max(
        params.approach_relief_start_distance_L -
            params.approach_relief_full_distance_L,
        1.0e-6,
    )
    approach_gate = _clamp01(
        (params.approach_relief_start_distance_L - distance_L) /
        approach_span,
    )
    closing_gate = _clamp01(
        0.5 *
        (1 + tanh(
            closing_speed /
            max(params.approach_closing_speed_scale, 1.0e-6),
        )),
    )
    approach_relief_gate = approach_gate * closing_gate

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
        approach_gate=approach_gate,
        closing_gate=closing_gate,
        approach_relief_gate=approach_relief_gate,
    )
end

function target_policy(state, params)
    guidance = guidance_module(state, params)
    cadence_gain =
        params.far_drive_frequency_gain +
        params.progress_drive_frequency_gain * guidance.closing_deficit
    cruise_frequency_scale =
        1.0 +
        cadence_gain *
        guidance.far_drive_gate *
        (1.0 - params.far_drive_turn_relief * abs(guidance.turn_command))
    approach_frequency_scale =
        1.0 -
        params.approach_frequency_relief * guidance.approach_relief_gate
    drive_frequency_scale =
        cruise_frequency_scale * approach_frequency_scale
    drive = drive_module(state, params, drive_frequency_scale)

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
