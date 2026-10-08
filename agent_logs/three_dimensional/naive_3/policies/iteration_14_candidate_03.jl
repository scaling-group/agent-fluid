# Distance- and alignment-gated anterior terminal assist around the inherited
# velocity-course controller. Joint state remains the only carrier phase.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        turn_curvature_limit=12.0 * pi / 180,
        terminal_distance_L=3.0,
        terminal_width_L=2.0,
        terminal_curvature_gain=0.50,
        head_assist_distance_L=2.0,
        head_assist_width_L=1.25,
        head_assist_error_on=0.35,
        head_assist_error_width=0.45,
        terminal_head_curvature=6.0 * pi / 180,
        full_bearing_limit=pi,
        steering_scale=0.20,
        velocity_limit_U=1.5,
        course_speed_on_U=0.15,
        course_speed_width_U=0.30,
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

    # Compare measured velocity course with the target ray once translation is
    # reliable. The wrapped difference is entirely body-frame and contains no
    # clock or memorized route.
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

    raw_distance = Float64(state.distance_L)
    finite_distance = isfinite(raw_distance)
    distance = finite_distance ? max(raw_distance, 0.0) : Inf

    # Preserve the inherited terminal posterior authority, which supplied a
    # small improvement without changing the broad approach. Do not raise it
    # further because the evaluated posterior excursion already reached 44.3
    # degrees against the 45-degree hard limit.
    terminal_fraction = clamp(
        (params.terminal_distance_L - distance) /
        max(params.terminal_width_L, eps(Float64)),
        0.0,
        1.0,
    )
    terminal_gate = terminal_fraction^2 * (3.0 - 2.0 * terminal_fraction)
    curvature_limit = params.turn_curvature_limit *
        (1.0 + params.terminal_curvature_gain * terminal_gate)

    # Recruit the actuator channel with remaining angle margin only inside the
    # final approach and only while measured course is unresolved. Sampled yaw
    # moment follows anterior-angle sign, while required yaw has sign opposite
    # turn_request, hence the minus sign. Alignment or distance releases the
    # center shift continuously back to the zero-centered carrier.
    head_distance_fraction = clamp(
        (params.head_assist_distance_L - distance) /
        max(params.head_assist_width_L, eps(Float64)),
        0.0,
        1.0,
    )
    head_distance_gate = head_distance_fraction^2 *
        (3.0 - 2.0 * head_distance_fraction)
    head_error_fraction = clamp(
        (abs(course_error) - params.head_assist_error_on) /
        max(params.head_assist_error_width, eps(Float64)),
        0.0,
        1.0,
    )
    head_error_gate = head_error_fraction^2 *
        (3.0 - 2.0 * head_error_fraction)
    head_assist_gate = head_distance_gate * head_error_gate
    head_center = -params.terminal_head_curvature * turn_request *
        head_assist_gate

    centered_q1 = q1 - head_center
    vdp_drive = params.oscillator_mu *
        (1 - (centered_q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * centered_q1

    # Build the traveling component from displacement about the scheduled
    # center so anterior assist does not consume the posterior angle margin.
    mean_tail_tangent = curvature_limit * turn_request
    carrier_tail_target = -centered_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    tail_target = mean_tail_tangent + carrier_tail_target
    a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
