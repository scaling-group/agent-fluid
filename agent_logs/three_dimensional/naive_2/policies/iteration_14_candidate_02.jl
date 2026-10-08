# Response-released anterior half-cycle damping around the empirically
# calibrated yaw-tracking carrier. Every cue is normalized and clock-free.

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
        anterior_response_distance_scale_L=4.0,
        anterior_response_forward_scale_L=2.0,
        anterior_response_gate_exponent=4,
        anterior_halfcycle_phase_scale=0.20,
        anterior_opposing_damping_ratio=0.12,
        steering_yaw_rate_target=0.80,
        steering_yaw_rate_scale=1.0,
        steering_yaw_rate_weight=0.45,
        steering_curvature_limit=12.0 * pi / 180,
        tail_halfcycle_wave_scale=0.25,
        tail_course_activation_scale=0.50,
        tail_opposing_halfcycle_relief=0.35,
        tail_yaw_deficit_scale=0.50,
        tail_yaw_deficit_extra_relief=0.20,
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
    course_command = course_speed_gate * tanh(
        course_error /
        max(params.steering_course_error_scale, eps(Float64)),
    )
    course_signal = centerline_gate * course_command
    course_brake = params.steering_course_error_weight * course_signal

    # Posterior curvature and physical yaw have opposite useful request
    # conventions in the completed deep-approach rollouts. Track actual minus
    # mapped requested yaw so wrong-sign response is restorative.
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
    mean_tail_tangent = params.steering_curvature_limit * tanh(turn_state)

    # Retain the bounded approach-aware course redistribution that precedes
    # the deep inherited approach. It widens continuously only after distance
    # progress and does not reduce anterior carrier amplitude.
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
        head_course_gate * course_command
    q1_carrier = q1 - head_course_center

    # Gate both phase-selective actuators with a calibrated directional
    # deficit. Correct or excessive physical yaw makes the gate exactly zero.
    directional_deficit = sqrt(max(
        route_turn_command * yaw_response_error,
        0.0,
    ))
    yaw_deficit_gate = course_speed_gate * tanh(
        directional_deficit /
        max(params.tail_yaw_deficit_scale, eps(Float64)),
    )^2

    # The failed parent displaced the anterior equilibrium. Instead, damp only
    # entry into the counter-turning anterior half-cycle near the lateral pass.
    # This dissipative pulse clips one excursion without amplifying the useful
    # stroke, delaying its return, or changing the oscillator's equilibrium.
    response_distance_ratio = distance / max(
        params.anterior_response_distance_scale_L,
        eps(Float64),
    )
    response_proximity_gate = 1 / (
        1 + response_distance_ratio^params.anterior_response_gate_exponent
    )
    forward_target = max(-target_x, 0.0)
    response_forward_ratio = forward_target / max(
        params.anterior_response_forward_scale_L,
        eps(Float64),
    )
    response_abreast_gate = 1 / (
        1 + response_forward_ratio^params.anterior_response_gate_exponent
    )
    anterior_phase_scale = max(
        params.anterior_halfcycle_phase_scale,
        eps(Float64),
    )
    head_position_side = tanh(q1_carrier / anterior_phase_scale)
    head_velocity_side = tanh(
        qd1 / max(omega * anterior_phase_scale, eps(Float64)),
    )
    opposing_head_position_gate = 0.5 * abs(route_turn_command) *
        (1 - route_turn_command * head_position_side)
    entering_opposing_velocity_gate = 0.5 *
        (1 - route_turn_command * head_velocity_side)
    anterior_response_gate =
        response_proximity_gate * response_abreast_gate *
        yaw_deficit_gate * opposing_head_position_gate *
        entering_opposing_velocity_gate
    vdp_drive = params.oscillator_mu *
        (1 - (q1_carrier / amp)^2) * qd1
    opposing_damping = 2 * params.anterior_opposing_damping_ratio *
        omega * anterior_response_gate * qd1
    a1_raw = vdp_drive - omega^2 * q1_carrier - opposing_damping

    # Preserve the stronger inherited posterior state-derived lag and limited
    # response-deficit half-cycle relief. The new mechanism does not retune it.
    tail_wave =
        -q1 - params.tail_lag_gain * qd1 / max(omega, eps(omega))
    phase_side = tanh(
        tail_wave /
        max(params.tail_halfcycle_wave_scale, eps(Float64)),
    )
    opposing_halfcycle_gate = 0.5 * abs(route_turn_command) *
        (1 - route_turn_command * phase_side)
    course_activation = tanh(
        abs(course_command) /
        max(params.tail_course_activation_scale, eps(Float64)),
    )^2
    base_relief = clamp(
        params.tail_opposing_halfcycle_relief,
        0.0,
        1.0,
    ) * course_activation
    deficit_relief = clamp(
        params.tail_yaw_deficit_extra_relief,
        0.0,
        1.0,
    ) * yaw_deficit_gate
    total_relief = clamp(base_relief + deficit_relief, 0.0, 1.0)
    tail_wave_scale = 1 - total_relief * opposing_halfcycle_gate
    phase_lag_target =
        mean_tail_tangent + tail_wave_scale * tail_wave
    a2_raw =
        omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    accel_limit = params.actuation_soft_limit
    a1 = accel_limit * tanh(a1_raw / accel_limit)
    a2 = accel_limit * tanh(a2_raw / accel_limit)

    return (phi_ddot=(a1, a2),)
end
