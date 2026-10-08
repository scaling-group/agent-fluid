# Course tracking with a terminal, response-released turn-side head burst.
# Joint state remains the only source of propulsive and steering beat phase.

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
        terminal_distance_on_L=2.0,
        terminal_distance_width_L=1.0,
        terminal_closing_on_U=0.10,
        terminal_closing_width_U=0.30,
        terminal_miss_on_L=0.55,
        terminal_miss_width_L=0.20,
        terminal_phase_angle=10.0 * pi / 180,
        terminal_yaw_release_rate=1.0,
        terminal_heading_rate_limit=4.0,
        terminal_head_force_angle=6.0 * pi / 180,
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
    # adapter's folded bearing, this remains signed after a target pass.
    target_x = Float64(state.target_body_L[1])
    target_y = Float64(state.target_body_L[2])
    finite_target = isfinite(target_x) && isfinite(target_y)
    raw_folded_bearing = Float64(state.bearing)
    fallback_bearing = isfinite(raw_folded_bearing) ?
        raw_folded_bearing : 0.0
    raw_full_bearing = finite_target ?
        atan(target_y, -target_x) : fallback_bearing
    full_bearing = clamp(
        raw_full_bearing,
        -params.full_bearing_limit,
        params.full_bearing_limit,
    )

    # Once translation is established, compare the actual body-frame course
    # with the target ray. This preserves the inherited near-capture route.
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

    # Terminal gates use only normalized body-frame geometry. They are exactly
    # zero outside 2L and select a closing constant-course miss, not a clocked
    # stage or a memorized route.
    raw_distance_L = Float64(state.distance_L)
    distance_L = isfinite(raw_distance_L) ? max(raw_distance_L, 0.0) : Inf
    distance_fraction = clamp(
        (params.terminal_distance_on_L - distance_L) /
        max(params.terminal_distance_width_L, eps(Float64)),
        0.0,
        1.0,
    )
    distance_gate = distance_fraction^2 *
        (3.0 - 2.0 * distance_fraction)

    target_distance = finite_target ? hypot(target_x, target_y) : 0.0
    closing_projection = finite_target &&
        target_distance > eps(Float64) ?
        (target_x * forward_velocity + target_y * lateral_velocity) /
            target_distance : 0.0
    closing_fraction = clamp(
        (closing_projection - params.terminal_closing_on_U) /
        max(params.terminal_closing_width_U, eps(Float64)),
        0.0,
        1.0,
    )
    closing_gate = closing_fraction^2 *
        (3.0 - 2.0 * closing_fraction)

    predicted_miss_L = finite_target && course_speed > eps(Float64) ?
        abs(target_x * lateral_velocity -
            target_y * forward_velocity) / course_speed : 0.0
    miss_fraction = clamp(
        (predicted_miss_L - params.terminal_miss_on_L) /
        max(params.terminal_miss_width_L, eps(Float64)),
        0.0,
        1.0,
    )
    miss_gate = miss_fraction^2 * (3.0 - 2.0 * miss_fraction)
    terminal_gate = distance_gate * closing_gate * miss_gate

    # Positive turn request requires negative yaw in this convention. Keep the
    # burst active at zero or wrong-way yaw, then release it continuously once
    # the measured yaw response is sufficiently corrective.
    raw_heading_rate = Float64(state.heading_rate)
    heading_rate = isfinite(raw_heading_rate) ? clamp(
        raw_heading_rate,
        -params.terminal_heading_rate_limit,
        params.terminal_heading_rate_limit,
    ) : 0.0
    corrective_yaw = max(0.0, -turn_request * heading_rate)
    response_fraction = clamp(
        corrective_yaw /
        max(params.terminal_yaw_release_rate, eps(Float64)),
        0.0,
        1.0,
    )
    response_gate = 1.0 - response_fraction^2 *
        (3.0 - 2.0 * response_fraction)

    # Observed anterior angle selects the requested bend half-cycle. The
    # bounded residual adds work only on that side; it neither holds a shifted
    # oscillator center nor attenuates the full posterior traveling carrier.
    phase_fraction = clamp(
        0.5 + 0.5 * turn_request * q1 /
            max(params.terminal_phase_angle, eps(Float64)),
        0.0,
        1.0,
    )
    phase_gate = phase_fraction^2 * (3.0 - 2.0 * phase_fraction)
    head_burst = omega^2 * params.terminal_head_force_angle *
        turn_request * terminal_gate * response_gate * phase_gate

    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1 + head_burst

    mean_tail_tangent = params.turn_curvature_limit * turn_request
    carrier_tail_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    tail_target = mean_tail_tangent + carrier_tail_target
    a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
