# Course-selected differential S-bend around the evidenced response-gated
# brake. Oscillation phase remains entirely in measured joint state.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        maximum_mean_curvature=7.0 * pi / 180,
        curvature_error_scale=0.45,
        bearing_limit=1.0,
        heading_rate_damping=0.18,
        heading_rate_limit=4.0,
        tail_curvature_share=0.8,
        alignment_bearing_scale=0.60,
        posterior_wave_floor=0.35,
        approach_distance_scale=3.2,
        approach_distance_power=8.0,
        lateral_direction_threshold=0.60,
        lateral_direction_scale=0.15,
        wrong_way_yaw_threshold=0.75,
        wrong_way_yaw_scale=0.25,
        posterior_brake_floor=0.35,
        course_redirect_distance_scale=3.6,
        course_redirect_distance_power=12.0,
        course_speed_scale=0.25,
        course_error_threshold=0.45,
        course_error_transition=0.20,
        course_error_scale=0.60,
        maximum_course_redirect=6.0 * pi / 180,
        posterior_course_countershare=0.5,
        command_limit=28.0,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

    # Preserve the evidenced cruise curvature and its measured-yaw damping.
    bearing = clamp(
        Float64(state.bearing),
        -params.bearing_limit,
        params.bearing_limit,
    )
    heading_rate = clamp(
        Float64(state.heading_rate),
        -params.heading_rate_limit,
        params.heading_rate_limit,
    )
    steering_error = bearing - params.heading_rate_damping * heading_rate
    cruise_curvature = params.maximum_mean_curvature *
        tanh(steering_error / params.curvature_error_scale)

    # Translational course is a slower response signal than beat-locked yaw.
    # Compare normalized body-frame target and velocity directions, then gate
    # the redirect away from cruise and the undefined zero-speed limit.
    target_x = Float64(state.target_body_L[1])
    target_y = Float64(state.target_body_L[2])
    velocity_x = Float64(state.velocity_body_U[1])
    velocity_y = Float64(state.velocity_body_U[2])
    target_norm = max(hypot(target_x, target_y), eps(Float64))
    speed = hypot(velocity_x, velocity_y)
    velocity_norm = max(speed, eps(Float64))
    target_unit_x = target_x / target_norm
    target_unit_y = target_y / target_norm
    velocity_unit_x = velocity_x / velocity_norm
    velocity_unit_y = velocity_y / velocity_norm
    course_cross = target_unit_x * velocity_unit_y -
        target_unit_y * velocity_unit_x
    course_dot = target_unit_x * velocity_unit_x +
        target_unit_y * velocity_unit_y
    course_error = atan(course_cross, course_dot)

    distance = max(Float64(state.distance_L), eps(Float64))
    course_approach_weight = 1 / (1 +
        (distance / params.course_redirect_distance_scale)^
            params.course_redirect_distance_power)
    speed_ratio = speed / (speed + params.course_speed_scale)
    course_speed_weight = speed_ratio^2
    course_error_weight = 0.5 * (1 + tanh(
        (abs(course_error) - params.course_error_threshold) /
            params.course_error_transition,
    ))
    course_redirect = params.maximum_course_redirect *
        course_approach_weight * course_speed_weight * course_error_weight *
        tanh(course_error / params.course_error_scale)

    # The assigned parent's shared course bend retained the lower-exit miss.
    # Route the same bounded request differentially: anterior curvature turns
    # the body while an opposite posterior equilibrium forms an S-bend.
    anterior_curvature_limit = params.maximum_mean_curvature +
        params.maximum_course_redirect
    anterior_curvature = clamp(
        cruise_curvature + course_redirect,
        -anterior_curvature_limit,
        anterior_curvature_limit,
    )
    centered_q1 = q1 - anterior_curvature
    vdp_drive = params.oscillator_mu *
        (1 - (centered_q1 / amp)^2) * qd1
    raw_a1 = vdp_drive - omega^2 * centered_q1

    # Preserve the alignment-gated traveling wave and the measured-yaw brake.
    normalized_bearing = bearing / params.alignment_bearing_scale
    posterior_wave_authority = params.posterior_wave_floor +
        (1 - params.posterior_wave_floor) / (1 + normalized_bearing^2)
    direction_error = atan(target_y, -target_x)
    direction_sign = tanh(
        direction_error / params.curvature_error_scale,
    )
    lateral_weight = 0.5 * (1 + tanh(
        (abs(direction_error) - params.lateral_direction_threshold) /
            params.lateral_direction_scale,
    ))
    wrong_way_yaw = max(direction_sign * heading_rate, 0.0)
    wrong_way_weight = 0.5 * (1 + tanh(
        (wrong_way_yaw - params.wrong_way_yaw_threshold) /
            params.wrong_way_yaw_scale,
    ))
    approach_weight = 1 / (1 +
        (distance / params.approach_distance_scale)^params.approach_distance_power)
    brake_weight = approach_weight * lateral_weight * wrong_way_weight
    propulsion_scale = 1 -
        (1 - params.posterior_brake_floor) * brake_weight

    tail_mean = params.tail_curvature_share * cruise_curvature -
        params.posterior_course_countershare * course_redirect
    posterior_wave = -centered_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    phase_lag_target = tail_mean +
        propulsion_scale * posterior_wave_authority * posterior_wave
    raw_a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Keep deterministic reserve below the 1800 deg/T^2 episode hard limit.
    a1 = clamp(raw_a1, -params.command_limit, params.command_limit)
    a2 = clamp(raw_a2, -params.command_limit, params.command_limit)
    return (phi_ddot=(a1, a2),)
end
