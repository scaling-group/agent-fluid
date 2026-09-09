# Compact L64 target controller: retain the evidenced approach allocation and
# add a bounded realized-motion residual before momentum carries the fish past.

function target_policy_params()
    return (
        version="dogfish3d_motion_residual_approach_bend_v2",
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
        tail_curvature_limit=8.0 * pi / 180,
        head_steer_accel=3.0,
        approach_outer_distance=6.0,
        approach_inner_distance=2.0,
        closing_speed_scale=0.35,
        velocity_component_limit_U=1.1,
        motion_angle_scale=0.35,
        motion_speed_scale_U=0.25,
        motion_head_bias_limit=3.0 * pi / 180,
        motion_tail_curvature_boost=6.0 * pi / 180,
        approach_amplitude_floor=0.58,
        approach_damping=3.0,
        approach_head_bias_limit=5.0 * pi / 180,
        approach_tail_curvature_boost=6.0 * pi / 180,
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

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    base_amplitude = params.oscillator_amplitude
    q1 = _policy_safe(state.phi[1], 0.0)
    q2 = _policy_safe(state.phi[2], 0.0)
    qd1 = _policy_safe(state.phi_dot[1], 0.0)
    qd2 = _policy_safe(state.phi_dot[2], 0.0)

    # Distance supplies a continuous approach coordinate, while positive
    # observed closing speed gates both drive relief and the motion residual.
    # If closing ceases, ordinary target pursuit and the carrier return smoothly.
    distance = max(
        _policy_safe(state.distance_L, params.approach_outer_distance),
        0.0,
    )
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

    # The fish points along negative body x. Keep ordinary target pursuit as the
    # broad route request, then compare it with realized motion direction. The
    # separate residual remains active when the line-of-sight request saturates.
    target_x = _policy_safe(state.target_body_L[1], -1.0)
    target_y = _policy_safe(state.target_body_L[2], 0.0)
    velocity_limit = max(params.velocity_component_limit_U, eps(Float64))
    velocity_x = clamp(
        _policy_safe(state.velocity_body_U[1], 0.0),
        -velocity_limit,
        velocity_limit,
    )
    velocity_y = clamp(
        _policy_safe(state.velocity_body_U[2], 0.0),
        -velocity_limit,
        velocity_limit,
    )
    target_angle = clamp(
        atan(target_y, -target_x),
        -params.target_angle_limit,
        params.target_angle_limit,
    )
    motion_speed = hypot(velocity_x, velocity_y)
    velocity_angle = clamp(
        atan(velocity_y, -velocity_x),
        -params.target_angle_limit,
        params.target_angle_limit,
    )
    motion_angle_error = target_angle - velocity_angle
    motion_command = -tanh(
        motion_angle_error / max(params.motion_angle_scale, eps(Float64)),
    )
    motion_authority = drive_relief * tanh(
        motion_speed / max(params.motion_speed_scale_U, eps(Float64)),
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

    # Center the state-feedback oscillator on a bounded approach bend. This
    # preserves joint state as phase and frees actuation from the carrier when
    # the fish is both near and still closing rapidly.
    amplitude_fraction =
        1.0 - drive_relief * (1.0 - params.approach_amplitude_floor)
    active_amplitude = max(
        base_amplitude * amplitude_fraction,
        eps(Float64),
    )
    head_bias =
        params.approach_head_bias_limit * approach_weight * turn_command +
        params.motion_head_bias_limit * motion_authority * motion_command
    centered_q1 = q1 - head_bias
    vdp_drive =
        params.oscillator_mu *
        (1 - (centered_q1 / active_amplitude)^2) *
        qd1
    head_drive =
        vdp_drive -
        omega^2 * centered_q1 -
        params.approach_damping * drive_relief * qd1

    # Both steering shares remain aligned. The approach weight raises total
    # mean tangent while the reduced carrier leaves command headroom for it.
    curvature_authority =
        params.tail_curvature_limit +
        params.approach_tail_curvature_boost * approach_weight
    mean_tail_tangent =
        curvature_authority * turn_command +
        params.motion_tail_curvature_boost * motion_authority * motion_command
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
