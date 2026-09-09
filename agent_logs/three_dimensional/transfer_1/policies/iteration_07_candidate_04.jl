# L64 3D candidate: retain the achieved-course servo and carrier-aligned
# steering that produced the closest inherited pass, then add a bounded
# terminal posterior response to observed target-normal velocity. The carrier
# is never attenuated; there is no clock, world route, or mutable state.

function target_policy_params()
    return (
        version="dogfish3d_course_servo_slip_response_v1",
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
        terminal_allocation_start_distance_L=4.00,
        terminal_allocation_full_distance_L=1.25,
        terminal_aligned_pulse_gain=2.00,
        steering_alignment_accel_scale=0.20,
        terminal_response_start_distance_L=3.00,
        terminal_response_full_distance_L=1.00,
        target_normal_velocity_scale=0.30,
        response_closing_speed_scale=0.16,
        response_tail_tangent_limit=5.0 * pi / 180,
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

function guidance_module(state, params)
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
    allocation_span = max(
        params.terminal_allocation_start_distance_L -
            params.terminal_allocation_full_distance_L,
        1.0e-6,
    )
    terminal_allocation_gate = _clamp01(
        (params.terminal_allocation_start_distance_L - distance_L) /
            allocation_span,
    )
    response_span = max(
        params.terminal_response_start_distance_L -
            params.terminal_response_full_distance_L,
        1.0e-6,
    )
    terminal_response_gate = _clamp01(
        (params.terminal_response_start_distance_L - distance_L) /
            response_span,
    )

    # This rotation-invariant cross product is the signed velocity normal to
    # the instantaneous target line. It is expressed entirely with normalized
    # body-frame observations and therefore does not inherit beat-phase yaw.
    target_normal_velocity =
        (target_x * velocity_y - target_y * velocity_x) / distance_L
    slip_response = tanh(
        target_normal_velocity /
            max(params.target_normal_velocity_scale, 1.0e-6),
    )
    response_closing_gate =
        0.5 * (
            1 + tanh(
                closing_speed /
                    max(params.response_closing_speed_scale, 1.0e-6),
            )
        )
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
        terminal_allocation_gate=terminal_allocation_gate,
        terminal_response_gate=terminal_response_gate,
        target_normal_velocity=target_normal_velocity,
        slip_response=slip_response,
        response_closing_gate=response_closing_gate,
    )
end

function drive_module(
    state,
    params,
    drive_frequency_scale=1.0,
    mean_tail_tangent=0.0,
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
    head_accel = vdp_drive - omega^2 * q1
    bounded_mean_tail_tangent = clamp(
        _safe(mean_tail_tangent, 0.0),
        -abs(params.response_tail_tangent_limit),
        abs(params.response_tail_tangent_limit),
    )
    tail_target =
        bounded_mean_tail_tangent - q1 -
        params.drive_tail_lag_gain * qd1 / max(omega, eps(Float64))
    tail_accel =
        omega^2 * (tail_target - q2) -
        2 * params.drive_tail_damping * omega * qd2
    return (
        head_accel=head_accel,
        tail_accel=tail_accel,
        omega=omega,
        qd1=qd1,
        qd2=qd2,
        mean_tail_tangent=bounded_mean_tail_tangent,
    )
end

@inline function carrier_aligned_steering_scale(
    turn_command,
    carrier_accel,
    terminal_gate,
    params,
)
    normalized_alignment =
        turn_command * carrier_accel /
        max(
            params.steering_alignment_accel_scale *
                params.acceleration_limit,
            1.0e-6,
        )
    aligned_half_gate = 0.5 * (1 + tanh(normalized_alignment))
    aligned_pulse =
        clamp(params.terminal_aligned_pulse_gain, 0.0, 2.0) *
        aligned_half_gate
    return (1 - terminal_gate) + terminal_gate * aligned_pulse
end

function target_policy(state, params)
    guidance = guidance_module(state, params)
    turn_load = abs(guidance.turn_command)
    cadence_gain =
        params.far_drive_frequency_gain +
        params.progress_drive_frequency_gain * guidance.closing_deficit
    drive_frequency_scale =
        1.0 +
        cadence_gain *
        guidance.far_drive_gate *
        (1.0 - params.far_drive_turn_relief * turn_load)
    mean_tail_tangent =
        params.response_tail_tangent_limit *
        guidance.terminal_response_gate *
        guidance.response_closing_gate *
        guidance.slip_response
    drive = drive_module(
        state,
        params,
        drive_frequency_scale,
        mean_tail_tangent,
    )
    steering_accel =
        params.steering_accel_limit * guidance.turn_command
    head_steering_scale = carrier_aligned_steering_scale(
        guidance.turn_command,
        drive.head_accel,
        guidance.terminal_allocation_gate,
        params,
    )
    tail_steering_scale = carrier_aligned_steering_scale(
        guidance.turn_command,
        drive.tail_accel,
        guidance.terminal_allocation_gate,
        params,
    )
    head_accel =
        drive.head_accel +
        params.head_steering_share *
        steering_accel *
        head_steering_scale
    tail_accel =
        drive.tail_accel +
        params.tail_steering_share *
        steering_accel *
        tail_steering_scale
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
