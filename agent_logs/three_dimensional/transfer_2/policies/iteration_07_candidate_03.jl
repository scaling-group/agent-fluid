# L64 3D sector-intercept to recapture-pivot candidate. Preserve the assigned
# parent's deep closing/abeam pulse, then hand off to the sampled target-behind
# pivot-and-release mode. The pivot adds bounded posterior mean curvature and
# unloads only its oscillatory carrier; target-ahead states and full carrier
# authority return on reacquisition. No clock, route, or world-frame direction
# enters the policy.

function target_policy_params(; L::Int=64)
    return (
        version="dogfish_target_control_v25_sector_recapture_pivot",
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
        redirect_request_scale=0.90,
        redirect_rate_scale=0.55,
        redirect_release_gain=0.92,
        negative_turn_request_gain=0.78,
        curvature_request_scale=2.20,
        negative_turn_curvature_gain=-10.5 * pi / 180,
        positive_turn_curvature_gain=-3.6 * pi / 180,
        curvature_veto_bearing_weight=0.50,
        curvature_veto_vector_weight=0.50,
        curvature_veto_angle_start=0.45,
        curvature_veto_angle_full=0.85,
        curvature_veto_polarity_scale=0.030,
        curvature_veto_release_gain=0.96,
        opposing_halfcycle_relief=0.68,
        intercept_forward_start=0.72,
        intercept_forward_full=0.28,
        intercept_posterior_release_start=0.45,
        intercept_posterior_release_full=0.82,
        intercept_lateral_start=0.45,
        intercept_lateral_full=0.72,
        intercept_lateral_scale=0.35,
        intercept_closing_speed_scale=0.16,
        intercept_tail_curvature_gain=-7.0 * pi / 180,
        recapture_behind_start=0.04,
        recapture_behind_full=0.30,
        recapture_lateral_scale=0.35,
        recapture_tail_curvature_gain=-7.0 * pi / 180,
        recapture_tail_wave_floor=0.40,
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

function drive_module(
    state,
    params,
    turn_request=0.0,
    drive_frequency_scale=1.0,
    recovery_request=0.0,
    route_error=0.0,
    curvature_veto_gate=0.0,
    intercept_request=0.0,
    recapture_request=0.0,
)
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
    base_mean_tail_tangent =
        params.negative_turn_curvature_gain * min(turn_command, 0.0) +
        params.positive_turn_curvature_gain * max(turn_command, 0.0) +
        params.recovery_tail_curvature_gain * recovery_command

    # Release only a mean tangent whose sign remains contradicted by material
    # body-frame route error.  The evaluated parent showed that this preserves
    # early progress but does not by itself recover the late downward sweep.
    polarity_product =
        _safe(route_error, 0.0) * base_mean_tail_tangent
    contradicted_polarity = max(
        tanh(
            polarity_product /
            max(params.curvature_veto_polarity_scale, 1.0e-6),
        ),
        0.0,
    )
    curvature_release =
        params.curvature_veto_release_gain *
        _clamp01(_safe(curvature_veto_gate, 0.0)) *
        contradicted_polarity
    released_mean_tail_tangent =
        base_mean_tail_tangent * (1 - _clamp01(curvature_release))
    intercept_mean_tail_tangent =
        params.intercept_tail_curvature_gain *
        _safe(intercept_request, 0.0)
    # Once the target is definitely behind, switch from interception to the
    # separately sampled pivot primitive. Its signed bend produces the turn;
    # request magnitude reallocates the posterior carrier without choosing a
    # world-frame side.
    recapture_mean_tail_tangent =
        params.recapture_tail_curvature_gain *
        _safe(recapture_request, 0.0)
    mean_tail_tangent =
        released_mean_tail_tangent +
        intercept_mean_tail_tangent +
        recapture_mean_tail_tangent

    base_tail_wave =
        -q1 - params.drive_tail_lag_gain * qd1 / max(omega, eps(omega))
    tail_wave_side = tanh(
        base_tail_wave / max(params.tail_tangent_scale, 1.0e-6),
    )

    # Asymmetric-flapping transfer: once the contradicted mean curvature has
    # been released, reduce only the posterior target-wave half-cycle opposing
    # the signed request.  The complementary half-cycle is untouched, so this
    # reallocates existing carrier authority without increasing its magnitude.
    opposing_halfcycle = max(-turn_command * tail_wave_side, 0.0)
    halfcycle_relief = clamp(
        params.opposing_halfcycle_relief *
        _clamp01(curvature_release) *
        opposing_halfcycle,
        0.0,
        params.opposing_halfcycle_relief,
    )
    recapture_carrier_gate = _clamp01(abs(_safe(recapture_request, 0.0)))
    recapture_tail_wave_scale =
        1.0 -
        (1.0 - _clamp01(params.recapture_tail_wave_floor)) *
        recapture_carrier_gate
    tail_wave =
        recapture_tail_wave_scale *
        (1 - halfcycle_relief) *
        base_tail_wave
    tail_target = mean_tail_tangent + tail_wave
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
        base_mean_tail_tangent=base_mean_tail_tangent,
        contradicted_polarity=contradicted_polarity,
        curvature_release=curvature_release,
        released_mean_tail_tangent=released_mean_tail_tangent,
        intercept_mean_tail_tangent=intercept_mean_tail_tangent,
        recapture_mean_tail_tangent=recapture_mean_tail_tangent,
        mean_tail_tangent=mean_tail_tangent,
        base_tail_wave=base_tail_wave,
        tail_wave_side=tail_wave_side,
        opposing_halfcycle=opposing_halfcycle,
        halfcycle_relief=halfcycle_relief,
        recapture_carrier_gate=recapture_carrier_gate,
        recapture_tail_wave_scale=recapture_tail_wave_scale,
        tail_wave=tail_wave,
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

    route_error =
        params.curvature_veto_bearing_weight * bearing +
        params.curvature_veto_vector_weight * vector_angle
    curvature_alignment = max(abs(bearing), abs(vector_angle))
    curvature_veto_gate = _clamp01(
        (curvature_alignment - params.curvature_veto_angle_start) /
        max(
            params.curvature_veto_angle_full - params.curvature_veto_angle_start,
            1.0e-6,
        ),
    )
    # Use a band-pass sector rather than the evaluated monotone posterior
    # latch.  The pulse starts during the last closing/abeam segment, remains
    # mirror-equivariant through lateral sign, and is forced back to zero once
    # the target is deeply behind.  A lateral deadband preserves centered
    # approaches and prevents an arbitrary turning side.
    intercept_entry_gate = _clamp01(
        (params.intercept_forward_start - forward_component) /
        max(
            params.intercept_forward_start - params.intercept_forward_full,
            1.0e-6,
        ),
    )
    posterior_component = -forward_component
    intercept_release_gate = 1 - _clamp01(
        (posterior_component - params.intercept_posterior_release_start) /
        max(
            params.intercept_posterior_release_full -
            params.intercept_posterior_release_start,
            1.0e-6,
        ),
    )
    intercept_lateral_gate = _clamp01(
        (abs(lateral_component) - params.intercept_lateral_start) /
        max(
            params.intercept_lateral_full - params.intercept_lateral_start,
            1.0e-6,
        ),
    )
    intercept_closing_gate = _clamp01(
        closing_speed /
        max(params.intercept_closing_speed_scale, 1.0e-6),
    )
    intercept_request =
        intercept_entry_gate *
        intercept_release_gate *
        intercept_lateral_gate *
        intercept_closing_gate *
        tanh(
            lateral_component /
            max(params.intercept_lateral_scale, 1.0e-6),
        )

    # Body-frame passage is a distinct regime from the closing-speed pulse.
    # Lateral sign selects the mirrored pivot direction; the gate and command
    # vanish continuously when the target returns ahead or closes laterally.
    recapture_behind_gate = _clamp01(
        (-forward_component - params.recapture_behind_start) /
        max(
            params.recapture_behind_full - params.recapture_behind_start,
            1.0e-6,
        ),
    )
    recapture_request =
        recapture_behind_gate *
        tanh(
            lateral_component /
            max(params.recapture_lateral_scale, 1.0e-6),
        )

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

    # Target geometry initiates a redirect; aligned observed yaw releases only
    # that route bias while rate feedback remains available to brake overshoot.
    desired_turn_sign = tanh(
        geometric_request / max(params.redirect_request_scale, 1.0e-6),
    )
    aligned_turn_response = max(
        tanh(
            desired_turn_sign * turn_rate /
            max(params.redirect_rate_scale, 1.0e-6),
        ),
        0.0,
    )
    redirect_gate = clamp(
        1.0 - params.redirect_release_gain * aligned_turn_response,
        1.0 - params.redirect_release_gain,
        1.0,
    )
    request = geometric_request * redirect_gate + rate_correction

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
        desired_turn_sign=desired_turn_sign,
        aligned_turn_response=aligned_turn_response,
        redirect_gate=redirect_gate,
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
        route_error=route_error,
        curvature_alignment=curvature_alignment,
        curvature_veto_gate=curvature_veto_gate,
        intercept_entry_gate=intercept_entry_gate,
        posterior_component=posterior_component,
        intercept_release_gate=intercept_release_gate,
        intercept_lateral_gate=intercept_lateral_gate,
        intercept_closing_gate=intercept_closing_gate,
        intercept_request=intercept_request,
        recapture_behind_gate=recapture_behind_gate,
        recapture_request=recapture_request,
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
        guidance.route_error,
        guidance.curvature_veto_gate,
        guidance.intercept_request,
        guidance.recapture_request,
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
