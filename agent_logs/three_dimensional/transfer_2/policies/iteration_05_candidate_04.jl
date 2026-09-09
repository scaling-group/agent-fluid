# Speed-authority-gated line-of-sight curvature controller.
#
# Preserve the sampled compact traveling-bend gait. A normalized body-frame
# target angle signs the distributed mean bend, while unnormalized forward
# speed schedules only steering authority. Instantaneous course direction and
# short-window rate feedback are excluded because their evaluated oscillations
# owned the route before propulsion was established.

function target_policy_params()
    return (
        version="dogfish3d_speed_gated_los_curvature_v1",
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.80,
        tail_damping=0.65,
        line_of_sight_limit=1.35,
        line_of_sight_scale=0.35,
        target_forward_floor=0.10,
        steering_authority_floor=0.18,
        steering_speed_scale=0.30,
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

    # The fish advances along negative body x; positive body y is the sampled
    # positive-bearing side. A small positive forward denominator keeps the
    # directly-aft ambiguity reflection symmetric while giving off-axis rear
    # targets substantially more authority than the adapter's folded bearing.
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

    # Forward speed is used only as a nonnegative authority measure, never as
    # a normalized direction. Thus lateral tail-beat velocity cannot reverse
    # the slow steering request as it did in the evaluated course controller.
    velocity_x = _policy_safe(state.velocity_body_U[1], 0.0)
    forward_speed = max(-velocity_x, 0.0)
    speed_fraction = tanh(
        forward_speed / max(params.steering_speed_scale, eps(Float64)),
    )
    steering_authority =
        params.steering_authority_floor +
        (1.0 - params.steering_authority_floor) * speed_fraction
    turn_command =
        steering_authority *
        tanh(
            bounded_aim_angle /
            max(params.line_of_sight_scale, eps(Float64)),
        )
    return (
        target_forward=target_forward,
        target_lateral=target_lateral,
        signed_aim_angle=signed_aim_angle,
        forward_speed=forward_speed,
        steering_authority=steering_authority,
        turn_command=turn_command,
    )
end

function target_policy(state, params)
    guidance = line_of_sight_guidance(state, params)
    omega = 2 * pi / params.control_period
    amplitude = params.oscillator_amplitude
    q1 = _policy_safe(state.phi[1], 0.0)
    q2 = _policy_safe(state.phi[2], 0.0)
    qd1 = _policy_safe(state.phi_dot[1], 0.0)
    qd2 = _policy_safe(state.phi_dot[2], 0.0)

    # Joint state remains the only gait phase. The anterior oscillator and
    # lagged posterior target retain the coherent self-propelled wake.
    vdp_drive =
        params.oscillator_mu *
        (1 - (q1 / max(amplitude, eps(Float64)))^2) *
        qd1
    head_drive = vdp_drive - omega^2 * q1

    # The compact evaluated controllers establish this distributed sign:
    # positive target-side error uses positive posterior mean tangent and a
    # small opposite anterior acceleration. Speed changes authority only.
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
        head_drive - params.head_steer_accel * guidance.turn_command

    return (
        phi_ddot=(
            _policy_soft_limit(raw_head_accel, params.command_accel_limit),
            _policy_soft_limit(tail_drive, params.command_accel_limit),
        ),
    )
end
