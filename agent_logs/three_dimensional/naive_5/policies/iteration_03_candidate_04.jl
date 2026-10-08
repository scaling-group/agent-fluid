# Course-error half-cycle steering on a state-feedback traveling bend.
# Target and velocity are read only in the normalized body frame; gait phase
# remains encoded in joint state, with no clock, world route, or mutable state.

function target_policy_params()
    return (
        control_period=0.90,
        oscillator_amplitude=16.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        bearing_limit=1.25,
        course_error_limit=1.0,
        course_speed_scale=0.15,
        turn_error_scale=0.30,
        half_cycle_velocity_scale=0.60,
        half_cycle_acceleration=8.0,
        steering_angle_soft_limit=34.0 * pi / 180,
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

    # Preserve the evidenced anterior carrier with enough amplitude and speed
    # reserve for a bounded steering asymmetry.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    carrier_a1 = vdp_drive - omega^2 * q1

    target_x = Float64(state.target_body_L[1])
    target_y = Float64(state.target_body_L[2])
    velocity_x = Float64(state.velocity_body_U[1])
    velocity_y = Float64(state.velocity_body_U[2])
    target_distance = hypot(target_x, target_y)
    speed = hypot(velocity_x, velocity_y)

    # Positive bearing requests negative yaw for this body's forward-axis
    # convention. Once translation is observable, the normalized cross product
    # instead turns the measured course toward the target. Both vectors are in
    # the body frame, so the course error is independent of world orientation.
    bearing = clamp(
        Float64(state.bearing),
        -params.bearing_limit,
        params.bearing_limit,
    )
    bearing_turn = -sin(bearing)
    course_turn = clamp(
        (velocity_x * target_y - velocity_y * target_x) /
        max(speed * target_distance, eps(Float64)),
        -params.course_error_limit,
        params.course_error_limit,
    )
    speed_scale2 = params.course_speed_scale^2
    course_weight = speed^2 / (speed^2 + speed_scale2)
    turn_request = (1 - course_weight) * bearing_turn +
        course_weight * course_turn
    turn_side = tanh(turn_request / params.turn_error_scale)

    # Reinforce only the anterior half-stroke compatible with the requested
    # turn. Fade that injection near a conservative angle boundary rather than
    # allowing the steering term to pump both half-strokes into hard limits.
    phase_velocity = tanh(
        qd1 /
        (max(omega * amp, eps(Float64)) * params.half_cycle_velocity_scale),
    )
    angle_headroom = clamp(
        1 - (q1 / params.steering_angle_soft_limit)^2,
        0.0,
        1.0,
    )
    half_cycle_drive = 0.5 * params.half_cycle_acceleration *
        (turn_side + abs(turn_side) * phase_velocity)
    a1 = carrier_a1 + angle_headroom * half_cycle_drive

    # Retain the phase-lagged posterior follower that produced the coherent
    # three-dimensional wake in the strongest sampled rollout.
    tail_target = -q1 - params.tail_lag_gain * qd1 / max(omega, eps(Float64))
    a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    limit = params.acceleration_limit
    return (
        phi_ddot=(
            clamp(a1, -limit, limit),
            clamp(a2, -limit, limit),
        ),
    )
end
