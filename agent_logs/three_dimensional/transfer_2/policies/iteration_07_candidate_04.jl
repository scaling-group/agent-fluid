# L64 target controller: retain the evidenced approach allocator and add one
# body-frame, response-gated redirect mode for a tighter terminal turn.

function target_policy_params()
    return (
        version="dogfish3d_response_gated_redirect_v1",
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.80,
        tail_damping=0.65,
        target_angle_limit=1.20,
        target_angle_gain=1.00,
        turn_rate_gain=0.42,
        turn_rate_scale=0.45,
        turn_request_scale=0.30,
        turn_direction_band=0.20,
        tail_curvature_limit=8.0 * pi / 180,
        head_steer_accel=3.0,
        approach_outer_distance=6.0,
        approach_inner_distance=2.0,
        closing_speed_scale=0.35,
        approach_amplitude_floor=0.58,
        approach_damping=3.0,
        approach_head_bias_limit=5.0 * pi / 180,
        approach_tail_curvature_boost=6.0 * pi / 180,
        redirect_outer_distance=8.0,
        redirect_inner_distance=2.0,
        redirect_error_on=0.25,
        redirect_error_full=0.65,
        redirect_response_rate_scale=0.45,
        redirect_response_authority_floor=0.35,
        redirect_amplitude_floor=0.32,
        redirect_damping=5.0,
        redirect_head_bias_boost=13.0 * pi / 180,
        redirect_tail_curvature_boost=20.0 * pi / 180,
        command_accel_limit=31.0,
    )
end

@inline function _policy_safe(value, fallback)
    parsed = Float64(value)
    return isfinite(parsed) ? parsed : fallback
end

@inline function _policy_soft_limit(value, limit)
    safe_limit = max(_policy_safe(limit, 1.0), eps(Float64))
    return safe_limit * tanh(_policy_safe(value, 0.0) / safe_limit)
end

@inline function _policy_smooth_ramp(value)
    bounded = clamp(_policy_safe(value, 0.0), 0.0, 1.0)
    return bounded * bounded * (3.0 - 2.0 * bounded)
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    base_amplitude = params.oscillator_amplitude
    q1 = _policy_safe(state.phi[1], 0.0)
    q2 = _policy_safe(state.phi[2], 0.0)
    qd1 = _policy_safe(state.phi_dot[1], 0.0)
    qd2 = _policy_safe(state.phi_dot[2], 0.0)

    # The fish points along negative body x. This full target direction keeps
    # fore/aft sense through an abeam crossing and remains reflection symmetric.
    target_x = _policy_safe(state.target_body_L[1], -1.0)
    target_y = _policy_safe(state.target_body_L[2], 0.0)
    target_angle = clamp(
        atan(target_y, -target_x),
        -params.target_angle_limit,
        params.target_angle_limit,
    )
    turn_rate = hasproperty(state, :turn_rate_recent) ?
        _policy_safe(state.turn_rate_recent, 0.0) :
        _policy_safe(state.heading_rate, 0.0)
    route_request = -params.target_angle_gain * target_angle
    rate_brake = -params.turn_rate_gain * tanh(
        turn_rate / max(params.turn_rate_scale, eps(Float64)),
    )
    turn_command = tanh(
        (route_request + rate_brake) /
        max(params.turn_request_scale, eps(Float64)),
    )
    turn_direction = tanh(
        -target_angle / max(params.turn_direction_band, eps(Float64)),
    )

    distance = max(
        _policy_safe(state.distance_L, params.redirect_outer_distance),
        0.0,
    )

    # Retain the evaluated allocator: while near and still closing, reduce the
    # saturated carrier so the aligned bend has usable command headroom.
    approach_span = max(
        params.approach_outer_distance - params.approach_inner_distance,
        eps(Float64),
    )
    approach_weight = clamp(
        (params.approach_outer_distance - distance) / approach_span,
        0.0,
        1.0,
    )
    closing_speed = hasproperty(state, :closing_speed_L) ?
        _policy_safe(state.closing_speed_L, 0.0) :
        0.0
    closing_gate = tanh(
        max(closing_speed, 0.0) /
        max(params.closing_speed_scale, eps(Float64)),
    )
    drive_relief = approach_weight * closing_gate

    # C-start invariant translated into continuous state feedback. Large
    # off-nose error in the middle/near field requests extra curvature. A
    # correct-sign recent yaw response releases most, but not all, of the
    # redirect until the geometric error itself has fallen.
    redirect_span = max(
        params.redirect_outer_distance - params.redirect_inner_distance,
        eps(Float64),
    )
    redirect_proximity = _policy_smooth_ramp(
        (params.redirect_outer_distance - distance) / redirect_span,
    )
    redirect_error_span = max(
        params.redirect_error_full - params.redirect_error_on,
        eps(Float64),
    )
    redirect_error = _policy_smooth_ramp(
        (abs(target_angle) - params.redirect_error_on) / redirect_error_span,
    )
    correct_turn_response = max(turn_direction * turn_rate, 0.0)
    response_release = tanh(
        correct_turn_response /
        max(params.redirect_response_rate_scale, eps(Float64)),
    )
    response_authority =
        1.0 -
        (1.0 - params.redirect_response_authority_floor) * response_release
    redirect_weight =
        redirect_proximity * redirect_error * response_authority

    approach_amplitude_fraction =
        1.0 - drive_relief * (1.0 - params.approach_amplitude_floor)
    redirect_amplitude_fraction =
        1.0 - redirect_weight * (1.0 - params.redirect_amplitude_floor)
    amplitude_fraction = max(
        approach_amplitude_fraction * redirect_amplitude_fraction,
        params.redirect_amplitude_floor,
    )
    active_amplitude = max(
        base_amplitude * amplitude_fraction,
        eps(Float64),
    )

    # The ordinary approach bias preserves the sampled policy's gentle turn.
    # Redirect authority adds a stronger same-sign C-bend without changing the
    # global acceleration envelope or introducing a clock-driven stage.
    head_bias =
        params.approach_head_bias_limit * approach_weight * turn_command +
        params.redirect_head_bias_boost * redirect_weight * turn_direction
    centered_q1 = q1 - head_bias
    vdp_drive =
        params.oscillator_mu *
        (1 - (centered_q1 / active_amplitude)^2) *
        qd1
    head_drive =
        vdp_drive -
        omega^2 * centered_q1 -
        params.approach_damping * drive_relief * qd1 -
        params.redirect_damping * redirect_weight * qd1

    mean_tail_tangent =
        params.tail_curvature_limit * turn_command +
        params.approach_tail_curvature_boost * approach_weight * turn_command +
        params.redirect_tail_curvature_boost * redirect_weight * turn_direction
    tail_target =
        mean_tail_tangent -
        q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(Float64))
    tail_drive =
        omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2
    raw_head_accel = head_drive + params.head_steer_accel * turn_command

    return (
        phi_ddot=(
            _policy_soft_limit(raw_head_accel, params.command_accel_limit),
            _policy_soft_limit(tail_drive, params.command_accel_limit),
        ),
    )
end
