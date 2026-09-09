# Velocity-compensated terminal aim on a course-residual traveling bend.
# The far-field carrier is unchanged; near-target mean curvature anticipates
# measured body velocity over one bounded response horizon.

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
        maximum_terminal_mean_bend=8.0 * pi / 180,
        minimum_terminal_course_share=0.35,
        maximum_intercept_horizon=0.75,
        intercept_speed_floor=0.25,
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
    # target/course angle is invariant to world yaw. Reflection symmetry leaves
    # the exactly-aft centerline unbiased.
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
    course_weight = speed^2 / (speed^2 + speed_scale^2)
    navigation_error = (1 - course_weight) * bounded_pursuit +
        course_weight * bounded_course_error
    turn_request = tanh(
        navigation_error / max(abs(params.steering_softness), eps(Float64)),
    )

    terminal_width = max(abs(params.terminal_distance_width), eps(Float64))
    terminal_gate = 0.5 * (
        1 - tanh((distance - params.terminal_distance) / terminal_width)
    )

    # Project the observed body velocity through at most one controller-owned
    # response horizon, never beyond the current time-to-target estimate. This
    # rotates the terminal aim against impending cross-target motion without a
    # clock, route, world coordinate, or static braking posture.
    intercept_floor = max(abs(params.intercept_speed_floor), eps(Float64))
    time_to_target = distance / max(speed, intercept_floor)
    intercept_horizon = min(
        abs(params.maximum_intercept_horizon),
        time_to_target,
    )
    intercept_weight = terminal_gate *
        speed^2 / (speed^2 + intercept_floor^2)
    intercept_x = target_x -
        intercept_weight * intercept_horizon * velocity_x
    intercept_y = target_y -
        intercept_weight * intercept_horizon * velocity_y
    intercept_norm = hypot(intercept_x, intercept_y)
    intercept_aft_tolerance = sqrt(eps(Float64)) * max(intercept_norm, 1.0)
    intercept_directly_aft = intercept_x > 0 &&
        abs(intercept_y) <= intercept_aft_tolerance
    intercept_error = if intercept_norm <= eps(Float64)
        bounded_pursuit
    elseif intercept_directly_aft
        0.0
    else
        atan(intercept_y, -intercept_x)
    end
    bounded_intercept_error = clamp(
        intercept_error,
        -maximum_error,
        maximum_error,
    )
    terminal_turn_request = tanh(
        bounded_intercept_error /
        max(abs(params.steering_softness), eps(Float64)),
    )
    terminal_mean_bend = terminal_gate *
        abs(params.maximum_terminal_mean_bend) * terminal_turn_request
    minimum_course_share = clamp(
        params.minimum_terminal_course_share,
        0.0,
        1.0,
    )
    course_share = 1 - terminal_gate * (1 - minimum_course_share)

    # Center the state-feedback oscillator and lagged posterior target on the
    # velocity-compensated mean while preserving the opposed traveling part.
    q1_centered = q1 - terminal_mean_bend
    vdp_drive = params.oscillator_mu *
        (1 - (q1_centered / amp)^2) * qd1
    carrier_a1 = vdp_drive - omega^2 * q1_centered
    phase_lag_target = 2 * terminal_mean_bend - q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    carrier_a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Preserve course-residual half-cycle steering, fading only to the
    # inherited nonzero terminal share as the mean-curvature channel enters.
    redirect_gate = tanh(
        abs(sin(bounded_course_error)) /
        max(abs(params.course_redirect_scale), eps(Float64)),
    ) * course_weight
    asymmetry_limit = params.cruise_half_cycle_asymmetry +
        redirect_gate * (
            params.redirect_half_cycle_asymmetry -
            params.cruise_half_cycle_asymmetry
        )
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
