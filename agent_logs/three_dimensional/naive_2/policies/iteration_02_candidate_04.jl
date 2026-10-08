# Course-aware half-cycle tail steering around the naive state-feedback gait.
# Oscillator phase remains in joint state; no clock or world route is used.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        bearing_scale=0.30,
        course_speed_scale=0.20,
        course_error_scale=0.80,
        course_error_weight=0.75,
        yaw_rate_scale=1.5,
        yaw_rate_weight=0.35,
        tail_halfcycle_asymmetry=0.36,
        tail_target_limit=42.0 * pi / 180,
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

    # Preserve the anterior carrier; sampled static anterior curvature sharply
    # reduced joint speed and useful translation.
    q1_ratio = q1 / max(amp, eps(Float64))
    vdp_drive = params.oscillator_mu * (1 - q1_ratio^2) * qd1
    a1_raw = vdp_drive - omega^2 * q1

    bearing = Float64(state.bearing)
    bearing = isfinite(bearing) ? clamp(bearing, -1.4, 1.4) : 0.0

    target_x = Float64(state.target_body_L[1])
    target_y = Float64(state.target_body_L[2])
    velocity_x = Float64(state.velocity_body_U[1])
    velocity_y = Float64(state.velocity_body_U[2])
    target_x = isfinite(target_x) ? target_x : 0.0
    target_y = isfinite(target_y) ? target_y : 0.0
    velocity_x = isfinite(velocity_x) ? velocity_x : 0.0
    velocity_y = isfinite(velocity_y) ? velocity_y : 0.0

    # The angle from target displacement to actual velocity is invariant to
    # world rotation. Ignore it near rest, where velocity direction is noisy.
    speed = hypot(velocity_x, velocity_y)
    course_cross = target_x * velocity_y - target_y * velocity_x
    course_dot = target_x * velocity_x + target_y * velocity_y
    course_error = speed > eps(Float64) ?
        clamp(atan(course_cross, course_dot), -pi / 2, pi / 2) : 0.0
    course_gate = tanh(
        speed / max(params.course_speed_scale, eps(Float64)),
    )^2

    yaw_rate = Float64(state.turn_rate_recent)
    yaw_rate = isfinite(yaw_rate) ? yaw_rate : 0.0
    turn_state =
        bearing / max(params.bearing_scale, eps(Float64)) +
        params.course_error_weight * course_gate * tanh(
            course_error / max(params.course_error_scale, eps(Float64)),
        ) +
        params.yaw_rate_weight * tanh(
            yaw_rate / max(params.yaw_rate_scale, eps(Float64)),
        )
    turn_command = tanh(turn_state)

    # Asymmetric posterior half-cycles create a mean turning moment while
    # retaining wave reversal and lag. This replaces a static curvature hold.
    posterior_wave =
        -q1 - params.tail_lag_gain * qd1 / max(omega, eps(omega))
    tail_target = posterior_wave +
        params.tail_halfcycle_asymmetry * turn_command * abs(posterior_wave)
    tail_target = clamp(
        tail_target,
        -params.tail_target_limit,
        params.tail_target_limit,
    )
    a2_raw =
        omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    accel_limit = params.actuation_soft_limit
    a1 = accel_limit * tanh(a1_raw / accel_limit)
    a2 = accel_limit * tanh(a2_raw / accel_limit)

    return (phi_ddot=(a1, a2),)
end
