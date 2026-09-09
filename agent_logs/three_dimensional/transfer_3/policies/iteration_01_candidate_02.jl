# Phase-2 candidate: sign-calibrated target pursuit through a bounded
# posterior mean-curvature bias. Oscillation phase is entirely joint-state
# feedback; target steering uses only normalized body-frame geometry and yaw.

function target_policy_params()
    return (
        version="dogfish3d_normalized_mean_curvature_pursuit_v1",
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.80,
        tail_damping=0.65,
        los_forward_floor=0.25,
        bearing_scale=0.45,
        target_turn_rate_limit=0.65,
        turn_rate_error_scale=0.35,
        mean_curvature_limit=12.0 * pi / 180,
    )
end

@inline function _finite_or(value, fallback)
    parsed = Float64(value)
    return isfinite(parsed) ? parsed : fallback
end

function pursuit_guidance(state, params)
    distance = max(_finite_or(state.distance_L, 1.0), 1.0e-6)
    target_x = _finite_or(state.target_body_L[1], -distance)
    target_y = _finite_or(state.target_body_L[2], 0.0)

    # The fish's forward axis is negative body x. Dividing by distance keeps
    # this geometry independent of grid resolution and target range.
    forward = -target_x / distance
    lateral = target_y / distance
    los_error = atan(lateral, max(forward, params.los_forward_floor))

    measured_turn_rate = hasproperty(state, :turn_rate_recent) ?
        _finite_or(state.turn_rate_recent, 0.0) :
        _finite_or(state.heading_rate, 0.0)

    # In the evidenced 3D convention, a target on positive body y requires
    # decreasing heading. Close the yaw-rate loop before imposing curvature.
    target_turn_rate =
        -params.target_turn_rate_limit *
        tanh(los_error / max(params.bearing_scale, 1.0e-6))
    turn_rate_error = target_turn_rate - measured_turn_rate
    mean_curvature =
        params.mean_curvature_limit *
        tanh(turn_rate_error / max(params.turn_rate_error_scale, 1.0e-6))

    return (
        los_error=los_error,
        target_turn_rate=target_turn_rate,
        measured_turn_rate=measured_turn_rate,
        mean_curvature=mean_curvature,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amplitude = params.oscillator_amplitude
    q1 = _finite_or(state.phi[1], 0.0)
    q2 = _finite_or(state.phi[2], 0.0)
    qd1 = _finite_or(state.phi_dot[1], 0.0)
    qd2 = _finite_or(state.phi_dot[2], 0.0)

    # Preserve the rollout's coherent, self-propelled traveling-bend carrier.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amplitude)^2) * qd1
    head_accel = vdp_drive - omega^2 * q1

    guidance = pursuit_guidance(state, params)
    tail_target =
        guidance.mean_curvature - q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(Float64))
    tail_accel =
        omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(head_accel, tail_accel),)
end
