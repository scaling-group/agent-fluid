# Target-signed wrong-way-yaw burst redirect around the demonstrated
# body-frame velocity-course controller. Joint state remains carrier phase.

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
        terminal_distance_L=4.0,
        terminal_width_L=2.5,
        terminal_error_on=0.35,
        terminal_error_width=0.55,
        heading_rate_limit=4.0,
        wrong_way_rate_scale=0.80,
        burst_head_curvature=12.0 * pi / 180,
        burst_head_damping=0.80,
        burst_acceleration_limit=18.0,
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

    # Preserve the evaluated raw body-translation course. The sampled
    # joint-rate compensation removed useful closed-loop steering information.
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

    # Preserve the demonstrated zero-centered carrier whenever a redirect is
    # not demanded by both terminal geometry and measured wrong-way yaw.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    carrier_a1 = vdp_drive - omega^2 * q1

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

    # Desired yaw has sign opposite turn_request in this body convention.
    # Thus turn_request*heading_rate is positive only during wrong-way yaw.
    raw_heading_rate = Float64(state.heading_rate)
    heading_rate = isfinite(raw_heading_rate) ? clamp(
        raw_heading_rate,
        -params.heading_rate_limit,
        params.heading_rate_limit,
    ) : 0.0
    wrong_way_rate = max(0.0, turn_request * heading_rate)
    response_fraction = clamp(
        wrong_way_rate / max(params.wrong_way_rate_scale, eps(Float64)),
        0.0,
        1.0,
    )
    response_gate = response_fraction^2 *
        (3.0 - 2.0 * response_fraction)
    redirect_gate = terminal_gate * error_gate * response_gate

    # Completed traces associate anterior-angle sign with yaw-moment sign.
    # Blend toward the target-useful opposite-turn-request bend only while yaw
    # is wrong-way. A bounded PD acceleration replaces, rather than adds to,
    # the carrier command so the redirect does not increase the raw envelope.
    burst_head_target = -params.burst_head_curvature * turn_request
    raw_burst_a1 = omega^2 * (burst_head_target - q1) -
        2 * params.burst_head_damping * omega * qd1
    burst_a1 = clamp(
        raw_burst_a1,
        -params.burst_acceleration_limit,
        params.burst_acceleration_limit,
    )
    a1 = (1.0 - redirect_gate) * carrier_a1 +
        redirect_gate * burst_a1

    # Keep both the bounded mean curvature and the complete lagged posterior
    # carrier active through the burst. Corrective yaw releases a1 back to the
    # oscillator, allowing the same traveling wake to resume continuously.
    mean_tail_tangent = params.turn_curvature_limit * turn_request
    lagged_carrier = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    tail_target = mean_tail_tangent + lagged_carrier
    a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
