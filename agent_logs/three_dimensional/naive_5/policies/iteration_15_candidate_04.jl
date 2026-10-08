# Predictive intercept redirect on a sign-corrected traveling-bend carrier.
# Phase and guidance come only from normalized observed body-frame state.

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
        redirect_joint1_angle=24.0 * pi / 180,
        redirect_joint2_angle=30.0 * pi / 180,
        redirect_frequency_ratio=0.45,
        redirect_damping=0.90,
        intercept_miss_safe_L=0.65,
        intercept_miss_full_L=1.10,
        intercept_distance_inner_L=4.00,
        intercept_distance_outer_L=5.00,
        intercept_ttg_urgent_T=1.50,
        intercept_ttg_anticipation_T=4.00,
        intercept_closing_speed_scale=0.20,
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
    target_course_dot = velocity_x * target_x +
        velocity_y * target_y
    course_error = clamp(
        target_course_cross /
        max(speed * target_distance, eps(Float64)),
        -params.course_error_limit,
        params.course_error_limit,
    )
    speed_scale2 = params.course_speed_scale^2
    course_weight = speed^2 / (speed^2 + speed_scale2)

    # Keep the steering side calibrated by the long sampled trajectories:
    # bearing supplies the low-speed request, while measured course dominates
    # after translation is observable.
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

    # Large target bearing blends the rhythm into the sampled same-sign
    # two-joint redirect. Phase-rejected yaw and bend attainment provide its
    # established far-field release conditions.
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

    base_redirect_target1 = params.redirect_joint1_angle * turn_side
    base_redirect_target2 = params.redirect_joint2_angle * turn_side
    bend_fraction1 = clamp(
        q1 * base_redirect_target1 /
        max(base_redirect_target1^2, eps(Float64)),
        0.0,
        1.0,
    )
    bend_fraction2 = clamp(
        q2 * base_redirect_target2 /
        max(base_redirect_target2^2, eps(Float64)),
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

    # Veto the settled-bend release only in the capture neighborhood while the
    # measured course still predicts a miss. All quantities are normalized
    # body-frame observations and the gate vanishes on the far carrier.
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

    # The sampled terminal actuators all began after the projected intercept
    # was already unsafe. Add a distinct middle-course interception layer:
    # positive time-to-go supplies urgency, while projected miss supplies the
    # response condition. This can re-engage the calibrated redirect even when
    # body bearing alone is modest, and it releases for a safe or receding
    # intercept rather than for joint attainment or yaw alone.
    closing_speed = max(
        target_course_dot / max(target_distance, eps(Float64)),
        0.0,
    )
    closing_scale2 = params.intercept_closing_speed_scale^2
    closing_gate = closing_speed^2 /
        (closing_speed^2 + closing_scale2)
    along_track_L = max(
        target_course_dot / max(speed, eps(Float64)),
        0.0,
    )
    time_to_go_T = along_track_L / max(speed, eps(Float64))
    intercept_miss_span = max(
        params.intercept_miss_full_L - params.intercept_miss_safe_L,
        eps(Float64),
    )
    intercept_miss_fraction = clamp(
        (projected_miss_L - params.intercept_miss_safe_L) /
            intercept_miss_span,
        0.0,
        1.0,
    )
    intercept_miss_gate = intercept_miss_fraction^2 *
        (3 - 2 * intercept_miss_fraction)
    intercept_ttg_span = max(
        params.intercept_ttg_anticipation_T -
            params.intercept_ttg_urgent_T,
        eps(Float64),
    )
    intercept_urgency_fraction = clamp(
        (params.intercept_ttg_anticipation_T - time_to_go_T) /
            intercept_ttg_span,
        0.0,
        1.0,
    )
    intercept_urgency_gate = intercept_urgency_fraction^2 *
        (3 - 2 * intercept_urgency_fraction)
    intercept_distance_span = max(
        params.intercept_distance_outer_L -
            params.intercept_distance_inner_L,
        eps(Float64),
    )
    intercept_distance_fraction = clamp(
        (params.intercept_distance_outer_L - target_distance) /
            intercept_distance_span,
        0.0,
        1.0,
    )
    middle_distance_gate = intercept_distance_fraction^2 *
        (3 - 2 * intercept_distance_fraction)
    predictive_redirect_weight = middle_distance_gate * course_weight *
        closing_gate * intercept_miss_gate * intercept_urgency_gate
    redirect_weight = 1 -
        (1 - redirect_weight) * (1 - predictive_redirect_weight)

    redirect_omega = params.redirect_frequency_ratio * omega
    redirect_a1 = redirect_omega^2 *
        (base_redirect_target1 - q1) -
        2 * params.redirect_damping * redirect_omega * qd1
    redirect_a2 = redirect_omega^2 *
        (base_redirect_target2 - q2) -
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
