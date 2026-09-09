# Phase-2 candidate: response-damped half-cycle course steering on the
# coherent state-feedback carrier. Joint-rate projections separate locomotor
# recoil before observed yaw response brakes the asymmetric posterior beat.

function target_policy_params()
    return (
        version="dogfish3d_response_damped_halfcycle_course_v2",
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.80,
        tail_damping=0.65,
        los_forward_floor=0.25,
        course_activation_speed=0.35,
        lateral_recoil_q1_gain=0.11,
        lateral_recoil_q2_gain=-0.035,
        course_error_scale=0.35,
        target_yaw_rate_limit=0.45,
        yaw_recoil_q1_gain=0.82,
        yaw_recoil_q2_gain=0.12,
        yaw_rate_error_scale=0.25,
        halfcycle_asymmetry_gain=0.10,
        halfcycle_phase_scale=10.0 * pi / 180,
        halfcycle_scale_min=0.90,
        halfcycle_scale_max=1.10,
    )
end

@inline function _finite_or(value, fallback)
    parsed = Float64(value)
    return isfinite(parsed) ? parsed : fallback
end

function target_guidance(state, qd1, qd2, params)
    distance = max(_finite_or(state.distance_L, 1.0), 1.0e-6)
    target_x = _finite_or(state.target_body_L[1], -distance)
    target_y = _finite_or(state.target_body_L[2], 0.0)
    target_norm = max(hypot(target_x, target_y), 1.0e-6)

    # Material body -x is forward. Normalize target direction independently
    # of resolution and range, preserving reflection equivariance.
    target_forward = -target_x / target_norm
    target_lateral = target_y / target_norm
    los_error = atan(
        target_lateral,
        max(target_forward, params.los_forward_floor),
    )

    velocity_x = _finite_or(state.velocity_body_U[1], 0.0)
    raw_lateral_velocity = _finite_or(state.velocity_body_U[2], 0.0)
    forward_speed = max(-velocity_x, 0.0)

    # Remove the repeatable joint-correlated lateral recoil before using body
    # velocity as a course observation. Persistent translation remains.
    course_lateral_velocity =
        raw_lateral_velocity +
        params.lateral_recoil_q1_gain * qd1 +
        params.lateral_recoil_q2_gain * qd2
    course_speed = hypot(forward_speed, course_lateral_velocity)
    course_forward = course_speed > 1.0e-6 ? forward_speed / course_speed : 1.0
    course_lateral = course_speed > 1.0e-6 ?
        course_lateral_velocity / course_speed : 0.0

    # The signed angle from observed course to target course releases or
    # reverses steering before delayed body alignment. At low speed, blend
    # continuously back to line-of-sight geometry.
    course_cross =
        target_lateral * course_forward -
        target_forward * course_lateral
    course_dot =
        target_forward * course_forward +
        target_lateral * course_lateral
    course_error = atan(course_cross, course_dot)
    course_gate = tanh(
        forward_speed / max(params.course_activation_speed, 1.0e-6),
    )
    guidance_error =
        (1 - course_gate) * los_error + course_gate * course_error
    target_yaw_rate =
        -params.target_yaw_rate_limit *
        tanh(guidance_error / max(params.course_error_scale, 1.0e-6))

    # Separate carrier-correlated rigid yaw. Positive response excess is the
    # evidenced half-cycle request sign; it reverses when yaw outruns demand.
    measured_yaw_rate = _finite_or(state.heading_rate, 0.0)
    phase_separated_yaw_rate =
        measured_yaw_rate +
        params.yaw_recoil_q1_gain * qd1 +
        params.yaw_recoil_q2_gain * qd2
    yaw_response_excess = phase_separated_yaw_rate - target_yaw_rate
    halfcycle_turn_request = tanh(
        yaw_response_excess / max(params.yaw_rate_error_scale, 1.0e-6),
    )

    return (
        los_error=los_error,
        raw_lateral_velocity=raw_lateral_velocity,
        course_lateral_velocity=course_lateral_velocity,
        course_error=course_error,
        course_gate=course_gate,
        guidance_error=guidance_error,
        target_yaw_rate=target_yaw_rate,
        measured_yaw_rate=measured_yaw_rate,
        phase_separated_yaw_rate=phase_separated_yaw_rate,
        yaw_response_excess=yaw_response_excess,
        halfcycle_turn_request=halfcycle_turn_request,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amplitude = params.oscillator_amplitude
    q1 = _finite_or(state.phi[1], 0.0)
    q2 = _finite_or(state.phi[2], 0.0)
    qd1 = _finite_or(state.phi_dot[1], 0.0)
    qd2 = _finite_or(state.phi_dot[2], 0.0)

    # Preserve the sampled self-propelled traveling-bend carrier exactly.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amplitude)^2) * qd1
    anterior_accel = vdp_drive - omega^2 * q1

    guidance = target_guidance(state, qd1, qd2, params)
    posterior_wave =
        -q1 - params.tail_lag_gain * qd1 / max(omega, eps(Float64))

    # Joint state identifies beat side without a clock. Response feedback
    # strengthens one posterior half-cycle and weakens the other, then changes
    # sides when the phase-separated yaw passes its bounded course demand.
    wave_side = tanh(
        posterior_wave / max(params.halfcycle_phase_scale, 1.0e-6),
    )
    halfcycle_scale = clamp(
        1.0 +
        params.halfcycle_asymmetry_gain *
        guidance.halfcycle_turn_request * wave_side,
        params.halfcycle_scale_min,
        params.halfcycle_scale_max,
    )
    posterior_target = halfcycle_scale * posterior_wave
    posterior_accel =
        omega^2 * (posterior_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(anterior_accel, posterior_accel),)
end
