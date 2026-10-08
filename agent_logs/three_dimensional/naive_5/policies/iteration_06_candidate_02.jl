# Traveling-bend propulsion with course-angle unilateral pump allocation.
# Gait phase and route error come only from normalized body-frame state.

function target_policy_params()
    return (
        control_period=0.90,
        oscillator_amplitude=18.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        bearing_limit=1.0,
        bearing_scale=0.35,
        course_angle_limit=1.50,
        course_angle_scale=0.55,
        course_speed_scale=0.20,
        phase_velocity_scale=0.60,
        phase_pump_acceleration=6.0,
        opposing_pump_attenuation=0.90,
        steering_angle_soft_limit=36.0 * pi / 180,
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

    # Retain the sampled traveling-bend scaffold. Joint velocity is the
    # observable gait phase; no clock or stored phase is introduced.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    carrier_a1 = vdp_drive - omega^2 * q1
    phase_velocity = tanh(
        qd1 /
        (max(omega * amp, eps(Float64)) * params.phase_velocity_scale),
    )

    # Use the full signed angle from measured course to target. Unlike a
    # cross-product sine alone, the dot product distinguishes approach from a
    # target that is behind after overshoot. Bearing supplies a defined launch
    # request while course is unreliable at very low speed.
    bearing = clamp(
        Float64(state.bearing),
        -params.bearing_limit,
        params.bearing_limit,
    )
    target_x = Float64(state.target_body_L[1])
    target_y = Float64(state.target_body_L[2])
    velocity_x = Float64(state.velocity_body_U[1])
    velocity_y = Float64(state.velocity_body_U[2])
    speed2 = velocity_x^2 + velocity_y^2
    target_distance2 = target_x^2 + target_y^2
    vector_scale = max(sqrt(speed2 * target_distance2), eps(Float64))
    course_sine = clamp(
        (velocity_x * target_y - velocity_y * target_x) / vector_scale,
        -1.0,
        1.0,
    )
    course_cosine = clamp(
        (velocity_x * target_x + velocity_y * target_y) / vector_scale,
        -1.0,
        1.0,
    )
    course_angle = clamp(
        atan(course_sine, course_cosine),
        -params.course_angle_limit,
        params.course_angle_limit,
    )
    speed_scale2 = params.course_speed_scale^2
    course_weight = speed2 / (speed2 + speed_scale2)

    # The direct-course sample calibrated positive course error to the negative
    # anterior half-stroke. Create that asymmetry by withholding pump energy
    # on the opposing stroke rather than adding acceleration into active caps.
    bearing_side = tanh(bearing / params.bearing_scale)
    course_side = -tanh(course_angle / params.course_angle_scale)
    turn_side = clamp(
        (1 - course_weight) * bearing_side +
        course_weight * course_side,
        -1.0,
        1.0,
    )
    opposing_stroke_weight = 0.5 * (1 - turn_side * phase_velocity)
    pump_scale = clamp(
        1 - params.opposing_pump_attenuation *
            abs(turn_side) * opposing_stroke_weight,
        1 - params.opposing_pump_attenuation,
        1.0,
    )
    phase_pump = params.phase_pump_acceleration *
        pump_scale * phase_velocity

    # Fade pump energy before the anterior hard limit. The restoring carrier
    # remains active so neither gate can latch the joint at a soft boundary.
    angle_ratio = abs(q1) / params.steering_angle_soft_limit
    angle_headroom = clamp(1 - angle_ratio^4, 0.0, 1.0)
    a1 = carrier_a1 + angle_headroom * phase_pump

    # Preserve the posterior state-feedback lag that generated every useful
    # long, coherent three-dimensional wake in the sampled lineage.
    tail_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(Float64))
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
