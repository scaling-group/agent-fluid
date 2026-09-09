# Common-bias traveling-bend controller.
#
# Normalized body-frame bearing recenters both joint oscillations on one
# bounded C-bend equilibrium. The posterior joint retains the evidenced lagged
# traveling wave, so steering changes its mean shape without replacing the
# propulsive rhythm or adding a hidden phase.

function target_policy_params()
    return (
        version="dogfish3d_common_bias_cpg_v1",
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.80,
        tail_damping=0.65,
        bearing_limit=1.20,
        bearing_scale=0.30,
        common_bias_limit=5.0 * pi / 180,
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

function common_bias_guidance(state, params)
    bearing = clamp(
        _policy_safe(state.bearing, 0.0),
        -params.bearing_limit,
        params.bearing_limit,
    )

    # The signed 3D turn sanity establishes that positive common joint bias
    # produces negative yaw. Positive body-frame bearing initially requires
    # that negative-yaw correction, so bearing maps directly to common bias.
    turn_command = tanh(
        bearing / max(params.bearing_scale, eps(Float64)),
    )
    common_bias = params.common_bias_limit * turn_command
    return (
        bearing=bearing,
        turn_command=turn_command,
        common_bias=common_bias,
    )
end

function target_policy(state, params)
    guidance = common_bias_guidance(state, params)
    omega = 2 * pi / params.control_period
    amplitude = max(params.oscillator_amplitude, eps(Float64))
    q1 = _policy_safe(state.phi[1], 0.0)
    q2 = _policy_safe(state.phi[2], 0.0)
    qd1 = _policy_safe(state.phi_dot[1], 0.0)
    qd2 = _policy_safe(state.phi_dot[2], 0.0)

    # Recenter the anterior state-feedback oscillator instead of adding a
    # steering acceleration to a zero-centered gait. This keeps joint state as
    # the only phase and makes the steering deformation a true common C-bend.
    centered_q1 = q1 - guidance.common_bias
    vdp_drive =
        params.oscillator_mu *
        (1 - (centered_q1 / amplitude)^2) *
        qd1
    head_drive = vdp_drive - omega^2 * centered_q1

    # The posterior oscillates about the same common bias while preserving the
    # sampled anterior opposition and velocity lag. At zero bearing this is
    # exactly the compact centered traveling-bend scaffold.
    tail_target =
        guidance.common_bias -
        centered_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(Float64))
    tail_drive =
        omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (
        phi_ddot=(
            _policy_soft_limit(head_drive, params.command_accel_limit),
            _policy_soft_limit(tail_drive, params.command_accel_limit),
        ),
    )
end
