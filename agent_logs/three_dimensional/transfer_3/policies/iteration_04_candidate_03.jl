# Phase-2 candidate: gait-phase-compensated yaw-rate pursuit on the coherent
# joint-state traveling bend. Target steering uses normalized body-frame
# geometry; joint velocity removes locomotor recoil from measured rigid yaw.

function target_policy_params()
    return (
        version="dogfish3d_phase_compensated_yaw_pursuit_v1",
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.80,
        tail_damping=0.65,
        los_forward_floor=0.25,
        bearing_scale=0.35,
        target_yaw_rate_limit=0.25,
        yaw_rate_error_scale=0.20,
        recoil_q1_velocity_gain=0.64,
        recoil_q2_velocity_gain=0.21,
        mean_curvature_limit=6.0 * pi / 180,
    )
end

@inline function _finite_or(value, fallback)
    parsed = Float64(value)
    return isfinite(parsed) ? parsed : fallback
end

function pursuit_guidance(state, params, qd1, qd2)
    distance = max(_finite_or(state.distance_L, 1.0), 1.0e-6)
    target_x = _finite_or(state.target_body_L[1], -distance)
    target_y = _finite_or(state.target_body_L[2], 0.0)

    # Material body -x points forward. Normalizing both components by range
    # makes this an equivariant angular error rather than a route coordinate.
    forward = -target_x / distance
    lateral = target_y / distance
    los_error = atan(lateral, max(forward, params.los_forward_floor))

    # Rigid yaw contains a large, repeatable recoil component from the two
    # bending rates. Remove that phase-correlated component before closing the
    # slow direction loop; no elapsed-time phase or mutable filter is needed.
    measured_yaw_rate = _finite_or(state.heading_rate, 0.0)
    compensated_yaw_rate =
        measured_yaw_rate +
        params.recoil_q1_velocity_gain * qd1 +
        params.recoil_q2_velocity_gain * qd2

    # Positive body-y target error requires negative rigid yaw. Positive
    # posterior mean curvature has that calibrated sign in the 3D rollout.
    target_yaw_rate =
        -params.target_yaw_rate_limit *
        tanh(los_error / max(params.bearing_scale, 1.0e-6))
    yaw_rate_error = compensated_yaw_rate - target_yaw_rate
    mean_curvature =
        params.mean_curvature_limit *
        tanh(yaw_rate_error / max(params.yaw_rate_error_scale, 1.0e-6))

    return (
        los_error=los_error,
        measured_yaw_rate=measured_yaw_rate,
        compensated_yaw_rate=compensated_yaw_rate,
        target_yaw_rate=target_yaw_rate,
        yaw_rate_error=yaw_rate_error,
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

    # Preserve the sampled carrier so this rollout isolates yaw compensation.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amplitude)^2) * qd1
    anterior_accel = vdp_drive - omega^2 * q1

    guidance = pursuit_guidance(state, params, qd1, qd2)
    posterior_target =
        guidance.mean_curvature - q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(Float64))
    posterior_accel =
        omega^2 * (posterior_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(anterior_accel, posterior_accel),)
end
