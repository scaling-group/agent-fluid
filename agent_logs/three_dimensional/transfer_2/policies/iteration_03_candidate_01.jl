# Course-vector curvature controller.
#
# Preserve the sampled compact traveling-bend gait.  Steering comes from one
# normalized geometric mechanism: a speed-gated cross-product between the
# target direction and inertial course, both expressed in the body frame.  The
# geometric error directly owns distributed mean curvature; beat-scale yaw rate
# is deliberately excluded because this evaluator does not provide a
# cycle-averaged turn response.

function target_policy_params()
    return (
        version="dogfish3d_course_vector_curvature_v1",
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.80,
        tail_damping=0.65,
        course_speed_floor=0.08,
        course_gate_scale=0.35,
        aim_error_scale=0.30,
        mean_curvature_limit=8.0 * pi / 180,
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

function course_vector_guidance(state, params)
    distance_L = max(_policy_safe(state.distance_L, 1.0), 1.0e-6)
    target_x = _policy_safe(state.target_body_L[1], -distance_L)
    target_y = _policy_safe(state.target_body_L[2], 0.0)
    target_norm = max(hypot(target_x, target_y), 1.0e-6)

    # The fish swims along negative body x.  These components are normalized
    # directions, so the cross-product below is bounded and invariant to rigid
    # heading even though both vectors are represented in the body frame.
    target_forward = clamp(-target_x / target_norm, -1.0, 1.0)
    target_lateral = clamp(target_y / target_norm, -1.0, 1.0)

    velocity_x = _policy_safe(state.velocity_body_U[1], 0.0)
    velocity_y = _policy_safe(state.velocity_body_U[2], 0.0)
    speed = hypot(velocity_x, velocity_y)
    course_norm = max(speed, params.course_speed_floor)
    course_forward = clamp(-velocity_x / course_norm, -1.0, 1.0)
    course_lateral = clamp(velocity_y / course_norm, -1.0, 1.0)
    forward_speed = max(-velocity_x, 0.0)
    course_gate = tanh(
        forward_speed / max(params.course_gate_scale, 1.0e-6),
    )

    # sin(target direction - course direction).  Before self-propulsion makes
    # course meaningful, target lateral geometry supplies the same turn sign.
    course_error =
        target_lateral * course_forward -
        target_forward * course_lateral
    aim_error =
        (1.0 - course_gate) * target_lateral +
        course_gate * course_error
    turn_command = tanh(
        aim_error / max(params.aim_error_scale, 1.0e-6),
    )
    return (
        target_forward=target_forward,
        target_lateral=target_lateral,
        course_forward=course_forward,
        course_lateral=course_lateral,
        course_gate=course_gate,
        course_error=course_error,
        aim_error=aim_error,
        turn_command=turn_command,
    )
end

function target_policy(state, params)
    guidance = course_vector_guidance(state, params)
    omega = 2 * pi / params.control_period
    amplitude = params.oscillator_amplitude
    q1 = _policy_safe(state.phi[1], 0.0)
    q2 = _policy_safe(state.phi[2], 0.0)
    qd1 = _policy_safe(state.phi_dot[1], 0.0)
    qd2 = _policy_safe(state.phi_dot[2], 0.0)

    # Joint state is the only gait phase.  The anterior oscillator and lagged
    # posterior target retain the coherent self-propelled wake in the compact
    # samples.
    vdp_drive =
        params.oscillator_mu *
        (1 - (q1 / max(amplitude, 1.0e-6))^2) *
        qd1
    head_drive = vdp_drive - omega^2 * q1

    # Positive geometric error requests the empirically calibrated positive
    # mean tail tangent and opposite anterior acceleration.  This distributed
    # bend gives prompt steering without recentering the propulsive oscillator.
    mean_tail_tangent =
        params.mean_curvature_limit * guidance.turn_command
    tail_target =
        mean_tail_tangent -
        q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(Float64))
    tail_drive =
        omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2
    raw_head_accel =
        head_drive - params.head_steer_accel * guidance.turn_command

    return (
        phi_ddot=(
            _policy_soft_limit(raw_head_accel, params.command_accel_limit),
            _policy_soft_limit(tail_drive, params.command_accel_limit),
        ),
    )
end
