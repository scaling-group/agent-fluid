# L64 3D candidate: retain the repeat-supported intercept-guarded speed-reserve
# controller, then add a small terminal inner loop that damps phase-compensated
# body yaw without suppressing the traveling bend. No clock, world coordinate,
# route, or mutable phase is used.

function target_policy_params()
    return (
        version="dogfish3d_speed_reserve_terminal_yaw_damping_v1",
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
        intercept_guard_start_distance_L=2.75,
        intercept_guard_full_distance_L=2.00,
        projected_miss_inner_L=0.60,
        projected_miss_outer_L=1.00,
        projection_speed_floor=0.20,
        approach_alignment_start=0.05,
        approach_alignment_full=0.30,
        terminal_yaw_damping_start_distance_L=1.50,
        terminal_yaw_damping_full_distance_L=0.90,
        terminal_yaw_damping_rate_scale=1.00,
        terminal_yaw_damping_gain=0.18,
        joint_speed_limit=260.0 * pi / 180,
        reserve_speed_start=0.82,
        reserve_speed_full=0.98,
        reserve_action_start=0.88,
        reserve_action_full=0.99,
        reserve_outward_scale=0.12,
        reserve_carrier_relief=0.55,
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
        q1=q1,
        q2=q2,
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

    # Body-frame cross and dot products retain their inertial geometric
    # meaning while avoiding a fixed world route or target coordinate.
    target_velocity_cross =
        target_x * velocity_y - target_y * velocity_x
    target_velocity_dot =
        target_x * velocity_x + target_y * velocity_y
    los_distance = max(distance_L, params.los_rate_distance_floor_L)
    inertial_los_rate =
        -target_velocity_cross / max(los_distance^2, 1.0e-6)
    projection_speed = max(course_speed, params.projection_speed_floor)
    projected_miss_distance_L =
        abs(target_velocity_cross) / projection_speed
    approach_alignment = clamp(
        target_velocity_dot /
            max(distance_L * projection_speed, 1.0e-6),
        -1.0,
        1.0,
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
        terminal_response_gate=terminal_response_gate,
        inertial_los_rate=inertial_los_rate,
        projected_miss_distance_L=projected_miss_distance_L,
        approach_alignment=approach_alignment,
    )
end

@inline function _smoothstep01(value)
    bounded = _clamp01(value)
    return bounded * bounded * (3 - 2 * bounded)
end

function turn_response_module(state, guidance, drive, params)
    # Joint velocities remove the evidenced beat component from body yaw.
    # Correct-sign response may release steering only while both LOS rate and
    # projected closest-pass geometry remain compatible with interception.
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
        params.los_miss_reengage_full - params.los_miss_reengage_start,
        1.0e-6,
    )
    los_miss_gate = _smoothstep01(
        (signed_los_miss - params.los_miss_reengage_start) / los_span,
    )

    intercept_distance_span = max(
        params.intercept_guard_start_distance_L -
            params.intercept_guard_full_distance_L,
        1.0e-6,
    )
    intercept_distance_gate = _smoothstep01(
        (params.intercept_guard_start_distance_L - guidance.distance_L) /
            intercept_distance_span,
    )
    projected_miss_span = max(
        params.projected_miss_outer_L - params.projected_miss_inner_L,
        1.0e-6,
    )
    projected_corridor_gate = _smoothstep01(
        (params.projected_miss_outer_L -
            guidance.projected_miss_distance_L) /
            projected_miss_span,
    )
    approach_span = max(
        params.approach_alignment_full - params.approach_alignment_start,
        1.0e-6,
    )
    approach_gate = _smoothstep01(
        (guidance.approach_alignment - params.approach_alignment_start) /
            approach_span,
    )
    intercept_compatible = projected_corridor_gate * approach_gate
    intercept_release_guard =
        (1.0 - intercept_distance_gate) +
        intercept_distance_gate * intercept_compatible
    release =
        guidance.terminal_response_gate *
        response_gate *
        (1.0 - los_miss_gate) *
        intercept_release_guard
    return (
        phase_compensated_turn_rate=phase_compensated_turn_rate,
        signed_turn_response=signed_turn_response,
        signed_los_miss=signed_los_miss,
        response_gate=response_gate,
        los_miss_gate=los_miss_gate,
        projected_corridor_gate=projected_corridor_gate,
        approach_gate=approach_gate,
        intercept_distance_gate=intercept_distance_gate,
        intercept_release_guard=intercept_release_guard,
        release=release,
    )
