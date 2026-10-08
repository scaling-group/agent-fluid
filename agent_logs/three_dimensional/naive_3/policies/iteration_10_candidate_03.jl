# Closing-only terminal allocation around the demonstrated body-frame course
# controller. Joint state remains the only source of propulsive phase.

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
        terminal_closing_speed_scale=0.20,
        terminal_closing_speed_limit=1.5,
        terminal_carrier_floor=0.55,
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
    target_x = Float64(state.target_body_L[1])
    target_y = Float64(state.target_body_L[2])
    raw_folded_bearing = Float64(state.bearing)
    fallback_bearing = isfinite(raw_folded_bearing) ?
        raw_folded_bearing : 0.0
    raw_full_bearing = isfinite(target_x) && isfinite(target_y) ?
        atan(target_y, -target_x) : fallback_bearing
    full_bearing = clamp(
        raw_full_bearing,
        -params.full_bearing_limit,
        params.full_bearing_limit,
    )

    # Once translation is established, compare the actual velocity course to
    # the target ray. This dimensionless angle captures sideslip relative to
    # forward progress rather than using a dimensional additive slip gain.
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

    # Preserve the zero-centered Van der Pol carrier that produced the
    # evidenced near-capture route. Terminal allocation never recenters or
    # damps the anterior joint.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1

    # The course policy missed capture by 0.107L while still moving at 0.845U.
    # Inside the final approach, reduce posterior propulsive share only while
    # distance is closing. If the target is passed, opening distance releases
    # the brake so course steering and the full traveling carrier can recover.
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
    raw_closing_speed = Float64(state.closing_speed_L)
    closing_speed = isfinite(raw_closing_speed) ? clamp(
        raw_closing_speed,
        0.0,
        params.terminal_closing_speed_limit,
    ) : 0.0
    closing_gate = tanh(
        closing_speed /
        max(params.terminal_closing_speed_scale, eps(Float64)),
    )
    terminal_gate = distance_gate * closing_gate
    carrier_scale = 1.0 - terminal_gate *
        (1.0 - params.terminal_carrier_floor)

    # Course curvature remains fully active as the posterior oscillatory share
    # falls, increasing relative steering authority without a static hold.
    mean_tail_tangent = params.turn_curvature_limit * turn_request
    carrier_tail_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(Float64))
    tail_target = mean_tail_tangent + carrier_scale * carrier_tail_target
    a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
