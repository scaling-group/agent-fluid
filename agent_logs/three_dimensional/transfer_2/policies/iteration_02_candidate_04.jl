# Coordinated L64 target controller: preserve the evidenced traveling-bend
# drive and apply one signed body-frame bearing request consistently at both
# joints. Propulsive yaw is deliberately excluded from the route loop.

function target_policy_params()
    return (
        version="dogfish3d_coordinated_bearing_curvature_v2",
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.80,
        tail_damping=0.65,
        bearing_limit=1.20,
        bearing_scale=0.30,
        tail_curvature_limit=8.0 * pi / 180,
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

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amplitude = params.oscillator_amplitude
    q1 = _policy_safe(state.phi[1], 0.0)
    q2 = _policy_safe(state.phi[2], 0.0)
    qd1 = _policy_safe(state.phi_dot[1], 0.0)
    qd2 = _policy_safe(state.phi_dot[2], 0.0)

    # Phase remains entirely in observed joint state.  The posterior target
    # retains the seed's directional lag and therefore its useful 3D wake.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amplitude)^2) * qd1
    head_drive = vdp_drive - omega^2 * q1

    # Positive body-frame bearing requires decreasing yaw in this geometry.
    # The sampled recent-yaw signal swings with the propulsive tailbeat, so the
    # route request uses only persistent target geometry rather than treating
    # gait yaw as a slow turn response.
    bearing = clamp(
        _policy_safe(state.bearing, 0.0),
        -params.bearing_limit,
        params.bearing_limit,
    )
    turn_command = -tanh(
        bearing / max(params.bearing_scale, eps(Float64)),
    )

    # The anterior steering acceleration and posterior total-tangent target now
    # share one calibrated sign.  This removes the parent's opposing-joint map
    # while retaining the traveling wave around the bounded average bend.
    mean_tail_tangent = params.tail_curvature_limit * turn_command
    tail_target =
        mean_tail_tangent - q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(Float64))
    tail_drive =
        omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2
    raw_head_accel = head_drive + params.head_steer_accel * turn_command

    # Smooth controller-owned bounds avoid depending on the episode's hard
    # acceleration clamp, which dominated the sampled parent's commands.
    return (
        phi_ddot=(
            _policy_soft_limit(raw_head_accel, params.command_accel_limit),
            _policy_soft_limit(tail_drive, params.command_accel_limit),
        ),
    )
end
