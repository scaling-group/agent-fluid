# Course-biased yaw-rate closure on a state-feedback traveling bend.
# Oscillator phase remains encoded in joint state; no clock or route is used.

function target_policy_params()
    return (
        control_period=0.90,
        oscillator_amplitude=18.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        bearing_limit=1.0,
        bearing_scale=0.35,
        max_bearing_turn_rate_ratio=0.08,
        course_error_limit=1.0,
        course_speed_scale=0.20,
        max_course_turn_rate_ratio=0.10,
        desired_turn_rate_ratio_limit=0.16,
        turn_rate_ratio_limit=0.35,
        turn_rate_error_scale=0.08,
        half_cycle_velocity_scale=0.60,
        half_cycle_acceleration=8.0,
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

    # Keep the sampled sub-limit carrier; phase lives in observed joint state.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    carrier_a1 = vdp_drive - omega^2 * q1

    # Positive bearing requests negative yaw. Once translation is observable,
    # bias that geometric request by the signed angle from measured course to
    # the target. Both vectors are body-frame quantities; speed gating avoids
    # assigning a course direction before the carrier has begun to translate.
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
    course_error = clamp(
        (velocity_x * target_y - velocity_y * target_x) /
        max(speed * target_distance, eps(Float64)),
        -params.course_error_limit,
        params.course_error_limit,
    )
    speed_scale2 = params.course_speed_scale^2
    course_weight = speed^2 / (speed^2 + speed_scale2)
    desired_turn_rate_ratio = clamp(
        -params.max_bearing_turn_rate_ratio *
            tanh(bearing / params.bearing_scale) +
        params.max_course_turn_rate_ratio * course_weight * course_error,
        -params.desired_turn_rate_ratio_limit,
        params.desired_turn_rate_ratio_limit,
    )

    # Track the slow route demand through the parent's phase-correlated yaw
    # loop. Keeping this closure distinguishes course bias from the failed
    # direct bearing/course half-cycle selectors in the sampled descendants.
    turn_rate_ratio = clamp(
        Float64(state.heading_rate) / max(omega, eps(omega)),
        -params.turn_rate_ratio_limit,
        params.turn_rate_ratio_limit,
    )
    turn_side = tanh(
        (desired_turn_rate_ratio - turn_rate_ratio) /
        params.turn_rate_error_scale,
    )
    phase_velocity = tanh(
        qd1 /
        (max(omega * amp, eps(omega)) * params.half_cycle_velocity_scale),
    )
    half_cycle_drive = 0.5 * params.half_cycle_acceleration * (
        turn_side + abs(turn_side) * phase_velocity
    )
    a1 = carrier_a1 + half_cycle_drive

    # Posterior propulsion remains a lagged follower of the asymmetric
    # anterior wave, so the alternating traveling bend is preserved.
    phase_lag_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    limit = params.acceleration_limit
    return (
        phi_ddot=(
            clamp(a1, -limit, limit),
            clamp(a2, -limit, limit),
        ),
    )
end
