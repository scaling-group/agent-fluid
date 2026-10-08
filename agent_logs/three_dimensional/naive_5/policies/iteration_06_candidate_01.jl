# Phase-separated propulsion with distributed half-cycle wave steering.
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
        course_error_limit=1.0,
        course_error_scale=0.50,
        course_speed_scale=0.20,
        phase_velocity_scale=0.60,
        phase_pump_acceleration=6.0,
        half_cycle_acceleration=3.0,
        tail_wave_asymmetry=0.30,
        tail_acceleration_headroom_exponent=4.0,
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

    # Retain the sampled traveling-bend scaffold. The explicit symmetric pump
    # preserves the useful role that raw beat-frequency yaw accidentally played
    # in the strongest rollout, without treating it as a target response.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    carrier_a1 = vdp_drive - omega^2 * q1
    phase_velocity = tanh(
        qd1 /
        (max(omega * amp, eps(Float64)) * params.phase_velocity_scale),
    )
    phase_pump = params.phase_pump_acceleration * phase_velocity

    # Select the turn side from slow route geometry, not gait-contaminated
    # instantaneous yaw. At low speed bearing supplies a defined request. Once
    # translation is observable, the normalized velocity/target cross product
    # reports which side of the target the measured course will pass.
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

    # The sampled response-gated parent is the only policy that lowered the
    # high-y corridor: its effective selector has the same sign as bearing and
    # the opposite sign from course error. Preserve that measured allocation.
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

    # Fade added energy before the anterior hard limit. The restoring carrier
    # remains active so this gate cannot latch the joint at the soft boundary.
    angle_ratio = abs(q1) / params.steering_angle_soft_limit
    angle_headroom = clamp(1 - angle_ratio^4, 0.0, 1.0)
    a1 = carrier_a1 + angle_headroom * (phase_pump + half_cycle_drive)
    limit = params.acceleration_limit

    # Preserve the posterior state-feedback lag that generated the coherent
    # three-dimensional wake, but distribute that existing wave between the
    # two half-cycles using the same response-calibrated route side. This
    # signed-absolute transform strengthens one posterior excursion while
    # weakening the other; at zero route error it is exactly the parent wave.
    symmetric_tail_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(Float64))
    tail_target = symmetric_tail_target +
        params.tail_wave_asymmetry * turn_side * abs(symmetric_tail_target)
    symmetric_a2 = omega^2 * (symmetric_tail_target - q2) -
        2 * params.tail_damping * omega * qd2
    tail_wave_drive = omega^2 * (tail_target - symmetric_tail_target)

    # Spend only unused posterior acceleration authority on the new spatial
    # allocation. A saturated parent command is left unchanged, while the
    # redistribution fades smoothly as the symmetric tail command approaches
    # the envelope.
    tail_acceleration_ratio = abs(symmetric_a2) /
        max(limit, eps(Float64))
    tail_acceleration_headroom = clamp(
        1 - tail_acceleration_ratio^params.tail_acceleration_headroom_exponent,
        0.0,
        1.0,
    )
    a2 = symmetric_a2 + tail_acceleration_headroom * tail_wave_drive

    return (
        phi_ddot=(
            clamp(a1, -limit, limit),
            clamp(a2, -limit, limit),
        ),
    )
end
