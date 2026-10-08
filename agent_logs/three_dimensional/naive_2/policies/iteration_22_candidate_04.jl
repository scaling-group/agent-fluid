# Joint-phase-demodulated bearing, yaw, and lateral-response tracking around
# a full-amplitude carrier. Every cue is body-frame and clock-free.

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
        tail_yaw_deficit_scale=0.50,
        tail_yaw_deficit_extra_relief=0.20,
        steering_yaw_rate_target=0.80,
        steering_yaw_rate_scale=1.0,
        steering_yaw_rate_weight=0.45,
        yaw_phase_angle_gain=1.25,
        yaw_phase_velocity_gain=0.55,
        bearing_phase_angle_gain=-0.92,
        bearing_phase_velocity_gain=-0.022,
        lateral_phase_angle_gain=-0.72,
        lateral_phase_velocity_gain=-0.13,
        steering_curvature_limit=12.0 * pi / 180,
        actuation_soft_limit=1800.0 * pi / 180,
        joint_speed_limit=260.0 * pi / 180,
        speed_guard_start_fraction=0.99,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Bearing supplies route geometry. Head-relative crossflow is read here,
    # then separated from the carrier's own lateral motion below.
    bearing_value = Float64(state.bearing)
    bearing = isfinite(bearing_value) ? bearing_value : 0.0
    crossflow_value = Float64(state.relative_flow_velocity_body_U[2])
    crossflow = isfinite(crossflow_value) ? crossflow_value : 0.0

    # The target-to-velocity angle predicts translational route crossing. It
    # is silent near rest and smoothly concentrated near the target line, so
    # it brakes a delayed turn without replacing far-error bearing authority
    # or reacting to a fixed world direction.
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
    raw_course_cross = target_x * velocity_y - target_y * velocity_x
    raw_course_dot = target_x * velocity_x + target_y * velocity_y
    raw_course_error = target_norm > eps(Float64) &&
        velocity_norm > eps(Float64) ?
        clamp(atan(raw_course_cross, raw_course_dot), -pi / 2, pi / 2) : 0.0
    forward_speed = max(-velocity_x, 0.0)
    course_speed_gate = tanh(
        forward_speed /
        max(params.steering_course_speed_scale, eps(Float64)),
    )^2
    alignment_ratio = abs(bearing) /
        max(params.course_bearing_window, eps(Float64))
    raw_course_core = course_speed_gate * tanh(
        raw_course_error /
        max(params.steering_course_error_scale, eps(Float64)),
    )
    centerline_gate = 1 / (
        1 + alignment_ratio^params.course_alignment_exponent
    )
    # Retain the assigned parent's bounded anterior lever. Its bearing window
    # and raw course signal exactly. This keeps the evidenced head-carrier
    # interaction outside the new posterior-response experiment.
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
        head_course_gate * raw_course_core
    q1_carrier = q1 - head_course_center
    vdp_drive = params.oscillator_mu *
        (1 - (q1_carrier / amp)^2) * qd1
    a1_raw = vdp_drive - omega^2 * q1_carrier

    # Measured bearing contains the same fast body-heading excursion that the
    # yaw observer removes from measured turn rate. Reconstruct that bearing
    # component from the centered carrier state and remove it only on
    # approach. Raw bearing still owns the anterior centerline gate, while the
    # residual below selects the slower posterior route response.
    carrier_bearing =
        params.bearing_phase_angle_gain * q1_carrier +
        params.bearing_phase_velocity_gain * qd1
    directional_bearing = clamp(
        bearing - approach_gate * carrier_bearing,
        -pi / 2,
        pi / 2,
    )

    # The nominal capture trace shows that anterior phase explains almost all
    # body-lateral velocity on approach. Reconstruct that internally generated
    # sway from the mean-removed carrier coordinate, then use only its residual
    # in posterior course and crossflow feedback. The approach gate preserves
    # the demonstrated far route and makes the fit active where it was stable.
    carrier_sway = approach_gate * (
        params.lateral_phase_angle_gain * q1_carrier +
        params.lateral_phase_velocity_gain * qd1
    )
    directional_velocity_y = velocity_y - carrier_sway
    directional_crossflow = crossflow + carrier_sway
    directional_velocity_norm = hypot(velocity_x, directional_velocity_y)
    course_cross =
        target_x * directional_velocity_y - target_y * velocity_x
    course_dot =
        target_x * velocity_x + target_y * directional_velocity_y
    course_error = target_norm > eps(Float64) &&
        directional_velocity_norm > eps(Float64) ?
        clamp(atan(course_cross, course_dot), -pi / 2, pi / 2) : 0.0
    course_core = course_speed_gate * tanh(
        course_error /
        max(params.steering_course_error_scale, eps(Float64)),
    )
    course_signal = centerline_gate * course_core
    course_brake = params.steering_course_error_weight * course_signal

    # Keep slow route geometry separate from residual slip and yaw response.
    # The slow request also identifies the useful posterior bend half-cycle.
    route_turn_state =
        directional_bearing /
        max(params.steering_bearing_scale, eps(Float64)) +
        course_brake
    route_turn_command = tanh(route_turn_state)

    # Completed trajectories show that most short-window yaw is the rhythmic
    # response to anterior joint phase. Reconstruct that response from the
    # mean-removed carrier coordinate so the slow approach-course center is
    # retained as directional response rather than subtracted as beat phase.
    # The compensation is state-derived, reflection-equivariant, and contains
    # no external clock or memorized route.
    yaw_rate_value = Float64(state.turn_rate_recent)
    yaw_rate = isfinite(yaw_rate_value) ? yaw_rate_value : 0.0
    carrier_yaw_rate =
        params.yaw_phase_angle_gain * q1_carrier -
        params.yaw_phase_velocity_gain * qd1
    directional_yaw_rate = yaw_rate - carrier_yaw_rate
    desired_yaw_rate =
        -params.steering_yaw_rate_target * route_turn_command
    yaw_response_error = tanh(
        (directional_yaw_rate - desired_yaw_rate) /
        max(params.steering_yaw_rate_scale, eps(Float64)),
    )
    turn_state =
        route_turn_state +
        params.steering_crossflow_weight * tanh(
            directional_crossflow /
            max(params.steering_crossflow_scale, eps(Float64)),
        ) +
        params.steering_yaw_rate_weight * yaw_response_error
    mean_tail_tangent = params.steering_curvature_limit * tanh(turn_state)

    # Infer beat side from the state-derived posterior wave. Only the
    # half-cycle opposing the slow route request is attenuated; the useful
    # excursion is never amplified and the anterior carrier remains intact.
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
    base_relief = clamp(
        params.tail_opposing_halfcycle_relief,
        0.0,
        1.0,
    ) * course_activation

    # Recruit limited extra phase-selective authority only when the
    # phase-demodulated physical response is short of the route-dependent yaw
    # request. Correct or excessive response releases the addition smoothly.
    directional_deficit = sqrt(max(
        route_turn_command * yaw_response_error,
        0.0,
    ))
    yaw_deficit_gate = course_speed_gate * tanh(
        directional_deficit /
        max(params.tail_yaw_deficit_scale, eps(Float64)),
    )^2
    deficit_relief = clamp(
        params.tail_yaw_deficit_extra_relief,
        0.0,
        1.0,
    ) * yaw_deficit_gate
    total_relief = clamp(base_relief + deficit_relief, 0.0, 1.0)
    tail_wave_scale = 1 - total_relief * opposing_halfcycle_gate
    phase_lag_target = mean_tail_tangent + tail_wave_scale * tail_wave
    a2_raw = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Stay smoothly inside the released acceleration envelope.
    accel_limit = params.actuation_soft_limit
    a1_bounded = accel_limit * tanh(a1_raw / accel_limit)
    a2_bounded = accel_limit * tanh(a2_raw / accel_limit)

    # The completed parent spends long intervals at the released joint-speed
    # boundary while still requesting acceleration farther outward. Project
    # only that infeasible component away in a narrow normalized guard band.
    # Inward acceleration remains untouched so neither beat reversal nor
    # steering recovery is delayed.
    speed_limit = max(abs(params.joint_speed_limit), eps(Float64))
    guard_start = clamp(
        params.speed_guard_start_fraction,
        0.0,
        1 - eps(Float64),
    )
    guard_span = max(1 - guard_start, eps(Float64))
    guard_progress1 = clamp(
        (abs(qd1) / speed_limit - guard_start) / guard_span,
        0.0,
        1.0,
    )
    guard_progress2 = clamp(
        (abs(qd2) / speed_limit - guard_start) / guard_span,
        0.0,
        1.0,
    )
    speed_guard1 = guard_progress1^2 * (3 - 2 * guard_progress1)
    speed_guard2 = guard_progress2^2 * (3 - 2 * guard_progress2)
    direction1 = sign(qd1)
    direction2 = sign(qd2)
    outward_a1 = direction1 * max(direction1 * a1_bounded, 0.0)
    outward_a2 = direction2 * max(direction2 * a2_bounded, 0.0)
    a1 = a1_bounded - speed_guard1 * outward_a1
    a2 = a2_bounded - speed_guard2 * outward_a2

    return (phi_ddot=(a1, a2),)
end
