# L64 3D candidate: preserve the fast posterior-priority traveling wave,
# odd signed-curvature controller, and error-qualified far-route observer.
# During approach, relieve only geometric steering while the measured inertial
# course is already target-directed; retain rate damping and restore full
# steering continuously when course quality falls.

function target_policy_params(; L::Int=64)
    return (
        version="dogfish_3d_course_aligned_approach_steering_relief_v9",
        L=Float64(L),
        drive_period=0.55,
        control_period=0.55,
        drive_amplitude=28.0 * pi / 180,
        head_envelope_amplitude=24.0 * pi / 180,
        drive_energy_gain=0.08,
        posterior_wave_gain=7.0 / 6.0,
        drive_tail_lag_gain=0.80,
        drive_tail_damping=0.65,
        far_drive_frequency_gain=0.114,
        far_drive_turn_relief=0.36,
        progress_drive_frequency_gain=0.034,
        progress_closing_speed_scale=0.16,
        capture_alignment_onset=0.82,
        capture_alignment_full=0.96,
        capture_speed_scale_U=0.25,
        course_aligned_geometric_relief=0.45,
        bearing_gain=3.2,
        vector_angle_gain=2.4,
        target_lateral_velocity_gain=0.20,
        bearing_trend_gain=0.70,
        bearing_trend_scale=0.110,
        turn_rate_target_gain=0.75,
        turn_rate_feedback_gain=1.25,
        turn_rate_request_scale=1.80,
        turn_rate_scale=0.22,
        line_of_sight_rate_gain=0.45,
        line_of_sight_rate_scale=0.035,
        line_of_sight_transition_L=1.90,
        line_of_sight_forward_scale=0.25,
        negative_turn_request_gain=0.78,
        curvature_request_scale=2.20,
        turn_curvature_limit=10.5 * pi / 180,
        approach_distance_L=2.10,
        approach_min_gain=0.36,
        positive_approach_min_gain=0.66,
        centerline_bearing_band=0.105,
        centerline_vector_band=0.120,
        centerline_min_turn_gain=0.31,
        sweep_bearing_band=0.35,
        sweep_rate_scale=0.12,
        sweep_damping_gain=0.45,
        positive_recovery_gain=0.64,
        positive_recovery_scale=0.24,
        positive_recovery_rate_scale=0.22,
        centerline_rate_brake_gain=0.43,
        centerline_rate_brake_scale=0.24,
        centerline_rate_brake_bearing_band=0.30,
        centerline_rate_brake_lateral_band=0.26,
        turn_request_limit=6.0,
        head_turn_share=0.70,
        tail_turn_share=1.00,
        halfcycle_tail_bias=0.25,
        halfcycle_velocity_gain=0.20,
        tail_tangent_scale=34.0 * pi / 180,
        body_angular_damping_gain=0.0,
        joint_acceleration_limit=1800.0 * pi / 180,
        joint_rate_limit=260.0 * pi / 180,
        rate_governor_onset=0.96,
    )
end
@inline function _clamp_unit(value)
    return clamp(value, -1.0, 1.0)
end

@inline function _clamp01(value)
    return clamp(value, 0.0, 1.0)
end

@inline function _smoothstep01(value)
    bounded = _clamp01(value)
    return bounded^2 * (3.0 - 2.0 * bounded)
end

@inline function _safe(value, fallback)
    parsed = Float64(value)
    return isfinite(parsed) ? parsed : fallback
end

