# Posterior acceleration-reserve allocation around the demonstrated body-frame
# velocity-course controller. Joint state remains the only carrier phase.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        turn_curvature_limit=12.0 * pi / 180,
        full_bearing_limit=pi,
        steering_scale=0.20,
        velocity_limit_U=1.5,
        course_speed_on_U=0.15,
        course_speed_width_U=0.30,
        allocation_distance_L=6.0,
        allocation_width_L=3.0,
        joint_acceleration_limit=1800.0 * pi / 180,
        steering_reserve_fraction=0.35,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

    # Measure target direction around the head-facing body -x axis. Unlike the
    # adapter's folded scalar bearing, this remains signed after a target pass.
    raw_target_x = Float64(state.target_body_L[1])
    raw_target_y = Float64(state.target_body_L[2])
    finite_target = isfinite(raw_target_x) && isfinite(raw_target_y)
    target_x = finite_target ? raw_target_x : -1.0
    target_y = finite_target ? raw_target_y : 0.0
    raw_full_bearing = atan(target_y, -target_x)
    full_bearing = clamp(
        raw_full_bearing,
        -params.full_bearing_limit,
        params.full_bearing_limit,
    )

    raw_forward_velocity = Float64(state.velocity_body_U[1])
    raw_lateral_velocity = Float64(state.velocity_body_U[2])
    forward_velocity = isfinite(raw_forward_velocity) ? clamp(
        raw_forward_velocity,
        -params.velocity_limit_U,
        params.velocity_limit_U,
    ) : 0.0
    lateral_velocity = isfinite(raw_lateral_velocity) ? clamp(
        raw_lateral_velocity,
        -params.velocity_limit_U,
        params.velocity_limit_U,
    ) : 0.0

    # Compare measured swimming course with the target ray once translation is
    # reliable. Both angles are normalized body-frame observations.
    course_speed = hypot(forward_velocity, lateral_velocity)
    course_bearing = course_speed > eps(Float64) ?
        atan(lateral_velocity, -forward_velocity) : 0.0
    raw_course_error = full_bearing - course_bearing
    course_error = atan(sin(raw_course_error), cos(raw_course_error))

    speed_fraction = clamp(
        (course_speed - params.course_speed_on_U) /
        max(params.course_speed_width_U, eps(Float64)),
        0.0,
        1.0,
    )
    course_gate = speed_fraction^2 * (3.0 - 2.0 * speed_fraction)
    steering_signal = (1.0 - course_gate) * full_bearing +
        course_gate * course_error
    turn_request = tanh(
        steering_signal / max(params.steering_scale, eps(Float64)),
    )

    # Preserve the demonstrated zero-centered anterior oscillator exactly.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1

    # Decompose posterior acceleration into traveling-carrier and mean-steering
    # work. Their unallocated sum is exactly the demonstrated controller.
    lagged_carrier = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    carrier_a2 = omega^2 * (lagged_carrier - q2) -
        2 * params.tail_damping * omega * qd2
    mean_tail_tangent = params.turn_curvature_limit * turn_request
    steering_a2 = omega^2 * mean_tail_tangent
    unallocated_a2 = carrier_a2 + steering_a2

    # Inside the evidenced terminal regime, reserve a bounded part of the
    # existing physical envelope for steering. The carrier is soft-bounded in
    # the remaining envelope, so hard clipping cannot erase the turn request.
    raw_distance = Float64(state.distance_L)
    distance = isfinite(raw_distance) ? max(raw_distance, 0.0) : Inf
    allocation_fraction = clamp(
        (params.allocation_distance_L - distance) /
        max(params.allocation_width_L, eps(Float64)),
        0.0,
        1.0,
    )
    allocation_gate = allocation_fraction^2 *
        (3.0 - 2.0 * allocation_fraction)

    acceleration_limit = max(
        params.joint_acceleration_limit,
        eps(Float64),
    )
    steering_limit = clamp(
        params.steering_reserve_fraction,
        0.0,
        1.0,
    ) * acceleration_limit
    reserved_steering = steering_limit > eps(Float64) ?
        steering_limit * tanh(steering_a2 / steering_limit) : 0.0
    carrier_limit = max(
        acceleration_limit - abs(reserved_steering),
        eps(Float64),
    )
    reserved_carrier = carrier_limit * tanh(carrier_a2 / carrier_limit)
    allocated_a2 = reserved_carrier + reserved_steering
    a2 = (1.0 - allocation_gate) * unallocated_a2 +
        allocation_gate * allocated_a2

    return (phi_ddot=(a1, a2),)
end
