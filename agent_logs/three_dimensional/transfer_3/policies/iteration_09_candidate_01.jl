# Phase-2 candidate: two-joint allocation of line-of-sight-rate feedback on
# the coherent state-feedback carrier. A bounded anterior center assists the
# posterior curvature loop, then releases when observed yaw meets route demand.

function target_policy_params()
    return (
        version="dogfish3d_los_rate_two_joint_allocation_v1",
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.80,
        tail_damping=0.65,
        los_forward_floor=0.25,
        bearing_error_scale=0.35,
        bearing_yaw_rate_limit=0.40,
        route_response_activation_speed=0.30,
        los_rate_scale=0.08,
        los_rate_yaw_limit=0.35,
        combined_yaw_rate_limit=0.50,
        yaw_recoil_q1_gain=0.82,
        yaw_recoil_q2_gain=0.12,
        yaw_rate_error_scale=0.25,
        anterior_yaw_center_limit=5.0 * pi / 180,
        mean_tail_curvature_limit=10.0 * pi / 180,
    )
end

@inline function _finite_or(value, fallback)
    parsed = Float64(value)
    return isfinite(parsed) ? parsed : fallback
end

function target_guidance(state, qd1, qd2, params)
    distance = max(_finite_or(state.distance_L, 1.0), 1.0e-6)
    target_x = _finite_or(state.target_body_L[1], -distance)
    target_y = _finite_or(state.target_body_L[2], 0.0)
    target_norm = max(hypot(target_x, target_y), 1.0e-6)

    # Material body -x is forward. Range normalization keeps the route demand
    # independent of L, moving-window position, and target range.
    target_forward = -target_x / target_norm
    target_lateral = target_y / target_norm
    bearing = atan(
        target_lateral,
        max(target_forward, params.los_forward_floor),
    )

    velocity_x = _finite_or(state.velocity_body_U[1], 0.0)
    velocity_y = _finite_or(state.velocity_body_U[2], 0.0)
    rigid_speed = hypot(velocity_x, velocity_y)

    # For a stationary target, cross(r, -v)/|r|^2 is the inertial target-line
    # angular rate. It observes route response without a small forward-speed
    # denominator; only this response term is suppressed near release.
    los_rate = (
        target_y * velocity_x - target_x * velocity_y
    ) / max(target_norm^2, 1.0e-6)
    response_gate = tanh(
        rigid_speed /
        max(params.route_response_activation_speed, 1.0e-6),
    )
    bearing_yaw_rate =
        -params.bearing_yaw_rate_limit *
        tanh(bearing / max(params.bearing_error_scale, 1.0e-6))
    response_yaw_rate =
        params.los_rate_yaw_limit *
        response_gate *
        tanh(los_rate / max(params.los_rate_scale, 1.0e-6))
    target_yaw_rate = clamp(
        bearing_yaw_rate + response_yaw_rate,
        -params.combined_yaw_rate_limit,
        params.combined_yaw_rate_limit,
    )

    # Project carrier-correlated joint recoil out of measured rigid yaw. The
    # remaining response residual drives both steering centers. Their signs are
    # opposite because positive anterior bend and positive tail mean curvature
    # produce opposite yaw on the evaluated body.
    measured_yaw_rate = _finite_or(state.heading_rate, 0.0)
    phase_conditioned_yaw_rate =
        measured_yaw_rate +
        params.yaw_recoil_q1_gain * qd1 +
        params.yaw_recoil_q2_gain * qd2
    yaw_rate_error = target_yaw_rate - phase_conditioned_yaw_rate
    normalized_yaw_residual = tanh(
        yaw_rate_error / max(params.yaw_rate_error_scale, 1.0e-6),
    )
    anterior_center =
        -params.anterior_yaw_center_limit * normalized_yaw_residual
    posterior_center =
        params.mean_tail_curvature_limit * normalized_yaw_residual

    return (
        bearing=bearing,
        rigid_speed=rigid_speed,
        los_rate=los_rate,
        response_gate=response_gate,
        bearing_yaw_rate=bearing_yaw_rate,
        response_yaw_rate=response_yaw_rate,
        target_yaw_rate=target_yaw_rate,
        measured_yaw_rate=measured_yaw_rate,
        phase_conditioned_yaw_rate=phase_conditioned_yaw_rate,
        yaw_rate_error=yaw_rate_error,
        normalized_yaw_residual=normalized_yaw_residual,
        anterior_center=anterior_center,
        posterior_center=posterior_center,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amplitude = params.oscillator_amplitude
    q1 = _finite_or(state.phi[1], 0.0)
    q2 = _finite_or(state.phi[2], 0.0)
    qd1 = _finite_or(state.phi_dot[1], 0.0)
    qd2 = _finite_or(state.phi_dot[2], 0.0)

    guidance = target_guidance(state, qd1, qd2, params)

    # Preserve the sampled traveling bend around a bounded feedback center.
    # When the yaw residual vanishes, this reduces exactly to the carrier.
    anterior_wave = q1 - guidance.anterior_center
    vdp_drive =
        params.oscillator_mu *
        (1 - (anterior_wave / amplitude)^2) * qd1
    anterior_accel = vdp_drive - omega^2 * anterior_wave

    posterior_target =
        guidance.posterior_center - anterior_wave -
        params.tail_lag_gain * qd1 / max(omega, eps(Float64))
    posterior_accel =
        omega^2 * (posterior_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(anterior_accel, posterior_accel),)
end
