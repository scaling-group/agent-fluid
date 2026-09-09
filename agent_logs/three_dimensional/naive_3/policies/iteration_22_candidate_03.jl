# Course-selected yaw-moment residual around the evidenced fixed-proximity
# posterior phase-lag scaffold. Oscillation phase remains in measured state.

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
        yaw_moment_limit=0.020,
        yaw_moment_scale=0.006,
        phase_distance_scale=3.6,
        phase_distance_power=12.0,
        phase_speed_scale=0.25,
        phase_error_scale=0.60,
        phase_velocity_scale=0.65,
        maximum_tail_lag_shift=0.50,
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
    mean_curvature = params.maximum_mean_curvature *
        tanh(steering_error / params.curvature_error_scale)

    # Compare the body-frame target ray with translational course. This slow
    # route error supplies direction while speed removes the stopped limit.
    target_x = Float64(state.target_body_L[1])
    target_y = Float64(state.target_body_L[2])
    velocity_x = Float64(state.velocity_body_U[1])
    velocity_y = Float64(state.velocity_body_U[2])
    distance = max(Float64(state.distance_L), eps(Float64))
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
    phase_approach_weight = 1 / (1 +
        (distance / params.phase_distance_scale)^params.phase_distance_power)
    speed_ratio = speed / (speed + params.phase_speed_scale)
    phase_speed_weight = speed_ratio^2
    phase_error_weight = tanh(
        abs(course_error) / params.phase_error_scale,
    )^2
    phase_weight = phase_approach_weight * phase_speed_weight *
        phase_error_weight
    course_direction = tanh(course_error / params.phase_error_scale)

    # Preserve the sampled anterior state-feedback carrier and move only its
    # equilibrium. No clock, world coordinate, route, or case identity enters.
    centered_q1 = q1 - mean_curvature
    vdp_drive = params.oscillator_mu *
        (1 - (centered_q1 / amp)^2) * qd1
    raw_a1 = vdp_drive - omega^2 * centered_q1

    # Gross misalignment attenuates posterior thrust without removing its mean
    # steering curvature. Alignment continuously restores the lagged wave.
    normalized_bearing = bearing / params.alignment_bearing_scale
    posterior_wave_authority = params.posterior_wave_floor +
        (1 - params.posterior_wave_floor) / (1 + normalized_bearing^2)

    # Retain the evidenced response-selected brake. Full target direction
    # distinguishes ahead from behind and signed yaw selects only the response
    # half-cycle that grows the direction error.
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
    yaw_brake_weight = approach_weight * lateral_weight * wrong_way_weight

    # Normalized hydrodynamic moment predicts the next yaw acceleration in all
    # sampled traces. Let the persistent course sign select only moment that
    # accelerates the miss. A smooth union anticipates the existing yaw brake
    # but never lowers posterior authority beneath its already tested floor.
    yaw_moment = clamp(
        Float64(state.moment_z_L2),
        -params.yaw_moment_limit,
        params.yaw_moment_limit,
    )
    wrong_way_moment = max(course_direction * yaw_moment, 0.0)
    moment_response_weight = tanh(
        wrong_way_moment / params.yaw_moment_scale,
    )^2
    moment_brake_weight = approach_weight * phase_speed_weight *
        phase_error_weight * moment_response_weight
    brake_weight = 1 - (1 - yaw_brake_weight) * (1 - moment_brake_weight)
    propulsion_scale = 1 -
        (1 - params.posterior_brake_floor) * brake_weight

    # Preserve the best sample's localized joint-state phase-lag action. The
    # course-direction/velocity product is reflection invariant, so mirrored
    # observations produce mirrored posterior targets and accelerations.
    normalized_joint_velocity = qd1 /
        max(params.phase_velocity_scale * omega * amp, eps(Float64))
    velocity_phase = tanh(course_direction * normalized_joint_velocity)
    modulated_tail_lag = params.tail_lag_gain +
        params.maximum_tail_lag_shift * phase_weight * velocity_phase
    tail_mean = params.tail_curvature_share * mean_curvature
    posterior_wave = -centered_q1 -
        modulated_tail_lag * qd1 / max(omega, eps(omega))
    phase_lag_target = tail_mean +
        propulsion_scale * posterior_wave_authority * posterior_wave
    raw_a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Keep deterministic reserve below the 1800 deg/T^2 episode hard limit.
    a1 = clamp(raw_a1, -params.command_limit, params.command_limit)
    a2 = clamp(raw_a2, -params.command_limit, params.command_limit)
    return (phi_ddot=(a1, a2),)
end
