# Speed-qualified course-to-yaw response tracking around the full
# crossflow-assisted traveling wave. Every signal is body-frame and clock-free.

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
        steering_yaw_rate_target=0.80,
        steering_yaw_rate_scale=1.0,
        steering_yaw_rate_weight=0.45,
        steering_curvature_limit=12.0 * pi / 180,
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

    bearing_value = Float64(state.bearing)
    bearing = isfinite(bearing_value) ? bearing_value : 0.0
    crossflow_value = Float64(state.relative_flow_velocity_body_U[2])
    crossflow = isfinite(crossflow_value) ? crossflow_value : 0.0

    # Compare the measured velocity direction with the target direction. The
    # cross-product order is velocity-to-target, so this correction has the
    # same turn convention as bearing. Speed qualification silences it near
    # rest without restricting it to a memorized route or rollout stage.
    target_x_value = Float64(state.target_body_L[1])
    target_y_value = Float64(state.target_body_L[2])
    velocity_x_value = Float64(state.velocity_body_U[1])
    velocity_y_value = Float64(state.velocity_body_U[2])
    target_x = isfinite(target_x_value) ? target_x_value : 0.0
    target_y = isfinite(target_y_value) ? target_y_value : 0.0
    velocity_x = isfinite(velocity_x_value) ? velocity_x_value : 0.0
    velocity_y = isfinite(velocity_y_value) ? velocity_y_value : 0.0
    target_norm = hypot(target_x, target_y)
    velocity_norm = hypot(velocity_x, velocity_y)
    course_cross = velocity_x * target_y - velocity_y * target_x
    course_dot = target_x * velocity_x + target_y * velocity_y
    course_error = target_norm > eps(Float64) &&
        velocity_norm > eps(Float64) ?
        clamp(atan(course_cross, course_dot), -pi / 2, pi / 2) : 0.0
    course_speed_gate = tanh(
        velocity_norm /
        max(params.steering_course_speed_scale, eps(Float64)),
    )^2
    course_signal = course_speed_gate * tanh(
        course_error /
        max(params.steering_course_error_scale, eps(Float64)),
    )

    # Body-frame route geometry requests a bounded yaw response. Comparing
    # that request with measured recent yaw rejects wrong-sign or excessive
    # rotation; adding raw yaw here would reinforce the sampled upper drift.
    route_turn_state =
        bearing / max(params.steering_bearing_scale, eps(Float64)) +
        params.steering_course_error_weight * course_signal
    route_turn_command = tanh(route_turn_state)
    desired_yaw_rate =
        params.steering_yaw_rate_target * route_turn_command
    yaw_rate_value = Float64(state.turn_rate_recent)
    yaw_rate = isfinite(yaw_rate_value) ? yaw_rate_value : 0.0
    yaw_response_error = tanh(
        (desired_yaw_rate - yaw_rate) /
        max(params.steering_yaw_rate_scale, eps(Float64)),
    )
    turn_state =
        route_turn_state +
        params.steering_crossflow_weight * tanh(
            crossflow /
            max(params.steering_crossflow_scale, eps(Float64)),
        ) +
        params.steering_yaw_rate_weight * yaw_response_error
    mean_tail_tangent = params.steering_curvature_limit * tanh(turn_state)

    # Preserve the evidenced anterior carrier instead of imposing another
    # approach bend or amplitude schedule.
    vdp_drive = params.oscillator_mu *
        (1 - (q1 / amp)^2) * qd1
    a1_raw = vdp_drive - omega^2 * q1

    # Apply direction tracking only to posterior mean curvature and retain the
    # complete state-derived lagged wave for propulsion.
    posterior_wave =
        -q1 - params.tail_lag_gain * qd1 / max(omega, eps(omega))
    phase_lag_target = mean_tail_tangent + posterior_wave
    a2_raw =
        omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    accel_limit = params.actuation_soft_limit
    a1 = accel_limit * tanh(a1_raw / accel_limit)
    a2 = accel_limit * tanh(a2_raw / accel_limit)

    return (phi_ddot=(a1, a2),)
end
