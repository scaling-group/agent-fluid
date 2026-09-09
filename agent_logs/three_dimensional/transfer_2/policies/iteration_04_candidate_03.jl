# Shifted traveling-wave course controller.
#
# Sampled static tail bends, distributed acceleration biases, and posterior
# half-cycle asymmetry all curled out without settling a route.  This candidate
# preserves the centered posterior-lag propulsion scaffold but uses one new
# steering actuator: observed route error moves the equilibrium of the whole
# traveling bend.  No clock, mutable memory, world route, or yaw-rate servo is
# used.

function target_policy_params()
    return (
        version="dogfish3d_shifted_wave_course_v1",
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.80,
        tail_damping=0.65,
        bearing_limit=1.20,
        target_forward_floor=0.20,
        target_angle_limit=1.25,
        course_forward_floor=0.08,
        course_angle_limit=1.25,
        course_speed_scale=0.30,
        route_error_limit=1.35,
        route_error_scale=0.35,
        center_offset_limit=4.0 * pi / 180,
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

function route_guidance(state, params)
    distance_L = max(_policy_safe(state.distance_L, 1.0), 1.0e-6)
    target_x = _policy_safe(state.target_body_L[1], -distance_L)
    target_y = _policy_safe(state.target_body_L[2], 0.0)
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
    bearing = clamp(
        _policy_safe(state.bearing, target_angle),
        -params.bearing_limit,
        params.bearing_limit,
    )

    velocity_x = _policy_safe(state.velocity_body_U[1], 0.0)
    velocity_y = _policy_safe(state.velocity_body_U[2], 0.0)
    speed = hypot(velocity_x, velocity_y)
    course_angle = atan(
        velocity_y,
        max(-velocity_x, params.course_forward_floor),
    )
    course_angle = clamp(
        course_angle,
        -params.course_angle_limit,
        params.course_angle_limit,
    )

    # Both angles are formed from body-frame vectors.  Their difference removes
    # common beat-scale body yaw once observed translation makes course valid.
    course_error = clamp(
        _policy_wrap_angle(target_angle - course_angle),
        -params.route_error_limit,
        params.route_error_limit,
    )
    course_gate = tanh(
        speed / max(params.course_speed_scale, 1.0e-6),
    )
    route_error =
        (1.0 - course_gate) * bearing + course_gate * course_error
    route_error = clamp(
        route_error,
        -params.route_error_limit,
        params.route_error_limit,
    )
    turn_request = tanh(
        route_error / max(params.route_error_scale, 1.0e-6),
    )

    # The sampled compact controller's anterior path associates positive
    # target error with negative anterior curvature.  Keep that observed sign,
    # but realize it as a bounded oscillator center rather than a DC torque.
    center_offset = -params.center_offset_limit * turn_request
    return (
        bearing=bearing,
        target_angle=target_angle,
        course_angle=course_angle,
        course_gate=course_gate,
        course_error=course_error,
        route_error=route_error,
        turn_request=turn_request,
        center_offset=center_offset,
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

    # Translate the state-feedback limit cycle around the requested center.
    # Its oscillatory coordinate, amplitude, and phase remain joint-observed.
    wave_coordinate = q1 - guidance.center_offset
    vdp_drive =
        params.oscillator_mu *
        (1.0 - (wave_coordinate / amplitude)^2) *
        qd1
    head_accel = vdp_drive - omega^2 * wave_coordinate

    # Express posterior lag in the same shifted coordinate.  q2 remains
    # centered while absolute tail tangent q1+q2 inherits the mean offset, so
    # the propulsive wave is translated rather than replaced by a static tail
    # bend or a one-sided amplitude gate.
    tail_target =
        -wave_coordinate -
        params.tail_lag_gain * qd1 / max(omega, eps(Float64))
    tail_accel =
        omega^2 * (tail_target - q2) -
        2.0 * params.tail_damping * omega * qd2

    return (
        phi_ddot=(
            _policy_soft_limit(head_accel, params.command_accel_limit),
            _policy_soft_limit(tail_accel, params.command_accel_limit),
        ),
    )
end
