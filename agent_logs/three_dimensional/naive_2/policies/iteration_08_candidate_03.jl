# State-feedback traveling bend with a course-aligned approach hold.
# Full body-frame target geometry steers the propulsive rhythm; near the target,
# closing and course alignment co-scale the complete gait without changing its
# carrier-to-steering authority ratio.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        maximum_bearing=pi / 2,
        maximum_lateral_velocity=1.0,
        steering_softness=0.35,
        lateral_velocity_gain=0.8,
        carrier_yaw_head_rate_gain=0.65,
        carrier_yaw_tail_rate_gain=0.22,
        maximum_yaw_residual=0.5,
        yaw_residual_gain=0.6,
        cruise_half_cycle_asymmetry=0.35,
        redirect_half_cycle_asymmetry=0.65,
        wrong_side_slip_scale=0.08,
        head_asymmetry_share=0.65,
        tail_asymmetry_share=1.0,
        approach_distance=5.0,
        approach_distance_width=1.0,
        minimum_course_speed=0.2,
        minimum_course_alignment=0.55,
        course_alignment_softness=0.15,
        minimum_closing_speed=0.2,
        closing_speed_softness=0.15,
        minimum_rhythm_scale=0.55,
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

    # Preserve the common seed's evidenced propulsive carrier and posterior
    # lag; steering changes neither its frequency nor its amplitude target.
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
    distance = isfinite(state.distance_L) ?
        max(Float64(state.distance_L), 0.0) :
        params.approach_distance + 4 * params.approach_distance_width
    lateral_velocity = isfinite(state.velocity_body_U[2]) ?
        Float64(state.velocity_body_U[2]) : 0.0
    forward_velocity = isfinite(state.velocity_body_U[1]) ?
        Float64(state.velocity_body_U[1]) : 0.0
    closing_speed = isfinite(state.closing_speed_L) ?
        Float64(state.closing_speed_L) : 0.0
    heading_rate = isfinite(state.heading_rate) ?
        Float64(state.heading_rate) : 0.0
    # The adapter's restricted bearing folds fore and aft target directions
    # together.  Use the normalized target vector to retain that distinction:
    # body forward is -x, so this is the full-circle pursuit angle.  Clamping
    # keeps turn authority bounded while preserving reflection equivariance.
    pursuit_bearing = isfinite(target_x) && isfinite(target_y) ?
        atan(target_y, -target_x) : fallback_bearing
    bounded_bearing = clamp(
        pursuit_bearing,
        -params.maximum_bearing,
        params.maximum_bearing,
    )
    bounded_lateral_velocity = clamp(
        lateral_velocity,
        -params.maximum_lateral_velocity,
        params.maximum_lateral_velocity,
    )

    # Velocity course is a rotation-invariant approach response: body forward
    # is -x, exactly as for pursuit_bearing. At near-zero speed its angle is
    # unreliable, so use forward course and let target bearing define error.
    speed = hypot(forward_velocity, lateral_velocity)
    velocity_course = speed > params.minimum_course_speed ?
        atan(lateral_velocity, -forward_velocity) : 0.0
    course_error = atan(
        sin(pursuit_bearing - velocity_course),
        cos(pursuit_bearing - velocity_course),
    )

    # The sampled yaw rate is mostly a repeatable function of joint phase.
    # Remove that carrier-correlated component before interpreting yaw as a
    # directional response. Correct-sign residual yaw then releases the turn;
    # wrong-sign residual yaw reinforces it without damping the propulsive beat.
    carrier_phase_yaw = -params.carrier_yaw_head_rate_gain * qd1 -
        params.carrier_yaw_tail_rate_gain * qd2
    yaw_residual = clamp(
        heading_rate - carrier_phase_yaw,
        -params.maximum_yaw_residual,
        params.maximum_yaw_residual,
    )
    turn_signal = bounded_bearing -
        params.lateral_velocity_gain * bounded_lateral_velocity +
        params.yaw_residual_gain * yaw_residual
    turn_request = tanh(
        turn_signal / max(params.steering_softness, eps(Float64)),
    )

    # Opposite-signed target bearing and lateral response indicate motion away
    # from the requested side. Gate the evidenced stronger redirect smoothly;
    # authority remains below one so both propulsive half-cycles survive.
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

    # Apply approach hold only while the fish is near, closing, and traveling
    # toward the target. A large course error continuously releases the hold,
    # restoring both propulsion and redirect authority. Unlike carrier-only
    # relief, the common rhythm scale preserves steering/carrier balance and
    # cannot make a retained one-sided redirect dominate a weakened beat.
    distance_width = max(params.approach_distance_width, eps(Float64))
    approach_proximity = 0.5 * (
        1 - tanh((distance - params.approach_distance) / distance_width)
    )
    alignment_softness = max(
        params.course_alignment_softness,
        eps(Float64),
    )
    course_alignment = 0.5 * (
        1 + tanh(
            (cos(course_error) - params.minimum_course_alignment) /
            alignment_softness,
        )
    )
    closing_softness = max(
        params.closing_speed_softness,
        eps(Float64),
    )
    closing_gate = 0.5 * (
        1 + tanh(
            (closing_speed - params.minimum_closing_speed) /
            closing_softness,
        )
    )
    approach_hold = approach_proximity * course_alignment * closing_gate
    rhythm_scale = 1 -
        (1 - params.minimum_rhythm_scale) * approach_hold

    # Signed absolute carrier acceleration strengthens the requested
    # half-cycle without imposing a fixed joint equilibrium. Posterior
    # emphasis retains the traveling bend, and smooth saturation stays inside
    # the actuator envelope before any downstream clipping.
    raw_a1 = rhythm_scale * (
        carrier_a1 +
        params.head_asymmetry_share * asymmetry * abs(carrier_a1)
    )
    raw_a2 = rhythm_scale * (
        carrier_a2 +
        params.tail_asymmetry_share * asymmetry * abs(carrier_a2)
    )
    limit = params.maximum_joint_acceleration
    bounded_a1 = limit * tanh(raw_a1 / limit)
    bounded_a2 = limit * tanh(raw_a2 / limit)

    return (
        phi_ddot=(bounded_a1, bounded_a2),
    )
end
