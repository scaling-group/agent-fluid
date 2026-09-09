# B-test seed: exact iteration-20 2D champion control law, with only
# the 3D evaluator's normalized observation field names adapted below.
# Source policy SHA256 (LF artifact bytes): ff36d930636985ae6259d28d502b0532ff78bef48f090cf447ae11c33dfd441a
# Adaptations: default L=64; distance_L/target_body_L are rescaled to the
# champion's original cell-unit convention; velocity_body_U, moment_z_L2, and
# control_period are field-name aliases. All control gains, branches, and
# formulas are unchanged.

function target_policy_params(; L::Int=64)
    return (
        version="dogfish_target_control_v18_cadence_relief_probe",
        L=Float64(L),
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
        bearing_gain=3.2,
        vector_angle_gain=2.4,
        target_lateral_velocity_gain=0.20,
        bearing_trend_gain=0.70,
        bearing_trend_scale=0.110,
        turn_rate_target_gain=0.75,
        turn_rate_feedback_gain=1.25,
        turn_rate_request_scale=1.80,
        turn_rate_scale=0.22,
        negative_turn_request_gain=0.78,
        curvature_request_scale=2.20,
        negative_turn_curvature_gain=-10.5 * pi / 180,
        positive_turn_curvature_gain=-3.6 * pi / 180,
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
        recovery_tail_curvature_gain=-5.1 * pi / 180,
        recovery_tail_curvature_scale=0.70,
        turn_request_limit=6.0,
        head_turn_share=0.70,
        tail_turn_share=1.00,
        halfcycle_tail_bias=0.25,
        halfcycle_velocity_gain=0.20,
        tail_tangent_scale=34.0 * pi / 180,
        body_angular_damping_gain=0.0,
    )
end
@inline function _clamp_unit(value)
    return clamp(value, -1.0, 1.0)
end

@inline function _clamp01(value)
    return clamp(value, 0.0, 1.0)
end

@inline function _safe(value, fallback)
    parsed = Float64(value)
    return isfinite(parsed) ? parsed : fallback
end

function drive_module(state, params, turn_request=0.0, drive_frequency_scale=1.0, recovery_request=0.0)
    omega =
        (2 * pi / params.drive_period) *
        max(_safe(drive_frequency_scale, 1.0), 0.50)
    amp = params.drive_amplitude
    q1 = _safe(state.phi[1], 0.0)
    q2 = _safe(state.phi[2], 0.0)
    qd1 = _safe(state.phi_dot[1], 0.0)
    qd2 = _safe(state.phi_dot[2], 0.0)

    # State-feedback drive: phase comes from joint state, not from a hidden clock.
    vdp_drive = params.drive_mu * (1 - (q1 / amp)^2) * qd1
    head_accel = vdp_drive - omega^2 * q1

    # Posterior joint follows the anterior bend with lag to create a traveling wave.
    # Bounded target-curvature feedback lets negative requests oppose the seed's
    # positive-turn drift without adding a hidden clock or target-specific mode.
    turn_command = tanh(_safe(turn_request, 0.0) / max(params.curvature_request_scale, 1.0e-6))
    recovery_command =
        tanh(max(_safe(recovery_request, 0.0), 0.0) / max(params.recovery_tail_curvature_scale, 1.0e-6))
    mean_tail_tangent =
        params.negative_turn_curvature_gain * min(turn_command, 0.0) +
        params.positive_turn_curvature_gain * max(turn_command, 0.0) +
        params.recovery_tail_curvature_gain * recovery_command
    tail_target = mean_tail_tangent - q1 - params.drive_tail_lag_gain * qd1 / max(omega, eps(omega))
    tail_accel = omega^2 * (tail_target - q2) - 2 * params.drive_tail_damping * omega * qd2
    return (
        head_accel=head_accel,
        tail_accel=tail_accel,
        omega=omega,
        q1=q1,
        q2=q2,
        qd1=qd1,
        qd2=qd2,
        turn_command=turn_command,
        recovery_command=recovery_command,
        mean_tail_tangent=mean_tail_tangent,
    )
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
    slip_y = _safe(state.velocity_body_U[2], 0.0) / params.L

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
    close_gate = 1 - approach
    request = geometric_request + rate_correction

    centerline_alignment = max(
        abs(bearing) / max(params.centerline_bearing_band, 1.0e-6),
        abs(vector_angle) / max(params.centerline_vector_band, 1.0e-6),
    )
    centerline_alignment = _clamp01(centerline_alignment)
    centerline_gain =
        params.centerline_min_turn_gain +
        (1 - params.centerline_min_turn_gain) * centerline_alignment

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
    recovery_curvature_request =
        max(positive_recovery, 0.0) + max(centerline_rate_brake, 0.0)
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
        bearing=bearing,
        bearing_trend=bearing_trend,
        vector_angle=vector_angle,
        forward_component=forward_component,
        lateral_component=lateral_component,
        distance_L=distance_L,
        approach_gain=effective_approach_gain,
        base_approach_gain=approach_gain,
        positive_approach_gain=positive_approach_gain,
        far_drive_gate=approach,
        drive_progress_boost=closing_deficit,
        closing_speed_L=closing_speed,
        centerline_gain=centerline_gain,
        sweep_damping=sweep_damping,
        positive_recovery=positive_recovery,
        centerline_rate_brake=centerline_rate_brake,
        recovery_curvature_request=recovery_curvature_request,
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
        guidance.recovery_curvature_request,
    )
    turn = turn_actuator_module(drive, guidance, params)
    angular_damping =
        -params.body_angular_damping_gain * _safe(state.moment_z_L2, 0.0) / max(params.L^3, eps(Float64))
    return (
        phi_ddot=(
            drive.head_accel + turn.head_delta + angular_damping,
            drive.tail_accel + turn.tail_delta,
        ),
    )
end
