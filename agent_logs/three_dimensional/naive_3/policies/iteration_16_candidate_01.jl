# Phase-compensated body-frame velocity-course steering around the
# demonstrated traveling-wave carrier. Joint state remains the only phase.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        turn_curvature_limit=12.0 * pi / 180,
        full_bearing_limit=pi,
        steering_scale=0.20,
        velocity_limit_U=1.5,
        course_speed_on_U=0.15,
        course_speed_width_U=0.30,
        phase_sway_gain=0.11,
        phase_sway_limit_U=0.60,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

    # Measure target direction around the head-facing body -x axis. Unlike the
    # adapter's folded scalar bearing, this remains signed after a target pass.
    raw_target_x = Float64(state.target_body_L[1])
    raw_target_y = Float64(state.target_body_L[2])
    finite_target = isfinite(raw_target_x) && isfinite(raw_target_y)
    target_x = finite_target ? raw_target_x : -1.0
    target_y = finite_target ? raw_target_y : 0.0
    raw_full_bearing = atan(target_y, -target_x)
    full_bearing = clamp(
        raw_full_bearing,
        -params.full_bearing_limit,
        params.full_bearing_limit,
    )

    raw_forward_velocity = Float64(state.velocity_body_U[1])
    raw_lateral_velocity = Float64(state.velocity_body_U[2])
    forward_velocity = isfinite(raw_forward_velocity) ? clamp(
        raw_forward_velocity,
        -params.velocity_limit_U,
        params.velocity_limit_U,
    ) : 0.0
    lateral_velocity = isfinite(raw_lateral_velocity) ? clamp(
        raw_lateral_velocity,
        -params.velocity_limit_U,
        params.velocity_limit_U,
    ) : 0.0

    # The evaluated carrier's fast lateral velocity is approximately
    # -phase_sway_gain*qd1. Remove that phase-correlated component before
    # interpreting translation as course, while bounding the residual channel.
    raw_phase_sway = params.phase_sway_gain * qd1
    phase_sway = isfinite(raw_phase_sway) ? clamp(
        raw_phase_sway,
        -params.phase_sway_limit_U,
        params.phase_sway_limit_U,
    ) : 0.0
    course_lateral_velocity = clamp(
        lateral_velocity + phase_sway,
        -params.velocity_limit_U,
        params.velocity_limit_U,
    )

    # Compare the target ray with the phase-compensated velocity course once
    # translation is reliable. At low speed, blend continuously to bearing.
    course_speed = hypot(forward_velocity, course_lateral_velocity)
    course_bearing = course_speed > eps(Float64) ?
        atan(course_lateral_velocity, -forward_velocity) : 0.0
    raw_course_error = full_bearing - course_bearing
    course_error = atan(sin(raw_course_error), cos(raw_course_error))

    speed_fraction = clamp(
        (course_speed - params.course_speed_on_U) /
        max(params.course_speed_width_U, eps(Float64)),
        0.0,
        1.0,
    )
    course_gate = speed_fraction^2 * (3.0 - 2.0 * speed_fraction)
    steering_signal = (1.0 - course_gate) * full_bearing +
        course_gate * course_error
    turn_request = tanh(
        steering_signal / max(params.steering_scale, eps(Float64)),
    )

    # Preserve the zero-centered oscillator and the demonstrated posterior
    # phase lag. Only the observation used for bounded mean curvature changes.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1
    mean_tail_tangent = params.turn_curvature_limit * turn_request
    carrier_tail_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    tail_target = mean_tail_tangent + carrier_tail_target
    a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
