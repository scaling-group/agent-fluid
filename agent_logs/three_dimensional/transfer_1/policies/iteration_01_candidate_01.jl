# Command-compatible target-curvature controller for the L64 3D moving window.
# Oscillation phase remains entirely in joint state; no clock, route, or
# world-frame coordinate enters the policy.

function target_policy_params(; L::Int=64)
    L > 0 || throw(ArgumentError("L must be positive"))
    return (
        version="dogfish3d_state_feedback_target_curvature_v1",
        control_period=0.90,
        oscillator_amplitude=14.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.80,
        tail_damping=0.65,
        target_error_scale=0.30,
        yaw_rate_damping_T=0.30,
        mean_tail_curvature_limit=12.0 * pi / 180,
        command_soft_limit=30.0,
    )
end

@inline function _finite_observation(value, fallback)
    parsed = Float64(value)
    return isfinite(parsed) ? parsed : fallback
end

@inline function _soft_bound(value, limit)
    safe_limit = max(abs(Float64(limit)), eps(Float64))
    return safe_limit * tanh(_finite_observation(value, 0.0) / safe_limit)
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amplitude = max(abs(params.oscillator_amplitude), eps(Float64))
    q1 = _finite_observation(state.phi[1], 0.0)
    q2 = _finite_observation(state.phi[2], 0.0)
    qd1 = _finite_observation(state.phi_dot[1], 0.0)
    qd2 = _finite_observation(state.phi_dot[2], 0.0)

    # Preserve the seed's self-excited anterior rhythm.
    vdp_drive =
        params.oscillator_mu *
        (1 - (q1 / amplitude)^2) *
        qd1
    raw_head_accel = vdp_drive - omega^2 * q1

    # The normalized lateral target direction is the persistent route error.
    # Positive body-y lies to the fish's right because its head points along
    # negative body-x; a positive mean tangent therefore requests negative yaw.
    distance_L = max(
        abs(_finite_observation(state.distance_L, 1.0)),
        eps(Float64),
    )
    target_lateral_L = _finite_observation(state.target_body_L[2], 0.0)
    lateral_target_error = clamp(target_lateral_L / distance_L, -1.0, 1.0)
    yaw_rate = hasproperty(state, :turn_rate_recent) ?
        _finite_observation(state.turn_rate_recent, 0.0) :
        _finite_observation(state.heading_rate, 0.0)

    curvature_error =
        lateral_target_error +
        params.yaw_rate_damping_T * yaw_rate
    mean_tail_tangent =
        params.mean_tail_curvature_limit *
        tanh(
            curvature_error /
            max(params.target_error_scale, eps(Float64)),
        )

    # Posterior lag retains the traveling bend while the bounded mean tangent
    # adds target-relative curvature. This is the sole steering actuator.
    tail_target =
        mean_tail_tangent -
        q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(Float64))
    raw_tail_accel =
        omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (
        phi_ddot=(
            _soft_bound(raw_head_accel, params.command_soft_limit),
            _soft_bound(raw_tail_accel, params.command_soft_limit),
        ),
    )
end
