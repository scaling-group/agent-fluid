# Terminal posterior half-cycle allocation around the inherited body-frame
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
        terminal_phase_distance_L=3.0,
        terminal_phase_width_L=2.0,
        phase_error_on=0.35,
        phase_error_width=0.55,
        tail_counter_moment_relief=0.55,
        moment_phase_angle=10.0 * pi / 180,
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
    # measurable. Both angles are body-frame quantities, so the wrapped error
    # corrects cross-track drift without a world route or external phase.
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

    # Preserve the inherited zero-centered anterior oscillator exactly. Its
    # observed angle supplies beat side but receives no stiffness, amplitude,
    # damping, or center modulation.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1

    # Restrict phase allocation to the terminal regime with unresolved course
    # error. This leaves the evidenced broad approach bit-for-bit unchanged.
    raw_distance = Float64(state.distance_L)
    distance = isfinite(raw_distance) ? max(raw_distance, 0.0) : Inf
    terminal_fraction = clamp(
        (params.terminal_phase_distance_L - distance) /
        max(params.terminal_phase_width_L, eps(Float64)),
        0.0,
        1.0,
    )
    terminal_gate = terminal_fraction^2 *
        (3.0 - 2.0 * terminal_fraction)
    error_fraction = clamp(
        (abs(course_error) - params.phase_error_on) /
        max(params.phase_error_width, eps(Float64)),
        0.0,
        1.0,
    )
    error_gate = error_fraction^2 * (3.0 - 2.0 * error_fraction)

    # Sampled traces associate yaw-moment sign with anterior-angle sign, while
    # required yaw has sign opposite turn_request. Hence halves whose q1 sign
    # matches turn_request are counter-moment halves. Relieve only their
    # posterior traveling component; the useful half remains at full strength.
    phase_side = tanh(
        q1 / max(params.moment_phase_angle, eps(Float64)),
    )
    counter_moment_phase = clamp(
        turn_request * phase_side,
        0.0,
        1.0,
    )
    relief_gate = terminal_gate * error_gate * counter_moment_phase
    carrier_scale = 1.0 -
        params.tail_counter_moment_relief * relief_gate

    # Keep the inherited 12-degree mean-curvature channel and posterior lag.
    # Distance or alignment continuously restores the symmetric carrier.
    mean_tail_tangent = params.turn_curvature_limit * turn_request
    carrier_tail_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    tail_target = mean_tail_tangent + carrier_scale * carrier_tail_target
    a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
