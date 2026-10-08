# Moment-responsive terminal half-cycle allocation around the demonstrated
# body-frame velocity-course controller. Joint state remains the carrier phase.

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
        terminal_distance_L=4.0,
        terminal_width_L=3.0,
        terminal_error_on=0.35,
        terminal_error_width=0.55,
        moment_response_scale_L2=0.012,
        stiffness_asymmetry=0.20,
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

    # Preserve the demonstrated raw velocity-course observation. In
    # particular, do not subtract a fitted joint-rate sway term: its completed
    # rollout lost the inherited near-target trajectory.
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

    # Recruit response-based half-cycle allocation only near the target and
    # only while the measured course remains unresolved. These gates are
    # reflection invariant and vanish continuously in the broad approach.
    raw_distance = Float64(state.distance_L)
    terminal_fraction = isfinite(raw_distance) ? clamp(
        (params.terminal_distance_L - max(raw_distance, 0.0)) /
        max(params.terminal_width_L, eps(Float64)),
        0.0,
        1.0,
    ) : 0.0
    terminal_gate = terminal_fraction^2 *
        (3.0 - 2.0 * terminal_fraction)
    error_fraction = clamp(
        (abs(course_error) - params.terminal_error_on) /
        max(params.terminal_error_width, eps(Float64)),
        0.0,
        1.0,
    )
    error_gate = error_fraction^2 * (3.0 - 2.0 * error_fraction)

    # Desired yaw has sign opposite turn_request in this body convention.
    # Normalize measured hydrodynamic moment, then lengthen the useful moment
    # half-cycle and shorten the opposing one without shifting the oscillator.
    raw_moment = Float64(state.moment_z_L2)
    moment_response = isfinite(raw_moment) ? tanh(
        raw_moment /
        max(params.moment_response_scale_L2, eps(Float64)),
    ) : 0.0
    moment_alignment = -turn_request * moment_response
    allocation_gate = course_gate * terminal_gate * error_gate
    stiffness_scale = 1.0 -
        params.stiffness_asymmetry * allocation_gate * moment_alignment

    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * stiffness_scale * q1

    # Keep the complete lagged posterior carrier and its demonstrated bounded
    # mean curvature. The new mechanism neither raises the posterior cap nor
    # suppresses propulsion to manufacture terminal dwell.
    mean_tail_tangent = params.turn_curvature_limit * turn_request
    lagged_carrier = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    tail_target = mean_tail_tangent + lagged_carrier
    a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
