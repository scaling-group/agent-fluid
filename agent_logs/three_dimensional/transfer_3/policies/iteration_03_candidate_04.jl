# Phase-2 candidate: target-course-released posterior half-cycle steering.
# All phase, course, and target signals come from normalized body-frame state;
# there is no clock, mutable filter, world-frame route, or wake-phase replay.

function target_policy_params()
    return (
        version="dogfish3d_course_gated_halfcycle_v1",

        # Intermediate state-feedback carrier: stronger than the sampled weak
        # 12 deg gait, but below the saturation-dominated 28 deg carrier.
        control_period=0.80,
        oscillator_amplitude=15.0 * pi / 180,
        oscillator_mu=0.35,
        posterior_lag_gain=0.72,
        posterior_damping=0.72,

        # Target heading at low speed, target-relative course once translating.
        los_forward_floor=0.20,
        los_error_scale=0.35,
        course_error_scale=0.60,
        course_speed_scale=0.18,
        course_blend=0.78,

        # One steering actuator: observed posterior half-cycle asymmetry.
        halfcycle_asymmetry_gain=0.18,
        halfcycle_phase_scale=10.0 * pi / 180,
        halfcycle_scale_min=0.80,
        halfcycle_scale_max=1.20,
        command_acceleration_limit=1700.0 * pi / 180,
    )
end

@inline function _finite_or(value, fallback)
    parsed = Float64(value)
    return isfinite(parsed) ? parsed : fallback
end

@inline function _soft_limit(value, limit)
    safe_limit = max(_finite_or(limit, 1.0), 1.0e-6)
    return safe_limit * tanh(_finite_or(value, 0.0) / safe_limit)
end

function course_guidance(state, params)
    distance = max(_finite_or(state.distance_L, 1.0), 1.0e-6)
    target_x = _finite_or(state.target_body_L[1], -distance)
    target_y = _finite_or(state.target_body_L[2], 0.0)
    target_unit_x = target_x / distance
    target_unit_y = target_y / distance

    # Material body -x points forward. At low speed, body-frame line of sight
    # supplies the signed yaw request: positive target y calls for negative yaw.
    forward = -target_unit_x
    los_error = atan(target_unit_y, max(forward, params.los_forward_floor))
    los_yaw_request = -tanh(
        los_error / max(params.los_error_scale, 1.0e-6),
    )

    velocity_x = _finite_or(state.velocity_body_U[1], 0.0)
    velocity_y = _finite_or(state.velocity_body_U[2], 0.0)
    speed = hypot(velocity_x, velocity_y)

    # The signed angle from observed velocity to the target vector is a course
    # error, not a beat-scale yaw estimate. It reverses as translation crosses
    # the desired course, providing continuous countersteer after an overshoot.
    inverse_speed = 1.0 / max(speed, 1.0e-6)
    velocity_unit_x = velocity_x * inverse_speed
    velocity_unit_y = velocity_y * inverse_speed
    course_cross =
        velocity_unit_x * target_unit_y - velocity_unit_y * target_unit_x
    course_dot =
        velocity_unit_x * target_unit_x + velocity_unit_y * target_unit_y
    course_error = atan(course_cross, course_dot)
    course_yaw_request = tanh(
        course_error / max(params.course_error_scale, 1.0e-6),
    )

    speed_ratio = speed / max(params.course_speed_scale, 1.0e-6)
    course_gate = tanh(speed_ratio)^2
    course_weight = clamp(params.course_blend * course_gate, 0.0, 1.0)
    yaw_request = clamp(
        (1.0 - course_weight) * los_yaw_request +
        course_weight * course_yaw_request,
        -1.0,
        1.0,
    )

    return (
        los_error=los_error,
        course_error=course_error,
        speed=speed,
        course_weight=course_weight,
        yaw_request=yaw_request,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amplitude = params.oscillator_amplitude
    q1 = _finite_or(state.phi[1], 0.0)
    q2 = _finite_or(state.phi[2], 0.0)
    qd1 = _finite_or(state.phi_dot[1], 0.0)
    qd2 = _finite_or(state.phi_dot[2], 0.0)

    # Joint-state oscillator: phase is encoded by (q1, qd1), not elapsed time.
    vdp_drive =
        params.oscillator_mu * (1.0 - (q1 / amplitude)^2) * qd1
    anterior_raw = vdp_drive - omega^2 * q1

    # A posterior-lagged bend supplies propulsion. The target/course request
    # changes only the observed half-cycle amplitude and has zero static bend
    # when no turn is requested.
    guidance = course_guidance(state, params)
    posterior_wave =
        -q1 - params.posterior_lag_gain * qd1 / max(omega, eps(Float64))
    wave_side = tanh(
        posterior_wave / max(params.halfcycle_phase_scale, 1.0e-6),
    )
    halfcycle_scale = clamp(
        1.0 +
        params.halfcycle_asymmetry_gain * guidance.yaw_request * wave_side,
        params.halfcycle_scale_min,
        params.halfcycle_scale_max,
    )
    posterior_target = halfcycle_scale * posterior_wave
    posterior_raw =
        omega^2 * (posterior_target - q2) -
        2.0 * params.posterior_damping * omega * qd2

    limit = params.command_acceleration_limit
    return (
        phi_ddot=(
            _soft_limit(anterior_raw, limit),
            _soft_limit(posterior_raw, limit),
        ),
    )
end
