# Phase-2 candidate: course-commanded posterior half-cycle asymmetry on the
# coherent state-feedback traveling bend. Target and velocity geometry remain
# normalized and body-frame; joint state supplies phase without a hidden clock.

function target_policy_params()
    return (
        version="dogfish3d_course_half_cycle_asymmetry_v1",
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.80,
        tail_damping=0.65,
        los_forward_floor=0.25,
        course_forward_floor=0.10,
        course_speed_scale=0.25,
        route_error_scale=0.35,
        half_cycle_asymmetry_limit=0.35,
        carrier_phase_width_fraction=0.25,
    )
end

@inline function _finite_or(value, fallback)
    parsed = Float64(value)
    return isfinite(parsed) ? parsed : fallback
end

@inline function _wrap_angle(value)
    return atan(sin(value), cos(value))
end

function target_guidance(state, params)
    distance = max(_finite_or(state.distance_L, 1.0), 1.0e-6)
    target_x = _finite_or(state.target_body_L[1], -distance)
    target_y = _finite_or(state.target_body_L[2], 0.0)

    # Material body -x is forward. Range normalization and body coordinates
    # preserve the route signal across moving-window shifts and reflections.
    target_forward = -target_x / distance
    target_lateral = target_y / distance
    target_course = atan(
        target_lateral,
        max(target_forward, params.los_forward_floor),
    )

    velocity_x = _finite_or(state.velocity_body_U[1], 0.0)
    velocity_y = _finite_or(state.velocity_body_U[2], 0.0)
    speed = hypot(velocity_x, velocity_y)
    measured_course = atan(
        velocity_y,
        max(-velocity_x, params.course_forward_floor),
    )

    # At release, suppress the direction of a nearly zero velocity. Once the
    # fish is self-propelled, course error anticipates LOS route overshoot.
    course_authority = tanh(
        speed / max(params.course_speed_scale, 1.0e-6),
    )
    route_error = _wrap_angle(
        target_course - course_authority * measured_course,
    )
    turn_request = -tanh(
        route_error / max(params.route_error_scale, 1.0e-6),
    )

    return (
        target_course=target_course,
        measured_course=measured_course,
        course_authority=course_authority,
        route_error=route_error,
        turn_request=turn_request,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amplitude = params.oscillator_amplitude
    q1 = _finite_or(state.phi[1], 0.0)
    q2 = _finite_or(state.phi[2], 0.0)
    qd1 = _finite_or(state.phi_dot[1], 0.0)
    qd2 = _finite_or(state.phi_dot[2], 0.0)

    # Preserve the sampled self-sustaining anterior carrier exactly.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amplitude)^2) * qd1
    anterior_accel = vdp_drive - omega^2 * q1

    guidance = target_guidance(state, params)
    posterior_carrier =
        -q1 - params.tail_lag_gain * qd1 / max(omega, eps(Float64))

    # Joint state identifies the carrier half-cycle. A bounded route command
    # strengthens the useful posterior bend and weakens the opposite bend;
    # both remain active, preserving a traveling wave rather than imposing a
    # static tail offset or closing a loop on within-beat rigid yaw recoil.
    phase_width = max(
        params.carrier_phase_width_fraction * amplitude,
        eps(Float64),
    )
    carrier_side = tanh(posterior_carrier / phase_width)
    asymmetry = params.half_cycle_asymmetry_limit * guidance.turn_request
    carrier_scale = 1 + asymmetry * carrier_side
    posterior_target = carrier_scale * posterior_carrier
    posterior_accel =
        omega^2 * (posterior_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(anterior_accel, posterior_accel),)
end