function drive_module(state, params, turn_request=0.0, drive_frequency_scale=1.0)
    omega =
        (2 * pi / params.drive_period) *
        max(_safe(drive_frequency_scale, 1.0), 0.50)
    amp = max(_safe(params.head_envelope_amplitude, params.drive_amplitude), 1.0e-6)
    q1 = _safe(state.phi[1], 0.0)
    q2 = _safe(state.phi[2], 0.0)
    qd1 = _safe(state.phi_dot[1], 0.0)
    qd2 = _safe(state.phi_dot[2], 0.0)

    # State-feedback drive: phase comes from joint state, not from a hidden
    # clock. The elliptical phase-plane energy pumps a weak stroke and damps an
    # oversized one without changing the requested cadence for both joints.
    phase_rate_scale = max(omega * amp, 1.0e-6)
    carrier_energy = (q1 / amp)^2 + (qd1 / phase_rate_scale)^2
    energy_drive =
        params.drive_energy_gain * omega * (1.0 - carrier_energy) * qd1
    head_accel = energy_drive - omega^2 * q1

    # Posterior joint follows the anterior bend with lag to create a traveling
    # wave. The mean tangent is an odd, bounded map, so reflected body-frame
    # target geometry produces reflected curvature without a direction-specific
    # actuator branch or hidden clock.
    turn_command = tanh(_safe(turn_request, 0.0) / max(params.curvature_request_scale, 1.0e-6))
    mean_tail_tangent = params.turn_curvature_limit * turn_command
    tail_wave_target = -params.posterior_wave_gain * (
        q1 + params.drive_tail_lag_gain * qd1 / max(omega, eps(omega))
    )
    tail_target = mean_tail_tangent + tail_wave_target
    tail_accel = omega^2 * (tail_target - q2) - 2 * params.drive_tail_damping * omega * qd2
    return (
        head_accel=head_accel,
        tail_accel=tail_accel,
        omega=omega,
        q1=q1,
        q2=q2,
        qd1=qd1,
        qd2=qd2,
        carrier_energy=carrier_energy,
        tail_wave_target=tail_wave_target,
        turn_command=turn_command,
        mean_tail_tangent=mean_tail_tangent,
    )
end

function envelope_governed_acceleration(accel, joint_rate, params)
    acceleration_limit =
        max(_safe(params.joint_acceleration_limit, pi), 1.0e-6)
    rate_limit = max(_safe(params.joint_rate_limit, pi), 1.0e-6)
    commanded = clamp(_safe(accel, 0.0), -acceleration_limit, acceleration_limit)
    rate = _safe(joint_rate, 0.0)

    # Preserve full deceleration/reversal authority. Only a command that would
    # increase the current signed speed is withdrawn near the rate envelope.
    commanded * rate <= 0.0 && return commanded
    onset = clamp(_safe(params.rate_governor_onset, 0.96), 0.0, 1.0 - 1.0e-6)
    proximity = _clamp01(
        (abs(rate) / rate_limit - onset) / max(1.0 - onset, 1.0e-6),
    )
    withdrawal = proximity^2 * (3.0 - 2.0 * proximity)
    return (1.0 - withdrawal) * commanded
end

