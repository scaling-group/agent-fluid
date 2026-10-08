# Phase-separated propulsion with course-biased response-gated steering.
# Gait phase, target geometry, velocity, and yaw response are observed state.

function target_policy_params()
    return (
        control_period=0.90,
        oscillator_amplitude=18.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        bearing_limit=1.0,
        bearing_scale=0.35,
        max_turn_rate_ratio=0.04,
        course_error_limit=1.0,
        course_speed_scale=0.20,
        max_course_turn_rate_ratio=0.06,
        desired_yaw_ratio_limit=0.11,
        yaw_residual_ratio_limit=0.20,
        yaw_error_scale=0.04,
        phase_yaw_coupling=0.45,
        phase_velocity_scale=0.60,
        phase_pump_acceleration=6.0,
        half_cycle_acceleration=3.0,
        steering_angle_soft_limit=36.0 * pi / 180,
        headroom_exponent=4.0,
        acceleration_limit=30.0,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

    # Retain the sampled traveling-bend scaffold. The explicit symmetric pump
    # preserves the useful role that raw beat-frequency yaw accidentally played
    # in the strongest rollout, without treating it as a target response.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    carrier_a1 = vdp_drive - omega^2 * q1
    phase_velocity = tanh(
        qd1 /
        (max(omega * amp, eps(Float64)) * params.phase_velocity_scale),
    )
    phase_pump = params.phase_pump_acceleration * phase_velocity

    # Positive body-frame bearing calls for negative yaw. Once translation is
    # observable, the normalized velocity-target cross product supplies a slow
    # course-miss request. It biases desired yaw rather than directly selecting
    # a half-stroke, and fades continuously during launch.
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
    speed2 = velocity_x^2 + velocity_y^2
    course_error = clamp(
        (velocity_x * target_y - velocity_y * target_x) /
        max(sqrt(speed2) * target_distance, eps(Float64)),
        -params.course_error_limit,
        params.course_error_limit,
    )
    course_speed_scale2 = params.course_speed_scale^2
    course_weight = speed2 / (speed2 + course_speed_scale2)
    desired_yaw_ratio = clamp(
        -params.max_turn_rate_ratio *
            tanh(bearing / params.bearing_scale) +
        params.max_course_turn_rate_ratio * course_weight * course_error,
        -params.desired_yaw_ratio_limit,
        params.desired_yaw_ratio_limit,
    )

    # Subtract the phase-synchronous yaw component evidenced in the sampled
    # carrier before comparing response with the slow request. Positive
    # half-stroke selection was observed to produce negative slow yaw, hence
    # the response-error sign.
    yaw_residual_ratio = clamp(
        (
            Float64(state.heading_rate) +
            params.phase_yaw_coupling * qd1
        ) / max(omega, eps(Float64)),
        -params.yaw_residual_ratio_limit,
        params.yaw_residual_ratio_limit,
    )
    turn_side = tanh(
        (yaw_residual_ratio - desired_yaw_ratio) /
        params.yaw_error_scale,
    )
    half_cycle_drive = 0.5 * params.half_cycle_acceleration * (
        turn_side + abs(turn_side) * phase_velocity
    )

    # Fade added energy before the anterior hard limit. The restoring carrier
    # remains active so this gate cannot latch the joint at the soft boundary.
    angle_ratio = abs(q1) / params.steering_angle_soft_limit
    angle_headroom = clamp(
        1 - angle_ratio^params.headroom_exponent,
        0.0,
        1.0,
    )
    a1 = carrier_a1 + angle_headroom * (phase_pump + half_cycle_drive)

    # Preserve the posterior state-feedback lag that generated the coherent
    # three-dimensional wake in the strongest sampled rollout.
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
