# L64 3D course-response candidate.  It preserves the assigned parent's
# envelope-aware joint-state oscillator and posterior lag.  Steering compares
# the observed swimming course with the body-frame target ray, requests a
# bounded yaw response, and releases a cycle-mean tail bend as that response
# appears.  No clock, route, or world-frame direction enters the policy.

function target_policy_params(; L::Int=64)
    return (
        version="dogfish_target_control_v20_course_response_mean_curvature",
        L=Float64(L),
        drive_period=0.80,
        control_period=0.80,
        drive_amplitude=22.0 * pi / 180,
        drive_mu=0.35,
        drive_tail_lag_gain=0.80,
        drive_tail_damping=0.65,
        target_scale_floor_L=0.25,
        target_forward_floor=0.15,
        target_angle_limit=1.25,
        course_forward_floor_U=0.08,
        course_speed_start_U=0.08,
        course_speed_full_U=0.45,
        course_error_scale=0.42,
        desired_turn_rate_limit=0.60,
        turn_rate_error_scale=3.00,
        mean_tail_tangent_limit=8.0 * pi / 180,
        approach_distance_L=2.10,
        approach_min_steering_gain=0.45,
        action_soft_limit=1750.0 * pi / 180,
        action_soft_limit_power=8.0,
    )
end
@inline function _clamp01(value)
    return clamp(value, 0.0, 1.0)
end

@inline function _safe(value, fallback)
    parsed = Float64(value)
    return isfinite(parsed) ? parsed : fallback
end

@inline function _soft_limit(value, limit, power)
    safe_limit = max(_safe(limit, 1.0), 1.0e-6)
    safe_power = max(_safe(power, 2.0), 2.0)
    ratio = abs(_safe(value, 0.0)) / safe_limit
    return _safe(value, 0.0) / (1 + ratio^safe_power)^(1 / safe_power)
end

function drive_module(state, params, mean_tail_tangent=0.0)
    omega = 2 * pi / params.drive_period
    amp = params.drive_amplitude
    q1 = _safe(state.phi[1], 0.0)
    q2 = _safe(state.phi[2], 0.0)
    qd1 = _safe(state.phi_dot[1], 0.0)
    qd2 = _safe(state.phi_dot[2], 0.0)

    # State-feedback drive: phase comes from joint state, not from a hidden clock.
    vdp_drive = params.drive_mu * (1 - (q1 / amp)^2) * qd1
    head_accel = vdp_drive - omega^2 * q1

    # The posterior joint retains the parent's traveling-wave lag.  Steering is
    # a bounded cycle-mean tangent target upstream of final action limiting.
    bounded_mean_tangent = clamp(
        _safe(mean_tail_tangent, 0.0),
        -params.mean_tail_tangent_limit,
        params.mean_tail_tangent_limit,
    )
    tail_target =
        bounded_mean_tangent - q1 -
        params.drive_tail_lag_gain * qd1 / max(omega, eps(omega))
    tail_accel = omega^2 * (tail_target - q2) - 2 * params.drive_tail_damping * omega * qd2
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
    # The evaluator supplies an L-normalized target ray.  Negative body x is
    # the nose direction; positive body y is clockwise from that direction.
    target_x = _safe(state.target_body_L[1], -distance_L)
    target_y = _safe(state.target_body_L[2], 0.0)
    forward_component = -target_x / scale
    lateral_component = target_y / scale
    target_angle = clamp(
        atan(lateral_component, max(forward_component, params.target_forward_floor)),
        -params.target_angle_limit,
        params.target_angle_limit,
    )

    velocity_x = _safe(state.velocity_body_U[1], 0.0)
    velocity_y = _safe(state.velocity_body_U[2], 0.0)
    swimming_speed = hypot(velocity_x, velocity_y)
    course_weight = _clamp01(
        (swimming_speed - params.course_speed_start_U) /
        max(params.course_speed_full_U - params.course_speed_start_U, 1.0e-6),
    )
    raw_course_angle = clamp(
        atan(velocity_y, max(-velocity_x, params.course_forward_floor_U)),
        -params.target_angle_limit,
        params.target_angle_limit,
    )
    course_angle = course_weight * raw_course_angle

    # In this body's coordinates, course_angle-target_angle is the signed
    # world-course correction: positive calls for positive theta rate.  With
    # little translation, course_angle tends continuously to zero and the
    # target ray alone chooses the startup turn.
    course_error = clamp(
        course_angle - target_angle,
        -2 * params.target_angle_limit,
        2 * params.target_angle_limit,
    )
    desired_turn_rate =
        params.desired_turn_rate_limit *
        tanh(course_error / max(params.course_error_scale, 1.0e-6))
    turn_rate = hasproperty(state, :turn_rate_recent) ?
        _safe(state.turn_rate_recent, 0.0) :
        _safe(state.heading_rate, 0.0)
    rate_error = desired_turn_rate - turn_rate
    response_request = tanh(
        rate_error / max(params.turn_rate_error_scale, 1.0e-6),
    )
    approach = _clamp01(distance_L / max(params.approach_distance_L, 1.0e-6))
    steering_gain =
        params.approach_min_steering_gain +
        (1 - params.approach_min_steering_gain) * approach
    mean_tail_tangent =
        params.mean_tail_tangent_limit * steering_gain * response_request
    return (
        mean_tail_tangent=mean_tail_tangent,
        target_angle=target_angle,
        course_angle=course_angle,
        raw_course_angle=raw_course_angle,
        course_weight=course_weight,
        course_error=course_error,
        desired_turn_rate=desired_turn_rate,
        turn_rate=turn_rate,
        rate_error=rate_error,
        response_request=response_request,
        forward_component=forward_component,
        lateral_component=lateral_component,
        distance_L=distance_L,
        swimming_speed=swimming_speed,
        steering_gain=steering_gain,
    )
end

function target_policy(state, params)
    guidance = guidance_module(state, params)
    drive = drive_module(state, params, guidance.mean_tail_tangent)
    return (
        phi_ddot=(
            _soft_limit(drive.head_accel, params.action_soft_limit, params.action_soft_limit_power),
            _soft_limit(drive.tail_accel, params.action_soft_limit, params.action_soft_limit_power),
        ),
    )
end
