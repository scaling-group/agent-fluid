# Compact L64 target controller: preserve the evidenced traveling-bend drive
# and steer by strengthening the target-directed posterior bend half-cycle.

function target_policy_params()
    return (
        version="dogfish3d_bearing_halfcycle_tail_v1",
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.80,
        tail_damping=0.65,
        bearing_limit=1.20,
        bearing_scale=0.35,
        tail_phase_scale=8.0 * pi / 180,
        halfcycle_asymmetry_limit=0.45,
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

function halfcycle_steering(state, params, base_tail_tangent)
    bearing = clamp(
        _policy_safe(state.bearing, 0.0),
        -params.bearing_limit,
        params.bearing_limit,
    )
    bearing_command = tanh(
        bearing / max(params.bearing_scale, eps(Float64)),
    )
    tail_side = tanh(
        base_tail_tangent / max(params.tail_phase_scale, eps(Float64)),
    )

    # Positive bearing strengthens the positive posterior-tangent half-cycle
    # and weakens the negative one; reflection changes both signs together.
    # This yields a cycle-mean bend without a static curvature offset or clock.
    halfcycle_gain = clamp(
        1.0 +
        params.halfcycle_asymmetry_limit * bearing_command * tail_side,
        1.0 - params.halfcycle_asymmetry_limit,
        1.0 + params.halfcycle_asymmetry_limit,
    )
    return (
        bearing=bearing,
        bearing_command=bearing_command,
        tail_side=tail_side,
        halfcycle_gain=halfcycle_gain,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amplitude = params.oscillator_amplitude
    q1 = _policy_safe(state.phi[1], 0.0)
    q2 = _policy_safe(state.phi[2], 0.0)
    qd1 = _policy_safe(state.phi_dot[1], 0.0)
    qd2 = _policy_safe(state.phi_dot[2], 0.0)

    # Joint state remains the only gait phase. The centered anterior oscillator
    # is unchanged from the drive that made the coherent three-dimensional wake.
    vdp_drive =
        params.oscillator_mu *
        (1 - (q1 / max(amplitude, eps(Float64)))^2) *
        qd1
    head_drive = vdp_drive - omega^2 * q1

    # In the seed, q1 + q2 tracks this posterior-lag tangent. Steering reshapes
    # its two observed half-cycles instead of adding a persistent mean offset.
    base_tail_tangent =
        -params.tail_lag_gain * qd1 / max(omega, eps(Float64))
    steering = halfcycle_steering(state, params, base_tail_tangent)
    shaped_tail_tangent =
        base_tail_tangent * steering.halfcycle_gain
    tail_target =
        shaped_tail_tangent - q1
    tail_drive =
        omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Smooth bounds keep both commands inside the physical acceleration
    # envelope without relying on the episode clamp.
    return (
        phi_ddot=(
            _policy_soft_limit(head_drive, params.command_accel_limit),
            _policy_soft_limit(tail_drive, params.command_accel_limit),
        ),
    )
end
