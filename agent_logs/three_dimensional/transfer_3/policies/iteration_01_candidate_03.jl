# Phase-2 course-redirect candidate. A joint-state oscillator preserves the
# transferred traveling wave. Body-frame target and velocity vectors define a
# yaw-phase-independent course error; lost closure and large course error blend
# continuously into a bounded two-joint C-bend, with no clock or hidden mode.

function target_policy_params(; L::Int=64)
    return (
        version="dogfish_3d_course_error_c_bend_redirect_v1",
        L=Float64(L),
        drive_period=0.55,
        control_period=0.55,
        drive_amplitude=28.0 * pi / 180,
        drive_mu=0.35,
        drive_tail_lag_gain=0.80,
        drive_tail_damping=0.65,
        course_speed_on=0.15,
        course_speed_full=0.45,
        steering_error_scale=0.55,
        cruise_curvature_limit=10.5 * pi / 180,
        redirect_error_on=0.55,
        redirect_error_full=1.15,
        redirect_closing_center=0.20,
        redirect_closing_scale=0.16,
        redirect_curvature_limit=28.0 * pi / 180,
        redirect_head_share=0.44,
        redirect_bandwidth_ratio=0.55,
        redirect_damping=0.95,
    )
end

@inline function _clamp01(value)
    return clamp(value, 0.0, 1.0)
end

@inline function _safe(value, fallback)
    parsed = Float64(value)
    return isfinite(parsed) ? parsed : fallback
end

@inline function _smooth_gate(value, onset, full)
    z = _clamp01((value - onset) / max(full - onset, 1.0e-6))
    return z * z * (3.0 - 2.0 * z)
end

function guidance_module(state, params)
    distance_L = max(_safe(state.distance_L, 1.0), 1.0e-6)
    target_x = _safe(state.target_body_L[1], -distance_L)
    target_y = _safe(state.target_body_L[2], 0.0)
    velocity_x = _safe(state.velocity_body_U[1], 0.0)
    velocity_y = _safe(state.velocity_body_U[2], 0.0)
    speed = hypot(velocity_x, velocity_y)
    speed_gate = _smooth_gate(speed, params.course_speed_on, params.course_speed_full)

    # The body's head direction is -body-x. At useful speed, replace that
    # oscillating heading axis continuously by the measured course axis. The
    # signed angle from this axis to the target is invariant to world rotation.
    inverse_speed = inv(max(speed, 1.0e-6))
    course_x = -(1.0 - speed_gate) + speed_gate * velocity_x * inverse_speed
    course_y = speed_gate * velocity_y * inverse_speed
    course_norm = max(hypot(course_x, course_y), 1.0e-6)
    course_x /= course_norm
    course_y /= course_norm
    course_cross_target = course_x * target_y - course_y * target_x
    course_dot_target = course_x * target_x + course_y * target_y
    raw_course_error = atan(course_cross_target, course_dot_target)
    course_error = clamp(raw_course_error, -1.50, 1.50)

    closing_speed = hasproperty(state, :window_closing_speed_L) ?
        _safe(state.window_closing_speed_L, 0.0) :
        _safe(state.closing_speed_L, 0.0)
    loss_of_closure = 0.5 * (
        1.0 - tanh(
            (closing_speed - params.redirect_closing_center) /
            max(params.redirect_closing_scale, 1.0e-6),
        )
    )
    error_gate = _smooth_gate(
        abs(course_error),
        params.redirect_error_on,
        params.redirect_error_full,
    )
    redirect_gate = _clamp01(speed_gate * error_gate * loss_of_closure)
    scaled_error = tanh(course_error / max(params.steering_error_scale, 1.0e-6))

    # Positive body curvature turns the head toward negative course error for
    # this tail-to-head convention. Both commands remain bounded references.
    cruise_curvature = -params.cruise_curvature_limit * scaled_error
    redirect_curvature = -params.redirect_curvature_limit * scaled_error
    return (
        course_error=course_error,
        raw_course_error=raw_course_error,
        speed=speed,
        speed_gate=speed_gate,
        closing_speed_L=closing_speed,
        loss_of_closure=loss_of_closure,
        error_gate=error_gate,
        redirect_gate=redirect_gate,
        cruise_curvature=cruise_curvature,
        redirect_curvature=redirect_curvature,
    )
end

function drive_module(state, params, guidance)
    omega = 2 * pi / params.drive_period
    amp = params.drive_amplitude
    q1 = _safe(state.phi[1], 0.0)
    q2 = _safe(state.phi[2], 0.0)
    qd1 = _safe(state.phi_dot[1], 0.0)
    qd2 = _safe(state.phi_dot[2], 0.0)

    # State-feedback drive: phase comes from joint state, not a hidden clock.
    vdp_drive = params.drive_mu * (1 - (q1 / amp)^2) * qd1
    head_accel = vdp_drive - omega^2 * q1

    # The posterior joint follows with lag while the course controller supplies
    # only a bounded mean tangent, retaining a directed traveling bend.
    tail_target = guidance.cruise_curvature - q1 -
        params.drive_tail_lag_gain * qd1 / max(omega, eps(omega))
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

function redirect_module(drive, guidance, params)
    redirect_omega = params.redirect_bandwidth_ratio * drive.omega
    head_target = params.redirect_head_share * guidance.redirect_curvature
    tail_target = (1.0 - params.redirect_head_share) * guidance.redirect_curvature
    damping = 2.0 * params.redirect_damping * redirect_omega
    return (
        head_accel=redirect_omega^2 * (head_target - drive.q1) - damping * drive.qd1,
        tail_accel=redirect_omega^2 * (tail_target - drive.q2) - damping * drive.qd2,
        head_target=head_target,
        tail_target=tail_target,
    )
end

function target_policy(state, params)
    guidance = guidance_module(state, params)
    drive = drive_module(state, params, guidance)
    redirect = redirect_module(drive, guidance, params)
    redirect_gate = guidance.redirect_gate
    drive_gate = 1.0 - redirect_gate
    return (
        phi_ddot=(
            drive_gate * drive.head_accel + redirect_gate * redirect.head_accel,
            drive_gate * drive.tail_accel + redirect_gate * redirect.tail_accel,
        ),
    )
end
