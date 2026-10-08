# Closing-time approach allocation around the inherited course-tracking
# carrier. Joint state remains the only source of propulsive phase.

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
        capture_radius_L=0.75,
        closing_speed_limit_L=1.5,
        arrival_time_on_T=2.0,
        arrival_time_width_T=1.0,
        arrival_carrier_floor=0.55,
        arrival_head_damping=0.20,
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
    # adapter's folded scalar bearing, this stays signed after a target pass.
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

    # Once translation is established, steer by the signed angle between the
    # measured body-frame velocity course and the target ray. This retains the
    # inherited near-capture mechanism while avoiding dimensional slip gains.
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

    # Estimate arrival from normalized target clearance and observed closing
    # speed. The gate is exactly zero during broad travel or while receding,
    # unlike the earlier distance-only holds that weakened the middle approach.
    raw_distance = Float64(state.distance_L)
    distance_L = isfinite(raw_distance) ? max(raw_distance, 0.0) : Inf
    raw_closing_speed = Float64(state.window_closing_speed_L)
    closing_speed_L = isfinite(raw_closing_speed) ? clamp(
        raw_closing_speed,
        0.0,
        params.closing_speed_limit_L,
    ) : 0.0
    clearance_L = max(distance_L - params.capture_radius_L, 0.0)
    time_to_capture_T = closing_speed_L > eps(Float64) ?
        clearance_L / closing_speed_L : Inf
    arrival_fraction = isfinite(time_to_capture_T) ? clamp(
        (params.arrival_time_on_T - time_to_capture_T) /
        max(params.arrival_time_width_T, eps(Float64)),
        0.0,
        1.0,
    ) : 0.0
    arrival_gate = arrival_fraction^2 * (3.0 - 2.0 * arrival_fraction)
    carrier_scale = 1.0 - arrival_gate *
        (1.0 - params.arrival_carrier_floor)

    # Preserve the zero-centered carrier outside imminent arrival. On final
    # approach, bounded damping reduces rhythmic demand without moving the
    # oscillator center or increasing peak steering.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    arrival_damping = arrival_gate * params.arrival_head_damping * omega
    a1 = vdp_drive - omega^2 * q1 - arrival_damping * qd1

    mean_tail_tangent = params.turn_curvature_limit * turn_request
    carrier_tail_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    tail_target = mean_tail_tangent + carrier_scale * carrier_tail_target
    a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
