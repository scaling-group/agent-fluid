# Soft-enveloped carrier with continuous posterior-angle and identity-windowed
# joint-speed viability around the captured acceleration-reserve
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
        acceleration_soft_knee_fraction=0.80,
        acceleration_soft_ceiling_fraction=0.95,
        joint_velocity_limit=260.0 * pi / 180,
        joint_velocity_buffer_fraction=0.02,
        velocity_identity_fraction=0.94,
        velocity_barrier_gain=4.0,
        joint_angle_limit=45.0 * pi / 180,
        joint_angle_buffer=2.0 * pi / 180,
        stopping_risk_onset=0.60,
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

    # Compare measured swimming course with the target ray once translation is
    # reliable. Both angles are normalized body-frame observations.
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

    # Preserve the demonstrated zero-centered anterior oscillator structure.
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

    # Give routine carrier requests a C1 shoulder before the actuator sees
    # them. The identity region preserves small-signal oscillator and steering
    # dynamics; the exponential shoulder approaches a sub-limit ceiling
    # without introducing an external phase or a hard-clipped plateau.
    soft_ceiling_fraction = clamp(
        params.acceleration_soft_ceiling_fraction,
        eps(Float64),
        1.0 - eps(Float64),
    )
    soft_knee_fraction = clamp(
        params.acceleration_soft_knee_fraction,
        0.0,
        soft_ceiling_fraction,
    )
    soft_ceiling = soft_ceiling_fraction * acceleration_limit
    soft_knee = soft_knee_fraction * acceleration_limit
    soft_span = max(soft_ceiling - soft_knee, eps(Float64))

    a1_magnitude = abs(a1)
    if a1_magnitude > soft_knee
        softened_magnitude = soft_knee + soft_span * (
            1.0 - exp(-(a1_magnitude - soft_knee) / soft_span)
        )
        a1 = copysign(softened_magnitude, a1)
    end

    a2_magnitude = abs(a2)
    if a2_magnitude > soft_knee
        softened_magnitude = soft_knee + soft_span * (
            1.0 - exp(-(a2_magnitude - soft_knee) / soft_span)
        )
        a2 = copysign(softened_magnitude, a2)
    end

    # Project only dynamically unsafe posterior motion away from its approached
    # angle boundary. The risk is kinetic stopping distance divided by the
    # remaining buffered margin, so a fast stroke is constrained earlier than
    # a slow one. This mechanical invariant is independent of target distance:
    # a held-out route cannot disable joint protection away from the target.
    angle_limit = max(params.joint_angle_limit, eps(Float64))
    angle_buffer = clamp(
        params.joint_angle_buffer,
        0.0,
        angle_limit,
    )
    motion_direction = qd2 > 0.0 ? 1.0 : qd2 < 0.0 ? -1.0 : 0.0
    outward_speed = abs(qd2)
    remaining_margin = motion_direction == 0.0 ? angle_limit : max(
        angle_limit - motion_direction * q2 - angle_buffer,
        0.0,
    )
    stopping_distance = outward_speed^2 / (2.0 * acceleration_limit)
    stopping_risk = stopping_distance / max(
        remaining_margin,
        eps(Float64),
    )
    risk_onset = clamp(
        params.stopping_risk_onset,
        0.0,
        1.0 - eps(Float64),
    )
    risk_fraction = clamp(
        (stopping_risk - risk_onset) / (1.0 - risk_onset),
        0.0,
        1.0,
    )
    barrier_gate = risk_fraction^2 * (3.0 - 2.0 * risk_fraction)
    outward_acceleration_ceiling =
        (1.0 - 2.0 * barrier_gate) * acceleration_limit
    if motion_direction != 0.0 && barrier_gate > 0.0
        directional_a2 = motion_direction * a2
        a2 = motion_direction * min(
            directional_a2,
            outward_acceleration_ceiling,
        )
    end

    # Retain an exact identity region for the useful carrier, then blend into
    # a velocity-margin barrier only near the buffered speed boundary. This
    # avoids the broad low-speed intervention of an always-active class-K
    # ceiling while preserving braking authority for a violating state.
    velocity_limit = max(params.joint_velocity_limit, eps(Float64))
    velocity_buffer_fraction = clamp(
        params.joint_velocity_buffer_fraction,
        0.0,
        1.0 - eps(Float64),
    )
    safe_velocity_fraction = 1.0 - velocity_buffer_fraction
    velocity_identity_fraction = clamp(
        params.velocity_identity_fraction,
        0.0,
        safe_velocity_fraction - eps(Float64),
    )
    velocity_barrier_rate = max(
        params.velocity_barrier_gain * omega,
        eps(Float64),
    )

    motion_direction1 = qd1 > 0.0 ? 1.0 : qd1 < 0.0 ? -1.0 : 0.0
    normalized_speed1 = abs(qd1) / velocity_limit
    speed_risk_fraction1 = clamp(
        (normalized_speed1 - velocity_identity_fraction) /
        max(
            safe_velocity_fraction - velocity_identity_fraction,
            eps(Float64),
        ),
        0.0,
        1.0,
    )
    speed_gate1 = speed_risk_fraction1^2 *
        (3.0 - 2.0 * speed_risk_fraction1)
    if motion_direction1 != 0.0 && speed_gate1 > 0.0
        velocity_margin1 = safe_velocity_fraction - normalized_speed1
        barrier_ceiling1 = clamp(
            velocity_barrier_rate * velocity_limit * velocity_margin1,
            -acceleration_limit,
            acceleration_limit,
        )
        outward_ceiling1 = (1.0 - speed_gate1) * acceleration_limit +
            speed_gate1 * barrier_ceiling1
        directional_a1 = motion_direction1 * a1
        a1 = motion_direction1 * min(directional_a1, outward_ceiling1)
    end

    motion_direction2 = qd2 > 0.0 ? 1.0 : qd2 < 0.0 ? -1.0 : 0.0
    normalized_speed2 = abs(qd2) / velocity_limit
    speed_risk_fraction2 = clamp(
        (normalized_speed2 - velocity_identity_fraction) /
        max(
            safe_velocity_fraction - velocity_identity_fraction,
            eps(Float64),
        ),
        0.0,
        1.0,
    )
    speed_gate2 = speed_risk_fraction2^2 *
        (3.0 - 2.0 * speed_risk_fraction2)
    if motion_direction2 != 0.0 && speed_gate2 > 0.0
        velocity_margin2 = safe_velocity_fraction - normalized_speed2
        barrier_ceiling2 = clamp(
            velocity_barrier_rate * velocity_limit * velocity_margin2,
            -acceleration_limit,
            acceleration_limit,
        )
        outward_ceiling2 = (1.0 - speed_gate2) * acceleration_limit +
            speed_gate2 * barrier_ceiling2
        directional_a2 = motion_direction2 * a2
        a2 = motion_direction2 * min(directional_a2, outward_ceiling2)
    end

    return (phi_ddot=(a1, a2),)
end
