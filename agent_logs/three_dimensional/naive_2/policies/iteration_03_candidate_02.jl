# Course-damped posterior mean-curvature steering for the 3D moving-window
# lane. Oscillator phase remains in joint state; route feedback uses only
# normalized body-frame geometry, velocity, and measured yaw response.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        steering_bearing_scale=0.30,
        steering_course_speed_scale=0.20,
        steering_course_error_scale=0.80,
        steering_course_error_weight=0.75,
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

    # Preserve the anterior propulsive carrier. Static anterior centering
    # suppressed joint speed and useful translation in the sampled failures.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1_raw = vdp_drive - omega^2 * q1

    bearing = Float64(state.bearing)
    bearing = isfinite(bearing) ? bearing : 0.0

    target_x = Float64(state.target_body_L[1])
    target_y = Float64(state.target_body_L[2])
    velocity_x = Float64(state.velocity_body_U[1])
    velocity_y = Float64(state.velocity_body_U[2])
    target_x = isfinite(target_x) ? target_x : 0.0
    target_y = isfinite(target_y) ? target_y : 0.0
    velocity_x = isfinite(velocity_x) ? velocity_x : 0.0
    velocity_y = isfinite(velocity_y) ? velocity_y : 0.0

    # Signed target-to-velocity angle is invariant to world rotation. The
    # fish's head is on the negative body-x axis, so gate this cue by forward
    # speed and ignore lateral beat velocity or backward motion near release.
    course_cross = target_x * velocity_y - target_y * velocity_x
    course_dot = target_x * velocity_x + target_y * velocity_y
    velocity_norm = hypot(velocity_x, velocity_y)
    course_error = velocity_norm > eps(Float64) ?
        clamp(atan(course_cross, course_dot), -pi / 2, pi / 2) : 0.0
    forward_speed = max(-velocity_x, 0.0)
    course_gate = tanh(
        forward_speed /
        max(params.steering_course_speed_scale, eps(Float64)),
    )^2

    yaw_rate = Float64(state.turn_rate_recent)
    yaw_rate = isfinite(yaw_rate) ? yaw_rate : 0.0

    # Bearing supplies the low-speed route request. Course error corrects
    # accumulated translational slip only after forward motion is established,
    # while yaw response damps continued rotation through the target line.
    turn_state =
        bearing / max(params.steering_bearing_scale, eps(Float64)) +
        params.steering_course_error_weight * course_gate * tanh(
            course_error /
            max(params.steering_course_error_scale, eps(Float64)),
        ) +
        params.steering_yaw_rate_weight * tanh(
            yaw_rate /
            max(params.steering_yaw_rate_scale, eps(Float64)),
        )
    mean_tail_tangent = params.steering_curvature_limit * tanh(turn_state)

    # Apply steering through the posterior mean tangent, the only sampled
    # actuator translation that materially improved distance while retaining
    # the alternating anterior carrier and posterior phase lag.
    phase_lag_target =
        mean_tail_tangent - q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2_raw = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    accel_limit = params.actuation_soft_limit
    a1 = accel_limit * tanh(a1_raw / accel_limit)
    a2 = accel_limit * tanh(a2_raw / accel_limit)

    return (phi_ddot=(a1, a2),)
end
