# Predicted-miss-gated anterior course redistribution around the full
# crossflow-assisted traveling wave. All navigation cues are body-frame.

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
        intercept_closing_speed_scale=0.25,
        intercept_miss_distance_scale=1.5,
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

    # Bearing supplies route geometry. Head-relative crossflow retains the
    # sampled slip residual that improved distance and survival.
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
    centerline_gate = 1 /
        (1 + alignment_ratio^params.course_alignment_exponent)
    course_core = course_speed_gate * tanh(
        course_error /
        max(params.steering_course_error_scale, eps(Float64)),
    )
    course_response = centerline_gate * course_core
    course_brake =
        params.steering_course_error_weight * course_response

    # Preserve the sampled distance-gated four-degree approach redirect. It is
    # negligible far away, then smoothly retains anterior course authority
    # after closest approach even when the target is strongly lateral.
    distance_value = Float64(state.distance_L)
    distance = isfinite(distance_value) ? max(distance_value, 0.0) : Inf
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

    # Constant-course projected miss distance detects a developing near miss
    # before range alone enters the approach gate. Closing, miss, and speed
    # gates are even under reflection; signed course supplies bend direction
    # and releases the transient redirect when velocity aligns to the target.
    closing_speed = target_norm > eps(Float64) ?
        max(course_dot / target_norm, 0.0) : 0.0
    projected_miss = velocity_norm > eps(Float64) ?
        abs(course_cross) / velocity_norm : 0.0
    closing_gate = tanh(
        closing_speed /
        max(params.intercept_closing_speed_scale, eps(Float64)),
    )^2
    miss_gate = tanh(
        projected_miss /
        max(params.intercept_miss_distance_scale, eps(Float64)),
    )^2
    intercept_gate = course_speed_gate * closing_gate * miss_gate

    # Smoothly union centerline, near-target, and predicted-miss authority.
    # Only the distribution of curvature changes: the posterior endpoint
    # request below remains referenced to the actual anterior angle.
    head_course_gate = 1 -
        (1 - centerline_gate) *
        (1 - approach_gate) *
        (1 - intercept_gate)
    head_course_center = params.anterior_course_curvature_limit *
        head_course_gate * course_core
    q1_carrier = q1 - head_course_center
    vdp_drive = params.oscillator_mu *
        (1 - (q1_carrier / amp)^2) * qd1
    a1_raw = vdp_drive - omega^2 * q1_carrier

    yaw_rate_value = Float64(state.turn_rate_recent)
    yaw_rate = isfinite(yaw_rate_value) ? yaw_rate_value : 0.0
    turn_state =
        bearing / max(params.steering_bearing_scale, eps(Float64)) +
        params.steering_crossflow_weight * tanh(
            crossflow /
            max(params.steering_crossflow_scale, eps(Float64)),
        ) +
        course_brake +
        params.steering_yaw_rate_weight * tanh(
            yaw_rate / max(params.steering_yaw_rate_scale, eps(Float64)),
        )
    mean_tail_tangent = params.steering_curvature_limit * tanh(turn_state)

    # Steering remains a bounded posterior mean. Referencing actual q1
    # redistributes the transient head correction without adding endpoint
    # curvature, and the complete lagged propulsive wave remains intact.
    phase_lag_target = mean_tail_tangent - q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2_raw = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Stay smoothly inside the released acceleration envelope.
    accel_limit = params.actuation_soft_limit
    a1 = accel_limit * tanh(a1_raw / accel_limit)
    a2 = accel_limit * tanh(a2_raw / accel_limit)

    return (phi_ddot=(a1, a2),)
end