function guidance_module(state, params)
    distance = max(_safe(state.distance_L * params.L, params.L), 1.0e-6)
    distance_L = distance / params.L
    scale = max(distance, 0.25 * params.L)
    # `target_body` is the target vector already rotated into the fish body frame.
    target_x = _safe(state.target_body_L[1] * params.L, -distance)
    target_y = _safe(state.target_body_L[2] * params.L, 0.0)
    forward_component = -target_x / scale
    lateral_component = target_y / scale
    vector_angle = atan(lateral_component, max(forward_component, 0.15))
    vector_angle = clamp(vector_angle, -1.25, 1.25)
    bearing = _clamp_unit(_safe(state.bearing, 0.0))
    bearing_trend = hasproperty(state, :bearing_window_rate) ?
        _safe(state.bearing_window_rate, 0.0) :
        _safe(state.bearing_rate, 0.0)
    closing_speed = hasproperty(state, :window_closing_speed_L) ?
        _safe(state.window_closing_speed_L, 0.0) :
        _safe(state.closing_speed_L, 0.0)
    closing_deficit =
        0.5 * (1 - tanh(closing_speed / max(params.progress_closing_speed_scale, 1.0e-6)))
    velocity_x = _safe(state.velocity_body_U[1], 0.0)
    velocity_y = _safe(state.velocity_body_U[2], 0.0)
    slip_y = velocity_y / params.L
    speed_U = hypot(velocity_x, velocity_y)
    target_norm = max(hypot(target_x, target_y), 1.0e-6)
    course_alignment = speed_U > 1.0e-6 ?
        clamp(
            (target_x * velocity_x + target_y * velocity_y) /
            (target_norm * speed_U),
            -1.0,
            1.0,
        ) :
        -1.0
    capture_alignment_gate = _clamp01(
        (course_alignment - params.capture_alignment_onset) /
        max(params.capture_alignment_full - params.capture_alignment_onset, 1.0e-6),
    )
    capture_speed_gate = tanh(
        speed_U / max(params.capture_speed_scale_U, 1.0e-6),
    )
    capture_corridor_gate = capture_alignment_gate * capture_speed_gate

    approach = _clamp01(distance_L / max(params.approach_distance_L, 1.0e-6))
    approach_gain = params.approach_min_gain + (1 - params.approach_min_gain) * approach

    geometric_request = -(
        params.bearing_gain * bearing +
        params.vector_angle_gain * vector_angle
    ) -
        params.target_lateral_velocity_gain * slip_y -
        params.bearing_trend_gain *
            tanh(bearing_trend / max(params.bearing_trend_scale, 1.0e-6))
    turn_rate = hasproperty(state, :turn_rate_recent) ?
        _safe(state.turn_rate_recent, 0.0) :
        _safe(state.heading_rate, 0.0)
    target_turn_rate =
        params.turn_rate_target_gain *
        tanh(geometric_request / max(params.turn_rate_request_scale, 1.0e-6))
    rate_error = target_turn_rate - turn_rate
    rate_correction =
        params.turn_rate_feedback_gain *
        tanh(rate_error / max(params.turn_rate_scale, 1.0e-6))

    centerline_alignment = max(
        abs(bearing) / max(params.centerline_bearing_band, 1.0e-6),
        abs(vector_angle) / max(params.centerline_vector_band, 1.0e-6),
    )
    centerline_alignment = _clamp01(centerline_alignment)
    centerline_gain =
        params.centerline_min_turn_gain +
        (1 - params.centerline_min_turn_gain) * centerline_alignment

    # Subtract co-windowed target-bearing rate from body turn rate to recover
    # inertial line-of-sight drift without estimating gait phase. Unlike the
    # sampled unqualified residual, this route observer has no authority once
    # current body-frame target error centers, and its smooth distance gate is
    # exactly zero throughout the separately validated approach controller.
    line_of_sight_rate = turn_rate - bearing_trend
    line_of_sight_distance_gate = _smoothstep01(
        (distance_L - params.approach_distance_L) /
        max(params.line_of_sight_transition_L, 1.0e-6),
    )
    line_of_sight_forward_gate = _clamp01(
        forward_component /
        max(params.line_of_sight_forward_scale, 1.0e-6),
    )
    line_of_sight_error_gate = centerline_alignment
    line_of_sight_correction =
        params.line_of_sight_rate_gain *
        line_of_sight_distance_gate *
        line_of_sight_forward_gate *
        line_of_sight_error_gate *
        tanh(
            line_of_sight_rate /
            max(params.line_of_sight_rate_scale, 1.0e-6),
        )
    close_gate = 1 - approach
    # Body attitude oscillates with the propulsive gait even when inertial
    # translation is already on course. In that observed regime, relieve only
    # the geometric bearing/vector demand: rate feedback remains available to
    # damp yaw, and the smooth corridor gate restores full steering as soon as
    # the measured course degrades. `close_gate` makes this exactly inactive
    # outside the established approach controller.
    course_aligned_steering_relief =
        params.course_aligned_geometric_relief *
        close_gate *
        capture_corridor_gate
    request =
        (1 - course_aligned_steering_relief) * geometric_request +
        rate_correction +
        line_of_sight_correction

    sweeping_to_center = bearing * bearing_trend < 0.0 ? 1.0 : 0.0
    sweep_window =
        _clamp01((params.sweep_bearing_band - abs(bearing)) / max(params.sweep_bearing_band, 1.0e-6))
    sweep_rate = tanh(abs(bearing_trend) / max(params.sweep_rate_scale, 1.0e-6))
    sweep_damping =
        params.sweep_damping_gain * close_gate * sweep_window * sweep_rate * sweeping_to_center

    request *= centerline_gain * (1 - sweep_damping)
    request = max(request, 0.0) + params.negative_turn_request_gain * min(request, 0.0)

    crossed_below = max(-bearing, 0.0) + 0.6 * max(-vector_angle, 0.0)
    negative_spin = max(-tanh(turn_rate / max(params.positive_recovery_rate_scale, 1.0e-6)), 0.0)
    positive_recovery =
        params.positive_recovery_gain *
        close_gate *
        tanh(crossed_below / max(params.positive_recovery_scale, 1.0e-6)) *
        negative_spin
    request += positive_recovery

    centerline_rate_alignment = max(
        abs(bearing) / max(params.centerline_rate_brake_bearing_band, 1.0e-6),
        abs(lateral_component) / max(params.centerline_rate_brake_lateral_band, 1.0e-6),
    )
    centerline_rate_window = 1 - _clamp01(centerline_rate_alignment)
    centerline_rate_brake =
        params.centerline_rate_brake_gain *
        close_gate *
        centerline_rate_window *
        tanh(-turn_rate / max(params.centerline_rate_brake_scale, 1.0e-6))
    request += centerline_rate_brake
    positive_approach_gain =
        params.positive_approach_min_gain +
        (1 - params.positive_approach_min_gain) * approach
    effective_approach_gain =
        request > 0.0 ? max(approach_gain, positive_approach_gain) : approach_gain
    request *= effective_approach_gain
    request = clamp(request, -params.turn_request_limit, params.turn_request_limit)
    return (
        turn_request=request,
        geometric_request=geometric_request,
        target_turn_rate=target_turn_rate,
        turn_rate=turn_rate,
        rate_correction=rate_correction,
        line_of_sight_rate=line_of_sight_rate,
        line_of_sight_correction=line_of_sight_correction,
        line_of_sight_distance_gate=line_of_sight_distance_gate,
        line_of_sight_forward_gate=line_of_sight_forward_gate,
        line_of_sight_error_gate=line_of_sight_error_gate,
        bearing=bearing,
        bearing_trend=bearing_trend,
        vector_angle=vector_angle,
        forward_component=forward_component,
        lateral_component=lateral_component,
        distance_L=distance_L,
        approach_gain=effective_approach_gain,
        base_approach_gain=approach_gain,
        positive_approach_gain=positive_approach_gain,
        # `approach` is one outside 2.10L. The alignment gate can therefore
        # change cadence only after entry into the already successful capture
        # corridor, and releases continuously if the course stops closing.
        far_drive_gate=max(approach, capture_corridor_gate),
        drive_progress_boost=closing_deficit,
        closing_speed_L=closing_speed,
        course_alignment=course_alignment,
        capture_alignment_gate=capture_alignment_gate,
        capture_speed_gate=capture_speed_gate,
        capture_corridor_gate=capture_corridor_gate,
        course_aligned_steering_relief=course_aligned_steering_relief,
        centerline_gain=centerline_gain,
        sweep_damping=sweep_damping,
        positive_recovery=positive_recovery,
        centerline_rate_brake=centerline_rate_brake,
    )
