# Course-responsive, phase-separated half-cycle steering.
# Gait phase, target geometry, and measured course come only from state.

function target_policy_params()
    return (
        control_period=0.90,
        oscillator_amplitude=18.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        bearing_limit=1.25,
        bearing_scale=0.40,
        max_bearing_turn_rate_ratio=0.04,
        course_error_limit=1.0,
        course_speed_scale=0.20,
        max_course_turn_rate_ratio=0.10,
        desired_turn_rate_ratio_limit=0.14,
        phase_yaw_velocity_gain=0.45,
        residual_turn_rate_limit=0.25,
        turn_rate_error_scale=0.04,
        phase_velocity_scale=0.60,
        phase_support_acceleration=5.0,
        half_cycle_steering_acceleration=5.0,
        steering_angle_soft_limit=40.0 * pi / 180,
        steering_speed_soft_limit=230.0 * pi / 180,
        headroom_exponent=4.0,
        acceleration_limit=28.0,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

    # Preserve the sampled state-feedback carrier and its lagged posterior
    # traveling bend. Joint state, rather than a clock, supplies gait phase.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    carrier_a1 = vdp_drive - omega^2 * q1
    phase_velocity = tanh(
        qd1 /
        (max(omega * amp, eps(Float64)) * params.phase_velocity_scale),
    )

    # Bearing observes body orientation, while this normalized cross product
    # observes whether the actual swimming course passes to one side of the
    # target. Suppress course direction before translation is established.
    bearing = clamp(
        Float64(state.bearing),
        -params.bearing_limit,
        params.bearing_limit,
    )
    target_x = Float64(state.target_body_L[1])
    target_y = Float64(state.target_body_L[2])
    velocity_x = Float64(state.velocity_body_U[1])
    velocity_y = Float64(state.velocity_body_U[2])
    target_distance = hypot(target_x, target_y)
    speed = hypot(velocity_x, velocity_y)
    course_error = clamp(
        (velocity_x * target_y - velocity_y * target_x) /
        max(speed * target_distance, eps(Float64)),
        -params.course_error_limit,
        params.course_error_limit,
    )
    speed_scale2 = params.course_speed_scale^2
    course_weight = speed^2 / (speed^2 + speed_scale2)
    desired_turn_rate_ratio = clamp(
        -params.max_bearing_turn_rate_ratio *
            tanh(bearing / params.bearing_scale) +
        params.max_course_turn_rate_ratio * course_weight * course_error,
        -params.desired_turn_rate_ratio_limit,
        params.desired_turn_rate_ratio_limit,
    )

    # Remove the sampled gait-synchronous component before evaluating slow yaw
    # response. The error sign matches the descendant in which a negative
    # half-stroke selector produced the useful positive-yaw correction.
    residual_turn_rate_ratio = clamp(
        (
            Float64(state.heading_rate) +
            params.phase_yaw_velocity_gain * qd1
        ) / max(omega, eps(Float64)),
        -params.residual_turn_rate_limit,
        params.residual_turn_rate_limit,
    )
    turn_side = tanh(
        (residual_turn_rate_ratio - desired_turn_rate_ratio) /
        params.turn_rate_error_scale,
    )

    # Keep the explicit symmetric phase support that sustained the alternating
    # wake, then allocate bounded extra authority to only the requested
    # half-cycle. Both fade before sampled anterior angle and speed limits.
    angle_ratio = abs(q1) / params.steering_angle_soft_limit
    speed_ratio = abs(qd1) / params.steering_speed_soft_limit
    angle_headroom = clamp(
        1 - angle_ratio^params.headroom_exponent,
        0.0,
        1.0,
    )
    speed_headroom = clamp(
        1 - speed_ratio^params.headroom_exponent,
        0.0,
        1.0,
    )
    extra_headroom = min(angle_headroom, speed_headroom)
    phase_support = params.phase_support_acceleration * phase_velocity
    half_cycle_steering = 0.5 * params.half_cycle_steering_acceleration * (
        turn_side + abs(turn_side) * phase_velocity
    )
    a1 = carrier_a1 +
        extra_headroom * (phase_support + half_cycle_steering)

    tail_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(Float64))
    a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    limit = params.acceleration_limit
    return (
        phi_ddot=(
            clamp(a1, -limit, limit),
            clamp(a2, -limit, limit),
        ),
    )
end
