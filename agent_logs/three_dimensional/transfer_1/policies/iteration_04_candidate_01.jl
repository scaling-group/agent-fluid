# L64 3D candidate: preserve the coherent joint-state traveling bend and the
# evidenced target-versus-achieved-course signal, but realize steering as a
# bounded, observed-half-cycle acceleration asymmetry. There is no clock,
# world coordinate, memorized route, or mutable controller state.

function target_policy_params()
    return (
        version="dogfish3d_course_halfcycle_smooth_v1",
        drive_period=0.55,
        control_period=0.55,
        drive_amplitude=28.0 * pi / 180,
        drive_mu=0.35,
        drive_tail_lag_gain=0.80,
        drive_tail_damping=0.65,
        target_angle_limit=1.25,
        course_angle_limit=1.25,
        course_forward_floor=0.08,
        course_speed_scale=0.25,
        route_error_scale=0.32,
        steering_accel_limit=12.0,
        head_steering_share=0.45,
        tail_steering_share=1.00,
        tail_tangent_scale=34.0 * pi / 180,
        halfcycle_bend_weight=0.60,
        halfcycle_motion_weight=0.40,
        halfcycle_asymmetry=0.45,
        halfcycle_gate_min=0.55,
        halfcycle_gate_max=1.45,
        far_drive_frequency_gain=0.114,
        far_drive_turn_relief=0.36,
        progress_drive_frequency_gain=0.034,
        progress_closing_speed_scale=0.16,
        approach_distance_L=2.10,
        terminal_relief_start_distance_L=4.00,
        terminal_relief_full_distance_L=1.25,
        terminal_drive_frequency_floor=0.72,
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

@inline function _smooth_limit(value, limit)
    bounded_limit = max(abs(_safe(limit, 0.0)), eps(Float64))
    return bounded_limit * tanh(_safe(value, 0.0) / bounded_limit)
end

function drive_module(state, params, drive_frequency_scale=1.0)
    omega =
        (2 * pi / params.drive_period) *
        max(_safe(drive_frequency_scale, 1.0), 0.50)
    amp = params.drive_amplitude
    q1 = _safe(state.phi[1], 0.0)
    q2 = _safe(state.phi[2], 0.0)
    qd1 = _safe(state.phi_dot[1], 0.0)
    qd2 = _safe(state.phi_dot[2], 0.0)

    # State-feedback drive: phase comes from joint state, not from a hidden clock.
    vdp_drive = params.drive_mu * (1 - (q1 / amp)^2) * qd1
    head_accel = vdp_drive - omega^2 * q1

    # Preserve the sampled posterior lag. Steering is applied separately so
    # the useful traveling bend is not replaced by a static mean-tail target.
    tail_target = -q1 - params.drive_tail_lag_gain * qd1 / max(omega, eps(omega))
    tail_accel = omega^2 * (tail_target - q2) - 2 * params.drive_tail_damping * omega * qd2
    return (
        head_accel=head_accel,
        tail_accel=tail_accel,
        omega=omega,
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

    # Body-frame -x is forward. Once translation is measurable, target versus
    # achieved course releases or reverses steering when the route responds.
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
        0.5 * (1 - tanh(closing_speed / max(params.progress_closing_speed_scale, 1.0e-6)))
    far_drive_gate = _clamp01(distance_L / max(params.approach_distance_L, 1.0e-6))
    terminal_relief_span = max(
        params.terminal_relief_start_distance_L -
            params.terminal_relief_full_distance_L,
        1.0e-6,
    )
    terminal_relief_gate = _clamp01(
        (params.terminal_relief_start_distance_L - distance_L) /
            terminal_relief_span,
    )
    terminal_drive_floor = clamp(
        params.terminal_drive_frequency_floor,
        0.50,
        1.0,
    )
    terminal_drive_scale =
        1.0 -
        (1.0 - terminal_drive_floor) * terminal_relief_gate
    return (
        turn_command=turn_command,
        distance_L=distance_L,
        target_angle=target_angle,
        course_angle=course_angle,
        course_speed=course_speed,
        course_gate=course_gate,
        course_error=course_error,
        route_error=route_error,
        far_drive_gate=far_drive_gate,
        drive_progress_boost=closing_deficit,
        closing_speed_L=closing_speed,
        terminal_relief_gate=terminal_relief_gate,
        terminal_drive_scale=terminal_drive_scale,
    )
end

function halfcycle_steering_module(drive, guidance, params)
    tail_tangent = drive.q1 + drive.q2
    tail_velocity = drive.qd1 + drive.qd2
    bend_phase = tanh(
        tail_tangent / max(params.tail_tangent_scale, 1.0e-6),
    )
    motion_phase = tanh(
        tail_velocity /
        max(abs(params.drive_amplitude * drive.omega), 1.0e-6),
    )
    observed_phase = clamp(
        params.halfcycle_bend_weight * bend_phase +
            params.halfcycle_motion_weight * motion_phase,
        -1.0,
        1.0,
    )

    # Mirroring target, course, and joint state reverses turn_command and
    # observed_phase together, leaving the scalar gate unchanged and reversing
    # only the steering sign. No clock or prescribed vortex phase is needed.
    halfcycle_gate = clamp(
        1.0 +
            params.halfcycle_asymmetry *
            guidance.turn_command *
            observed_phase,
        params.halfcycle_gate_min,
        params.halfcycle_gate_max,
    )
    steering_accel =
        params.steering_accel_limit *
        guidance.turn_command *
        halfcycle_gate
    return (
        steering_accel=steering_accel,
        halfcycle_gate=halfcycle_gate,
        observed_phase=observed_phase,
    )
end

function target_policy(state, params)
    guidance = guidance_module(state, params)
    turn_load = abs(guidance.turn_command)
    cadence_gain =
        params.far_drive_frequency_gain +
        params.progress_drive_frequency_gain * guidance.drive_progress_boost
    drive_frequency_scale =
        (1.0 +
         cadence_gain *
         guidance.far_drive_gate *
         (1.0 - params.far_drive_turn_relief * turn_load)) *
        guidance.terminal_drive_scale
    drive = drive_module(state, params, drive_frequency_scale)
    steering = halfcycle_steering_module(drive, guidance, params)
    raw_head_accel =
        drive.head_accel +
        params.head_steering_share * steering.steering_accel
    raw_tail_accel =
        drive.tail_accel +
        params.tail_steering_share * steering.steering_accel
    return (
        phi_ddot=(
            _smooth_limit(raw_head_accel, params.acceleration_limit),
            _smooth_limit(raw_tail_accel, params.acceleration_limit),
        ),
    )
end
