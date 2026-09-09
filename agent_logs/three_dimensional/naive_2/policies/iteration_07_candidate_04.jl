# Rotation-invariant velocity-course steering on a traveling-bend carrier.
# Target and translational course select the half-cycle bias while resolved
# closing motion exists; the evidenced propulsive carrier is never relieved.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        maximum_bearing=pi / 2,
        maximum_lateral_velocity=1.0,
        lateral_velocity_gain=0.8,
        maximum_course_error=pi / 2,
        minimum_target_range=0.25,
        course_speed_softness=0.2,
        closing_alignment_softness=0.2,
        steering_softness=0.35,
        carrier_yaw_head_rate_gain=0.65,
        carrier_yaw_tail_rate_gain=0.22,
        maximum_yaw_residual=0.5,
        yaw_residual_gain=0.6,
        cruise_half_cycle_asymmetry=0.35,
        redirect_half_cycle_asymmetry=0.65,
        wrong_side_slip_scale=0.08,
        head_asymmetry_share=0.65,
        tail_asymmetry_share=1.0,
        maximum_joint_acceleration=30.0,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Preserve the clean finite sample's anterior state-feedback oscillator
    # and posterior lag. Steering changes neither carrier scale nor frequency.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    carrier_a1 = vdp_drive - omega^2 * q1
    phase_lag_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    carrier_a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    fallback_bearing = isfinite(state.bearing) ?
        Float64(state.bearing) : 0.0
    target_x = isfinite(state.target_body_L[1]) ?
        Float64(state.target_body_L[1]) : -1.0
    target_y = isfinite(state.target_body_L[2]) ?
        Float64(state.target_body_L[2]) : 0.0
    velocity_x = isfinite(state.velocity_body_U[1]) ?
        Float64(state.velocity_body_U[1]) : 0.0
    velocity_y = isfinite(state.velocity_body_U[2]) ?
        Float64(state.velocity_body_U[2]) : 0.0
    heading_rate = isfinite(state.heading_rate) ?
        Float64(state.heading_rate) : 0.0

    bounded_bearing = clamp(
        fallback_bearing,
        -params.maximum_bearing,
        params.maximum_bearing,
    )
    bounded_lateral_velocity = clamp(
        velocity_y,
        -params.maximum_lateral_velocity,
        params.maximum_lateral_velocity,
    )
    body_route_signal = bounded_bearing -
        params.lateral_velocity_gain * bounded_lateral_velocity

    # The signed angle between target vector and translational velocity is
    # unchanged by their common body-frame rotation. It therefore measures a
    # collision-course error without inheriting the beat-correlated body yaw.
    # target x velocity has the steering sign used by the sampled half-cycle
    # controller; target dot velocity distinguishes closing from receding.
    target_norm = max(
        hypot(target_x, target_y),
        params.minimum_target_range,
    )
    speed = hypot(velocity_x, velocity_y)
    course_scale = target_norm * max(speed, eps(Float64))
    normalized_course_dot = clamp(
        (target_x * velocity_x + target_y * velocity_y) / course_scale,
        -1.0,
        1.0,
    )
    normalized_course_cross = clamp(
        (target_x * velocity_y - target_y * velocity_x) / course_scale,
        -1.0,
        1.0,
    )
    course_error = speed > eps(Float64) ?
        atan(normalized_course_cross, normalized_course_dot) : 0.0
    bounded_course_error = clamp(
        course_error,
        -params.maximum_course_error,
        params.maximum_course_error,
    )

    # At release, velocity direction is unresolved, so retain the inherited
    # body-bearing/slip request. Resolved positive closing projection blends
    # smoothly to course interception; a receding course releases the blend
    # rather than sustaining the sampled terminal U-turn.
    speed_weight = speed / (speed + params.course_speed_softness)
    closing_weight = 0.5 * (
        1 + tanh(
            normalized_course_dot /
            max(params.closing_alignment_softness, eps(Float64)),
        )
    )
    course_weight = speed_weight * closing_weight
    route_signal = (1 - course_weight) * body_route_signal +
        course_weight * bounded_course_error

    # Remove the evidenced joint-phase-correlated yaw before using measured
    # yaw as directional response. Correct response releases steering and
    # wrong-sign response reinforces it without damping the carrier itself.
    carrier_phase_yaw_rate =
        -params.carrier_yaw_head_rate_gain * qd1 -
        params.carrier_yaw_tail_rate_gain * qd2
    yaw_residual = clamp(
        heading_rate - carrier_phase_yaw_rate,
        -params.maximum_yaw_residual,
        params.maximum_yaw_residual,
    )
    turn_signal = route_signal + params.yaw_residual_gain * yaw_residual
    turn_request = tanh(
        turn_signal / max(params.steering_softness, eps(Float64)),
    )

    # Retain the sampled response gate and shared-joint beat asymmetry. The
    # course mechanism changes the persistent route request, not the carrier
    # or its actuator envelope.
    wrong_side_slip = max(
        -bounded_bearing * bounded_lateral_velocity,
        0.0,
    )
    redirect_gate = tanh(
        wrong_side_slip / max(params.wrong_side_slip_scale, eps(Float64)),
    )
    asymmetry_limit = params.cruise_half_cycle_asymmetry +
        redirect_gate * (
            params.redirect_half_cycle_asymmetry -
            params.cruise_half_cycle_asymmetry
        )
    asymmetry = asymmetry_limit * turn_request

    raw_a1 = carrier_a1 +
        params.head_asymmetry_share * asymmetry * abs(carrier_a1)
    raw_a2 = carrier_a2 +
        params.tail_asymmetry_share * asymmetry * abs(carrier_a2)
    limit = params.maximum_joint_acceleration
    bounded_a1 = limit * tanh(raw_a1 / limit)
    bounded_a2 = limit * tanh(raw_a2 / limit)

    return (
        phi_ddot=(bounded_a1, bounded_a2),
    )
end
