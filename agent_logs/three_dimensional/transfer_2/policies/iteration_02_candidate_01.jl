# Phase-2 course-alignment candidate.  Preserve the demonstrated joint-state
# traveling wave, but release its small tail-only steering bias according to
# measured swimming direction rather than body yaw, elapsed time, or a route.

function target_policy_params(; L::Int=64)
    return (
        version="dogfish_target_control_v20_course_released_tail_curvature",
        L=Float64(L),
        drive_period=0.55,
        control_period=0.55,
        drive_amplitude=28.0 * pi / 180,
        drive_mu=0.35,
        drive_tail_lag_gain=0.80,
        drive_tail_damping=0.65,
        drive_frequency_min_scale=0.50,
        far_drive_frequency_gain=0.114,
        far_drive_turn_relief=0.36,
        progress_drive_frequency_gain=0.034,
        progress_closing_speed_scale=0.16,
        target_scale_floor_L=0.25,
        course_angle_limit=1.25,
        course_speed_scale=0.30,
        course_speed_power=2.0,
        turn_error_scale=0.65,
        turn_curvature_limit=2.0 * pi / 180,
        approach_distance_L=2.10,
        approach_min_curvature_gain=0.35,
    )
end

@inline function _clamp01(value)
    return clamp(value, 0.0, 1.0)
end

@inline function _safe(value, fallback)
    parsed = Float64(value)
    return isfinite(parsed) ? parsed : fallback
end

function drive_module(
    state,
    params,
    mean_tail_tangent=0.0,
    drive_frequency_scale=1.0,
)
    omega =
        (2 * pi / params.drive_period) *
        max(_safe(drive_frequency_scale, 1.0), params.drive_frequency_min_scale)
    amp = params.drive_amplitude
    q1 = _safe(state.phi[1], 0.0)
    q2 = _safe(state.phi[2], 0.0)
    qd1 = _safe(state.phi_dot[1], 0.0)
    qd2 = _safe(state.phi_dot[2], 0.0)

    # Phase remains encoded only by joint state.  The anterior oscillator
    # supplies the carrier; the posterior target preserves its measured lag.
    vdp_drive = params.drive_mu * (1 - (q1 / amp)^2) * qd1
    head_accel = vdp_drive - omega^2 * q1
    bounded_mean_tangent = clamp(
        _safe(mean_tail_tangent, 0.0),
        -params.turn_curvature_limit,
        params.turn_curvature_limit,
    )
    tail_target =
        bounded_mean_tangent - q1 -
        params.drive_tail_lag_gain * qd1 / max(omega, eps(omega))
    tail_accel =
        omega^2 * (tail_target - q2) -
        2 * params.drive_tail_damping * omega * qd2
    return (
        head_accel=head_accel,
        tail_accel=tail_accel,
        omega=omega,
        mean_tail_tangent=bounded_mean_tangent,
    )
end

function guidance_module(state, params)
    distance_L = max(_safe(state.distance_L, 1.0), 1.0e-6)
    scale = max(distance_L, params.target_scale_floor_L)
    target_x = _safe(state.target_body_L[1], -distance_L)
    target_y = _safe(state.target_body_L[2], 0.0)
    target_x_unit = target_x / scale
    target_y_unit = target_y / scale

    # Local -x is forward.  At low speed, initialize from the signed angle
    # between that axis and the target.  This requests negative tail curvature
    # for the small positive-y error in the sampled release pose.
    body_course_error = atan(-target_y_unit, -target_x_unit)
    body_course_error = clamp(
        body_course_error,
        -params.course_angle_limit,
        params.course_angle_limit,
    )

    # Once translation develops, use the angle from actual velocity to the
    # target.  This reverses or releases before a persistent body-axis bearing
    # can drive the high-authority over-turn seen in the sampled parent.
    velocity_x = _safe(state.velocity_body_U[1], 0.0)
    velocity_y = _safe(state.velocity_body_U[2], 0.0)
    speed = _safe(hypot(velocity_x, velocity_y), 0.0)
    course_cross = velocity_x * target_y_unit - velocity_y * target_x_unit
    course_dot = velocity_x * target_x_unit + velocity_y * target_y_unit
    velocity_course_error = atan(course_cross, course_dot)
    velocity_course_error = clamp(
        velocity_course_error,
        -params.course_angle_limit,
        params.course_angle_limit,
    )
    speed_ratio =
        speed / max(params.course_speed_scale, 1.0e-6)
    speed_power = max(params.course_speed_power, 1.0)
    course_gate =
        speed_ratio^speed_power / (1 + speed_ratio^speed_power)
    route_error =
        (1 - course_gate) * body_course_error +
        course_gate * velocity_course_error

    approach = _clamp01(
        distance_L / max(params.approach_distance_L, 1.0e-6),
    )
    curvature_gain =
        params.approach_min_curvature_gain +
        (1 - params.approach_min_curvature_gain) * approach
    mean_tail_tangent =
        params.turn_curvature_limit *
        curvature_gain *
        tanh(route_error / max(params.turn_error_scale, 1.0e-6))

    closing_speed = hasproperty(state, :window_closing_speed_L) ?
        _safe(state.window_closing_speed_L, 0.0) :
        _safe(state.closing_speed_L, 0.0)
    closing_deficit =
        0.5 * (
            1 -
            tanh(
                closing_speed /
                max(params.progress_closing_speed_scale, 1.0e-6),
            )
        )
    return (
        mean_tail_tangent=mean_tail_tangent,
        route_error=route_error,
        body_course_error=body_course_error,
        velocity_course_error=velocity_course_error,
        course_gate=course_gate,
        speed=speed,
        distance_L=distance_L,
        far_drive_gate=approach,
        drive_progress_boost=closing_deficit,
    )
end

function target_policy(state, params)
    guidance = guidance_module(state, params)
    turn_load = _clamp01(
        abs(guidance.mean_tail_tangent) /
        max(params.turn_curvature_limit, 1.0e-6),
    )
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
        guidance.mean_tail_tangent,
        drive_frequency_scale,
    )
    return (
        phi_ddot=(
            drive.head_accel,
            drive.tail_accel,
        ),
    )
end
