# Collision-cone burst redirect on a course-residual traveling bend.
# Body-frame target and velocity predict the closest pass; excess terminal
# miss recruits bounded mean curvature, then releases into the full carrier.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        maximum_navigation_error=pi / 2,
        course_speed_scale=0.25,
        steering_softness=0.35,
        cruise_half_cycle_asymmetry=0.35,
        redirect_half_cycle_asymmetry=0.65,
        course_redirect_scale=0.35,
        head_asymmetry_share=0.65,
        tail_asymmetry_share=1.0,
        terminal_distance=3.0,
        terminal_distance_width=0.5,
        collision_cone_radius=0.60,
        collision_cone_softness=0.20,
        collision_direction_scale=0.35,
        collision_closing_speed_scale=0.35,
        collision_speed_floor=0.20,
        maximum_burst_mean_bend=12.0 * pi / 180,
        minimum_burst_course_share=0.35,
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

    fallback_bearing = isfinite(state.bearing) ? Float64(state.bearing) : 0.0
    target_x = isfinite(state.target_body_L[1]) ?
        Float64(state.target_body_L[1]) : -1.0
    target_y = isfinite(state.target_body_L[2]) ?
        Float64(state.target_body_L[2]) : 0.0
    velocity_x = isfinite(state.velocity_body_U[1]) ?
        Float64(state.velocity_body_U[1]) : 0.0
    velocity_y = isfinite(state.velocity_body_U[2]) ?
        Float64(state.velocity_body_U[2]) : 0.0
    distance = isfinite(state.distance_L) ?
        max(Float64(state.distance_L), 0.0) :
        params.terminal_distance + 4 * params.terminal_distance_width

    # Body forward is -x. Target and velocity share the body frame, so the
    # target/course mismatch is independent of instantaneous world heading.
    # Reflection symmetry leaves the measure-zero exactly-aft case unbiased.
    target_norm = hypot(target_x, target_y)
    aft_tolerance = sqrt(eps(Float64)) * max(target_norm, 1.0)
    directly_aft = target_x > 0 && abs(target_y) <= aft_tolerance
    pursuit_error = if target_norm <= eps(Float64)
        fallback_bearing
    elseif directly_aft
        0.0
    else
        atan(target_y, -target_x)
    end

    speed = hypot(velocity_x, velocity_y)
    speed_squared = speed^2
    course_cross = target_x * velocity_y - target_y * velocity_x
    course_dot = target_x * velocity_x + target_y * velocity_y
    course_scale = target_norm * speed
    antiparallel = course_dot < 0 && abs(course_cross) <=
        sqrt(eps(Float64)) * max(course_scale, eps(Float64))
    course_error = if speed <= eps(Float64) || target_norm <= eps(Float64)
        pursuit_error
    elseif antiparallel
        pursuit_error
    else
        atan(course_cross, course_dot)
    end

    maximum_error = max(abs(params.maximum_navigation_error), eps(Float64))
    bounded_pursuit = clamp(pursuit_error, -maximum_error, maximum_error)
    bounded_course_error = clamp(course_error, -maximum_error, maximum_error)
    speed_scale = max(abs(params.course_speed_scale), eps(Float64))
    course_weight = speed_squared / (speed_squared + speed_scale^2)
    navigation_error = (1 - course_weight) * bounded_pursuit +
        course_weight * bounded_course_error
    turn_request = tanh(
        navigation_error / max(abs(params.steering_softness), eps(Float64)),
    )

    # Constant-velocity closest approach provides a state-based collision
    # cone. The target is stationary in the task frame, so future relative
    # displacement is target - velocity*time. Projection is active only while
    # the observed course is closing; it uses no clock or remembered route.
    speed_floor = max(abs(params.collision_speed_floor), eps(Float64))
    projection_time = max(course_dot, 0.0) /
        max(speed_squared, speed_floor^2)
    closest_x = target_x - projection_time * velocity_x
    closest_y = target_y - projection_time * velocity_y
    predicted_miss = hypot(closest_x, closest_y)
    closing_speed = target_norm > eps(Float64) ?
        course_dot / target_norm : 0.0

    terminal_width = max(abs(params.terminal_distance_width), eps(Float64))
    terminal_gate = 0.5 * (
        1 - tanh((distance - params.terminal_distance) / terminal_width)
    )
    closing_gate = tanh(
        max(closing_speed, 0.0) /
        max(abs(params.collision_closing_speed_scale), eps(Float64)),
    )
    miss_excess = max(
        predicted_miss - abs(params.collision_cone_radius),
        0.0,
    )
    miss_gate = tanh(
        miss_excess /
        max(abs(params.collision_cone_softness), eps(Float64)),
    )

    # Signed perpendicular miss is course_cross/speed. Positive is the same
    # request sign used by the inherited course controller. The assigned
    # parent established that its corrective common-bend response has the
    # opposite sign, so only the terminal burst carries this minus mapping.
    signed_miss = course_cross / max(speed, speed_floor)
    burst_direction = tanh(
        signed_miss /
        max(abs(params.collision_direction_scale), eps(Float64)),
    )
    burst_weight = terminal_gate * closing_gate * miss_gate
    terminal_mean_bend = -burst_weight *
        abs(params.maximum_burst_mean_bend) * burst_direction

    # Center the anterior oscillator and posterior traveling target on the
    # burst curvature. When the collision cone becomes safe, the mean returns
    # smoothly to zero and the full opposed posterior-lag beat is restored.
    q1_centered = q1 - terminal_mean_bend
    vdp_drive = params.oscillator_mu *
        (1 - (q1_centered / amp)^2) * qd1
    carrier_a1 = vdp_drive - omega^2 * q1_centered
    phase_lag_target = 2 * terminal_mean_bend - q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    carrier_a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Course misalignment retains the evidenced half-cycle redirect. During a
    # burst it yields part, but not all, of steering authority to mean
    # curvature; release restores the unmodified far/middle controller.
    redirect_gate = tanh(
        abs(sin(bounded_course_error)) /
        max(abs(params.course_redirect_scale), eps(Float64)),
    ) * course_weight
    asymmetry_limit = params.cruise_half_cycle_asymmetry +
        redirect_gate * (
            params.redirect_half_cycle_asymmetry -
            params.cruise_half_cycle_asymmetry
        )
    minimum_course_share = clamp(
        params.minimum_burst_course_share,
        0.0,
        1.0,
    )
    course_share = 1 - burst_weight * (1 - minimum_course_share)
    asymmetry = course_share * asymmetry_limit * turn_request

    raw_a1 = carrier_a1 +
        params.head_asymmetry_share * asymmetry * abs(carrier_a1)
    raw_a2 = carrier_a2 +
        params.tail_asymmetry_share * asymmetry * abs(carrier_a2)
    limit = abs(params.maximum_joint_acceleration)
    bounded_a1 = limit * tanh(raw_a1 / max(limit, eps(Float64)))
    bounded_a2 = limit * tanh(raw_a2 / max(limit, eps(Float64)))

    return (
        phi_ddot=(bounded_a1, bounded_a2),
    )
end
