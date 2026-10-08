# Velocity-course tracking with a terminal line-of-sight-rate lead.
# Joint state remains the only source of propulsive phase.

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
        navigation_distance_L=3.5,
        navigation_distance_width_L=1.0,
        navigation_closing_scale_U=0.25,
        navigation_front_limit=pi / 2,
        navigation_front_width=0.35,
        navigation_component_rate_limit=6.0,
        navigation_rate_limit=1.2,
        navigation_rate_scale=0.30,
        navigation_steering_weight=0.20,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

    # Measure around the head-facing body -x axis. This keeps the target side
    # signed after a pass without introducing a world-frame route.
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

    # Preserve the inherited velocity-course observation that produced the
    # narrowest approach. At low speed, fall back continuously to target ray.
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
    course_steering = (1.0 - course_gate) * full_bearing +
        course_gate * course_error

    # In the front quadrant the adapter bearing is the signed target ray.
    # With this convention, recent yaw minus windowed bearing rate estimates
    # inertial line-of-sight rotation and cancels most beat-scale body yaw.
    raw_bearing_rate = Float64(state.bearing_window_rate)
    raw_turn_rate = Float64(state.turn_rate_recent)
    bearing_rate = isfinite(raw_bearing_rate) ? clamp(
        raw_bearing_rate,
        -params.navigation_component_rate_limit,
        params.navigation_component_rate_limit,
    ) : 0.0
    turn_rate = isfinite(raw_turn_rate) ? clamp(
        raw_turn_rate,
        -params.navigation_component_rate_limit,
        params.navigation_component_rate_limit,
    ) : 0.0
    line_of_sight_rate = clamp(
        turn_rate - bearing_rate,
        -params.navigation_rate_limit,
        params.navigation_rate_limit,
    )

    raw_distance_L = Float64(state.distance_L)
    distance_L = isfinite(raw_distance_L) ? max(raw_distance_L, 0.0) : Inf
    proximity_fraction = clamp(
        (params.navigation_distance_L - distance_L) /
        max(params.navigation_distance_width_L, eps(Float64)),
        0.0,
        1.0,
    )
    proximity_gate = proximity_fraction^2 *
        (3.0 - 2.0 * proximity_fraction)

    target_distance = finite_target ? hypot(target_x, target_y) : 0.0
    closing_projection = finite_target &&
        target_distance > eps(Float64) ?
        (target_x * forward_velocity + target_y * lateral_velocity) /
            target_distance : 0.0
    closing_fraction = clamp(
        closing_projection /
        max(params.navigation_closing_scale_U, eps(Float64)),
        0.0,
        1.0,
    )
    closing_gate = closing_fraction^2 * (3.0 - 2.0 * closing_fraction)

    front_fraction = clamp(
        (params.navigation_front_limit - abs(full_bearing)) /
        max(params.navigation_front_width, eps(Float64)),
        0.0,
        1.0,
    )
    front_gate = front_fraction^2 * (3.0 - 2.0 * front_fraction)
    navigation_gate = course_gate * proximity_gate * closing_gate * front_gate
    navigation_signal = tanh(
        line_of_sight_rate / max(params.navigation_rate_scale, eps(Float64)),
    )

    # Positive inertial line-of-sight rotation requires negative turn request
    # in this body's sign convention. Lead the course command without raising
    # the established posterior curvature cap.
    steering_signal = course_steering - navigation_gate *
        params.navigation_steering_weight * navigation_signal
    turn_request = tanh(
        steering_signal / max(params.steering_scale, eps(Float64)),
    )

    # Preserve the zero-centered traveling carrier and posterior lag exactly.
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
