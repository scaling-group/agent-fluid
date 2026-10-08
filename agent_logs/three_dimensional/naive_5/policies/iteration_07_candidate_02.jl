# Observation-gated C-start redirect with a terminal intercept guard.
# Gait phase, redirect, and approach release use only normalized body-frame state.

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
        redirect_joint1_angle=24.0 * pi / 180,
        redirect_joint2_angle=30.0 * pi / 180,
        redirect_frequency_ratio=0.45,
        redirect_damping=0.90,
        approach_outer_distance=3.0,
        approach_inner_distance=1.4,
        approach_miss_start=0.70,
        approach_miss_full=1.10,
        approach_closing_alignment_scale=0.35,
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
    route_denominator = max(speed * target_distance, eps(Float64))
    course_error = clamp(
        (velocity_x * target_y - velocity_y * target_x) /
        route_denominator,
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

    # A large body-frame heading error blends the rhythm into a bounded
    # same-sign two-joint bend. Phase-rejected yaw supplies the ordinary
    # release condition, so cruise recovers from a completed redirect without
    # a clock or hidden controller stage.
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
    release_gate = aligned_yaw_fraction^2 *
        (3 - 2 * aligned_yaw_fraction)
    base_redirect_weight = large_error_gate * (1 - release_gate)

    # The sampled redirect coasted 0.42L outside capture while cruise and bend
    # tracking cancelled. During a closing near approach, estimate the miss of
    # the current straight-line course from the normalized cross product. If
    # that miss is wider than the capture corridor, suppress premature release
    # toward the existing full redirect. The guard vanishes on an aligned path
    # and once the velocity no longer closes on the target.
    projected_miss_distance = target_distance * abs(course_error)
    distance_span = max(
        params.approach_outer_distance - params.approach_inner_distance,
        eps(Float64),
    )
    approach_distance_fraction = clamp(
        (params.approach_outer_distance - target_distance) / distance_span,
        0.0,
        1.0,
    )
    approach_distance_gate = approach_distance_fraction^2 *
        (3 - 2 * approach_distance_fraction)
    miss_span = max(
        params.approach_miss_full - params.approach_miss_start,
        eps(Float64),
    )
    approach_miss_fraction = clamp(
        (projected_miss_distance - params.approach_miss_start) / miss_span,
        0.0,
        1.0,
    )
    approach_miss_gate = approach_miss_fraction^2 *
        (3 - 2 * approach_miss_fraction)
    closing_alignment = clamp(
        (velocity_x * target_x + velocity_y * target_y) /
        route_denominator,
        0.0,
        1.0,
    )
    approach_closing_fraction = clamp(
        closing_alignment / params.approach_closing_alignment_scale,
        0.0,
        1.0,
    )
    approach_closing_gate = approach_closing_fraction^2 *
        (3 - 2 * approach_closing_fraction)
    approach_guard = approach_distance_gate *
        approach_miss_gate * approach_closing_gate
    redirect_weight = 1 -
        (1 - base_redirect_weight) * (1 - approach_guard)

    redirect_omega = params.redirect_frequency_ratio * omega
    redirect_target1 = params.redirect_joint1_angle * turn_side
    redirect_target2 = params.redirect_joint2_angle * turn_side
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
