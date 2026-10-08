# Phase-2 target-helpful-motion steering-release candidate. It preserves the
# evaluated geometry/course-agreed allocator, captured terminal posture, and
# validated traveling-bend controller. Outside the protected terminal band,
# body-frame target side, relative crossflow, and positive closure may release
# a small paired share of the additive steering residual when translation is
# already helping. It adds no thrust, lag, mean bend, clock, route, case
# identity, or world-coordinate feedback.

function target_policy_params(; L::Int=64)
    return (
        version="dogfish_3d_target_v43_outer_helpful_motion_steering_release",
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
        redirect_angle_start=0.32,
        redirect_angle_full=0.82,
        redirect_request_scale=0.48,
        redirect_head_curvature_gain=7.0 * pi / 180,
        redirect_tail_curvature_gain=20.0 * pi / 180,
        redirect_drive_relief=0.44,
        redirect_drive_floor=0.62,
        terminal_reallocation_on_L=4.0,
        terminal_reallocation_full_L=2.4,
        terminal_preview_periods=0.75,
        terminal_preview_closing_limit_L=0.80,
        terminal_closing_support_full_L=0.16,
        terminal_carrier_floor=0.22,
        terminal_curvature_bandwidth_ratio=0.45,
        terminal_curvature_damping=1.0,
        terminal_curvature_accel_limit=900.0 * pi / 180,
        terminal_tracking_error_full=0.18,
        terminal_settled_hold_fraction=0.82,
        terminal_crossflow_relief_on_L=1.60,
        terminal_crossflow_relief_full_L=0.90,
        terminal_crossflow_relief_max_fraction=0.14,
        terminal_crossflow_relief_target_scale=0.30,
        terminal_crossflow_relief_scale_U=0.20,
        terminal_crossflow_relief_closing_scale_L=0.40,
        terminal_intercept_miss_on_L=0.55,
        terminal_intercept_miss_full_L=0.30,
        terminal_intercept_release_max_fraction=0.035,
        terminal_intercept_hold_max_fraction=0.12,
        outer_helpful_motion_release_max_fraction=0.025,
        outer_helpful_motion_scale_U=0.20,
        outer_helpful_motion_closing_scale_L=0.40,
        outer_helpful_motion_lateral_scale=0.30,
        outer_helpful_motion_speed_on_U=0.50,
        outer_helpful_motion_speed_full_U=0.70,
        outer_helpful_motion_full_margin_L=0.50,
        coupled_saturation_fraction=0.12,
        coupled_saturation_direction_fraction=0.06,
        coupled_saturation_response_fraction=0.03,
        coupled_saturation_direction_full_sine=0.20,
        coupled_saturation_lag_error_on=0.20,
        coupled_saturation_lag_error_full=0.65,
        coupled_saturation_full_margin_L=0.50,
        outer_course_miss_fraction_on=0.55,
        outer_course_miss_fraction_full=0.85,
        outer_course_speed_support_full_U=0.20,
        turn_request_limit=6.0,
        head_turn_share=0.70,
        tail_turn_share=1.00,
        halfcycle_tail_bias=0.25,
        halfcycle_velocity_gain=0.20,
        tail_tangent_scale=34.0 * pi / 180,
        body_angular_damping_gain=0.0,
        command_accel_limit=1750.0 * pi / 180,
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
    return bounded * bounded * (3.0 - 2.0 * bounded)
end

@inline function _safe(value, fallback)
    parsed = Float64(value)
    return isfinite(parsed) ? parsed : fallback
end

@inline function _direction_conditioned_coupled_limit(
    head_command,
    tail_command,
    limit,
    base_coupled_fraction,
    direction_coupled_fraction,
    response_coupled_fraction,
    direction_full_sine,
    posterior_lag_error,
    lag_error_on,
    lag_error_full,
    activation_gate,
)
    safe_limit = max(_safe(limit, 0.0), 1.0e-6)
    raw_head = _safe(head_command, 0.0)
    raw_tail = _safe(tail_command, 0.0)
    clipped_head = clamp(raw_head, -safe_limit, safe_limit)
    clipped_tail = clamp(raw_tail, -safe_limit, safe_limit)
    peak_command = max(abs(raw_head), abs(raw_tail))
    common_scale = min(1.0, safe_limit / max(peak_command, 1.0e-6))
    raw_norm = hypot(raw_head, raw_tail)
    clipped_norm = hypot(clipped_head, clipped_tail)
    direction_sine = abs(
        raw_head * clipped_tail - raw_tail * clipped_head,
    ) / max(raw_norm * clipped_norm, 1.0e-6)
    direction_support = _smoothstep01(
        direction_sine / max(_safe(direction_full_sine, 1.0), 1.0e-6),
    )
    lag_on = max(_safe(lag_error_on, 0.0), 0.0)
    lag_full = max(_safe(lag_error_full, lag_on), lag_on + 1.0e-6)
    lag_support = _smoothstep01(
        (_safe(posterior_lag_error, 0.0) - lag_on) /
        (lag_full - lag_on),
    )
    blend =
        _clamp01(_safe(activation_gate, 0.0)) *
        _clamp01(
            _safe(base_coupled_fraction, 0.0) +
            _safe(direction_coupled_fraction, 0.0) * direction_support +
            _safe(response_coupled_fraction, 0.0) *
                direction_support * lag_support,
        )
    return (
        head=(1.0 - blend) * clipped_head + blend * common_scale * raw_head,
        tail=(1.0 - blend) * clipped_tail + blend * common_scale * raw_tail,
        common_scale=common_scale,
        blend=blend,
        direction_sine=direction_sine,
        direction_support=direction_support,
        lag_support=lag_support,
    )
end

function drive_module(
    state,
    params,
    turn_request=0.0,
    drive_frequency_scale=1.0,
    recovery_request=0.0,
    redirect_gate=0.0,
    redirect_command=0.0,
)
    omega =
        (2 * pi / params.drive_period) *
        max(_safe(drive_frequency_scale, 1.0), 0.50)
    amp = params.drive_amplitude
    q1 = _safe(state.phi[1], 0.0)
    q2 = _safe(state.phi[2], 0.0)
    qd1 = _safe(state.phi_dot[1], 0.0)
    qd2 = _safe(state.phi_dot[2], 0.0)

    # State-feedback drive: phase comes from joint state, not from a hidden
    # clock.  A large-error redirect shifts its equilibrium rather than adding
    # a small residual to an already clipped carrier.
    redirect_weight = _clamp01(_safe(redirect_gate, 0.0))
    bounded_redirect = clamp(_safe(redirect_command, 0.0), -1.0, 1.0)
    head_bias =
        redirect_weight * params.redirect_head_curvature_gain * bounded_redirect
    oscillatory_q1 = q1 - head_bias
    vdp_drive = params.drive_mu * (1 - (oscillatory_q1 / amp)^2) * qd1
    head_accel = vdp_drive - omega^2 * oscillatory_q1

    # Posterior joint follows the anterior bend with lag to create a traveling wave.
    # Bounded target-curvature feedback lets negative requests oppose the seed's
    # positive-turn drift without adding a hidden clock or target-specific mode.
    turn_command = tanh(_safe(turn_request, 0.0) / max(params.curvature_request_scale, 1.0e-6))
    recovery_command =
        tanh(max(_safe(recovery_request, 0.0), 0.0) / max(params.recovery_tail_curvature_scale, 1.0e-6))
    baseline_tail_tangent =
        params.negative_turn_curvature_gain * min(turn_command, 0.0) +
        params.positive_turn_curvature_gain * max(turn_command, 0.0) +
        params.recovery_tail_curvature_gain * recovery_command
    redirect_tail_tangent =
        params.redirect_tail_curvature_gain * bounded_redirect
    mean_tail_tangent =
        (1.0 - redirect_weight) * baseline_tail_tangent +
        redirect_weight * redirect_tail_tangent
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
        redirect_weight=redirect_weight,
        redirect_command=bounded_redirect,
        head_bias=head_bias,
        baseline_tail_tangent=baseline_tail_tangent,
        mean_tail_tangent=mean_tail_tangent,
        tail_target=tail_target,
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
    body_speed_U = hypot(
        _safe(state.velocity_body_U[1], 0.0),
        _safe(state.velocity_body_U[2], 0.0),
    )
    relative_crossflow_y = hasproperty(state, :relative_flow_velocity_body_U) ?
        _safe(state.relative_flow_velocity_body_U[2], 0.0) :
        -_safe(state.velocity_body_U[2], 0.0)

    # The inherited short derivative window is much shorter than a tail beat,
    # so it cannot distinguish mean heading from gait yaw.  Redirect is gated
    # only by persistent geometry represented in the two body-frame angles.
    redirect_angle = 0.5 * (bearing + vector_angle)
    redirect_gate = _smoothstep01(
        (abs(redirect_angle) - params.redirect_angle_start) /
        max(params.redirect_angle_full - params.redirect_angle_start, 1.0e-6),
    )
    redirect_command = -tanh(
        redirect_angle / max(params.redirect_request_scale, 1.0e-6),
    )
    # Preview only the scalar range transition. Target geometry continues to
    # own redirect activation, sign, and the two joint equilibria. The bounded
    # preview advances allocation by less than one declared control period;
    # closure support releases it continuously when range stops decreasing.
    preview_closing_speed_L = clamp(
        closing_speed,
        0.0,
        max(params.terminal_preview_closing_limit_L, 1.0e-6),
    )
    preview_horizon_T =
        _clamp01(params.terminal_preview_periods) * params.control_period
    preview_distance_L = max(
        distance_L - preview_horizon_T * preview_closing_speed_L,
        0.0,
    )
    terminal_proximity_gate = _smoothstep01(
        (params.terminal_reallocation_on_L - preview_distance_L) /
        max(
            params.terminal_reallocation_on_L - params.terminal_reallocation_full_L,
            1.0e-6,
        ),
    )
    terminal_closure_support = _smoothstep01(
        closing_speed / max(params.terminal_closing_support_full_L, 1.0e-6),
    )
    terminal_reallocation_gate =
        redirect_gate * terminal_proximity_gate * terminal_closure_support

    # In still water, relative lateral flow opposite the target-side sign is
    # the body-frame signature of translation toward that lateral target
    # component. It earns only a late, closure-supported relief of the shared
    # curvature allocation; it never requests a turn or chooses a beat phase.
    target_side = tanh(
        lateral_component /
        max(params.terminal_crossflow_relief_target_scale, 1.0e-6),
    )
    target_helpful_crossflow_U = max(
        -relative_crossflow_y * target_side,
        0.0,
    )
    terminal_crossflow_support = _smoothstep01(
        target_helpful_crossflow_U /
        max(params.terminal_crossflow_relief_scale_U, 1.0e-6),
    )
    terminal_relief_closure_support = _smoothstep01(
        closing_speed /
        max(params.terminal_crossflow_relief_closing_scale_L, 1.0e-6),
    )
    terminal_relief_proximity = _smoothstep01(
        (params.terminal_crossflow_relief_on_L - distance_L) /
        max(
            params.terminal_crossflow_relief_on_L -
            params.terminal_crossflow_relief_full_L,
            1.0e-6,
        ),
    )
    # Relative crossflow opposite the target-side sign also identifies center
    # translation that is already helping the outer route. Unlike the terminal
    # posture relief above, this signal may only release a small share of the
    # additive steering residual. Established translation, positive closure,
    # and material lateral target geometry keep release transients or
    # gait-scale sway alone from granting consent, while the actual-distance
    # gate makes the mechanism exactly zero at and below 4 L.
    outer_helpful_motion_proximity = _smoothstep01(
        (distance_L - params.terminal_reallocation_on_L) /
        max(params.outer_helpful_motion_full_margin_L, 1.0e-6),
    )
    outer_helpful_motion_crossflow_support = _smoothstep01(
        target_helpful_crossflow_U /
        max(params.outer_helpful_motion_scale_U, 1.0e-6),
    )
    outer_helpful_motion_closure_support = _smoothstep01(
        closing_speed /
        max(params.outer_helpful_motion_closing_scale_L, 1.0e-6),
    )
    outer_helpful_motion_lateral_support = _smoothstep01(
        abs(lateral_component) /
        max(params.outer_helpful_motion_lateral_scale, 1.0e-6),
    )
    outer_helpful_motion_speed_support = _smoothstep01(
        (body_speed_U - params.outer_helpful_motion_speed_on_U) /
        max(
            params.outer_helpful_motion_speed_full_U -
            params.outer_helpful_motion_speed_on_U,
            1.0e-6,
        ),
    )
    outer_helpful_motion_release =
        _clamp01(params.outer_helpful_motion_release_max_fraction) *
        outer_helpful_motion_proximity *
        outer_helpful_motion_crossflow_support *
        outer_helpful_motion_closure_support *
        outer_helpful_motion_lateral_support *
        outer_helpful_motion_speed_support *
        (1.0 - redirect_gate)
    # Constant-velocity cross-track miss is an observed intercept response,
    # not a heading command. Both vectors use the same body-frame convention
    # (forward is negative x in the raw adapter), and velocity is normalized by
    # the inherited length scale. Withhold support at negligible speed rather
    # than interpreting a zero cross product as a perfect intercept.
    course_forward_U = -_safe(state.velocity_body_U[1], 0.0)
    course_lateral_U = _safe(state.velocity_body_U[2], 0.0)
    course_speed_U = hypot(course_forward_U, course_lateral_U)
    course_forward = course_forward_U / params.L
    course_lateral = course_lateral_U / params.L
    course_speed = hypot(course_forward, course_lateral)
    target_direction_norm = hypot(forward_component, lateral_component)
    course_alignment = (
        forward_component * course_forward +
        lateral_component * course_lateral
    ) / max(target_direction_norm * course_speed, 1.0e-6)
    course_error = acos(_clamp_unit(course_alignment))
    course_cross =
        forward_component * course_lateral -
        lateral_component * course_forward
    course_signed_sine = clamp(
        course_cross / max(target_direction_norm * course_speed, 1.0e-6),
        -1.0,
        1.0,
    )
    course_sine = abs(course_signed_sine)
    predicted_miss_L = course_speed > 1.0e-6 ?
        distance_L * _clamp01(course_sine) :
        distance_L
    course_miss_fraction = _clamp01(
        predicted_miss_L / max(distance_L, 1.0e-6),
    )
    # Center course contains both route translation and fast gait-scale sway.
    # It may elevate the low-frequency target residual only when its signed
    # correction agrees with geometry-only target steering. Reusing the
    # centerline angle scale makes the consent vanish smoothly as either cue
    # crosses zero, without introducing beat phase or a new authority gain.
    course_geometry_agreement = _smoothstep01(
        max(redirect_angle * course_signed_sine, 0.0) /
        max(
            max(
                params.centerline_bearing_band,
                params.centerline_vector_band,
            ),
            1.0e-6,
        ),
    )
    terminal_intercept_support = 1.0 - _smoothstep01(
        (predicted_miss_L - params.terminal_intercept_miss_full_L) /
        max(
            params.terminal_intercept_miss_on_L -
            params.terminal_intercept_miss_full_L,
            1.0e-6,
        ),
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
        relative_crossflow_y=relative_crossflow_y,
        centerline_gain=centerline_gain,
        sweep_damping=sweep_damping,
        positive_recovery=positive_recovery,
        centerline_rate_brake=centerline_rate_brake,
        recovery_curvature_request=recovery_curvature_request,
        redirect_angle=redirect_angle,
        redirect_gate=redirect_gate,
        redirect_command=redirect_command,
        preview_closing_speed_L=preview_closing_speed_L,
        preview_horizon_T=preview_horizon_T,
        preview_distance_L=preview_distance_L,
        terminal_proximity_gate=terminal_proximity_gate,
        terminal_closure_support=terminal_closure_support,
        terminal_reallocation_gate=terminal_reallocation_gate,
        target_helpful_crossflow_U=target_helpful_crossflow_U,
        terminal_crossflow_support=terminal_crossflow_support,
        terminal_relief_closure_support=terminal_relief_closure_support,
        terminal_relief_proximity=terminal_relief_proximity,
        outer_helpful_motion_release=outer_helpful_motion_release,
        course_speed_U=course_speed_U,
        course_error=course_error,
        course_signed_sine=course_signed_sine,
        predicted_miss_L=predicted_miss_L,
        course_miss_fraction=course_miss_fraction,
        course_geometry_agreement=course_geometry_agreement,
        terminal_intercept_support=terminal_intercept_support,
    )
end

function turn_actuator_module(drive, guidance, params)
    tail_tangent = drive.q1 + drive.q2
    tail_velocity = drive.qd1 + drive.qd2
    tail_side = tanh(tail_tangent / max(params.tail_tangent_scale, 1.0e-6))
    tail_motion = tanh(tail_velocity / max(params.drive_amplitude * drive.omega, 1.0e-6))

    # Steering biases the currently observed bend/velocity cycle without an
    # explicit period, keeping parameter tuning on active state-feedback terms.
    baseline_request = (1.0 - guidance.redirect_gate) * guidance.turn_request
    halfcycle_gate =
        1.0 +
        params.halfcycle_tail_bias * baseline_request * tail_side +
        params.halfcycle_velocity_gain * baseline_request * tail_motion
    halfcycle_gate = clamp(halfcycle_gate, 0.55, 1.45)
    steer = baseline_request * halfcycle_gate
    return (
        head_delta=params.head_turn_share * steer,
        tail_delta=params.tail_turn_share * steer,
        halfcycle_gate=halfcycle_gate,
        steer=steer,
    )
end

function terminal_redirect_module(drive, params)
    redirect_omega = max(
        params.terminal_curvature_bandwidth_ratio * drive.omega,
        1.0e-6,
    )
    damping = 2.0 * params.terminal_curvature_damping * redirect_omega

    # `mean_tail_tangent` is the desired q1+q2 equilibrium. Tracking q2 to
    # that tangent minus the head bias shares the bend between both joints
    # instead of superposing the full carrier on the posterior curvature.
    head_target = drive.head_bias
    tail_target = drive.mean_tail_tangent - head_target
    accel_limit = max(params.terminal_curvature_accel_limit, 1.0e-6)
    raw_head_accel =
        redirect_omega^2 * (head_target - drive.q1) - damping * drive.qd1
    raw_tail_accel =
        redirect_omega^2 * (tail_target - drive.q2) - damping * drive.qd2

    # The full equilibrium controller forms the requested bend. Once both
    # joints are close to it, recover part of the carrier that is already
    # centered on this same mean curvature. This is response-triggered state
    # feedback, not a timed burst or a change of turn sign.
    tracking_error = max(
        abs(head_target - drive.q1),
        abs(tail_target - drive.q2),
    ) / max(params.drive_amplitude, 1.0e-6)
    unsettled_weight = _smoothstep01(
        tracking_error / max(params.terminal_tracking_error_full, 1.0e-6),
    )
    settled_hold = _clamp01(params.terminal_settled_hold_fraction)
    allocation_support =
        settled_hold + (1.0 - settled_hold) * unsettled_weight
    return (
        head_accel=clamp(raw_head_accel, -accel_limit, accel_limit),
        tail_accel=clamp(raw_tail_accel, -accel_limit, accel_limit),
        head_target=head_target,
        tail_target=tail_target,
        redirect_omega=redirect_omega,
        tracking_error=tracking_error,
        unsettled_weight=unsettled_weight,
        allocation_support=allocation_support,
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
    drive_frequency_scale = max(
        params.redirect_drive_floor,
        drive_frequency_scale *
        (1.0 - params.redirect_drive_relief * guidance.redirect_gate),
    )
    drive = drive_module(
        state,
        params,
        guidance.turn_request,
        drive_frequency_scale,
        guidance.recovery_curvature_request,
        guidance.redirect_gate,
        guidance.redirect_command,
    )
    turn = turn_actuator_module(drive, guidance, params)
    turn_residual_scale = 1.0 - guidance.outer_helpful_motion_release
    turn_head_delta = turn_residual_scale * turn.head_delta
    turn_tail_delta = turn_residual_scale * turn.tail_delta
    terminal_redirect = terminal_redirect_module(drive, params)
    # The evaluated outer mechanism can enter the terminal band on a valid
    # center intercept before large target angle activates redirect. Give that
    # state a small posture handoff toward the same damped bend equilibrium.
    # An actual-distance gate keeps the added branch exactly zero outside 4 L;
    # `max` prevents it from stacking authority onto an active redirect.
    terminal_actual_proximity_gate = _smoothstep01(
        (params.terminal_reallocation_on_L - guidance.distance_L) /
        max(
            params.terminal_reallocation_on_L -
            params.terminal_reallocation_full_L,
            1.0e-6,
        ),
    )
    terminal_intercept_posture_support =
        _clamp01(params.terminal_intercept_hold_max_fraction) *
        terminal_actual_proximity_gate *
        guidance.terminal_intercept_support
    terminal_posture_gate = max(
        guidance.redirect_gate,
        terminal_intercept_posture_support,
    )
    base_terminal_weight =
        terminal_posture_gate *
        guidance.terminal_proximity_gate *
        guidance.terminal_closure_support *
        (1.0 - params.terminal_carrier_floor) *
        terminal_redirect.allocation_support
    settled_response = 1.0 - terminal_redirect.unsettled_weight
    terminal_response_support =
        guidance.terminal_relief_proximity *
        guidance.terminal_crossflow_support *
        guidance.terminal_relief_closure_support *
        settled_response
    terminal_intercept_release =
        _clamp01(params.terminal_intercept_release_max_fraction) *
        terminal_response_support *
        guidance.terminal_intercept_support
    terminal_curvature_relief = _clamp01(
        _clamp01(params.terminal_crossflow_relief_max_fraction) *
        terminal_response_support +
        terminal_intercept_release,
    )
    terminal_weight =
        base_terminal_weight * (1.0 - terminal_curvature_relief)
    carrier_weight = 1.0 - terminal_weight
    limit = max(params.command_accel_limit, 1.0e-6)
    # Independent clipping can flatten the requested anterior/posterior ratio
    # during the high-command outer carrier. Poor posterior response retains
    # the strongest sampled extra common-scale support. Once that response is
    # settled, only the complementary fraction may instead preserve the
    # bounded target-turn residual after limiting the rhythmic drive. The two
    # priorities remain exclusive throughout this allocation.
    outer_saturation_gate = _smoothstep01(
        (guidance.distance_L - params.terminal_reallocation_on_L) /
        max(params.coupled_saturation_full_margin_L, 1.0e-6),
    )
    posterior_lag_error = abs(drive.tail_target - drive.q2) /
        max(params.drive_amplitude, 1.0e-6)
    response_limit = _direction_conditioned_coupled_limit(
        drive.head_accel + turn_head_delta,
        drive.tail_accel + turn_tail_delta,
        limit,
        params.coupled_saturation_fraction,
        params.coupled_saturation_direction_fraction,
        params.coupled_saturation_response_fraction,
        params.coupled_saturation_direction_full_sine,
        posterior_lag_error,
        params.coupled_saturation_lag_error_on,
        params.coupled_saturation_lag_error_full,
        outer_saturation_gate,
    )
    base_limit = _direction_conditioned_coupled_limit(
        drive.head_accel + turn_head_delta,
        drive.tail_accel + turn_tail_delta,
        limit,
        params.coupled_saturation_fraction,
        params.coupled_saturation_direction_fraction,
        0.0,
        params.coupled_saturation_direction_full_sine,
        0.0,
        params.coupled_saturation_lag_error_on,
        params.coupled_saturation_lag_error_full,
        outer_saturation_gate,
    )
    drive_limit = _direction_conditioned_coupled_limit(
        drive.head_accel,
        drive.tail_accel,
        limit,
        params.coupled_saturation_fraction,
        params.coupled_saturation_direction_fraction,
        0.0,
        params.coupled_saturation_direction_full_sine,
        0.0,
        params.coupled_saturation_lag_error_on,
        params.coupled_saturation_lag_error_full,
        outer_saturation_gate,
    )
    prioritized_head_command = clamp(
        drive_limit.head + turn_head_delta,
        -limit,
        limit,
    )
    prioritized_tail_command = clamp(
        drive_limit.tail + turn_tail_delta,
        -limit,
        limit,
    )
    target_residual_priority_gate =
        outer_saturation_gate *
        base_limit.direction_support *
        _clamp01(1.0 - base_limit.common_scale)
    residual_head_command =
        base_limit.head +
        target_residual_priority_gate *
        (prioritized_head_command - base_limit.head)
    residual_tail_command =
        base_limit.tail +
        target_residual_priority_gate *
        (prioritized_tail_command - base_limit.tail)

    # The response-exclusive parent uses posterior position response to select
    # between common limiting and target-residual preservation. Established
    # center translation with a severe normalized miss may transfer a bounded
    # share toward the target residual only when its signed correction agrees
    # with geometry-only steering. This changes neither total authority nor
    # the terminal law because the outer gate is exactly zero at and below 4 L.
    settled_share = 1.0 - response_limit.lag_support
    baseline_head_command =
        response_limit.head +
        settled_share * (residual_head_command - base_limit.head)
    baseline_tail_command =
        response_limit.tail +
        settled_share * (residual_tail_command - base_limit.tail)
    course_motion_support = _smoothstep01(
        guidance.course_speed_U /
        max(params.outer_course_speed_support_full_U, 1.0e-6),
    )
    course_miss_support = _smoothstep01(
        (guidance.course_miss_fraction - params.outer_course_miss_fraction_on) /
        max(
            params.outer_course_miss_fraction_full -
            params.outer_course_miss_fraction_on,
            1.0e-6,
        ),
    )
    course_residual_priority =
        outer_saturation_gate *
        base_limit.direction_support *
        course_motion_support *
        course_miss_support *
        guidance.course_geometry_agreement
    response_to_residual_head =
        response_limit.lag_support *
            (residual_head_command - base_limit.head) -
        (response_limit.head - base_limit.head)
    response_to_residual_tail =
        response_limit.lag_support *
            (residual_tail_command - base_limit.tail) -
        (response_limit.tail - base_limit.tail)
    carrier_head_command =
        baseline_head_command +
        course_residual_priority * response_to_residual_head
    carrier_tail_command =
        baseline_tail_command +
        course_residual_priority * response_to_residual_tail
    angular_damping =
        -params.body_angular_damping_gain * _safe(state.moment_z_L2, 0.0) / max(params.L^3, eps(Float64))
    head_command =
        carrier_weight * carrier_head_command +
        terminal_weight * terminal_redirect.head_accel +
        angular_damping
    tail_command =
        carrier_weight * carrier_tail_command +
        terminal_weight * terminal_redirect.tail_accel
    return (
        phi_ddot=(
            clamp(head_command, -limit, limit),
            clamp(tail_command, -limit, limit),
        ),
    )
end
