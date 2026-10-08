# Course tracking with terminal, predicted-miss counterstroke relief.
# Joint state remains the only source of propulsive and steering beat phase.

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
        terminal_distance_L=2.5,
        terminal_distance_width_L=1.0,
        terminal_closing_on_U=0.10,
        terminal_closing_width_U=0.30,
        terminal_miss_on_L=0.55,
        terminal_miss_width_L=0.20,
        terminal_counterstroke_relief=0.40,
        terminal_phase_angle=10.0 * pi / 180,
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
    target_x = Float64(state.target_body_L[1])
    target_y = Float64(state.target_body_L[2])
    finite_target = isfinite(target_x) && isfinite(target_y)
    raw_folded_bearing = Float64(state.bearing)
    fallback_bearing = isfinite(raw_folded_bearing) ?
        raw_folded_bearing : 0.0
    raw_full_bearing = finite_target ?
        atan(target_y, -target_x) : fallback_bearing
    full_bearing = clamp(
        raw_full_bearing,
        -params.full_bearing_limit,
        params.full_bearing_limit,
    )

    # Compare the velocity course with the target ray once translation is
    # meaningful. This body-frame angle cancels body heading and detects the
    # cross-target drift that the inherited linear slip residual missed.
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

    # Preserve the evidenced zero-centered anterior traveling-wave carrier.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1

    # Constant-course miss distance is a normalized collision-corridor signal:
    # |target x velocity| / |velocity|. It activates terminal allocation only
    # while close, still closing, and geometrically on course to miss capture.
    raw_distance_L = Float64(state.distance_L)
    distance_L = isfinite(raw_distance_L) ? max(raw_distance_L, 0.0) : Inf
    proximity_fraction = clamp(
        (params.terminal_distance_L - distance_L) /
        max(params.terminal_distance_width_L, eps(Float64)),
        0.0,
        1.0,
    )
    proximity_gate = proximity_fraction^2 *
        (3.0 - 2.0 * proximity_fraction)

    target_distance = finite_target ? hypot(target_x, target_y) : 0.0
    closing_projection = finite_target &&
        target_distance > eps(Float64) ?
        (target_x * forward_velocity + target_y * lateral_velocity) /
            target_distance : 0.0
    closing_fraction = clamp(
        (closing_projection - params.terminal_closing_on_U) /
        max(params.terminal_closing_width_U, eps(Float64)),
        0.0,
        1.0,
    )
    closing_gate = closing_fraction^2 * (3.0 - 2.0 * closing_fraction)

    predicted_miss_L = finite_target && course_speed > eps(Float64) ?
        abs(target_x * lateral_velocity -
            target_y * forward_velocity) / course_speed : 0.0
    miss_fraction = clamp(
        (predicted_miss_L - params.terminal_miss_on_L) /
        max(params.terminal_miss_width_L, eps(Float64)),
        0.0,
        1.0,
    )
    miss_gate = miss_fraction^2 * (3.0 - 2.0 * miss_fraction)
    terminal_gate = proximity_gate * closing_gate * miss_gate

    # Broad-approach data associate the sign of anterior angle with yaw-moment
    # sign. During a predicted terminal miss, attenuate only the posterior
    # carrier half that opposes requested yaw; the useful half and anterior
    # oscillator remain active, avoiding the fixed joints of prior holds.
    phase_side = tanh(
        q1 / max(params.terminal_phase_angle, eps(Float64)),
    )
    opposing_fraction = 0.5 * (1.0 - turn_request * phase_side)
    counterstroke_relief = clamp(
        params.terminal_counterstroke_relief * terminal_gate *
            abs(turn_request) * opposing_fraction,
        0.0,
        params.terminal_counterstroke_relief,
    )

    mean_tail_tangent = params.turn_curvature_limit * turn_request
    carrier_tail_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(Float64))
    tail_target = mean_tail_tangent +
        (1.0 - counterstroke_relief) * carrier_tail_target
    a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
