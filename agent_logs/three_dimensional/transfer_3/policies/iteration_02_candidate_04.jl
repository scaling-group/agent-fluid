# Phase-2 candidate: course-stabilized, zero-mean tail half-cycle steering.
# Carrier phase comes only from joint state; route feedback uses normalized
# body-frame target and velocity vectors and contains no clock or fixed route.

function target_policy_params()
    return (
        version="dogfish3d_course_halfcycle_v1",

        # Intermediate traveling-bend carrier: faster and broader than the
        # parent's nonpropulsive gait, but guarded below the episode limit.
        control_period=0.90,
        oscillator_amplitude=14.0 * pi / 180,
        oscillator_mu=0.35,
        tail_amplitude_ratio=1.18,
        tail_phase_lag=85.0 * pi / 180,
        tail_damping=0.80,

        # Velocity/target course feedback cancels common body-yaw oscillation.
        # Bearing supplies a bounded fallback only before useful surge exists.
        course_speed_scale=0.12,
        target_angle_limit=1.25,
        steering_error_scale=0.35,
        startup_steering_fraction=0.25,
        tail_halfcycle_asymmetry_limit=0.22,
        phase_radius_floor=2.0 * pi / 180,

        # This guard is below the immutable 1800 deg/T^2 evaluator envelope.
        command_acceleration_limit=1750.0 * pi / 180,
    )
end

@inline function _finite_or(value, fallback)
    parsed = Float64(value)
    return isfinite(parsed) ? parsed : fallback
end

function course_guidance(state, params)
    distance = max(_finite_or(state.distance_L, 1.0), 1.0e-6)
    target_x = _finite_or(state.target_body_L[1], -distance)
    target_y = _finite_or(state.target_body_L[2], 0.0)
    target_norm = max(hypot(target_x, target_y), 1.0e-6)

    bearing_fallback = atan(target_y, max(abs(target_x), 0.25))
    bearing = clamp(
        _finite_or(state.bearing, bearing_fallback),
        -params.target_angle_limit,
        params.target_angle_limit,
    )

    velocity_x = _finite_or(state.velocity_body_U[1], 0.0)
    velocity_y = _finite_or(state.velocity_body_U[2], 0.0)
    speed = hypot(velocity_x, velocity_y)
    course_weight = speed / (speed + max(params.course_speed_scale, 1.0e-6))

    # The signed angle from velocity to target is invariant to the shared body
    # rotation. Negating it matches the evidenced convention: a positive
    # request drives positive tail asymmetry and therefore negative world yaw.
    course_cross =
        (velocity_x * target_y - velocity_y * target_x) /
        max(speed * target_norm, 1.0e-6)
    course_dot =
        (velocity_x * target_x + velocity_y * target_y) /
        max(speed * target_norm, 1.0e-6)
    course_error = speed > 1.0e-6 ?
        clamp(
            -atan(course_cross, course_dot),
            -params.target_angle_limit,
            params.target_angle_limit,
        ) : bearing

    steering_error =
        (1.0 - course_weight) * bearing + course_weight * course_error
    steering_authority =
        params.startup_steering_fraction +
        (1.0 - params.startup_steering_fraction) * course_weight
    halfcycle_asymmetry =
        params.tail_halfcycle_asymmetry_limit * steering_authority *
        tanh(steering_error / max(params.steering_error_scale, 1.0e-6))

    return (
        steering_error=steering_error,
        course_weight=course_weight,
        halfcycle_asymmetry=halfcycle_asymmetry,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amplitude = params.oscillator_amplitude
    q1 = _finite_or(state.phi[1], 0.0)
    q2 = _finite_or(state.phi[2], 0.0)
    qd1 = _finite_or(state.phi_dot[1], 0.0)
    qd2 = _finite_or(state.phi_dot[2], 0.0)

    # A Van der Pol state oscillator maintains the anterior carrier without an
    # external phase. The posterior target is its lagged, emphasized quadrature.
    anterior_drive =
        params.oscillator_mu * (1.0 - (q1 / amplitude)^2) * qd1
    anterior_accel = anterior_drive - omega^2 * q1

    quadrature = qd1 / max(omega, eps(Float64))
    phase_radius = max(hypot(q1, quadrature), params.phase_radius_floor)
    lagged_sine =
        cos(params.tail_phase_lag) * q1 -
        sin(params.tail_phase_lag) * quadrature

    # abs(sin(phase))-2/pi has exactly zero cycle mean. Multiplying this
    # joint-state phase shape by the bounded route request strengthens one
    # posterior half-cycle without introducing the failed static C-bend.
    normalized_lagged_sine = clamp(lagged_sine / phase_radius, -1.0, 1.0)
    zero_mean_halfcycle = abs(normalized_lagged_sine) - 2.0 / pi
    guidance = course_guidance(state, params)
    shaped_lagged_wave =
        lagged_sine +
        phase_radius * guidance.halfcycle_asymmetry * zero_mean_halfcycle
    posterior_target = params.tail_amplitude_ratio * shaped_lagged_wave
    posterior_accel =
        omega^2 * (posterior_target - q2) -
        2.0 * params.tail_damping * omega * qd2

    limit = max(params.command_acceleration_limit, 1.0e-6)
    return (
        phi_ddot=(
            clamp(anterior_accel, -limit, limit),
            clamp(posterior_accel, -limit, limit),
        ),
    )
end
