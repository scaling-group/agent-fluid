# Phase-2 candidate: tail-beat-mean direction reconstruction on the coherent
# joint-state traveling bend. Joint phase removes locomotor recoil from both
# body-frame line of sight and rigid yaw before the slow pursuit loop closes.

function target_policy_params()
    return (
        version="dogfish3d_phase_reconstructed_direction_pursuit_v1",
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.80,
        tail_damping=0.65,
        los_forward_floor=0.25,
        line_of_sight_q1_gain=0.55,
        line_of_sight_q2_gain=0.10,
        bearing_scale=0.40,
        target_yaw_rate_limit=0.40,
        yaw_rate_qd1_gain=0.62,
        yaw_rate_qd2_gain=0.10,
        yaw_rate_error_scale=0.80,
        mean_tail_curvature_limit=10.0 * pi / 180,
    )
end

@inline function _finite_or(value, fallback)
    parsed = Float64(value)
    return isfinite(parsed) ? parsed : fallback
end

function target_guidance(state, params, q1, q2, qd1, qd2)
    distance = max(_finite_or(state.distance_L, 1.0), 1.0e-6)
    target_x = _finite_or(state.target_body_L[1], -distance)
    target_y = _finite_or(state.target_body_L[2], 0.0)

    # Material body -x points forward. Normalize by range, then remove the
    # repeatable joint-angle component of apparent line-of-sight motion so a
    # tail beat does not look like a route crossing.
    forward = -target_x / distance
    lateral = target_y / distance
    raw_line_of_sight = atan(lateral, max(forward, params.los_forward_floor))
    reconstructed_line_of_sight =
        raw_line_of_sight +
        params.line_of_sight_q1_gain * q1 +
        params.line_of_sight_q2_gain * q2

    target_yaw_rate =
        -params.target_yaw_rate_limit *
        tanh(reconstructed_line_of_sight / max(params.bearing_scale, 1.0e-6))

    # Apply the matching derivative reconstruction to rigid yaw. The error
    # polarity is desired minus measured: after an overshoot, a positive
    # requested yaw rate produces counter-curvature instead of sustaining the
    # original negative-yaw turn.
    measured_yaw_rate = _finite_or(state.heading_rate, 0.0)
    reconstructed_yaw_rate =
        measured_yaw_rate +
        params.yaw_rate_qd1_gain * qd1 +
        params.yaw_rate_qd2_gain * qd2
    yaw_rate_error = target_yaw_rate - reconstructed_yaw_rate
    mean_tail_curvature =
        params.mean_tail_curvature_limit *
        tanh(yaw_rate_error / max(params.yaw_rate_error_scale, 1.0e-6))

    return (
        raw_line_of_sight=raw_line_of_sight,
        reconstructed_line_of_sight=reconstructed_line_of_sight,
        target_yaw_rate=target_yaw_rate,
        measured_yaw_rate=measured_yaw_rate,
        reconstructed_yaw_rate=reconstructed_yaw_rate,
        yaw_rate_error=yaw_rate_error,
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

    # Preserve the strongest sampled carrier so the rollout isolates the new
    # phase-reconstructed direction feedback.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amplitude)^2) * qd1
    anterior_accel = vdp_drive - omega^2 * q1

    guidance = target_guidance(state, params, q1, q2, qd1, qd2)
    posterior_target =
        guidance.mean_tail_curvature - q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(Float64))
    posterior_accel =
        omega^2 * (posterior_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(anterior_accel, posterior_accel),)
end
