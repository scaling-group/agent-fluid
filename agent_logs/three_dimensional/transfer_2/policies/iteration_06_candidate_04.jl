# Aligned line-of-sight mean-curvature controller.
#
# Keep the evidenced joint-state traveling wave, but make persistent normalized
# target geometry—not beat-scale yaw rate—the owner of route steering. Both
# steering contributions retain the aligned sign that produced the best
# sampled closest approach.

function target_policy_params()
    return (
        version="dogfish3d_aligned_los_mean_curvature_v1",
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.80,
        tail_damping=0.65,
        line_of_sight_limit=1.35,
        line_of_sight_scale=0.35,
        target_forward_floor=0.10,
        mean_curvature_limit=8.0 * pi / 180,
        head_steer_accel=3.0,
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

function line_of_sight_guidance(state, params)
    target_x = _policy_safe(state.target_body_L[1], -1.0)
    target_y = _policy_safe(state.target_body_L[2], 0.0)
    target_norm = max(hypot(target_x, target_y), eps(Float64))

    # Negative body x is the fish's forward direction. Retaining both unit
    # target components exposes an abeam or rear target that folded bearing
    # suppresses. The positive floor resolves the directly-aft ambiguity from
    # lateral target sign without embedding a world-frame turn direction.
    target_forward = clamp(-target_x / target_norm, -1.0, 1.0)
    target_lateral = clamp(target_y / target_norm, -1.0, 1.0)
    signed_aim_angle = atan(
        target_lateral,
        max(target_forward, params.target_forward_floor),
    )
    bounded_aim_angle = clamp(
        signed_aim_angle,
        -params.line_of_sight_limit,
        params.line_of_sight_limit,
    )

    # The sampled 3D sign convention requires positive target-body y to
    # request negative yaw. No instantaneous yaw or velocity direction may
    # reverse this persistent geometry-owned request.
    turn_command = -tanh(
        bounded_aim_angle /
        max(params.line_of_sight_scale, eps(Float64)),
    )
    return (
        target_forward=target_forward,
        target_lateral=target_lateral,
        signed_aim_angle=signed_aim_angle,
        turn_command=turn_command,
    )
end

function target_policy(state, params)
    guidance = line_of_sight_guidance(state, params)
    omega = 2 * pi / params.control_period
    amplitude = max(params.oscillator_amplitude, eps(Float64))
    q1 = _policy_safe(state.phi[1], 0.0)
    q2 = _policy_safe(state.phi[2], 0.0)
    qd1 = _policy_safe(state.phi_dot[1], 0.0)
    qd2 = _policy_safe(state.phi_dot[2], 0.0)

    # Joint state remains the only gait phase. The posterior target preserves
    # the directional lag that produces the sampled coherent 3D wake.
    vdp_drive =
        params.oscillator_mu *
        (1 - (q1 / amplitude)^2) *
        qd1
    head_drive = vdp_drive - omega^2 * q1

    # Anterior acceleration and posterior mean tangent use the same evidenced
    # steering sign. This differs from the inherited LOS controller whose
    # opposing contributions curled upward before useful translation.
    mean_tail_tangent =
        params.mean_curvature_limit * guidance.turn_command
    tail_target =
        mean_tail_tangent -
        q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(Float64))
    tail_drive =
        omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2
    raw_head_accel =
        head_drive + params.head_steer_accel * guidance.turn_command

    return (
        phi_ddot=(
            _policy_soft_limit(raw_head_accel, params.command_accel_limit),
            _policy_soft_limit(tail_drive, params.command_accel_limit),
        ),
    )
end
