# Closure-loss burst redirect around the actuator-calibrated traveling wave.
# Every route, response, and phase cue is body-frame, bounded, and clock-free.

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
        redirect_distance_scale=4.0,
        redirect_distance_exponent=4,
        redirect_closing_speed_scale=0.20,
        redirect_yaw_opposition_scale=0.35,
        redirect_halfcycle_wave_scale=0.25,
        redirect_halfcycle_modulation=0.30,
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

    # Route geometry and head-relative crossflow remain separate from the
    # measured yaw response. These are normalized observations, not a fixed
    # world direction or a memorized route.
    bearing_value = Float64(state.bearing)
    bearing = isfinite(bearing_value) ? bearing_value : 0.0
    crossflow_value = Float64(state.relative_flow_velocity_body_U[2])
    crossflow = isfinite(crossflow_value) ? crossflow_value : 0.0

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

    # Retain the empirically calibrated actuator-coordinate convention. The
    # target-cross-velocity angle is speed-qualified and concentrated near a
    # body-bearing crossing; physical yaw polarity is mapped explicitly below.
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
    centerline_gate = 1 / (
        1 + alignment_ratio^params.course_alignment_exponent
    )
    course_core = course_speed_gate * tanh(
        course_error /
        max(params.steering_course_error_scale, eps(Float64)),
    )
    course_signal = centerline_gate * course_core
    course_brake = params.steering_course_error_weight * course_signal

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

    # Redistribute the course correction without changing the anterior
    # oscillator amplitude, frequency, or phase. Near-target activation opens
    # this small anterior lever even after body bearing has crossed centerline.
    head_course_gate = centerline_gate +
        approach_gate * (1 - centerline_gate)
    head_course_center = params.anterior_course_curvature_limit *
        head_course_gate * course_core
    q1_carrier = q1 - head_course_center
    vdp_drive = params.oscillator_mu *
        (1 - (q1_carrier / amp)^2) * qd1
    a1_raw = vdp_drive - omega^2 * q1_carrier

    # Posterior curvature and physical yaw have opposite response signs in the
    # completed useful rollout. Feedback is actual minus mapped request; this
    # preserves that empirical actuator convention rather than assuming a
    # textbook geometric sign.
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

    # Preserve the complete lagged posterior carrier. A redirect becomes
    # available only when proximity, lost closure, and opposite-sign measured
    # yaw agree; positive closing or a correctly responding turn leaves the
    # waveform exactly unchanged.
    closing_speed_value = Float64(state.closing_speed_L)
    closing_speed = isfinite(closing_speed_value) ? closing_speed_value : Inf
    distance_ratio = distance /
        max(params.redirect_distance_scale, eps(Float64))
    proximity_gate = 1 / (
        1 + distance_ratio^params.redirect_distance_exponent
    )
    closure_loss_gate = tanh(
        max(-closing_speed, 0.0) /
        max(params.redirect_closing_speed_scale, eps(Float64)),
    )^2
    desired_yaw_direction = tanh(
        desired_yaw_rate /
        max(params.steering_yaw_rate_target, eps(Float64)),
    )
    measured_yaw_direction = tanh(
        yaw_rate /
        max(params.steering_yaw_rate_scale, eps(Float64)),
    )
    yaw_opposition = max(
        -desired_yaw_direction * measured_yaw_direction,
        0.0,
    )
    yaw_opposition_gate = tanh(
        yaw_opposition /
        max(params.redirect_yaw_opposition_scale, eps(Float64)),
    )^2
    redirect_gate = proximity_gate * closure_loss_gate *
        yaw_opposition_gate

    # Joint state supplies beat phase. Equal bounded amplification of the
    # favorable half-cycle and attenuation of the unfavorable half-cycle makes
    # the scale modulation symmetric while creating a transient turn-biased
    # waveform; no clock or static anterior curvature is introduced.
    posterior_wave =
        -q1 - params.tail_lag_gain * qd1 / max(omega, eps(omega))
    phase_side = tanh(
        posterior_wave /
        max(params.redirect_halfcycle_wave_scale, eps(Float64)),
    )
    redirect_strength = clamp(
        params.redirect_halfcycle_modulation,
        0.0,
        0.45,
    )
    phase_modulation =
        redirect_strength * redirect_gate *
        route_turn_command * phase_side
    tail_wave_scale = 1 + phase_modulation

    phase_lag_target =
        mean_tail_tangent + tail_wave_scale * posterior_wave
    a2_raw = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    accel_limit = params.actuation_soft_limit
    a1 = accel_limit * tanh(a1_raw / accel_limit)
    a2 = accel_limit * tanh(a2_raw / accel_limit)

    return (phi_ddot=(a1, a2),)
end
