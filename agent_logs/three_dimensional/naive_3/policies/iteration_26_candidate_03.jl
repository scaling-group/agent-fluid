# Turn-response-deficit burst around the evidenced course-response C-turn.
# Oscillation phase remains entirely in measured joint state.

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
        phase_distance_scale=3.6,
        phase_distance_power=12.0,
        phase_speed_scale=0.25,
        phase_error_scale=0.60,
        phase_velocity_scale=0.65,
        maximum_tail_lag_shift=0.50,
        redirect_forward_threshold=0.10,
        redirect_forward_scale=0.08,
        redirect_lateral_scale=0.35,
        response_distance_scale=4.8,
        response_distance_power=8.0,
        response_speed_scale=0.25,
        response_course_dot_threshold=0.05,
        response_course_dot_scale=0.15,
        response_direction_scale=0.60,
        maximum_response_curvature=8.0 * pi / 180,
        burst_course_error_threshold=1.0,
        burst_course_error_scale=0.20,
        burst_turn_response_threshold=0.55,
        burst_turn_response_scale=0.15,
        maximum_anterior_burst_curvature=5.0 * pi / 180,
        maximum_redirect_curvature=18.0 * pi / 180,
        redirect_tail_share=1.05,
        redirect_wave_floor=0.45,
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

    # Compare the body-frame target ray with translational course. Unlike raw
    # yaw, this error persists across gait half-cycles. The speed weight removes
    # the undefined zero-velocity direction continuously.
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

    # Acute cruise bearing intentionally preserves the evidenced first pass,
    # but it cannot distinguish a lateral target from one already behind the
    # head. Full target direction therefore selects a separate recovery
    # topology only after normalized forward projection becomes negative.
    target_forward = -target_unit_x
    direction_error = atan(target_y, -target_x)
    redirect_weight = 0.5 * (1 + tanh(
        (-target_forward - params.redirect_forward_threshold) /
            params.redirect_forward_scale,
    ))
    redirect_direction = tanh(
        target_unit_y / params.redirect_lateral_scale,
    )
    base_redirect_curvature = -params.maximum_redirect_curvature *
        redirect_direction

    # Preserve the sampled course-response reserve: a nearby target that is
    # fully behind and tangent or receding adds curvature without removing the
    # proven redirect or its traveling-wave carrier.
    response_distance_weight = 1 / (1 +
        (distance / params.response_distance_scale)^params.response_distance_power)
    response_speed_ratio = speed / (speed + params.response_speed_scale)
    response_speed_weight = response_speed_ratio^2
    nonclosing_course_weight = 0.5 * (1 + tanh(
        (params.response_course_dot_threshold - course_dot) /
            params.response_course_dot_scale,
    ))
    response_direction = tanh(
        course_error / params.response_direction_scale,
    )
    response_weight = redirect_weight^2 * response_distance_weight *
        response_speed_weight * nonclosing_course_weight
    response_curvature = -params.maximum_response_curvature *
        response_weight * response_direction
    redirect_curvature = base_redirect_curvature + response_curvature

    # The closest sampled pass retains large course error while useful yaw is
    # weak. Add a transient anterior C-bend only for that measured response
    # deficit, then release it as yaw develops in the requested turn direction.
    # The signed product and curvature both mirror with target geometry.
    large_course_error_weight = 0.5 * (1 + tanh(
        (abs(course_error) - params.burst_course_error_threshold) /
            params.burst_course_error_scale,
    ))
    useful_turn_response = -response_direction * heading_rate
    turn_response_deficit_weight = 0.5 * (1 + tanh(
        (params.burst_turn_response_threshold - useful_turn_response) /
            params.burst_turn_response_scale,
    ))
    burst_weight = redirect_weight^2 * response_distance_weight *
        response_speed_weight * large_course_error_weight *
        turn_response_deficit_weight
    burst_curvature = -params.maximum_anterior_burst_curvature *
        burst_weight * response_direction
    anterior_redirect_curvature = redirect_curvature + burst_curvature
    anterior_mean = (1 - redirect_weight) * mean_curvature +
        redirect_weight * anterior_redirect_curvature
    redirect_wave_scale = 1 -
        (1 - params.redirect_wave_floor) * redirect_weight

    # During recovery the anterior equilibrium receives the transient burst,
    # while the posterior equilibrium below retains the sampled course-response
    # turn. Releasing the burst therefore returns relative authority to the
    # posteriorly lagged wave without a clock or hidden maneuver stage.
    centered_q1 = q1 - anterior_mean
    effective_amp = max(redirect_wave_scale * amp, eps(Float64))
    vdp_drive = params.oscillator_mu *
        (1 - (centered_q1 / effective_amp)^2) * qd1
    raw_a1 = vdp_drive - omega^2 * centered_q1

    # Gross misalignment attenuates posterior thrust without removing its mean
    # steering curvature. Alignment continuously restores the full lagged wave.
    normalized_bearing = bearing / params.alignment_bearing_scale
    posterior_wave_authority = params.posterior_wave_floor +
        (1 - params.posterior_wave_floor) / (1 + normalized_bearing^2)

    # During approach, weaken only the posterior wave half-cycle whose measured
    # yaw grows the signed full-direction error.
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

    # Preserve the evidenced joint-state phase modulation and posterior
    # course-response equilibrium; the new response-deficit burst is
    # intentionally anterior-only.
    normalized_joint_velocity = qd1 /
        max(params.phase_velocity_scale * omega * amp, eps(Float64))
    velocity_phase = tanh(course_direction * normalized_joint_velocity)
    modulated_tail_lag = params.tail_lag_gain +
        params.maximum_tail_lag_shift * phase_weight * velocity_phase
    tail_mean = (1 - redirect_weight) *
        params.tail_curvature_share * mean_curvature +
        redirect_weight * params.redirect_tail_share * redirect_curvature
    posterior_wave = -centered_q1 -
        modulated_tail_lag * qd1 / max(omega, eps(omega))
    phase_lag_target = tail_mean +
        propulsion_scale * posterior_wave_authority * redirect_wave_scale *
            posterior_wave
    raw_a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Keep deterministic reserve below the 1800 deg/T^2 episode hard limit.
    a1 = clamp(raw_a1, -params.command_limit, params.command_limit)
    a2 = clamp(raw_a2, -params.command_limit, params.command_limit)

    return (phi_ddot=(a1, a2),)
end
