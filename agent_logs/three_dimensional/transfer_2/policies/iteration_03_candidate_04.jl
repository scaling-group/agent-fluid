# Course-error half-cycle steering controller.
#
# Useful sampled policies self-propel with a centered joint-state oscillator and
# posterior lag, but four mean-curvature variants either pass above the target
# or curl out near release.  This candidate retains the propulsive scaffold and
# applies one different steering primitive: normalized target-minus-course
# error strengthens only the compatible observed joint-state half-cycle of the
# posterior target.  It uses no clock, route, static curvature, or yaw-rate
# servo.

function target_policy_params()
    return (
        version="dogfish3d_course_halfcycle_asymmetry_v1",
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.80,
        tail_damping=0.65,
        target_forward_floor=0.20,
        target_angle_limit=1.25,
        velocity_forward_floor=0.08,
        course_angle_limit=1.25,
        course_speed_scale=0.35,
        route_error_limit=1.35,
        route_error_scale=0.45,
        phase_velocity_lead=0.15,
        phase_transition=0.30,
        halfcycle_asymmetry=0.34,
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

    # The material fish swims along negative body x.  Normalizing by distance
    # makes the target geometry independent of resolution and route length.
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

    # At release velocity direction is undefined.  Bring course correction in
    # continuously only after the fish establishes observed forward motion.
    course_gate = tanh(
        forward_speed / max(params.course_speed_scale, 1.0e-6),
    )
    route_error = clamp(
        target_angle - course_gate * course_angle,
        -params.route_error_limit,
        params.route_error_limit,
    )
    turn_request = tanh(
        route_error / max(params.route_error_scale, 1.0e-6),
    )
    return (
        target_angle=target_angle,
        course_angle=course_angle,
        course_gate=course_gate,
        route_error=route_error,
        turn_request=turn_request,
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

    # Joint state remains the only gait phase.  Keeping this oscillator centered
    # preserves the traveling drive that was lost by the sampled static curl.
    vdp_drive =
        params.oscillator_mu *
        (1 - (q1 / amplitude)^2) *
        qd1
    head_accel = vdp_drive - omega^2 * q1

    # Angle plus a small normalized velocity lead identifies the current
    # half-cycle without a clock.  For positive route error, the selected gain
    # makes cycle-mean (q1 + q2) positive under posterior tracking; the sampled
    # early 3D response associates that sign with reducing positive error.
    phase_coordinate =
        (q1 + params.phase_velocity_lead * qd1 / max(omega, eps(Float64))) /
        amplitude
    beat_side = tanh(
        phase_coordinate / max(params.phase_transition, 1.0e-6),
    )
    posterior_gain =
        1.0 -
        params.halfcycle_asymmetry * guidance.turn_request * beat_side
    posterior_gain = clamp(
        posterior_gain,
        1.0 - params.halfcycle_asymmetry,
        1.0 + params.halfcycle_asymmetry,
    )
    tail_target =
        -posterior_gain * q1 -
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
