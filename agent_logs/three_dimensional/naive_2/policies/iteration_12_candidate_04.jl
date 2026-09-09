# Traveling-bend carrier with a course-response redirect burst.
# Near a measured course miss, wrong-side yaw recruits bounded half-cycle
# authority; corrective yaw releases the burst without suppressing propulsion.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        maximum_direction_error=pi / 2,
        maximum_lateral_velocity=1.0,
        steering_softness=0.35,
        lateral_velocity_gain=0.8,
        carrier_yaw_head_rate_gain=0.65,
        carrier_yaw_tail_rate_gain=0.22,
        maximum_yaw_residual=0.5,
        yaw_residual_gain=0.6,
        course_speed_scale=0.25,
        course_error_scale=0.5,
        approach_distance=4.0,
        approach_softness=0.75,
        wrong_yaw_response_scale=0.08,
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

    # Preserve the evidenced state-feedback carrier and posterior lag.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    carrier_a1 = vdp_drive - omega^2 * q1
    phase_lag_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    carrier_a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    fallback_bearing = isfinite(state.bearing) ? Float64(state.bearing) : 0.0
    target_x = isfinite(state.target_body_L[1]) ?
        Float64(state.target_body_L[1]) : -1.0
    target_y = isfinite(state.target_body_L[2]) ?
        Float64(state.target_body_L[2]) : 0.0
    velocity_x = isfinite(state.velocity_body_U[1]) ?
        Float64(state.velocity_body_U[1]) : 0.0
    velocity_y = isfinite(state.velocity_body_U[2]) ?
        Float64(state.velocity_body_U[2]) : 0.0
    distance = isfinite(state.distance_L) ?
        max(Float64(state.distance_L), 0.0) :
        params.approach_distance + 4 * params.approach_softness
    heading_rate = isfinite(state.heading_rate) ?
        Float64(state.heading_rate) : 0.0

    # Body forward is -x.  Full-circle pursuit retains the fore/aft target
    # distinction, while the target-versus-velocity angle measures the actual
    # interception error independently of instantaneous body yaw.
    pursuit_bearing = isfinite(target_x) && isfinite(target_y) ?
        atan(target_y, -target_x) : fallback_bearing
    bounded_bearing = clamp(
        pursuit_bearing,
        -params.maximum_direction_error,
        params.maximum_direction_error,
    )
    target_norm = hypot(target_x, target_y)
    speed = hypot(velocity_x, velocity_y)
    raw_course_error = target_norm > eps(Float64) && speed > eps(Float64) ?
        atan(
            target_x * velocity_y - target_y * velocity_x,
            target_x * velocity_x + target_y * velocity_y,
        ) : bounded_bearing
    bounded_course_error = clamp(
        raw_course_error,
        -params.maximum_direction_error,
        params.maximum_direction_error,
    )
    bounded_lateral_velocity = clamp(
        velocity_y,
        -params.maximum_lateral_velocity,
        params.maximum_lateral_velocity,
    )

    # Use course only after translation establishes it and only in the region
    # where sampled pursuit policies begin their terminal miss.  The far-field
    # target response therefore remains the evidenced bearing controller.
    speed_gate = tanh(
        speed / max(params.course_speed_scale, eps(Float64)),
    )
    approach_gate = 0.5 * (
        1 + tanh(
            (params.approach_distance - distance) /
            max(params.approach_softness, eps(Float64)),
        )
    )
    course_weight = approach_gate * speed_gate
    direction_error = (1 - course_weight) * bounded_bearing +
        course_weight * bounded_course_error

    # Remove beat-correlated yaw before judging whether the redirect works.
    # Correct yaw has the opposite sign to the body-frame direction error and
    # releases the request; same-sign yaw is a wrong-side response.
    carrier_phase_yaw = -params.carrier_yaw_head_rate_gain * qd1 -
        params.carrier_yaw_tail_rate_gain * qd2
    yaw_residual = clamp(
        heading_rate - carrier_phase_yaw,
        -params.maximum_yaw_residual,
        params.maximum_yaw_residual,
    )
    turn_signal = direction_error -
        params.lateral_velocity_gain * bounded_lateral_velocity +
        params.yaw_residual_gain * yaw_residual
    turn_request = tanh(
        turn_signal / max(params.steering_softness, eps(Float64)),
    )

    # Preserve the established slip redirect outside the terminal region.  A
    # near off-course state recruits the same bounded half-cycle actuator only
    # while yaw remains on the wrong side, implementing response release rather
    # than another accumulated-bend threshold or persistent static posture.
    wrong_side_slip = max(
        -bounded_bearing * bounded_lateral_velocity,
        0.0,
    )
    slip_redirect_gate = tanh(
        wrong_side_slip /
        max(params.wrong_side_slip_scale, eps(Float64)),
    )
    course_misalignment = tanh(
        abs(bounded_course_error) /
        max(params.course_error_scale, eps(Float64)),
    )
    wrong_yaw_response = max(direction_error * yaw_residual, 0.0)
    wrong_yaw_gate = tanh(
        wrong_yaw_response /
        max(params.wrong_yaw_response_scale, eps(Float64)),
    )
    response_burst_gate = approach_gate * speed_gate *
        course_misalignment * wrong_yaw_gate
    redirect_gate = max(slip_redirect_gate, response_burst_gate)
    asymmetry_limit = params.cruise_half_cycle_asymmetry +
        redirect_gate * (
            params.redirect_half_cycle_asymmetry -
            params.cruise_half_cycle_asymmetry
        )
    asymmetry = asymmetry_limit * turn_request

    # Full carrier authority keeps an opposed restoring half-cycle available.
    # Smooth saturation remains inside the acceleration envelope.
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
