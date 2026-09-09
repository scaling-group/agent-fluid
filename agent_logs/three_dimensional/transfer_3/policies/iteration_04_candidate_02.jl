# Phase-2 candidate: preserve the joint-state traveling bend and steer with a
# phase-conditioned yaw-response residual. Joint state supplies carrier phase;
# normalized body-frame target geometry supplies only the slow turn request.

function target_policy_params()
    return (
        version="dogfish3d_phase_conditioned_yaw_residual_v1",
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.80,
        tail_damping=0.65,
        los_forward_floor=0.25,
        bearing_scale=0.35,
        target_turn_rate_limit=0.45,
        phase_yaw_velocity_gain=0.47,
        turn_rate_error_scale=0.25,
        mean_tail_curvature_limit=10.0 * pi / 180,
    )
end

@inline function _finite_or(value, fallback)
    parsed = Float64(value)
    return isfinite(parsed) ? parsed : fallback
end

function target_guidance(state, qd1, params)
    distance = max(_finite_or(state.distance_L, 1.0), 1.0e-6)
    target_x = _finite_or(state.target_body_L[1], -distance)
    target_y = _finite_or(state.target_body_L[2], 0.0)

    # Forward is negative body x. Distance-normalized geometry is bounded and
    # reflection-equivariant, and remains meaningful after the target passes.
    forward = -target_x / distance
    lateral = target_y / distance
    los_error = atan(lateral, max(forward, params.los_forward_floor))
    target_turn_rate =
        -params.target_turn_rate_limit *
        tanh(los_error / max(params.bearing_scale, 1.0e-6))

    # The sampled strong-carrier traces show that most instantaneous yaw is a
    # repeatable carrier component proportional to anterior joint velocity.
    # Remove that observed phase component before closing the slow turn loop.
    measured_turn_rate = _finite_or(state.heading_rate, 0.0)
    phase_conditioned_turn_rate =
        measured_turn_rate + params.phase_yaw_velocity_gain * qd1
    turn_rate_error = target_turn_rate - phase_conditioned_turn_rate
    mean_tail_curvature =
        params.mean_tail_curvature_limit *
        tanh(turn_rate_error / max(params.turn_rate_error_scale, 1.0e-6))

    return (
        los_error=los_error,
        target_turn_rate=target_turn_rate,
        measured_turn_rate=measured_turn_rate,
        phase_conditioned_turn_rate=phase_conditioned_turn_rate,
        turn_rate_error=turn_rate_error,
        mean_tail_curvature=mean_tail_curvature,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amplitude = params.oscillator_amplitude
    q1 = _finite_or(state.phi[1], 0.0)
    q2 = _finite_or(state.phi[2], 0.0)
    qd1 = _finite_or(state.phi_dot[1], 0.0)
    qd2 = _finite_or(state.phi_dot[2], 0.0)

    # Preserve the parent's self-sustaining propulsive carrier exactly.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amplitude)^2) * qd1
    anterior_accel = vdp_drive - omega^2 * q1

    guidance = target_guidance(state, qd1, params)
    posterior_target =
        guidance.mean_tail_curvature - q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(Float64))
    posterior_accel =
        omega^2 * (posterior_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(anterior_accel, posterior_accel),)
end
