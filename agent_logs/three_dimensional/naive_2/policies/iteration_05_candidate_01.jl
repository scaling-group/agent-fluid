# Course-braked posterior mean steering with a large-error anterior
# half-cycle residual. Oscillator phase remains entirely in joint state.

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
        steering_yaw_rate_scale=1.0,
        steering_yaw_rate_weight=0.45,
        steering_curvature_limit=12.0 * pi / 180,
        head_halfcycle_bearing_scale=0.35,
        head_halfcycle_gate_exponent=4,
        head_halfcycle_asymmetry=0.25,
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

    # Keep the sampled zero-centered carrier: target feedback never enters the
    # Van der Pol energy term, so the gait remains clock-free and self-excited.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1

    bearing_value = Float64(state.bearing)
    bearing = isfinite(bearing_value) ? bearing_value : 0.0
    crossflow_value = Float64(state.relative_flow_velocity_body_U[2])
    crossflow = isfinite(crossflow_value) ? crossflow_value : 0.0

    # Construct a rotation-invariant angle between the target vector and the
    # actual swimming course. It is silent near rest and concentrated near the
    # target centerline, where the sampled course brake improved turn arrest.
    target_x_value = Float64(state.target_body_L[1])
    target_y_value = Float64(state.target_body_L[2])
    velocity_x_value = Float64(state.velocity_body_U[1])
    velocity_y_value = Float64(state.velocity_body_U[2])
    target_x = isfinite(target_x_value) ? target_x_value : 0.0
    target_y = isfinite(target_y_value) ? target_y_value : 0.0
    velocity_x = isfinite(velocity_x_value) ? velocity_x_value : 0.0
    velocity_y = isfinite(velocity_y_value) ? velocity_y_value : 0.0
    velocity_norm = hypot(velocity_x, velocity_y)
    course_cross = target_x * velocity_y - target_y * velocity_x
    course_dot = target_x * velocity_x + target_y * velocity_y
    course_error = velocity_norm > eps(Float64) ?
        clamp(atan(course_cross, course_dot), -pi / 2, pi / 2) : 0.0
    forward_speed = max(-velocity_x, 0.0)
    course_speed_gate = tanh(
        forward_speed /
        max(params.steering_course_speed_scale, eps(Float64)),
    )^2
    alignment_ratio = abs(bearing) /
        max(params.course_bearing_window, eps(Float64))
    centerline_gate = 1 / (1 + alignment_ratio^4)
    course_brake = params.steering_course_error_weight *
        course_speed_gate * centerline_gate * tanh(
            course_error /
            max(params.steering_course_error_scale, eps(Float64)),
        )

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
    turn_command = tanh(turn_state)

    # Posterior mean curvature remains the proven sustained steering channel.
    # The complete lagged waveform is retained around the bounded mean target.
    mean_tail_tangent = params.steering_curvature_limit * turn_command
    phase_lag_target =
        mean_tail_tangent - q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2_raw = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Once route error is established, strengthen only the requested anterior
    # half-cycle. This perturbation is odd under reflection, vanishes at every
    # q1 zero crossing, and does not recenter either the energy term or tail
    # wave as the sampled static redirect did.
    head_error_ratio = abs(bearing) /
        max(params.head_halfcycle_bearing_scale, eps(Float64))
    head_error_power =
        head_error_ratio^params.head_halfcycle_gate_exponent
    head_error_gate = head_error_power / (1 + head_error_power)
    head_halfcycle_target =
        params.head_halfcycle_asymmetry *
        turn_command * head_error_gate * abs(q1)
    a1_raw = vdp_drive - omega^2 * (q1 - head_halfcycle_target)

    # Smoothly stay inside the released acceleration envelope.
    accel_limit = params.actuation_soft_limit
    a1 = accel_limit * tanh(a1_raw / accel_limit)
    a2 = accel_limit * tanh(a2_raw / accel_limit)

    return (phi_ddot=(a1, a2),)
end
