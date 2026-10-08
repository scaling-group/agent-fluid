# Terminal posterior counter-moment relief around the demonstrated body-frame
# velocity-course controller. Joint state remains the only carrier phase.

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
        terminal_distance_L=3.5,
        terminal_width_L=2.5,
        terminal_error_on=0.45,
        terminal_error_width=0.65,
        counter_phase_angle=8.0 * pi / 180,
        counter_carrier_floor=0.55,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

    # Measure target direction around the head-facing body -x axis. This
    # remains signed after a pass, unlike the adapter's folded scalar bearing.
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

    # Compare the measured swimming course with the target ray once body
    # translation is large enough for course angle to be informative.
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
    course_speed = hypot(forward_velocity, lateral_velocity)
    course_bearing = course_speed > eps(Float64) ?
        atan(lateral_velocity, -forward_velocity) : 0.0
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

    # Preserve the successful zero-centered anterior oscillator exactly. Its
    # angle is also the rollout-calibrated sign of beat-scale yaw moment.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1

    # Recruit half-cycle allocation only in the terminal region and only while
    # measured course error is unresolved. Required yaw has sign opposite the
    # turn request, so q1 with the same sign as turn_request marks the observed
    # counter-moment half-cycle. Smoothly relieve that posterior carrier half
    # while leaving the useful half and mean-curvature request unchanged.
    raw_distance = Float64(state.distance_L)
    terminal_fraction = isfinite(raw_distance) ? clamp(
        (params.terminal_distance_L - max(raw_distance, 0.0)) /
        max(params.terminal_width_L, eps(Float64)),
        0.0,
        1.0,
    ) : 0.0
    terminal_gate = terminal_fraction^2 *
        (3.0 - 2.0 * terminal_fraction)
    error_fraction = clamp(
        (abs(course_error) - params.terminal_error_on) /
        max(params.terminal_error_width, eps(Float64)),
        0.0,
        1.0,
    )
    error_gate = error_fraction^2 * (3.0 - 2.0 * error_fraction)
    phase_side = tanh(
        q1 / max(params.counter_phase_angle, eps(Float64)),
    )
    counter_phase = clamp(
        0.5 * (1.0 + turn_request * phase_side),
        0.0,
        1.0,
    )
    counter_relief = terminal_gate * error_gate * counter_phase
    carrier_scale = 1.0 - counter_relief *
        (1.0 - params.counter_carrier_floor)

    mean_tail_tangent = params.turn_curvature_limit * turn_request
    lagged_carrier = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(Float64))
    tail_target = mean_tail_tangent + carrier_scale * lagged_carrier
    a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
