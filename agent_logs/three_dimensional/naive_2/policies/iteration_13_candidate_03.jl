# Closure-loss burst redirect around the actuator-calibrated yaw-response
# carrier. Every route, response, and terminal cue is body-frame and clock-free.

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
        approach_start_distance_L=6.5,
        approach_full_distance_L=3.0,
        tail_halfcycle_wave_scale=0.25,
        tail_course_activation_scale=0.50,
        tail_opposing_halfcycle_relief=0.35,
        steering_yaw_rate_target=0.80,
        steering_yaw_rate_scale=1.0,
        steering_yaw_rate_weight=0.45,
        steering_curvature_limit=12.0 * pi / 180,
        terminal_redirect_distance_scale=4.0,
        terminal_redirect_distance_exponent=4,
        terminal_closing_speed_scale=0.20,
        terminal_redirect_curvature_limit=8.0 * pi / 180,
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
    target_norm = hypot(target_x, target_y)
    velocity_norm = hypot(velocity_x, velocity_y)
    course_cross = target_x * velocity_y - target_y * velocity_x
    course_dot = target_x * velocity_x + target_y * velocity_y
    course_error = target_norm > eps(Float64) &&
        velocity_norm > eps(Float64) ?
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
    course_core = course_speed_gate * tanh(
        course_error /
        max(params.steering_course_error_scale, eps(Float64)),
    )
    course_signal = centerline_gate * course_core
    course_brake = params.steering_course_error_weight * course_signal

    # Retain the bounded anterior lever from the inherited deep approach. It
    # redistributes course correction without reducing oscillator amplitude.
    distance_value = Float64(state.distance_L)
    distance = isfinite(distance_value) && distance_value >= 0.0 ?
        distance_value : Inf
    approach_span = max(
        params.approach_start_distance_L -
        params.approach_full_distance_L,
        eps(Float64),
    )
    approach_progress = clamp(
        (params.approach_start_distance_L - distance) / approach_span,
        0.0,
        1.0,
    )
    approach_gate = approach_progress^2 * (3 - 2 * approach_progress)
    head_course_gate = centerline_gate +
        approach_gate * (1 - centerline_gate)
    head_course_center = params.anterior_course_curvature_limit *
        head_course_gate * course_core
    q1_carrier = q1 - head_course_center
    vdp_drive = params.oscillator_mu *
        (1 - (q1_carrier / amp)^2) * qd1
    a1_raw = vdp_drive - omega^2 * q1_carrier

    # Posterior curvature and physical yaw use the empirically calibrated
    # opposite request conventions. Feedback regulates response to the route
    # request instead of indiscriminately damping all yaw toward zero.
    route_turn_state =
        bearing / max(params.steering_bearing_scale, eps(Float64)) +
        course_brake
    route_turn_command = tanh(route_turn_state)
    desired_yaw_rate =
        -params.steering_yaw_rate_target * route_turn_command
    yaw_rate_value = Float64(state.turn_rate_recent)
    yaw_rate = isfinite(yaw_rate_value) ? yaw_rate_value : 0.0
    yaw_response_error = tanh(
        (yaw_rate - desired_yaw_rate) /
        max(params.steering_yaw_rate_scale, eps(Float64)),
    )
    turn_state =
        route_turn_state +
        params.steering_crossflow_weight * tanh(
            crossflow /
            max(params.steering_crossflow_scale, eps(Float64)),
        ) +
        params.steering_yaw_rate_weight * yaw_response_error
    base_tail_tangent = params.steering_curvature_limit * tanh(turn_state)

    # Infer beat side from joint state and attenuate only the half-cycle that
    # opposes the requested turn. This inherited phase-compatible channel
    # neither amplifies a stroke nor alters the anterior carrier.
    tail_wave =
        -q1 - params.tail_lag_gain * qd1 / max(omega, eps(omega))
    phase_side = tanh(
        tail_wave /
        max(params.tail_halfcycle_wave_scale, eps(Float64)),
    )
    opposing_halfcycle_gate = 0.5 * abs(route_turn_command) *
        (1 - route_turn_command * phase_side)
    course_activation = tanh(
        abs(course_core) /
        max(params.tail_course_activation_scale, eps(Float64)),
    )^2
    opposing_relief = clamp(
        params.tail_opposing_halfcycle_relief,
        0.0,
        1.0,
    )
    tail_wave_scale = 1 -
        opposing_relief * course_activation * opposing_halfcycle_gate

    # A body-frame target--velocity projection is a smoother closure cue than
    # the failed one-step head-distance derivative. When proximity, lost
    # radial closure, and a large course residual agree, add a bounded burst
    # to posterior mean curvature. The full wave is never relieved, and the
    # burst releases continuously as targetward closure returns.
    radial_closing_speed = target_norm > eps(Float64) ?
        course_dot / target_norm : 0.0
    distance_ratio = distance /
        max(params.terminal_redirect_distance_scale, eps(Float64))
    proximity_gate = 1 / (
        1 + distance_ratio^params.terminal_redirect_distance_exponent
    )
    closure_deficit_gate = 0.5 * (1 - tanh(
        radial_closing_speed /
        max(params.terminal_closing_speed_scale, eps(Float64)),
    ))
    redirect_gate = proximity_gate * closure_deficit_gate * abs(course_core)
    redirect_curvature =
        params.terminal_redirect_curvature_limit *
        redirect_gate * course_core
    combined_curvature_limit =
        params.steering_curvature_limit +
        params.terminal_redirect_curvature_limit
    mean_tail_tangent = clamp(
        base_tail_tangent + redirect_curvature,
        -combined_curvature_limit,
        combined_curvature_limit,
    )

    phase_lag_target = mean_tail_tangent + tail_wave_scale * tail_wave
    a2_raw =
        omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    accel_limit = params.actuation_soft_limit
    a1 = accel_limit * tanh(a1_raw / accel_limit)
    a2 = accel_limit * tanh(a2_raw / accel_limit)

    return (phi_ddot=(a1, a2),)
end
