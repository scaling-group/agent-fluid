# Response-gated mean-curvature target policy for the L64 3D moving window.
# The propulsive phase lives entirely in joint state; no clock, route, or
# world-frame coordinate enters the controller.

function target_policy_params()
    return (
        version="dogfish3d_response_gated_curvature_v1",
        control_period=1.10,
        oscillator_amplitude=10.0 * pi / 180,
        oscillator_mu=0.35,
        tail_amplitude_ratio=1.30,
        tail_phase_lag=85.0 * pi / 180,
        tail_damping=0.80,
        target_vector_mix=0.35,
        target_angle_limit=1.25,
        target_angle_scale=0.30,
        desired_turn_rate_limit=0.45,
        turn_response_scale=0.40,
        mean_tail_curvature_limit=14.0 * pi / 180,
    )
end

@inline function _finite_or(value, fallback)
    parsed = Float64(value)
    return isfinite(parsed) ? parsed : fallback
end

function target_guidance(state, params)
    # Both angles are normalized, body-frame geometric observations.  Blending
    # the evaluator's bearing with an independently reconstructed target-vector
    # angle avoids dependence on either representation's near-axis convention.
    target_x = _finite_or(state.target_body_L[1], -1.0)
    target_y = _finite_or(state.target_body_L[2], 0.0)
    vector_angle = atan(target_y, max(abs(target_x), 0.25))
    bearing = _finite_or(state.bearing, vector_angle)
    target_angle = clamp(
        (1.0 - params.target_vector_mix) * bearing +
        params.target_vector_mix * vector_angle,
        -params.target_angle_limit,
        params.target_angle_limit,
    )

    # Positive body-frame target angle requires decreasing world yaw for this
    # fish convention.  Recent measured turn response releases and reverses the
    # curvature bias when the requested yaw rate has already been achieved.
    desired_turn_rate = -params.desired_turn_rate_limit *
        tanh(target_angle / max(params.target_angle_scale, 1.0e-6))
    measured_turn_rate = _finite_or(state.turn_rate_recent, 0.0)
    turn_rate_error = desired_turn_rate - measured_turn_rate
    response_command = tanh(
        turn_rate_error / max(params.turn_response_scale, 1.0e-6),
    )
    mean_tail_curvature = -params.mean_tail_curvature_limit * response_command

    return (
        target_angle=target_angle,
        desired_turn_rate=desired_turn_rate,
        measured_turn_rate=measured_turn_rate,
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

    # Anterior Van der Pol state-feedback oscillator supplies the rhythm.
    anterior_drive =
        params.oscillator_mu * (1.0 - (q1 / amplitude)^2) * qd1
    anterior_accel = anterior_drive - omega^2 * q1

    # The posterior joint tracks a lagged, emphasized traveling bend.  Steering
    # enters as a bounded mean tangent, so it changes the wave shape instead of
    # competing with the carrier through a large raw acceleration residual.
    guidance = target_guidance(state, params)
    posterior_wave_target = params.tail_amplitude_ratio * (
        cos(params.tail_phase_lag) * q1 -
        sin(params.tail_phase_lag) * qd1 / max(omega, eps(omega))
    )
    posterior_target = posterior_wave_target + guidance.mean_tail_curvature
    posterior_accel =
        omega^2 * (posterior_target - q2) -
        2.0 * params.tail_damping * omega * qd2

    return (phi_ddot=(anterior_accel, posterior_accel),)
end
