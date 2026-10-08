# Rearward-response burst redirection around the actuator-calibrated
# yaw-tracking carrier. Every route and response cue is body-frame and clock-free.

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
        rearward_target_scale_L=0.50,
        redirect_radial_speed_scale=0.20,
        redirect_heading_error_scale=0.60,
        rearward_anterior_curvature_limit=8.0 * pi / 180,
        anterior_total_curvature_limit=12.0 * pi / 180,
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

    # Retain target x velocity as the evidenced actuator-coordinate course
    # residual. It is silent near rest and concentrated near the target line.
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

    # The e28 inherited rollout established the opposite mapping between an
    # actuator-coordinate posterior request and physical yaw. Track that
    # requested response rather than damping all useful yaw toward zero.
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

    # Preserve the approach-aware anterior course redistribution from the yaw
    # branch. It relaxes the bearing window continuously only near the target.
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

    # A missed pass is topologically distinct from ordinary course error.
    # Body-positive x points aft relative to swimming, so positive target_x
    # identifies a rearward target. Combine that observation with negative
    # target-projected translational velocity before applying a C-start-like
    # anterior redirect. The full target angle supplies only redirect sign;
    # its physical-yaw sign is mapped back into actuator coordinates.
    radial_closure = target_norm > eps(Float64) ?
        course_dot / target_norm : 0.0
    rearward_gate = 0.5 * (1 + tanh(
        target_x / max(params.rearward_target_scale_L, eps(Float64)),
    ))
    closure_deficit_gate = 0.5 * (1 - tanh(
        radial_closure /
        max(params.redirect_radial_speed_scale, eps(Float64)),
    ))
    physical_target_angle = target_norm > eps(Float64) ?
        atan(-target_y, -target_x) : 0.0
    actuator_redirect = tanh(
        -physical_target_angle /
        max(params.redirect_heading_error_scale, eps(Float64)),
    )
    rearward_head_center =
        params.rearward_anterior_curvature_limit *
        rearward_gate * closure_deficit_gate * actuator_redirect
    head_center = clamp(
        head_course_center + rearward_head_center,
        -params.anterior_total_curvature_limit,
        params.anterior_total_curvature_limit,
    )
    q1_carrier = q1 - head_center
    vdp_drive = params.oscillator_mu *
        (1 - (q1_carrier / amp)^2) * qd1
    a1_raw = vdp_drive - omega^2 * q1_carrier

    # Keep the yaw branch's phase-compatible posterior modulation unchanged.
    # The redirect shifts q1 while the -q1 posterior reference preserves the
    # requested endpoint mean and the traveling-wave relationship.
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