end

function terminal_yaw_damping_module(guidance, response, params)
    # Existing response calibration establishes that a steering request and
    # its achieved yaw have opposite signs. Therefore a residual with the same
    # sign as measured yaw opposes that yaw. Joint-velocity compensation keeps
    # the inner loop from chasing the carrier's beat-scale body oscillation.
    damping_span = max(
        params.terminal_yaw_damping_start_distance_L -
            params.terminal_yaw_damping_full_distance_L,
        1.0e-6,
    )
    damping_gate = _smoothstep01(
        (params.terminal_yaw_damping_start_distance_L -
            guidance.distance_L) /
            damping_span,
    )
    normalized_yaw_rate = tanh(
        response.phase_compensated_turn_rate /
            max(params.terminal_yaw_damping_rate_scale, 1.0e-6),
    )
    damping_turn =
        clamp(params.terminal_yaw_damping_gain, 0.0, 0.35) *
        damping_gate *
        normalized_yaw_rate
    return (
        damping_gate=damping_gate,
        normalized_yaw_rate=normalized_yaw_rate,
        damping_turn=damping_turn,
    )
end

@inline function carrier_reserve_scale(
    joint_velocity,
    previous_action,
    carrier_accel,
    terminal_gate,
    params,
)
    # Relief requires four simultaneous observations: terminal range, speed
    # near its envelope, a previously saturated outward action, and a current
    # carrier acceleration that is still outward. Restoring carrier effort and
    # the separate steering residual are never attenuated.
    speed_ratio =
        abs(joint_velocity) / max(params.joint_speed_limit, 1.0e-6)
    action_ratio =
        abs(previous_action) / max(params.acceleration_limit, 1.0e-6)
    speed_span = max(
        params.reserve_speed_full - params.reserve_speed_start,
        1.0e-6,
    )
    action_span = max(
        params.reserve_action_full - params.reserve_action_start,
        1.0e-6,
    )
    speed_gate = _smoothstep01(
        (speed_ratio - params.reserve_speed_start) / speed_span,
    )
    action_gate = _smoothstep01(
        (action_ratio - params.reserve_action_start) / action_span,
    )
    normalized_previous_outward =
        joint_velocity * previous_action /
        max(
            params.joint_speed_limit * params.acceleration_limit,
            1.0e-6,
        )
    normalized_carrier_outward =
        joint_velocity * carrier_accel /
        max(
            params.joint_speed_limit * params.acceleration_limit,
            1.0e-6,
        )
    outward_scale = max(params.reserve_outward_scale, 1.0e-6)
    previous_outward_gate =
        0.5 * (1 + tanh(normalized_previous_outward / outward_scale))
    carrier_outward_gate =
        0.5 * (1 + tanh(normalized_carrier_outward / outward_scale))
    relief =
        _clamp01(terminal_gate) *
        clamp(params.reserve_carrier_relief, 0.0, 0.90) *
        speed_gate *
        action_gate *
        previous_outward_gate *
        carrier_outward_gate
    return 1.0 - relief
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

    # Keep the evaluated intercept veto, additive route steering, and sparse
    # carrier reserve. The new inner loop is zero outside the final 1.5L and
    # adds bounded yaw damping without attenuating the propulsive carrier.
    response = turn_response_module(state, guidance, drive, params)
    yaw_damping = terminal_yaw_damping_module(guidance, response, params)
    previous_action = hasproperty(state, :previous_action) ?
        state.previous_action : (0.0, 0.0)
    previous_head_action = _safe(previous_action[1], 0.0)
    previous_tail_action = _safe(previous_action[2], 0.0)
    head_carrier_scale = carrier_reserve_scale(
        drive.qd1,
        previous_head_action,
        drive.head_accel,
        guidance.terminal_response_gate,
        params,
    )
    tail_carrier_scale = carrier_reserve_scale(
        drive.qd2,
        previous_tail_action,
        drive.tail_accel,
        guidance.terminal_response_gate,
        params,
    )
    route_steering_turn =
        guidance.turn_command * (1.0 - response.release)
    steering_turn = route_steering_turn + yaw_damping.damping_turn
    steering_accel = params.steering_accel_limit * steering_turn
    head_accel =
        head_carrier_scale * drive.head_accel +
        params.head_steering_share * steering_accel
    tail_accel =
        tail_carrier_scale * drive.tail_accel +
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
