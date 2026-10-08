# L64 3D course-released half-cycle-lag candidate.  Preserve the transferred
# joint-state carrier and its posterior traveling-wave lag, but replace static
# mean curvature and direct steering with a small target/course-responsive
# asymmetry of the observed anterior-velocity half-cycles.  No clock, route,
# persistent bend, or world-frame direction enters the policy.

function target_policy_params(; L::Int=64)
    return (
        version="dogfish_target_control_v21_course_released_halfcycle_lag",
        L=Float64(L),
        drive_period=0.55,
        control_period=0.55,
        drive_amplitude=28.0 * pi / 180,
        drive_mu=0.35,
        drive_tail_lag_gain=0.80,
        drive_tail_damping=0.65,
        drive_frequency_min_scale=0.50,
        far_drive_frequency_gain=0.114,
        far_drive_turn_relief=0.36,
        progress_drive_frequency_gain=0.034,
        progress_closing_speed_scale=0.16,
        target_scale_floor_L=0.25,
        course_angle_limit=1.25,
        course_speed_scale=0.30,
        course_speed_power=2.0,
        turn_error_scale=0.65,
        halfcycle_lag_asymmetry=0.06,
        halfcycle_velocity_scale=0.50,
        approach_distance_L=2.10,
        approach_min_turn_gain=0.35,
    )
end

@inline function _clamp01(value)
    return clamp(value, 0.0, 1.0)
end

@inline function _safe(value, fallback)
    parsed = Float64(value)
    return isfinite(parsed) ? parsed : fallback
end

function drive_module(
    state,
    params,
    turn_command=0.0,
    drive_frequency_scale=1.0,
)
    omega =
        (2 * pi / params.drive_period) *
        max(
            _safe(drive_frequency_scale, 1.0),
            params.drive_frequency_min_scale,
        )
    amp = params.drive_amplitude
    q1 = _safe(state.phi[1], 0.0)
    q2 = _safe(state.phi[2], 0.0)
    qd1 = _safe(state.phi_dot[1], 0.0)
    qd2 = _safe(state.phi_dot[2], 0.0)

    # State-feedback drive: phase comes from joint state, not from a hidden clock.
    vdp_drive = params.drive_mu * (1 - (q1 / amp)^2) * qd1
    head_accel = vdp_drive - omega^2 * q1

    # State-phased steering: change the posterior velocity-lag coefficient by
    # opposite small amounts on the two observed anterior-velocity half-cycles.
    # The modulation vanishes at joint reversal and course alignment, leaving
    # no persistent posterior offset.
    phase_velocity = tanh(
        qd1 /
        max(
            params.halfcycle_velocity_scale * amp * omega,
            eps(omega),
        ),
    )
    bounded_turn = clamp(_safe(turn_command, 0.0), -1.0, 1.0)
    lag_modulation =
        params.halfcycle_lag_asymmetry * bounded_turn * phase_velocity
    lag_scale = clamp(
        1.0 - lag_modulation,
        1.0 - params.halfcycle_lag_asymmetry,
        1.0 + params.halfcycle_lag_asymmetry,
    )
    tail_target =
        -q1 -
        params.drive_tail_lag_gain * lag_scale * qd1 /
        max(omega, eps(omega))
    tail_accel = omega^2 * (tail_target - q2) - 2 * params.drive_tail_damping * omega * qd2
    return (
        head_accel=head_accel,
        tail_accel=tail_accel,
        omega=omega,
        q1=q1,
        q2=q2,
        qd1=qd1,
        qd2=qd2,
        turn_command=bounded_turn,
        phase_velocity=phase_velocity,
        lag_modulation=lag_modulation,
        lag_scale=lag_scale,
        tail_target=tail_target,
    )
end

function guidance_module(state, params)
    distance_L = max(_safe(state.distance_L, 1.0), 1.0e-6)
    scale = max(distance_L, params.target_scale_floor_L)
    target_x = _safe(state.target_body_L[1], -distance_L) / scale
    target_y = _safe(state.target_body_L[2], 0.0) / scale

    # Local -x is the nose direction.  At startup, body-frame target angle
    # chooses the correction.  As translation develops, the observed angle
    # from swimming velocity to the target releases or reverses that request.
    body_course_error = clamp(
        atan(-target_y, -target_x),
        -params.course_angle_limit,
        params.course_angle_limit,
    )
    velocity_x = _safe(state.velocity_body_U[1], 0.0)
    velocity_y = _safe(state.velocity_body_U[2], 0.0)
    speed = _safe(hypot(velocity_x, velocity_y), 0.0)
    course_cross = velocity_x * target_y - velocity_y * target_x
    course_dot = velocity_x * target_x + velocity_y * target_y
    velocity_course_error = clamp(
        atan(course_cross, course_dot),
        -params.course_angle_limit,
        params.course_angle_limit,
    )
    speed_ratio = speed / max(params.course_speed_scale, 1.0e-6)
    speed_power = max(params.course_speed_power, 1.0)
    course_gate =
        speed_ratio^speed_power / (1.0 + speed_ratio^speed_power)
    route_error =
        (1.0 - course_gate) * body_course_error +
        course_gate * velocity_course_error

    approach = _clamp01(
        distance_L / max(params.approach_distance_L, 1.0e-6),
    )
    turn_gain =
        params.approach_min_turn_gain +
        (1.0 - params.approach_min_turn_gain) * approach
    turn_command =
        turn_gain * tanh(route_error / max(params.turn_error_scale, 1.0e-6))

    closing_speed = hasproperty(state, :window_closing_speed_L) ?
        _safe(state.window_closing_speed_L, 0.0) :
        _safe(state.closing_speed_L, 0.0)
    closing_deficit =
        0.5 * (1 - tanh(closing_speed / max(params.progress_closing_speed_scale, 1.0e-6)))
    return (
        turn_command=turn_command,
        route_error=route_error,
        body_course_error=body_course_error,
        velocity_course_error=velocity_course_error,
        course_gate=course_gate,
        speed=speed,
        distance_L=distance_L,
        turn_gain=turn_gain,
        far_drive_gate=approach,
        drive_progress_boost=closing_deficit,
        closing_speed_L=closing_speed,
    )
end

function target_policy(state, params)
    guidance = guidance_module(state, params)
    turn_load = _clamp01(abs(guidance.turn_command))
    cadence_gain =
        params.far_drive_frequency_gain +
        params.progress_drive_frequency_gain * guidance.drive_progress_boost
    drive_frequency_scale =
        1.0 +
        cadence_gain *
        guidance.far_drive_gate *
        (1.0 - params.far_drive_turn_relief * turn_load)
    drive = drive_module(
        state,
        params,
        guidance.turn_command,
        drive_frequency_scale,
    )
    return (
        phi_ddot=(
            drive.head_accel,
            drive.tail_accel,
        ),
    )
end
