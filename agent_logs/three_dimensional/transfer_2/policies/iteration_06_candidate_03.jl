# Compact L64 target controller: preserve the evidenced traveling-bend drive
# while steering its mean curvature from target-versus-course geometry.

function target_policy_params()
    return (
        version="dogfish3d_course_curvature_redirect_v1",
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.80,
        tail_damping=0.65,
        course_angle_floor=0.12,
        target_angle_limit=1.45,
        course_speed_scale=0.35,
        course_feedback_weight=0.65,
        rear_gate_center=0.25,
        rear_gate_width=0.15,
        rear_authority_boost=0.45,
        turn_request_scale=0.42,
        tail_curvature_limit=8.0 * pi / 180,
        head_steer_accel=3.0,
        command_accel_limit=31.0,
    )
end

@inline function _policy_safe(value, fallback)
    parsed = Float64(value)
    return isfinite(parsed) ? parsed : fallback
end

@inline function _policy_soft_limit(value, limit)
    safe_limit = max(_policy_safe(limit, 1.0), eps(Float64))
    return safe_limit * tanh(_policy_safe(value, 0.0) / safe_limit)
end

@inline function _policy_wrap_angle(value)
    safe_value = _policy_safe(value, 0.0)
    return atan(sin(safe_value), cos(safe_value))
end

function course_guidance(state, params)
    target_x = _policy_safe(state.target_body_L[1], -1.0)
    target_y = _policy_safe(state.target_body_L[2], 0.0)
    target_norm = max(hypot(target_x, target_y), eps(Float64))

    # Body x points aft in this observation contract. Keeping its sign in the
    # normalized forward component distinguishes target-ahead from astern.
    target_forward = clamp(-target_x / target_norm, -1.0, 1.0)
    target_lateral = clamp(target_y / target_norm, -1.0, 1.0)
    target_angle = atan(
        target_lateral,
        max(target_forward, 0.0),
    )
    target_angle = clamp(
        target_angle,
        -params.target_angle_limit,
        params.target_angle_limit,
    )

    velocity_x = _policy_safe(state.velocity_body_U[1], 0.0)
    velocity_y = _policy_safe(state.velocity_body_U[2], 0.0)
    speed = hypot(velocity_x, velocity_y)
    velocity_forward = -velocity_x
    course_angle = atan(
        velocity_y,
        max(velocity_forward, params.course_angle_floor),
    )
    course_angle = clamp(
        course_angle,
        -params.target_angle_limit,
        params.target_angle_limit,
    )
    course_error = _policy_wrap_angle(target_angle - course_angle)

    # Course is uninformative at release. As self-propulsion develops, blend
    # from body-axis error toward the actual target-versus-velocity error.
    speed_gate = tanh(
        speed / max(params.course_speed_scale, eps(Float64)),
    )
    course_weight = params.course_feedback_weight * speed_gate
    steering_error =
        (1.0 - course_weight) * target_angle +
        course_weight * course_error

    # A smooth abeam/astern gate raises redirect authority without a clock,
    # route, or discontinuous mode. It releases as soon as the target returns
    # to the forward sector.
    rear_gate = 0.5 * (
        1.0 - tanh(
            (target_forward - params.rear_gate_center) /
            max(params.rear_gate_width, eps(Float64)),
        )
    )
    steering_authority = 1.0 + params.rear_authority_boost * rear_gate
    turn_command = -tanh(
        steering_authority * steering_error /
        max(params.turn_request_scale, eps(Float64)),
    )
    return (
        target_forward=target_forward,
        target_lateral=target_lateral,
        target_angle=target_angle,
        course_angle=course_angle,
        course_error=course_error,
        speed_gate=speed_gate,
        rear_gate=rear_gate,
        turn_command=turn_command,
    )
end

function target_policy(state, params)
    guidance = course_guidance(state, params)
    omega = 2 * pi / params.control_period
    amplitude = params.oscillator_amplitude
    q1 = _policy_safe(state.phi[1], 0.0)
    q2 = _policy_safe(state.phi[2], 0.0)
    qd1 = _policy_safe(state.phi_dot[1], 0.0)
    qd2 = _policy_safe(state.phi_dot[2], 0.0)

    # Joint state remains the only gait phase. The posterior target preserves
    # the sampled near miss's directional lag and coherent three-dimensional
    # alternating wake.
    vdp_drive =
        params.oscillator_mu *
        (1 - (q1 / max(amplitude, eps(Float64)))^2) *
        qd1
    head_drive = vdp_drive - omega^2 * q1
    mean_tail_tangent =
        params.tail_curvature_limit * guidance.turn_command
    tail_target =
        mean_tail_tangent -
        q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(Float64))
    tail_drive =
        omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    # The anterior and posterior steering contributions share one request;
    # they do not fight across the beat as in the best-score compact sample.
    raw_head_accel =
        head_drive + params.head_steer_accel * guidance.turn_command
    return (
        phi_ddot=(
            _policy_soft_limit(raw_head_accel, params.command_accel_limit),
            _policy_soft_limit(tail_drive, params.command_accel_limit),
        ),
    )
end
