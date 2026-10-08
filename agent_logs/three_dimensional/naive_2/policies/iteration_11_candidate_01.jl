# Bearing-response release around the full crossflow-assisted traveling wave.
# Every route and response signal remains normalized and clock-free.

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
        course_alignment_exponent=4,
        anterior_course_curvature_limit=4.0 * pi / 180,
        steering_bearing_rate_scale=1.50,
        steering_response_release=0.45,
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

    # The target-to-velocity angle supplies the sampled anticipatory route
    # response. It is silent near rest and concentrated around a target-line
    # crossing, rather than encoding a world direction or a rollout stage.
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
    centerline_gate =
        1 / (1 + alignment_ratio^params.course_alignment_exponent)
    course_signal = course_speed_gate * centerline_gate * tanh(
        course_error /
        max(params.steering_course_error_scale, eps(Float64)),
    )
    course_brake = params.steering_course_error_weight * course_signal

    # Release only the slow route bias when measured target bearing is already
    # converging toward the body centerline. The signed product is continuous
    # through zero bearing, speed qualification suppresses near-rest noise,
    # and a worsening or stationary bearing receives the complete route term.
    bearing_rate_value = Float64(state.bearing_window_rate)
    bearing_rate = isfinite(bearing_rate_value) ? bearing_rate_value : 0.0
    bearing_command = tanh(
        bearing / max(params.steering_bearing_scale, eps(Float64)),
    )
    toward_center_rate = max(-bearing_command * bearing_rate, 0.0)
    response_gate = course_speed_gate * tanh(
        toward_center_rate /
        max(params.steering_bearing_rate_scale, eps(Float64)),
    )^2
    response_release = clamp(params.steering_response_release, 0.0, 1.0)
    route_state =
        bearing / max(params.steering_bearing_scale, eps(Float64)) +
        course_brake
    released_route_state =
        (1 - response_release * response_gate) * route_state

    # Fast crossflow and yaw rejection remain outside the response release so
    # it cannot switch off disturbance damping along with the route request.
    yaw_rate_value = Float64(state.turn_rate_recent)
    yaw_rate = isfinite(yaw_rate_value) ? yaw_rate_value : 0.0
    turn_state =
        released_route_state +
        params.steering_crossflow_weight * tanh(
            crossflow /
            max(params.steering_crossflow_scale, eps(Float64)),
        ) +
        params.steering_yaw_rate_weight * tanh(
            yaw_rate / max(params.steering_yaw_rate_scale, eps(Float64)),
        )
    mean_tail_tangent = params.steering_curvature_limit * tanh(turn_state)

    # Redistribute only the centerline course correction toward the anterior
    # joint. The small equilibrium shift is zero at rest and away from the
    # crossing window, preserving the zero-mean carrier elsewhere.
    head_course_center =
        params.anterior_course_curvature_limit * course_signal
    q1_carrier = q1 - head_course_center
    vdp_drive = params.oscillator_mu *
        (1 - (q1_carrier / amp)^2) * qd1
    a1_raw = vdp_drive - omega^2 * q1_carrier

    # Keep the complete posterior wave: completed drive- and half-cycle-relief
    # descendants lost approach distance without changing the upper-exit
    # topology. Response release acts only on posterior steering mean.
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
