# L64 3D candidate: preserve the observed traveling-bend carrier while a
# normalized achieved-course error drives phase-selective half-cycle steering.
# Joint state supplies phase; no clock, world coordinate, route, or mutable
# controller state is used.

function target_policy_params()
    return (
        version="dogfish3d_course_halfcycle_steering_v1",
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
        halfcycle_tangent_scale=34.0 * pi / 180,
        halfcycle_velocity_scale=1.00,
        halfcycle_tangent_weight=0.70,
        halfcycle_modulation=0.65,
        halfcycle_gate_min=0.35,
        halfcycle_gate_max=1.65,
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
    amp = params.drive_amplitude
    q1 = _safe(state.phi[1], 0.0)
    q2 = _safe(state.phi[2], 0.0)
    qd1 = _safe(state.phi_dot[1], 0.0)
    qd2 = _safe(state.phi_dot[2], 0.0)

    # State-feedback drive: phase comes from joint state, not from a hidden clock.
    vdp_drive = params.drive_mu * (1 - (q1 / amp)^2) * qd1
    head_accel = vdp_drive - omega^2 * q1

    # Posterior lag preserves the observed propulsive traveling bend. Steering
    # is applied separately so it can be distributed over observed beat phase.
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

    # Body-frame -x is forward. Once speed is measurable, target-versus-course
    # error releases or reverses the route request after translation responds.
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
    )
end

function halfcycle_steering_module(drive, guidance, params)
    tail_tangent = drive.q1 + drive.q2
    tail_velocity = drive.qd1 + drive.qd2
    tangent_side = tanh(
        tail_tangent / max(params.halfcycle_tangent_scale, 1.0e-6),
    )
    velocity_scale = max(
        params.halfcycle_velocity_scale *
            params.drive_amplitude * drive.omega,
        1.0e-6,
    )
    velocity_side = tanh(tail_velocity / velocity_scale)
    tangent_weight = clamp(params.halfcycle_tangent_weight, 0.0, 1.0)
    phase_indicator =
        tangent_weight * tangent_side +
        (1 - tangent_weight) * velocity_side

    # Positive inherited shared acceleration gives the initially required yaw
    # sign. Preserve that sign, but strengthen it only when the observed bend
    # half-cycle is aligned with the route request and weaken the opposite half.
    alignment = guidance.turn_command * phase_indicator
    halfcycle_gate = clamp(
        1.0 + params.halfcycle_modulation * alignment,
        params.halfcycle_gate_min,
        params.halfcycle_gate_max,
    )
    steering_accel =
        params.steering_accel_limit *
        guidance.turn_command *
        halfcycle_gate
    return (
        head_delta=params.head_steering_share * steering_accel,
        tail_delta=params.tail_steering_share * steering_accel,
        tail_tangent=tail_tangent,
        tail_velocity=tail_velocity,
        phase_indicator=phase_indicator,
        alignment=alignment,
        halfcycle_gate=halfcycle_gate,
    )
end

function target_policy(state, params)
    guidance = guidance_module(state, params)
    turn_load = abs(guidance.turn_command)
    cadence_gain =
        params.far_drive_frequency_gain +
        params.progress_drive_frequency_gain * guidance.drive_progress_boost
    drive_frequency_scale =
        1.0 +
        cadence_gain *
        guidance.far_drive_gate *
        (1.0 - params.far_drive_turn_relief * turn_load)
    drive = drive_module(
        state,
        params,
        drive_frequency_scale,
    )
    steering = halfcycle_steering_module(drive, guidance, params)
    return (
        phi_ddot=(
            clamp(
                drive.head_accel + steering.head_delta,
                -params.acceleration_limit,
                params.acceleration_limit,
            ),
            clamp(
                drive.tail_accel + steering.tail_delta,
                -params.acceleration_limit,
                params.acceleration_limit,
            ),
        ),
    )
end
