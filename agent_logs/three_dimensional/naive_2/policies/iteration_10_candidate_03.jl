# Response-gated anterior redirect around the inherited approach-asymmetric
# posterior wave. Every route, response, and phase cue is body-frame and clock-free.

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
        anterior_redirect_curvature_limit=4.0 * pi / 180,
        anterior_redirect_direction_scale=0.50,
        tail_halfcycle_wave_scale=0.25,
        tail_opposing_halfcycle_relief=0.35,
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

    # Target-to-velocity course error supplies translational response rather
    # than an inertial route. It is silent near rest and speed qualified.
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
    course_core = course_speed_gate * tanh(
        course_error /
        max(params.steering_course_error_scale, eps(Float64)),
    )
    alignment_ratio = abs(bearing) /
        max(params.course_bearing_window, eps(Float64))
    centerline_gate = 1 / (
        1 + alignment_ratio^params.course_alignment_exponent
    )
    course_signal = centerline_gate * course_core
    course_brake = params.steering_course_error_weight * course_signal

    # Preserve the inherited approach schedule. It relaxes the small-bearing
    # window on the tested four-degree course redistribution and gates both
    # response redirect and posterior half-cycle steering.
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
    approach_gate =
        approach_progress^2 * (3 - 2 * approach_progress)
    head_course_gate = centerline_gate +
        approach_gate * (1 - centerline_gate)
    head_course_center = params.anterior_course_curvature_limit *
        head_course_gate * course_core

    # Add a response-localized C-start-like redirect only when bearing and
    # measured course agree on the turn direction. Their disagreement or
    # restored alignment releases it, avoiding a persistent anterior bend.
    bearing_command = tanh(
        bearing / max(params.steering_bearing_scale, eps(Float64)),
    )
    route_agreement = max(bearing_command * course_core, 0.0)
    redirect_gate = approach_gate * sqrt(route_agreement)
    redirect_direction = tanh(
        (bearing_command + course_core) /
        max(params.anterior_redirect_direction_scale, eps(Float64)),
    )
    response_redirect =
        params.anterior_redirect_curvature_limit *
        redirect_gate * redirect_direction
    q1_carrier = q1 - head_course_center - response_redirect

    # The full oscillator remains active around its transient equilibrium.
    # The posterior wave uses actual q1, so extra anterior curvature is
    # redistributed rather than added to the bounded tail-end steering mean.
    vdp_drive = params.oscillator_mu *
        (1 - (q1_carrier / amp)^2) * qd1
    a1_raw = vdp_drive - omega^2 * q1_carrier

    # Slow route geometry is separated from fast crossflow and yaw rejection.
    # The route command also identifies the useful posterior bend half-cycle.
    route_turn_state =
        bearing / max(params.steering_bearing_scale, eps(Float64)) +
        course_brake
    route_turn_command = tanh(route_turn_state)
    yaw_rate_value = Float64(state.turn_rate_recent)
    yaw_rate = isfinite(yaw_rate_value) ? yaw_rate_value : 0.0
    turn_state =
        route_turn_state +
        params.steering_crossflow_weight * tanh(
            crossflow /
            max(params.steering_crossflow_scale, eps(Float64)),
        ) +
        params.steering_yaw_rate_weight * tanh(
            yaw_rate / max(params.steering_yaw_rate_scale, eps(Float64)),
        )
    mean_tail_tangent = params.steering_curvature_limit * tanh(turn_state)

    # Retain the best inherited posterior actuator: on approach, attenuate
    # only the wave half-cycle opposing the slow route request.
    tail_wave =
        -q1 - params.tail_lag_gain * qd1 / max(omega, eps(omega))
    phase_side = tanh(
        tail_wave /
        max(params.tail_halfcycle_wave_scale, eps(Float64)),
    )
    opposing_halfcycle_gate = 0.5 * abs(route_turn_command) *
        (1 - route_turn_command * phase_side)
    opposing_relief = clamp(
        params.tail_opposing_halfcycle_relief,
        0.0,
        1.0,
    )
    tail_wave_scale = 1 -
        opposing_relief * approach_gate * opposing_halfcycle_gate
    phase_lag_target =
        mean_tail_tangent + tail_wave_scale * tail_wave
    a2_raw = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    accel_limit = params.actuation_soft_limit
    a1 = accel_limit * tanh(a1_raw / accel_limit)
    a2 = accel_limit * tanh(a2_raw / accel_limit)

    return (phi_ddot=(a1, a2),)
end
