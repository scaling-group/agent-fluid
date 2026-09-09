# Course-aware response-gated curvature controller.
#
# The sampled compact controller demonstrated a coherent posterior-lag wake but
# steered body heading without settling its inertial course.  This candidate
# retains that drive and uses one steering mechanism: speed-gated target/course
# error requests a yaw rate, and measured yaw-rate error biases only the mean
# posterior curvature.  No clock, route, or anterior oscillator shift is used.

function target_policy_params()
    return (
        version="dogfish3d_course_response_curvature_v1",
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.80,
        tail_damping=0.65,
        target_forward_floor=0.20,
        target_angle_limit=1.35,
        velocity_forward_floor=0.08,
        course_angle_limit=1.25,
        course_speed_scale=0.35,
        aim_error_scale=0.35,
        desired_yaw_rate_limit=0.60,
        yaw_rate_error_scale=0.45,
        mean_curvature_limit=8.0 * pi / 180,
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

function course_guidance(state, params)
    distance_L = max(_policy_safe(state.distance_L, 1.0), 1.0e-6)
    target_x = _policy_safe(state.target_body_L[1], -distance_L)
    target_y = _policy_safe(state.target_body_L[2], 0.0)

    # The material fish swims along negative body x.  Division by distance
    # makes the geometry independent of grid resolution and route length.
    target_forward = -target_x / distance_L
    target_lateral = target_y / distance_L
    target_angle = atan(
        target_lateral,
        max(target_forward, params.target_forward_floor),
    )
    target_angle = clamp(
        target_angle,
        -params.target_angle_limit,
        params.target_angle_limit,
    )

    velocity_x = _policy_safe(state.velocity_body_U[1], 0.0)
    velocity_y = _policy_safe(state.velocity_body_U[2], 0.0)
    forward_speed = max(-velocity_x, 0.0)
    course_angle = atan(
        velocity_y,
        max(forward_speed, params.velocity_forward_floor),
    )
    course_angle = clamp(
        course_angle,
        -params.course_angle_limit,
        params.course_angle_limit,
    )

    # Do not amplify a poorly defined course at release.  As forward motion
    # develops, correct the direction of travel rather than body angle alone.
    course_gate = tanh(
        forward_speed / max(params.course_speed_scale, 1.0e-6),
    )
    aim_error = target_angle - course_gate * course_angle
    desired_yaw_rate =
        -params.desired_yaw_rate_limit *
        tanh(aim_error / max(params.aim_error_scale, 1.0e-6))
    yaw_rate = hasproperty(state, :turn_rate_recent) ?
        _policy_safe(state.turn_rate_recent, 0.0) :
        _policy_safe(state.heading_rate, 0.0)

    # Positive mean curvature produces negative yaw in the sampled 3D FSI
    # response.  This error form therefore supplies both pursuit and braking.
    yaw_rate_error = yaw_rate - desired_yaw_rate
    curvature_command = tanh(
        yaw_rate_error / max(params.yaw_rate_error_scale, 1.0e-6),
    )
    mean_curvature = params.mean_curvature_limit * curvature_command
    return (
        target_angle=target_angle,
        course_angle=course_angle,
        course_gate=course_gate,
        aim_error=aim_error,
        desired_yaw_rate=desired_yaw_rate,
        yaw_rate=yaw_rate,
        mean_curvature=mean_curvature,
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

    # Joint state remains the only gait phase.  The anterior oscillator is not
    # recentered, preserving the drive lost by the sampled static-bend failure.
    vdp_drive =
        params.oscillator_mu *
        (1 - (q1 / max(amplitude, 1.0e-6))^2) *
        qd1
    head_accel = vdp_drive - omega^2 * q1

    # Posterior lag forms the traveling bend; its bounded mean tangent is the
    # sole steering actuator so steering does not replace propulsion.
    tail_target =
        guidance.mean_curvature -
        q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(Float64))
    tail_accel =
        omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (
        phi_ddot=(
            _policy_soft_limit(head_accel, params.command_accel_limit),
            _policy_soft_limit(tail_accel, params.command_accel_limit),
        ),
    )
end
