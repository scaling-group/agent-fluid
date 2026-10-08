# Sign-corrected traveling bend with response-commutated course-slip tail
# vectoring, capture-gated posterior wave shape, and viability guards.

function target_policy_params()
    return (
        control_period=0.90,
        oscillator_amplitude=18.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        bearing_limit=1.25,
        bearing_scale=0.35,
        course_error_limit=1.0,
        course_error_scale=0.50,
        course_speed_scale=0.20,
        phase_velocity_scale=0.60,
        phase_pump_acceleration=6.0,
        half_cycle_acceleration=3.0,
        steering_angle_soft_limit=36.0 * pi / 180,
        headroom_exponent=4.0,
        phase_yaw_coupling=0.45,
        yaw_residual_ratio_limit=0.20,
        redirect_bearing_start=0.45,
        redirect_bearing_full=1.10,
        redirect_release_yaw_ratio=0.10,
        redirect_bend_release_start=0.35,
        redirect_bend_release_full=0.75,
        approach_distance_inner_L=1.10,
        approach_distance_outer_L=1.75,
        approach_miss_inner_L=0.60,
        approach_miss_outer_L=0.80,
        navigation_translation_distance_inner_L=3.0,
        navigation_translation_distance_outer_L=4.5,
        navigation_los_rate_ratio_scale=0.025,
        navigation_yaw_gain=2.0,
        navigation_yaw_ratio_limit=0.14,
        navigation_response_deficit_full=0.06,
        navigation_closing_speed_full_L=0.25,
        navigation_half_cycle_acceleration=3.0,
        course_slip_deficit_start=0.15,
        course_slip_deficit_full=0.55,
        course_tail_vectoring=0.12,
        course_force_response_scale=0.006,
        course_tail_response_modulation=0.20,
        capture_tail_lag_modulation=0.18,
        redirect_joint1_angle=24.0 * pi / 180,
        redirect_joint2_angle=30.0 * pi / 180,
        redirect_frequency_ratio=0.45,
        redirect_damping=0.90,
        joint_guard_soft_limit=43.0 * pi / 180,
        joint_angle_limit=45.0 * pi / 180,
        joint_speed_guard_soft_limit=250.0 * pi / 180,
        joint_speed_limit=260.0 * pi / 180,
        joint_acceleration_soft_limit=27.0,
        acceleration_limit=30.0,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

    # Preserve the sampled phase-separated traveling bend. Oscillator phase is
    # inferred from anterior joint state, and the posterior joint remains a
    # damped lagged follower rather than a clock-driven trajectory.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    carrier_a1 = vdp_drive - omega^2 * q1
    phase_velocity = tanh(
        qd1 /
        (max(omega * amp, eps(Float64)) * params.phase_velocity_scale),
    )
    phase_pump = params.phase_pump_acceleration * phase_velocity

    bearing = clamp(
        Float64(state.bearing),
        -params.bearing_limit,
        params.bearing_limit,
    )
    target_x = Float64(state.target_body_L[1])
    target_y = Float64(state.target_body_L[2])
    velocity_x = Float64(state.velocity_body_U[1])
    velocity_y = Float64(state.velocity_body_U[2])
    target_distance = hypot(target_x, target_y)
    speed = hypot(velocity_x, velocity_y)
    target_course_cross = velocity_x * target_y -
        velocity_y * target_x
    course_error = clamp(
        target_course_cross /
        max(speed * target_distance, eps(Float64)),
        -params.course_error_limit,
        params.course_error_limit,
    )
    speed_scale2 = params.course_speed_scale^2
    course_weight = speed^2 / (speed^2 + speed_scale2)

    # Use the steering side calibrated by the sampled long trajectories:
    # anterior selector sign follows bearing and opposes target/course cross
    # error once translation makes course observable.
    bearing_side = tanh(bearing / params.bearing_scale)
    course_side = -tanh(course_error / params.course_error_scale)
    turn_side = clamp(
        (1 - course_weight) * bearing_side +
        course_weight * course_side,
        -1.0,
        1.0,
    )
    half_cycle_drive = 0.5 * params.half_cycle_acceleration * (
        turn_side + abs(turn_side) * phase_velocity
    )

    angle_ratio = abs(q1) / params.steering_angle_soft_limit
    angle_headroom = clamp(
        1 - angle_ratio^params.headroom_exponent,
        0.0,
        1.0,
    )
    cruise_a1 = carrier_a1 +
        angle_headroom * (phase_pump + half_cycle_drive)
    cruise_tail_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(Float64))
    cruise_a2 = omega^2 * (cruise_tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Large target bearing blends the rhythm into the evaluated, bounded
    # same-sign redirect. Phase-rejected yaw and normalized bend attainment
    # release it before a static bend suppresses the traveling carrier.
    redirect_span = max(
        params.redirect_bearing_full - params.redirect_bearing_start,
        eps(Float64),
    )
    error_fraction = clamp(
        (abs(bearing) - params.redirect_bearing_start) / redirect_span,
        0.0,
        1.0,
    )
    large_error_gate = error_fraction^2 * (3 - 2 * error_fraction)
    yaw_residual_ratio = clamp(
        (
            Float64(state.heading_rate) +
            params.phase_yaw_coupling * qd1
        ) / max(omega, eps(Float64)),
        -params.yaw_residual_ratio_limit,
        params.yaw_residual_ratio_limit,
    )
    aligned_yaw_fraction = clamp(
        -turn_side * yaw_residual_ratio /
        params.redirect_release_yaw_ratio,
        0.0,
        1.0,
    )
    yaw_release_gate = aligned_yaw_fraction^2 *
        (3 - 2 * aligned_yaw_fraction)

    redirect_target1 = params.redirect_joint1_angle * turn_side
    redirect_target2 = params.redirect_joint2_angle * turn_side
    bend_fraction1 = clamp(
        q1 * redirect_target1 /
        max(redirect_target1^2, eps(Float64)),
        0.0,
        1.0,
    )
    bend_fraction2 = clamp(
        q2 * redirect_target2 /
        max(redirect_target2^2, eps(Float64)),
        0.0,
        1.0,
    )
    bend_fraction = min(bend_fraction1, bend_fraction2)
    bend_release_span = max(
        params.redirect_bend_release_full -
            params.redirect_bend_release_start,
        eps(Float64),
    )
    bend_release_fraction = clamp(
        (bend_fraction - params.redirect_bend_release_start) /
            bend_release_span,
        0.0,
        1.0,
    )
    bend_release_gate = bend_release_fraction^2 *
        (3 - 2 * bend_release_fraction)
    base_release_gate = 1 -
        (1 - yaw_release_gate) * (1 - bend_release_gate)

    # Veto release only in the capture neighborhood when the measured course
    # still predicts a miss. This retains the evaluated far response release.
    projected_miss_L = abs(target_course_cross) /
        max(speed, eps(Float64))
    approach_distance_span = max(
        params.approach_distance_outer_L -
            params.approach_distance_inner_L,
        eps(Float64),
    )
    approach_fraction = clamp(
        (params.approach_distance_outer_L - target_distance) /
            approach_distance_span,
        0.0,
        1.0,
    )
    approach_gate = approach_fraction^2 *
        (3 - 2 * approach_fraction)
    approach_miss_span = max(
        params.approach_miss_outer_L - params.approach_miss_inner_L,
        eps(Float64),
    )
    miss_fraction = clamp(
        (projected_miss_L - params.approach_miss_inner_L) /
            approach_miss_span,
        0.0,
        1.0,
    )
    miss_gate = miss_fraction^2 * (3 - 2 * miss_fraction)
    terminal_release_veto = approach_gate * miss_gate
    release_gate = base_release_gate * (1 - terminal_release_veto)
    redirect_weight = large_error_gate * (1 - release_gate)

    redirect_omega = params.redirect_frequency_ratio * omega
    redirect_a1 = redirect_omega^2 * (redirect_target1 - q1) -
        2 * params.redirect_damping * redirect_omega * qd1
    redirect_a2 = redirect_omega^2 * (redirect_target2 - q2) -
        2 * params.redirect_damping * redirect_omega * qd2

    a1 = (1 - redirect_weight) * cruise_a1 +
        redirect_weight * redirect_a1
    a2 = (1 - redirect_weight) * cruise_a2 +
        redirect_weight * redirect_a2

    # Preserve the evaluated response magnitude, but do not let the folded
    # bearing signal choose steering side by itself: its apparent target-line
    # rate contains tail-beat-scale body rotation. Body-frame target and
    # translational velocity give a second, coordinate-free inertial line-of-
    # sight rate. As course becomes observable, smoothly prefer that persistent
    # geometric side when it agrees with course error. This changes allocation,
    # not the response gain or command envelope; disagreement and low-speed
    # states retain the evaluated response.
    inertial_los_rate_ratio = (
        Float64(state.bearing_window_rate) +
        Float64(state.turn_rate_recent)
    ) / max(omega, eps(Float64))
    history_los_turn_side = -tanh(
        inertial_los_rate_ratio /
        params.navigation_los_rate_ratio_scale,
    )
    translation_los_rate_ratio = target_course_cross /
        max(target_distance^2 * omega, eps(Float64))
    translation_los_turn_side = -tanh(
        translation_los_rate_ratio /
        params.navigation_los_rate_ratio_scale,
    )
    translation_side_agreement = clamp(
        course_side * translation_los_turn_side,
        0.0,
        1.0,
    )
    translation_distance_span = max(
        params.navigation_translation_distance_outer_L -
            params.navigation_translation_distance_inner_L,
        eps(Float64),
    )
    translation_distance_fraction = clamp(
        (params.navigation_translation_distance_outer_L - target_distance) /
            translation_distance_span,
        0.0,
        1.0,
    )
    translation_distance_gate = translation_distance_fraction^2 *
        (3 - 2 * translation_distance_fraction)
    translation_side_weight = translation_distance_gate * course_weight *
        translation_side_agreement * abs(translation_los_turn_side)
    los_turn_side = clamp(
        (1 - translation_side_weight) * history_los_turn_side +
            translation_side_weight * translation_los_turn_side,
        -1.0,
        1.0,
    )
    desired_yaw_magnitude_ratio = min(
        params.navigation_yaw_gain * abs(inertial_los_rate_ratio),
        params.navigation_yaw_ratio_limit,
    )
    aligned_yaw_magnitude_ratio = clamp(
        -los_turn_side * yaw_residual_ratio,
        0.0,
        params.navigation_yaw_ratio_limit,
    )
    response_deficit_fraction = clamp(
        (desired_yaw_magnitude_ratio - aligned_yaw_magnitude_ratio) /
            params.navigation_response_deficit_full,
        0.0,
        1.0,
    )
    response_deficit_gate = response_deficit_fraction^2 *
        (3 - 2 * response_deficit_fraction)
    closing_fraction = clamp(
        Float64(state.closing_speed_L) /
            params.navigation_closing_speed_full_L,
        0.0,
        1.0,
    )
    closing_gate = closing_fraction^2 * (3 - 2 * closing_fraction)
    navigation_turn_side = los_turn_side * response_deficit_gate
    navigation_half_cycle_drive = 0.5 *
        params.navigation_half_cycle_acceleration * (
            navigation_turn_side +
            abs(navigation_turn_side) * phase_velocity
    )
    a1 += course_weight * closing_gate * angle_headroom *
        navigation_half_cycle_drive

    # The sampled routes acquire the correct translational course much later
    # than their body aim. Preserve the successful posterior course-slip
    # vectoring, but use measured hydrodynamic response to redistribute a small
    # fraction of that authority across the beat. Route geometry still owns
    # steering side. Target-normal force only increases the tail shift when it
    # rotates velocity away from the required course, and reduces it by the
    # same bounded fraction during helpful phases. Zero force exactly recovers
    # the sampled vectoring; startup, aligned, non-closing, redirect-dominated,
    # and late-capture states retain the established continuous gates.
    course_slip_deficit = max(
        abs(course_error) - abs(sin(bearing)),
        0.0,
    )
    course_slip_span = max(
        params.course_slip_deficit_full -
            params.course_slip_deficit_start,
        eps(Float64),
    )
    course_slip_fraction = clamp(
        (course_slip_deficit - params.course_slip_deficit_start) /
            course_slip_span,
        0.0,
        1.0,
    )
    course_slip_gate = course_slip_fraction^2 *
        (3 - 2 * course_slip_fraction)
    upstream_course_gate = (1 - translation_distance_gate) * course_weight *
        closing_gate * course_slip_gate * (1 - redirect_weight)

    force_x = Float64(state.force_body_L[1])
    force_y = Float64(state.force_body_L[2])
    course_force_turn_ratio = (
        velocity_x * force_y - velocity_y * force_x
    ) / max(
        speed * params.course_force_response_scale,
        eps(Float64),
    )
    adverse_force_phase = tanh(course_side * course_force_turn_ratio)
    course_response_factor = clamp(
        1 + params.course_tail_response_modulation * adverse_force_phase,
        1 - params.course_tail_response_modulation,
        1 + params.course_tail_response_modulation,
    )
    course_tail_target_shift = params.course_tail_vectoring *
        course_response_factor * upstream_course_gate * course_side *
        phase_velocity * qd1 / max(omega, eps(Float64))
    a2 += omega^2 * course_tail_target_shift

    # The sampled anterior capture-corridor residual barely changed the
    # shallow crossing, so allocate the same evidenced miss/response request
    # through posterior wave shape instead of adding more anterior authority.
    # When course and target-line rotation request the same side, alternating
    # the posterior lag around its cruise value creates a bounded target-side
    # tail bias. Joint-state phase keeps the construction reflection
    # equivariant, and the existing terminal veto confines it to a closing,
    # capture-scale miss. Redirect-dominated and well-responding states pass
    # through unchanged.
    capture_side_agreement = clamp(
        course_side * los_turn_side,
        0.0,
        1.0,
    )
    capture_phase_gate = terminal_release_veto * course_weight *
        closing_gate * response_deficit_gate * capture_side_agreement
    capture_tail_target_shift = params.capture_tail_lag_modulation *
        capture_phase_gate * course_side * phase_velocity * qd1 /
        max(omega, eps(Float64))
    capture_tail_acceleration = omega^2 * capture_tail_target_shift
    a2 += (1 - redirect_weight) * capture_tail_acceleration

    # Independent acceleration clipping can distort the anterior/posterior
    # command ratio that sustains the traveling bend. Above a soft command
    # band, compress the peak magnitude toward the policy limit and apply the
    # same scale to both joints. Viable commands pass through exactly. The
    # angle and speed guards remain downstream so their safety authority is
    # never weakened by this coordination-preserving projection.
    limit = params.acceleration_limit
    acceleration_soft_limit = min(
        params.joint_acceleration_soft_limit,
        limit,
    )
    acceleration_soft_span = max(
        limit - acceleration_soft_limit,
        eps(Float64),
    )
    command_peak = max(abs(a1), abs(a2))
    if command_peak > acceleration_soft_limit
        acceleration_excess = command_peak - acceleration_soft_limit
        compressed_peak = acceleration_soft_limit +
            acceleration_soft_span * acceleration_excess /
                (acceleration_soft_span + acceleration_excess)
        common_scale = compressed_peak / max(command_peak, eps(Float64))
        a1 *= common_scale
        a2 *= common_scale
    end

    # Preserve the evaluated carrier and steering command until an
    # outward-moving joint's angle plus its acceleration-limited stopping
    # excursion approaches the hard envelope. The smooth guard can only make
    # that joint's command more inward; it is inactive for inward motion.
    guard_span = max(
        params.joint_angle_limit - params.joint_guard_soft_limit,
        eps(Float64),
    )

    if q1 * qd1 > 0.0
        stopping_excursion1 = qd1^2 / max(2 * limit, eps(Float64))
        predicted_angle1 = abs(q1) + stopping_excursion1
        guard_fraction1 = clamp(
            (predicted_angle1 - params.joint_guard_soft_limit) / guard_span,
            0.0,
            1.0,
        )
        guard_gate1 = guard_fraction1^2 * (3 - 2 * guard_fraction1)
        motion_side1 = sign(qd1)
        blended_brake1 = (1 - guard_gate1) * a1 -
            guard_gate1 * motion_side1 * limit
        a1 = motion_side1 * min(
            motion_side1 * a1,
            motion_side1 * blended_brake1,
        )
    end

    if q2 * qd2 > 0.0
        stopping_excursion2 = qd2^2 / max(2 * limit, eps(Float64))
        predicted_angle2 = abs(q2) + stopping_excursion2
        guard_fraction2 = clamp(
            (predicted_angle2 - params.joint_guard_soft_limit) / guard_span,
            0.0,
            1.0,
        )
        guard_gate2 = guard_fraction2^2 * (3 - 2 * guard_fraction2)
        motion_side2 = sign(qd2)
        blended_brake2 = (1 - guard_gate2) * a2 -
            guard_gate2 * motion_side2 * limit
        a2 = motion_side2 * min(
            motion_side2 * a2,
            motion_side2 * blended_brake2,
        )
    end

    # The sampled angle guard leaves substantial joint-speed-cap residence.
    # When a near-limit joint would be accelerated still faster, smoothly
    # replace only that worsening component with bounded opposite acceleration.
    # Sub-band and speed-reducing commands pass through exactly, and applying
    # the same signed construction to both joints preserves reflection symmetry.
    speed_guard_span = max(
        params.joint_speed_limit - params.joint_speed_guard_soft_limit,
        eps(Float64),
    )
    speed_guard_brake = min(omega * speed_guard_span, limit)

    if qd1 * a1 > 0.0
        speed_fraction1 = clamp(
            (abs(qd1) - params.joint_speed_guard_soft_limit) /
                speed_guard_span,
            0.0,
            1.0,
        )
        speed_gate1 = speed_fraction1^2 * (3 - 2 * speed_fraction1)
        motion_side1 = sign(qd1)
        a1 = (1 - speed_gate1) * a1 -
            speed_gate1 * motion_side1 * speed_guard_brake
    end

    if qd2 * a2 > 0.0
        speed_fraction2 = clamp(
            (abs(qd2) - params.joint_speed_guard_soft_limit) /
                speed_guard_span,
            0.0,
            1.0,
        )
        speed_gate2 = speed_fraction2^2 * (3 - 2 * speed_fraction2)
        motion_side2 = sign(qd2)
        a2 = (1 - speed_gate2) * a2 -
            speed_gate2 * motion_side2 * speed_guard_brake
    end

    return (
        phi_ddot=(
            clamp(a1, -limit, limit),
            clamp(a2, -limit, limit),
        ),
    )
end
