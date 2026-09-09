# Course-error steering on the evidenced state-feedback traveling bend.
# Body-frame target and velocity invariants reject carrier yaw while bounded
# shared-joint half-cycle modulation preserves the propulsive rhythm.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        maximum_bearing=pi / 2,
        maximum_course_error=pi / 2,
        course_speed_scale=0.4,
        maximum_course_weight=0.75,
        redirect_course_scale=0.5,
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
        approach_distance=6.0,
        approach_distance_width=1.0,
        approach_course_scale=0.6,
        minimum_command_scale=0.35,
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
    velocity_x = isfinite(state.velocity_body_U[1]) ?
        Float64(state.velocity_body_U[1]) : 0.0
    velocity_y = isfinite(state.velocity_body_U[2]) ?
        Float64(state.velocity_body_U[2]) : 0.0
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

    # The signed angle from measured velocity to the target vector depends
    # only on their dot and cross products. It is therefore unchanged by the
    # carrier's body-frame yaw, unlike instantaneous pursuit bearing. At low
    # speed there is no reliable course, so fall back continuously to bearing.
    course_cross = velocity_x * target_y - velocity_y * target_x
    course_dot = velocity_x * target_x + velocity_y * target_y
    raw_course_turn = -atan(course_cross, course_dot)
    bounded_course_turn = clamp(
        raw_course_turn,
        -params.maximum_course_error,
        params.maximum_course_error,
    )
    speed = hypot(velocity_x, velocity_y)
    speed_ratio = speed / max(params.course_speed_scale, eps(Float64))
    course_weight = params.maximum_course_weight * tanh(speed_ratio)^2
    course_reliability = course_weight /
        max(params.maximum_course_weight, eps(Float64))
    navigation_error = (1 - course_weight) * bounded_bearing +
        course_weight * bounded_course_turn

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
    turn_signal = navigation_error + params.yaw_residual_gain * yaw_residual
    turn_request = tanh(
        turn_signal / max(params.steering_softness, eps(Float64)),
    )

    # Preserve the parent's response gate, but evaluate wrong-side slip against
    # the phase-robust navigation error. Course misalignment supplies an
    # additional geometry gate when actual translation misses the target.
    wrong_side_slip = max(
        -navigation_error * velocity_y,
        0.0,
    )
    slip_gate = tanh(
        wrong_side_slip / max(params.wrong_side_slip_scale, eps(Float64)),
    )
    course_gate = course_weight * tanh(
        abs(bounded_course_turn) /
        max(params.redirect_course_scale, eps(Float64)),
    )
    redirect_gate = 1 - (1 - slip_gate) * (1 - course_gate)
    asymmetry_limit = params.cruise_half_cycle_asymmetry +
        redirect_gate * (
            params.redirect_half_cycle_asymmetry -
            params.cruise_half_cycle_asymmetry
    )
    asymmetry = asymmetry_limit * turn_request

    # If the measured course still misses a nearby target, slow the complete
    # rhythmic command. Co-scaling the carrier and its half-cycle modulation
    # preserves their ratio, so steering cannot erase a restorative half-cycle
    # as it did when only the symmetric carrier was relieved.
    distance_width = max(params.approach_distance_width, eps(Float64))
    approach_proximity = 0.5 * (
        1 - tanh((distance - params.approach_distance) / distance_width)
    )
    approach_miss = tanh(
        abs(bounded_course_turn) /
        max(params.approach_course_scale, eps(Float64)),
    )
    command_scale = 1 -
        (1 - params.minimum_command_scale) *
        approach_proximity * course_reliability * approach_miss

    # Signed absolute carrier acceleration strengthens the requested
    # half-cycle without imposing a fixed joint equilibrium. Posterior
    # emphasis retains the traveling bend. Smooth saturation stays inside the
    # actuator envelope before any downstream clipping.
    raw_a1 = command_scale * (
        carrier_a1 +
        params.head_asymmetry_share * asymmetry * abs(carrier_a1)
    )
    raw_a2 = command_scale * (
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
