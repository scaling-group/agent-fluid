# Sign-corrected traveling bend with course-gated posterior recovery.
# Gait phase, redirect release, and recovery come only from observed state.

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
        redirect_joint1_angle=24.0 * pi / 180,
        redirect_joint2_angle=30.0 * pi / 180,
        redirect_frequency_ratio=0.45,
        redirect_damping=0.90,
        recovery_distance_inner_L=1.10,
        recovery_distance_full_L=2.25,
        recovery_distance_outer_L=5.00,
        recovery_course_start=0.55,
        recovery_course_full=0.90,
        recovery_tail_acceleration=6.0,
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

    # Large target bearing blends the rhythm into a bounded, same-sign
    # two-joint redirect. Phase-rejected yaw and normalized bend attainment
    # release the maneuver before static curvature destroys the traveling wave.
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
    bend_phase_gate = bend_fraction^2 * (3 - 2 * bend_fraction)
    release_gate = 1 -
        (1 - yaw_release_gate) * (1 - bend_release_gate)
    redirect_weight = large_error_gate * (1 - release_gate)

    # The two failed terminal refinements acted after the fish had already
    # crossed the target station too high. During the middle approach, use the
    # attained C-start bend itself as a phase trigger for one bounded posterior
    # counterstroke. It fades as the tail leaves that bend, so no clock, latch,
    # or static offset is introduced.
    course_span = max(
        params.recovery_course_full - params.recovery_course_start,
        eps(Float64),
    )
    course_fraction = clamp(
        (abs(course_error) - params.recovery_course_start) / course_span,
        0.0,
        1.0,
    )
    course_gate = course_fraction^2 * (3 - 2 * course_fraction)
    outer_distance_span = max(
        params.recovery_distance_outer_L -
            params.recovery_distance_full_L,
        eps(Float64),
    )
    outer_distance_fraction = clamp(
        (params.recovery_distance_outer_L - target_distance) /
            outer_distance_span,
        0.0,
        1.0,
    )
    outer_distance_gate = outer_distance_fraction^2 *
        (3 - 2 * outer_distance_fraction)
    inner_distance_span = max(
        params.recovery_distance_full_L -
            params.recovery_distance_inner_L,
        eps(Float64),
    )
    inner_distance_fraction = clamp(
        (target_distance - params.recovery_distance_inner_L) /
            inner_distance_span,
        0.0,
        1.0,
    )
    inner_distance_gate = inner_distance_fraction^2 *
        (3 - 2 * inner_distance_fraction)
    tail_angle_ratio = abs(q2) / params.steering_angle_soft_limit
    tail_angle_headroom = clamp(
        1 - tail_angle_ratio^params.headroom_exponent,
        0.0,
        1.0,
    )
    recovery_gate = course_weight * course_gate * outer_distance_gate *
        inner_distance_gate * bend_phase_gate *
        tail_angle_headroom
    recovery_a2 = -params.recovery_tail_acceleration *
        turn_side * recovery_gate
    cruise_a2 += recovery_a2

    redirect_omega = params.redirect_frequency_ratio * omega
    redirect_a1 = redirect_omega^2 * (redirect_target1 - q1) -
        2 * params.redirect_damping * redirect_omega * qd1
    redirect_a2 = redirect_omega^2 * (redirect_target2 - q2) -
        2 * params.redirect_damping * redirect_omega * qd2

    a1 = (1 - redirect_weight) * cruise_a1 +
        redirect_weight * redirect_a1
    a2 = (1 - redirect_weight) * cruise_a2 +
        redirect_weight * redirect_a2

    limit = params.acceleration_limit
    return (
        phi_ddot=(
            clamp(a1, -limit, limit),
            clamp(a2, -limit, limit),
        ),
    )
end
