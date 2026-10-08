# Soft-kneed rhythmic carrier with separate velocity-course steering and a
# continuous posterior viability projection. Joint state remains the only
# carrier phase.

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
        carrier_soft_knee_fraction=0.80,
        carrier_soft_ceiling_fraction=0.95,
        steering_reserve_fraction=0.35,
        joint_angle_limit=45.0 * pi / 180,
        joint_angle_buffer=2.0 * pi / 180,
        stopping_risk_onset=0.60,
    )
end

function _soften_carrier_acceleration(
    request,
    acceleration_limit,
    knee_fraction,
    ceiling_fraction,
)
    limit = max(Float64(acceleration_limit), eps(Float64))
    finite_request = isfinite(request) ? Float64(request) : 0.0
    knee_ratio = clamp(Float64(knee_fraction), 0.0, 1.0)
    ceiling_ratio = clamp(Float64(ceiling_fraction), knee_ratio, 1.0)
    knee = knee_ratio * limit
    ceiling = ceiling_ratio * limit
    magnitude = abs(finite_request)
    magnitude <= knee && return finite_request

    # This odd C1 soft knee preserves carrier sign and small-signal dynamics.
    # Unlike a hard clamp, its slope changes continuously at the knee and its
    # rhythmic demand retains deliberate headroom below the physical envelope.
    span = max(ceiling - knee, eps(Float64))
    softened_magnitude = knee + span * tanh((magnitude - knee) / span)
    return sign(finite_request) * softened_magnitude
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

    acceleration_limit = max(
        params.joint_acceleration_limit,
        eps(Float64),
    )

    # Preserve the demonstrated zero-centered anterior oscillator and soften
    # only its high rhythmic acceleration demand before the actuator clips it.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    raw_a1 = vdp_drive - omega^2 * q1
    a1 = _soften_carrier_acceleration(
        raw_a1,
        acceleration_limit,
        params.carrier_soft_knee_fraction,
        params.carrier_soft_ceiling_fraction,
    )

    # Decompose posterior acceleration into traveling-carrier and mean-steering
    # work. The soft knee acts only on the carrier; target feedback remains a
    # separately signed residual instead of being scaled with propulsion.
    lagged_carrier = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    raw_carrier_a2 = omega^2 * (lagged_carrier - q2) -
        2 * params.tail_damping * omega * qd2
    carrier_a2 = _soften_carrier_acceleration(
        raw_carrier_a2,
        acceleration_limit,
        params.carrier_soft_knee_fraction,
        params.carrier_soft_ceiling_fraction,
    )
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

    # Defensively keep the composed residual and full-authority barrier inside
    # the same acceleration envelope enforced by the actuator.
    feasible_a1 = clamp(a1, -acceleration_limit, acceleration_limit)
    feasible_a2 = clamp(a2, -acceleration_limit, acceleration_limit)

    return (phi_ddot=(feasible_a1, feasible_a2),)
end
