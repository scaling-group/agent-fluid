# Course-error mean-curvature controller.
#
# The bounded joint-state oscillator and posterior lag preserve the sampled
# coherent traveling wake. Normalized body-frame target-minus-course geometry
# owns one mean-curvature command: large route error redirects the swimmer and
# observed course alignment releases it back toward the centered propulsive
# gait. No instantaneous yaw-rate feedback or hidden phase is used.

function target_policy_params()
    return (
        version="dogfish3d_course_curvature_release_v1",
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.80,
        tail_damping=0.65,
        target_forward_floor=0.20,
        target_angle_limit=1.20,
        velocity_forward_floor=0.08,
        course_angle_limit=1.20,
        course_speed_scale=0.35,
        route_error_limit=1.20,
        route_error_scale=0.30,
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

function route_guidance(state, params)
    distance_L = max(_policy_safe(state.distance_L, 1.0), 1.0e-6)
    target_x = _policy_safe(state.target_body_L[1], -distance_L)
    target_y = _policy_safe(state.target_body_L[2], 0.0)

    # The fish advances along negative body x. Positive angles denote target
    # or course displacement toward positive body y and require positive mean
    # tail tangent in the sampled three-dimensional response convention.
    target_forward = max(-target_x / distance_L, params.target_forward_floor)
    target_lateral = target_y / distance_L
    target_angle = clamp(
        atan(target_lateral, target_forward),
        -params.target_angle_limit,
        params.target_angle_limit,
    )

    velocity_x = _policy_safe(state.velocity_body_U[1], 0.0)
    velocity_y = _policy_safe(state.velocity_body_U[2], 0.0)
    forward_speed = max(-velocity_x, 0.0)
    course_angle = clamp(
        atan(velocity_y, max(forward_speed, params.velocity_forward_floor)),
        -params.course_angle_limit,
        params.course_angle_limit,
    )

    # Course direction is undefined at release. Its authority grows only with
    # observed forward translation; target geometry remains available from the
    # first step and continuously owns the requested direction.
    course_gate = tanh(
        forward_speed / max(params.course_speed_scale, 1.0e-6),
    )
    route_error = clamp(
        target_angle - course_gate * course_angle,
        -params.route_error_limit,
        params.route_error_limit,
    )
    turn_command = tanh(
        route_error / max(params.route_error_scale, 1.0e-6),
    )
    return (
        target_angle=target_angle,
        course_angle=course_angle,
        course_gate=course_gate,
        route_error=route_error,
        turn_command=turn_command,
    )
end

function target_policy(state, params)
    guidance = route_guidance(state, params)
    omega = 2 * pi / params.control_period
    amplitude = max(params.oscillator_amplitude, 1.0e-6)
    q1 = _policy_safe(state.phi[1], 0.0)
    q2 = _policy_safe(state.phi[2], 0.0)
    qd1 = _policy_safe(state.phi_dot[1], 0.0)
    qd2 = _policy_safe(state.phi_dot[2], 0.0)

    # Joint state supplies oscillator phase; the posterior target keeps the
    # evidenced directional lag and adds only bounded mean curvature.
    vdp_drive =
        params.oscillator_mu *
        (1 - (q1 / amplitude)^2) *
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

    # Small opposite-signed anterior steering complements the posterior bend
    # without moving the oscillator equilibrium. Smooth controller-owned
    # limits keep direct commands inside the physical acceleration envelope.
    raw_head_accel =
        head_drive - params.head_steer_accel * guidance.turn_command
    return (
        phi_ddot=(
            _policy_soft_limit(raw_head_accel, params.command_accel_limit),
            _policy_soft_limit(tail_drive, params.command_accel_limit),
        ),
    )
end
