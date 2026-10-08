# Two-timescale posterior steering around the full state-feedback traveling
# wave. Slow route curvature and fast yaw recoil have independent soft bounds.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        steering_bearing_scale=0.30,
        steering_crossflow_scale=0.25,
        steering_crossflow_weight=0.75,
        steering_course_speed_scale=0.20,
        steering_course_error_scale=0.80,
        steering_course_error_weight=0.55,
        course_bearing_window=0.30,
        route_curvature_limit=12.0 * pi / 180,
        yaw_recoil_rate_scale=1.0,
        yaw_recoil_curvature_limit=5.0 * pi / 180,
        actuation_soft_limit=1800.0 * pi / 180,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Keep the anterior carrier target-independent. Static and gated anterior
    # recentering both lost useful translation in the sampled rollouts.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1_raw = vdp_drive - omega^2 * q1

    bearing_value = Float64(state.bearing)
    bearing = isfinite(bearing_value) ? bearing_value : 0.0
    crossflow_value = Float64(state.relative_flow_velocity_body_U[2])
    crossflow = isfinite(crossflow_value) ? crossflow_value : 0.0

    # Target-to-velocity angle predicts centerline crossing without a world
    # route. It remains silent near rest and outside the alignment window.
    target_x_value = Float64(state.target_body_L[1])
    target_y_value = Float64(state.target_body_L[2])
    velocity_x_value = Float64(state.velocity_body_U[1])
    velocity_y_value = Float64(state.velocity_body_U[2])
    target_x = isfinite(target_x_value) ? target_x_value : 0.0
    target_y = isfinite(target_y_value) ? target_y_value : 0.0
    velocity_x = isfinite(velocity_x_value) ? velocity_x_value : 0.0
    velocity_y = isfinite(velocity_y_value) ? velocity_y_value : 0.0
    velocity_norm = hypot(velocity_x, velocity_y)
    course_cross = target_x * velocity_y - target_y * velocity_x
    course_dot = target_x * velocity_x + target_y * velocity_y
    course_error = velocity_norm > eps(Float64) ?
        clamp(atan(course_cross, course_dot), -pi / 2, pi / 2) : 0.0
    forward_speed = max(-velocity_x, 0.0)
    course_speed_gate = tanh(
        forward_speed /
        max(params.steering_course_speed_scale, eps(Float64)),
    )^2
    alignment_ratio = abs(bearing) /
        max(params.course_bearing_window, eps(Float64))
    centerline_gate = 1 / (1 + alignment_ratio^4)
    course_brake = params.steering_course_error_weight *
        course_speed_gate * centerline_gate * tanh(
            course_error /
            max(params.steering_course_error_scale, eps(Float64)),
        )

    # Slow geometry and slip retain the strongest sampled route mechanism.
    # Their curvature saturates independently of the fast measured response.
    route_state =
        bearing / max(params.steering_bearing_scale, eps(Float64)) +
        params.steering_crossflow_weight * tanh(
            crossflow /
            max(params.steering_crossflow_scale, eps(Float64)),
        ) +
        course_brake
    route_curvature = params.route_curvature_limit * tanh(route_state)

    # In this sign convention, posterior curvature with the same sign as yaw
    # opposes that yaw. A separate bounded channel reinforces an unanswered
    # route turn but releases it as soon as corrective yaw appears; unlike the
    # inherited single saturation, route authority cannot mask this response.
    yaw_rate_value = Float64(state.turn_rate_recent)
    yaw_rate = isfinite(yaw_rate_value) ? yaw_rate_value : 0.0
    yaw_recoil_curvature = params.yaw_recoil_curvature_limit * tanh(
        yaw_rate / max(params.yaw_recoil_rate_scale, eps(Float64)),
    )
    mean_tail_tangent = route_curvature + yaw_recoil_curvature

    # Preserve every component of the full posterior lagged wave. Only its
    # bounded mean tangent changes with target and measured yaw response.
    posterior_wave =
        -q1 - params.tail_lag_gain * qd1 / max(omega, eps(omega))
    tail_target = mean_tail_tangent + posterior_wave
    a2_raw = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    accel_limit = params.actuation_soft_limit
    a1 = accel_limit * tanh(a1_raw / accel_limit)
    a2 = accel_limit * tanh(a2_raw / accel_limit)

    return (phi_ddot=(a1, a2),)
end
