# Yaw-damped half-cycle steering for the L64 3D moving-window task.
# Oscillator phase remains entirely in observed joint state; target guidance
# uses only normalized body-frame geometry and measured yaw response.

function target_policy_params()
    return (
        version="dogfish3d_yaw_damped_halfcycle_v1",
        control_period=0.80,
        oscillator_amplitude=14.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.80,
        tail_damping=0.65,
        target_error_scale=0.25,
        yaw_rate_damping_T=0.35,
        halfcycle_asymmetry_limit=0.28,
        bend_side_scale=10.0 * pi / 180,
        command_soft_limit=30.0,
        command_softness=8.0,
    )
end

@inline function _finite_observation(value, fallback)
    parsed = Float64(value)
    return isfinite(parsed) ? parsed : fallback
end

@inline function _smooth_bound(value, limit, softness)
    command = _finite_observation(value, 0.0)
    safe_limit = max(abs(_finite_observation(limit, 1.0)), eps(Float64))
    exponent = max(_finite_observation(softness, 2.0), 2.0)
    ratio = abs(command) / safe_limit

    # Algebraically equivalent branches avoid overflow for very large finite
    # commands while approaching the limit smoothly from below.
    shaped_ratio = if ratio <= 1.0
        ratio / (1.0 + ratio^exponent)^(1.0 / exponent)
    else
        inverse_ratio = 1.0 / ratio
        1.0 / (1.0 + inverse_ratio^exponent)^(1.0 / exponent)
    end
    return copysign(safe_limit * shaped_ratio, command)
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amplitude = max(abs(params.oscillator_amplitude), eps(Float64))
    q1 = _finite_observation(state.phi[1], 0.0)
    q2 = _finite_observation(state.phi[2], 0.0)
    qd1 = _finite_observation(state.phi_dot[1], 0.0)
    qd2 = _finite_observation(state.phi_dot[2], 0.0)

    # Positive body-y target error requires the empirically calibrated positive
    # bend side, which produces negative yaw in this fish. Measured negative yaw
    # releases and eventually reverses that request before turn momentum builds.
    distance_L = max(
        abs(_finite_observation(state.distance_L, 1.0)),
        eps(Float64),
    )
    target_lateral_L = _finite_observation(state.target_body_L[2], 0.0)
    lateral_target_error = clamp(target_lateral_L / distance_L, -1.0, 1.0)
    yaw_rate = hasproperty(state, :turn_rate_recent) ?
        _finite_observation(state.turn_rate_recent, 0.0) :
        _finite_observation(state.heading_rate, 0.0)
    steering_error =
        lateral_target_error + params.yaw_rate_damping_T * yaw_rate
    halfcycle_asymmetry =
        params.halfcycle_asymmetry_limit *
        tanh(steering_error / max(params.target_error_scale, eps(Float64)))

    # State-derived bend side replaces a clocked phase. On the requested side,
    # reduce spring return; on the opposite side, strengthen it. This biases
    # half-cycle amplitude without imposing the failed static mean curvature.
    bend_side = tanh(q1 / max(params.bend_side_scale, eps(Float64)))
    restoring_scale = clamp(
        1.0 - halfcycle_asymmetry * bend_side,
        1.0 - params.halfcycle_asymmetry_limit,
        1.0 + params.halfcycle_asymmetry_limit,
    )
    vdp_drive =
        params.oscillator_mu *
        (1.0 - (q1 / amplitude)^2) *
        qd1
    raw_head_accel = vdp_drive - omega^2 * restoring_scale * q1

    # Preserve the evidence-backed posterior lag and zero cycle-mean tangent.
    # Steering therefore changes alternating bend strength, not body posture.
    tail_target =
        -q1 - params.tail_lag_gain * qd1 / max(omega, eps(Float64))
    raw_tail_accel =
        omega^2 * (tail_target - q2) -
        2.0 * params.tail_damping * omega * qd2

    return (
        phi_ddot=(
            _smooth_bound(
                raw_head_accel,
                params.command_soft_limit,
                params.command_softness,
            ),
            _smooth_bound(
                raw_tail_accel,
                params.command_soft_limit,
                params.command_softness,
            ),
        ),
    )
end
