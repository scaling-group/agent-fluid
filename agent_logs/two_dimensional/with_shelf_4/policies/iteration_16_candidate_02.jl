function target_policy_params()
    return (
        control_period=0.72,
        oscillator_amplitude=22.0 * pi / 180,
        oscillator_mu=0.4,
        bearing_scale=25.0 * pi / 180,
        bearing_rate_scale=0.5,
        bearing_rate_damping=0.2,
        closing_speed_scale=0.05,
        course_alignment_gain=0.12,
        half_cycle_asymmetry=0.3,
        phase_softness=0.35,
        tail_lag_gain=0.65,
        tail_damping=0.7,
        moment_scale=0.08,
        moment_rejection_gain=0.15,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

    # Persistent body-frame bearing owns the route. Qualify its windowed-rate
    # damping with measured target-distance progress: alignment change alone
    # can be body spin, while positive closing speed confirms useful response.
    # This keeps the redirect firm until it produces translation, then restores
    # the sampled damping continuously without a hidden mode or time schedule.
    bearing = Float64(state.bearing)
    bearing_error = bearing / params.bearing_scale
    bearing_rate = tanh(
        Float64(state.bearing_window_rate) / params.bearing_rate_scale,
    )
    closing_progress = tanh(
        max(Float64(state.window_closing_speed_L), 0.0) /
        params.closing_speed_scale,
    )

    # Heading toward the target and translating toward it are not equivalent
    # in a lateral wake. Compare the observed body-velocity direction with the
    # target bearing, but let this course correction earn authority only after
    # the existing distance history confirms targetward motion. The angular
    # construction is scale-free and vanishes continuously at zero speed.
    velocity_forward = -Float64(state.velocity_body_U[1])
    velocity_lateral = Float64(state.velocity_body_U[2])
    velocity_speed = hypot(velocity_forward, velocity_lateral)
    course_bearing = atan(
        velocity_lateral,
        max(abs(velocity_forward), 0.25 * velocity_speed, eps(Float64)),
    )
    course_error = atan(
        sin(bearing - course_bearing),
        cos(bearing - course_bearing),
    )
    course_correction = params.course_alignment_gain * closing_progress *
        tanh(course_error / params.bearing_scale)
    route_turn = tanh(
        bearing_error +
        params.bearing_rate_damping * closing_progress * bearing_rate +
        course_correction,
    )

    # Retain the best sampled policy's smaller, direct normalized yaw-load
    # residual. It trims fast wake disturbances without concentrating its
    # authority near zero bearing or assuming an external vortex phase.
    wake_turn = params.moment_rejection_gain * tanh(
        Float64(state.moment_z_L2) / params.moment_scale,
    )
    turn_request = clamp(route_turn + wake_turn, -1.0, 1.0)

    # Infer the active beat side from joint state and strengthen only the
    # requested half-cycle.  The restoring equilibrium stays at zero, retaining
    # the successful alternating propulsion while route and wake terms vanish.
    phase_coordinate = (q1 + qd1 / max(omega, eps(omega))) / amp
    beat_side = tanh(phase_coordinate / params.phase_softness)
    half_cycle_amplitude = amp * (
        1 + params.half_cycle_asymmetry * turn_request * beat_side
    )

    normalized_position = q1 / half_cycle_amplitude
    normalized_velocity = qd1 / (omega * half_cycle_amplitude)
    radius_squared = normalized_position^2 + normalized_velocity^2
    radial_drive = params.oscillator_mu * omega *
        (1 - clamp(radius_squared, 0.0, 4.0)) * qd1
    a1 = radial_drive - omega^2 * q1

    # Preserve the posterior-lagged traveling bend.  The load residual acts
    # only through the anterior half-cycle envelope, so it cannot replace the
    # tail's alternating propulsive target with a separate steering offset.
    tail_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
