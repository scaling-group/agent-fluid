# L64 3D candidate: retain the observed propulsive state-feedback wave and
# bounded achieved-course steering, but remove joint-phase lateral motion from
# the slow course signal before closing the route loop. No clock, world
# coordinate, route, or mutable phase is used.

function target_policy_params()
    return (
        version="dogfish3d_joint_phase_compensated_course_v1",
        drive_period=0.55,
        control_period=0.55,
        drive_amplitude=28.0 * pi / 180,
        drive_mu=0.35,
        drive_tail_lag_gain=0.80,
        drive_tail_damping=0.65,
        far_drive_frequency_gain=0.114,
        far_drive_turn_relief=0.36,
        progress_drive_frequency_gain=0.034,
        progress_closing_speed_scale=0.16,
        approach_distance_L=2.10,
        target_angle_limit=1.25,
        course_angle_limit=1.25,
        course_forward_floor=0.08,
        course_speed_scale=0.25,
        route_error_scale=0.32,
        lateral_phase_qd1_gain=-0.084,
        lateral_phase_qd2_gain=0.020,
        phase_compensation_energy_scale=0.35,
        steering_accel_limit=12.0,
        head_steering_share=0.45,
        tail_steering_share=1.00,
        acceleration_limit=1800.0 * pi / 180,
    )
end

@inline function _clamp01(value)
    return clamp(value, 0.0, 1.0)
end

@inline function _safe(value, fallback)
    parsed = Float64(value)
    return isfinite(parsed) ? parsed : fallback
end

function drive_module(state, params, drive_frequency_scale=1.0)
    omega =
        (2 * pi / params.drive_period) *
        max(_safe(drive_frequency_scale, 1.0), 0.50)
    amp = max(abs(params.drive_amplitude), eps(Float64))
    q1 = _safe(state.phi[1], 0.0)
    q2 = _safe(state.phi[2], 0.0)
    qd1 = _safe(state.phi_dot[1], 0.0)
    qd2 = _safe(state.phi_dot[2], 0.0)

    # State-feedback drive: phase comes from joint state, not from a hidden
    # clock. The posterior target retains the sampled traveling-bend carrier.
    vdp_drive = params.drive_mu * (1 - (q1 / amp)^2) * qd1
    head_accel = vdp_drive - omega^2 * q1
    tail_target =
        -q1 -
        params.drive_tail_lag_gain * qd1 / max(omega, eps(Float64))
    tail_accel =
        omega^2 * (tail_target - q2) -
        2 * params.drive_tail_damping * omega * qd2
    return (
        head_accel=head_accel,
        tail_accel=tail_accel,
        omega=omega,
        amp=amp,
        q1=q1,
        q2=q2,
        qd1=qd1,
        qd2=qd2,
    )
end

function guidance_module(state, params)
    distance_L = max(abs(_safe(state.distance_L, 1.0)), 1.0e-6)
    target_x = _safe(state.target_body_L[1], -distance_L)
    target_y = _safe(state.target_body_L[2], 0.0)
    target_angle = atan(
        target_y,
        max(-target_x, params.course_forward_floor),
    )
    target_angle = clamp(
        target_angle,
        -params.target_angle_limit,
        params.target_angle_limit,
    )

    velocity_x = _safe(state.velocity_body_U[1], 0.0)
    velocity_y = _safe(state.velocity_body_U[2], 0.0)
    raw_course_speed = hypot(velocity_x, velocity_y)
    qd1 = _safe(state.phi_dot[1], 0.0)
    qd2 = _safe(state.phi_dot[2], 0.0)
    omega = 2 * pi / max(params.drive_period, 1.0e-6)
    amp = max(abs(params.drive_amplitude), eps(Float64))
    head_energy = hypot(
        _safe(state.phi[1], 0.0) / amp,
        qd1 / max(omega * amp, 1.0e-6),
    )
    tail_energy = hypot(
        _safe(state.phi[2], 0.0) / amp,
        qd2 / max(omega * amp, 1.0e-6),
    )
    carrier_energy = min(head_energy, tail_energy)
    compensation_gate =
        tanh(
            carrier_energy /
            max(params.phase_compensation_energy_scale, 1.0e-6),
        )^2

    # Across all sampled rollouts the beat-centered lateral velocity, but not
    # longitudinal velocity, is strongly predicted by the two joint rates.
    # Remove only that fast odd component before forming the slow route error.
    lateral_beat_velocity =
        params.lateral_phase_qd1_gain * qd1 +
        params.lateral_phase_qd2_gain * qd2
    compensated_velocity_y =
        velocity_y - compensation_gate * lateral_beat_velocity
    compensated_course_speed = hypot(velocity_x, compensated_velocity_y)
    course_angle = atan(
        compensated_velocity_y,
        max(-velocity_x, params.course_forward_floor),
    )
    course_angle = clamp(
        course_angle,
        -params.course_angle_limit,
        params.course_angle_limit,
    )
    course_gate =
        tanh(
            raw_course_speed /
            max(params.course_speed_scale, 1.0e-6),
        )^2
    course_error = clamp(
        target_angle - course_angle,
        -params.course_angle_limit,
        params.course_angle_limit,
    )
    route_error =
        (1 - course_gate) * target_angle +
        course_gate * course_error
    turn_command =
        tanh(route_error / max(params.route_error_scale, 1.0e-6))

    closing_speed = hasproperty(state, :window_closing_speed_L) ?
        _safe(state.window_closing_speed_L, 0.0) :
        _safe(state.closing_speed_L, 0.0)
    closing_deficit =
        0.5 *
        (1 - tanh(
            closing_speed /
            max(params.progress_closing_speed_scale, 1.0e-6),
        ))
    far_drive_gate =
        _clamp01(distance_L / max(params.approach_distance_L, 1.0e-6))
    return (
        distance_L=distance_L,
        target_angle=target_angle,
        raw_course_speed=raw_course_speed,
        compensated_course_speed=compensated_course_speed,
        course_angle=course_angle,
        course_gate=course_gate,
        course_error=course_error,
        route_error=route_error,
        turn_command=turn_command,
        carrier_energy=carrier_energy,
        compensation_gate=compensation_gate,
        lateral_beat_velocity=lateral_beat_velocity,
        compensated_velocity_y=compensated_velocity_y,
        far_drive_gate=far_drive_gate,
        closing_deficit=closing_deficit,
        closing_speed_L=closing_speed,
    )
end

function target_policy(state, params)
    guidance = guidance_module(state, params)
    cadence_gain =
        params.far_drive_frequency_gain +
        params.progress_drive_frequency_gain * guidance.closing_deficit
    drive_frequency_scale =
        1.0 +
        cadence_gain *
        guidance.far_drive_gate *
        (1.0 -
         params.far_drive_turn_relief * abs(guidance.turn_command))
    drive = drive_module(state, params, drive_frequency_scale)
    steering_accel =
        params.steering_accel_limit * guidance.turn_command
    head_accel =
        drive.head_accel +
        params.head_steering_share * steering_accel
    tail_accel =
        drive.tail_accel +
        params.tail_steering_share * steering_accel
    return (
        phi_ddot=(
            clamp(
                head_accel,
                -params.acceleration_limit,
                params.acceleration_limit,
            ),
            clamp(
                tail_accel,
                -params.acceleration_limit,
                params.acceleration_limit,
            ),
        ),
    )
end