end

function turn_actuator_module(drive, guidance, params)
    tail_tangent = drive.q1 + drive.q2
    tail_velocity = drive.qd1 + drive.qd2
    tail_side = tanh(tail_tangent / max(params.tail_tangent_scale, 1.0e-6))
    tail_motion = tanh(tail_velocity / max(params.drive_amplitude * drive.omega, 1.0e-6))

    # Steering biases the currently observed bend/velocity cycle without an
    # explicit period, keeping parameter tuning on active state-feedback terms.
    halfcycle_gate =
        1.0 +
        params.halfcycle_tail_bias * guidance.turn_request * tail_side +
        params.halfcycle_velocity_gain * guidance.turn_request * tail_motion
    halfcycle_gate = clamp(halfcycle_gate, 0.55, 1.45)
    steer = guidance.turn_request * halfcycle_gate
    return (
        head_delta=params.head_turn_share * steer,
        tail_delta=params.tail_turn_share * steer,
        halfcycle_gate=halfcycle_gate,
        steer=steer,
    )
end

function target_policy(state, params)
    guidance = guidance_module(state, params)
    turn_load = _clamp01(abs(guidance.turn_request) / max(params.turn_request_limit, 1.0e-6))
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
        guidance.turn_request,
        drive_frequency_scale,
    )
    turn = turn_actuator_module(drive, guidance, params)
    angular_damping =
        -params.body_angular_damping_gain * _safe(state.moment_z_L2, 0.0) / max(params.L^3, eps(Float64))
    return (
        phi_ddot=(
            envelope_governed_acceleration(
                drive.head_accel + turn.head_delta + angular_damping,
                drive.qd1,
                params,
            ),
            envelope_governed_acceleration(
                drive.tail_accel + turn.tail_delta,
                drive.qd2,
                params,
            ),
        ),
    )
end
