# Approach-localized course-error redirect around the evidenced target-response
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
        course_redirect_distance_scale=4.0,
        course_redirect_distance_power=10.0,
        course_speed_scale=0.25,
        course_error_threshold=0.45,
        course_error_activation_scale=0.16,
        course_direction_scale=0.55,
        maximum_course_curvature=4.0 * pi / 180,
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

    # Persistent target error asks for bounded average curvature. Measured yaw
    # releases the request as the body turns; all geometry is body-relative.
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
    bearing_curvature = params.maximum_mean_curvature *
        tanh(steering_error / params.curvature_error_scale)

    # The sampled near miss remains fast but its translational course is about
    # orthogonal to the target ray. Compare those two body-frame directions
    # directly, and request a bounded curvature burst only on approach. The
    # signal vanishes continuously with distance, speed, or course alignment.
    target_x = Float64(state.target_body_L[1])
    target_y = Float64(state.target_body_L[2])
    distance = max(Float64(state.distance_L), eps(Float64))
    target_norm = hypot(target_x, target_y)
    velocity_x = Float64(state.velocity_body_U[1])
    velocity_y = Float64(state.velocity_body_U[2])
    speed = hypot(velocity_x, velocity_y)
    target_direction = target_norm > eps(Float64) ?
        atan(target_y, -target_x) : 0.0
    course_direction = target_norm > eps(Float64) && speed > eps(Float64) ?
        atan(velocity_y, -velocity_x) : target_direction
    course_error = atan(
        sin(target_direction - course_direction),
        cos(target_direction - course_direction),
    )
    course_alignment_weight = 0.5 * (1 + tanh(
        (abs(course_error) - params.course_error_threshold) /
            params.course_error_activation_scale,
    ))
    course_speed_weight = speed^2 /
        (speed^2 + params.course_speed_scale^2)
    course_distance_weight = 1 / (1 +
        (distance / params.course_redirect_distance_scale)^
            params.course_redirect_distance_power)
    course_curvature = params.maximum_course_curvature *
        course_distance_weight * course_speed_weight *
        course_alignment_weight *
        tanh(course_error / params.course_direction_scale)
    mean_curvature = bearing_curvature + course_curvature

    # Preserve the sampled anterior state-feedback carrier and move only its
    # equilibrium. No clock, world coordinate, route, or case identity enters.
    centered_q1 = q1 - mean_curvature
    vdp_drive = params.oscillator_mu *
        (1 - (centered_q1 / amp)^2) * qd1
    raw_a1 = vdp_drive - omega^2 * centered_q1

    # Gross misalignment attenuates posterior thrust without removing its mean
    # steering curvature. Alignment continuously restores the full lagged wave.
    normalized_bearing = bearing / params.alignment_bearing_scale
    posterior_wave_authority = params.posterior_wave_floor +
        (1 - params.posterior_wave_floor) / (1 + normalized_bearing^2)

    # Full target direction retains the ahead/behind distinction hidden by the
    # acute bearing. During approach, weaken only the posterior wave half-cycle
    # whose measured yaw grows that signed direction error. Corrective yaw gets
    # the unmodified wave, so mean steering and useful propulsion remain.
    direction_error = target_direction
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

    # Retain the evidenced brake's posterior wave allocation. The geometric
    # redirect enters through the shared mean-curvature layer, rather than a
    # new posterior-only equilibrium, polarity change, or phase manipulation.
    tail_mean = params.tail_curvature_share * mean_curvature
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
