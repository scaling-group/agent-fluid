# Compact L64 target controller: preserve the evidenced traveling-bend drive
# and steer with a bearing-signed curvature whose authority releases only
# after observed body-frame target alignment improves.

function target_policy_params()
    return (
        version="dogfish3d_bearing_response_release_v2",
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.80,
        tail_damping=0.65,
        bearing_limit=1.20,
        bearing_scale=0.35,
        response_direction_band=0.12,
        response_rate_scale=0.45,
        response_authority_floor=0.28,
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

function steering_response(state, params)
    bearing = clamp(
        _policy_safe(state.bearing, 0.0),
        -params.bearing_limit,
        params.bearing_limit,
    )
    bearing_rate = hasproperty(state, :bearing_window_rate) ?
        _policy_safe(state.bearing_window_rate, 0.0) :
        _policy_safe(state.bearing_rate, 0.0)

    # The sampled 3D convention requires positive mean tail tangent to reduce
    # positive bearing. Bearing fixes the requested sign. A smooth bearing
    # direction turns line-of-sight rate into a reflection-symmetric measure
    # of motion toward alignment.
    bearing_direction = tanh(
        bearing / max(params.response_direction_band, eps(Float64)),
    )
    toward_center_rate = max(-bearing_direction * bearing_rate, 0.0)

    # Turn response may release curvature but cannot reverse it before the
    # target actually crosses the body centerline. This avoids converting the
    # beat-scale rate excursions seen in the best parent into opposite bends.
    release_fraction = tanh(
        toward_center_rate / max(params.response_rate_scale, eps(Float64)),
    )
    response_authority =
        1.0 -
        (1.0 - params.response_authority_floor) * release_fraction
    bearing_command = tanh(
        bearing / max(params.bearing_scale, eps(Float64)),
    )
    curvature_command = bearing_command * response_authority
    return (
        bearing=bearing,
        bearing_rate=bearing_rate,
        toward_center_rate=toward_center_rate,
        response_authority=response_authority,
        curvature_command=curvature_command,
    )
end

function target_policy(state, params)
    steering = steering_response(state, params)
    omega = 2 * pi / params.control_period
    amplitude = params.oscillator_amplitude
    q1 = _policy_safe(state.phi[1], 0.0)
    q2 = _policy_safe(state.phi[2], 0.0)
    qd1 = _policy_safe(state.phi_dot[1], 0.0)
    qd2 = _policy_safe(state.phi_dot[2], 0.0)

    # Joint state remains the only gait phase. The posterior target preserves
    # the best sample's directional lag and coherent three-dimensional wake.
    vdp_drive =
        params.oscillator_mu *
        (1 - (q1 / max(amplitude, eps(Float64)))^2) *
        qd1
    head_drive = vdp_drive - omega^2 * q1
    mean_tail_tangent =
        params.tail_curvature_limit * steering.curvature_command
    tail_target =
        mean_tail_tangent -
        q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(Float64))
    tail_drive =
        omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    # A small opposite-signed anterior acceleration complements the posterior
    # mean tangent without shifting the oscillator equilibrium. Smooth bounds
    # keep both commands inside the physical acceleration envelope.
    raw_head_accel =
        head_drive -
        params.head_steer_accel * steering.curvature_command
    return (
        phi_ddot=(
            _policy_soft_limit(raw_head_accel, params.command_accel_limit),
            _policy_soft_limit(tail_drive, params.command_accel_limit),
        ),
    )
end
