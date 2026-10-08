# Terminal posterior counter-moment allocation around the reproduced
# velocity-course controller. Joint state remains the only carrier phase.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        turn_curvature_limit=12.0 * pi / 180,
        terminal_distance_L=2.5,
        terminal_width_L=1.5,
        terminal_counterstroke_relief=0.50,
        terminal_phase_angle=8.0 * pi / 180,
        full_bearing_limit=pi,
        steering_scale=0.20,
        velocity_limit_U=1.5,
        course_speed_on_U=0.15,
        course_speed_width_U=0.30,
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

    # Compare actual swimming course with the target ray once translation is
    # measurable. The wrapped body-frame mismatch corrects cross-track drift
    # without a world route or an external phase.
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

    # Keep the demonstrated zero-centered anterior oscillator unchanged. Its
    # angle supplies observed beat side but receives no scheduled stiffness,
    # amplitude, offset, or damping change.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1

    # Below 2.5L, allocate posterior carrier amplitude by the calibrated
    # anterior-angle phase. In the inherited terminal trace,
    # turn_request*q1 > 0 marks the half-cycle with counterproductive yaw
    # moment. Attenuate only that oscillatory tail stroke; retain the useful
    # half and the bounded mean-curvature request in full.
    raw_distance = Float64(state.distance_L)
    distance = isfinite(raw_distance) ? max(raw_distance, 0.0) : Inf
    terminal_fraction = clamp(
        (params.terminal_distance_L - distance) /
        max(params.terminal_width_L, eps(Float64)),
        0.0,
        1.0,
    )
    terminal_gate = terminal_fraction^2 *
        (3.0 - 2.0 * terminal_fraction)
    counterstroke_phase = 0.5 * (1.0 + tanh(
        turn_request * q1 /
        max(params.terminal_phase_angle, eps(Float64)),
    ))
    allocation_gate = terminal_gate * abs(turn_request) *
        counterstroke_phase
    carrier_scale = 1.0 - params.terminal_counterstroke_relief *
        allocation_gate

    mean_tail_tangent = params.turn_curvature_limit * turn_request
    carrier_tail_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    tail_target = mean_tail_tangent + carrier_scale * carrier_tail_target
    a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
