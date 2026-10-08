# Rear-sector response-following reacquisition around the empirically
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
        steering_yaw_rate_target=0.80,
        steering_yaw_rate_scale=1.0,
        steering_yaw_rate_weight=0.45,
        steering_curvature_limit=12.0 * pi / 180,
        reacquire_distance_scale_L=4.0,
        reacquire_distance_exponent=4,
        reacquire_rear_fraction_scale=0.20,
        reacquire_closing_speed_scale=0.20,
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

    # The calibrated route convention is posterior actuator coordinates:
    # useful physical yaw has the opposite sign. Establish the original
    # request and its measured response before deciding whether reacquisition
    # is allowed to choose the other U-turn branch.
    base_route_turn_state =
        bearing / max(params.steering_bearing_scale, eps(Float64)) +
        course_brake
    base_route_turn_command = tanh(base_route_turn_state)
    yaw_rate_value = Float64(state.turn_rate_recent)
    yaw_rate = isfinite(yaw_rate_value) ? yaw_rate_value : 0.0
    base_desired_yaw_rate =
        -params.steering_yaw_rate_target * base_route_turn_command
    base_yaw_response_error = tanh(
        (yaw_rate - base_desired_yaw_rate) /
        max(params.steering_yaw_rate_scale, eps(Float64)),
    )

    # Rear-sector response selection is exactly silent through the inherited
    # first approach. Once the target is behind and radial closure is lost, an
    # opposite response deficit permits the established physical yaw to select
    # a feasible U-turn. Returning the target forward releases this branch.
    distance_value = Float64(state.distance_L)
    distance = isfinite(distance_value) && distance_value >= 0.0 ?
        distance_value : Inf
    radial_closing_speed = target_norm > eps(Float64) ?
        course_dot / target_norm : 0.0
    rearward_fraction = target_norm > eps(Float64) ?
        max(target_x / target_norm, 0.0) : 0.0
    rear_sector_gate = tanh(
        rearward_fraction /
        max(params.reacquire_rear_fraction_scale, eps(Float64)),
    )^2
    reacquire_distance_ratio = distance /
        max(params.reacquire_distance_scale_L, eps(Float64))
    reacquire_proximity_gate = 1 / (
        1 + reacquire_distance_ratio^params.reacquire_distance_exponent
    )
    closure_loss_gate = 0.5 * (1 - tanh(
        radial_closing_speed /
        max(params.reacquire_closing_speed_scale, eps(Float64)),
    ))
    base_directional_deficit = sqrt(max(
        base_route_turn_command * base_yaw_response_error,
        0.0,
    ))
    base_response_deficit_gate = course_speed_gate * tanh(
        base_directional_deficit /
        max(params.tail_yaw_deficit_scale, eps(Float64)),
    )^2
    reacquire_gate = clamp(
        rear_sector_gate * reacquire_proximity_gate *
        closure_loss_gate * base_response_deficit_gate,
        0.0,
        1.0,
    )
    response_follow_command = -tanh(
        yaw_rate / max(params.steering_yaw_rate_scale, eps(Float64)),
    )
    route_turn_command = clamp(
        base_route_turn_command + reacquire_gate *
        (response_follow_command - base_route_turn_command),
        -1.0,
        1.0,
    )
    command_bound = 1 - sqrt(eps(Float64))
    route_turn_state = atanh(clamp(
        route_turn_command,
        -command_bound,
        command_bound,
    ))

    desired_yaw_rate =
        -params.steering_yaw_rate_target * route_turn_command
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

    # Retain the approach-aware anterior course lever, but release it toward
    # the full zero-mean oscillator while a rear-sector turn is selected. This
    # avoids stacking terminal static curvature on both joints.
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
        head_course_gate * course_command * (1 - reacquire_gate)
    q1_carrier = q1 - head_course_center
    vdp_drive = params.oscillator_mu *
        (1 - (q1_carrier / amp)^2) * qd1
    a1_raw = vdp_drive - omega^2 * q1_carrier

    # Joint state identifies posterior beat side. Preserve the inherited
    # course-gated half-cycle relief, and add response-deficit relief only when
    # the currently selected physical-yaw request is still underachieved.
    posterior_wave =
        -q1 - params.tail_lag_gain * qd1 / max(omega, eps(omega))
    phase_side = tanh(
        posterior_wave /
        max(params.tail_halfcycle_wave_scale, eps(Float64)),
    )
    opposing_halfcycle_gate = 0.5 * abs(route_turn_command) *
        (1 - route_turn_command * phase_side)
    course_activation = tanh(
        abs(course_command) /
        max(params.tail_course_activation_scale, eps(Float64)),
    )^2
    directional_deficit = sqrt(max(
        route_turn_command * yaw_response_error,
        0.0,
    ))
    yaw_deficit_gate = course_speed_gate * tanh(
        directional_deficit /
        max(params.tail_yaw_deficit_scale, eps(Float64)),
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
        mean_tail_tangent + tail_wave_scale * posterior_wave
    a2_raw =
        omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    accel_limit = params.actuation_soft_limit
    a1 = accel_limit * tanh(a1_raw / accel_limit)
    a2 = accel_limit * tanh(a2_raw / accel_limit)

    return (phi_ddot=(a1, a2),)
end
