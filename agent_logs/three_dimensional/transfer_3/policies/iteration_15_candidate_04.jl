# Phase-2 candidate: retain the completed LOS-rate traveling bend, then move
# only sign-coherent slow curvature forward during the terminal approach.

function target_policy_params()
    return (
        version="dogfish3d_near_range_conservative_allocation_v1",
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
        mean_tail_curvature_limit=10.0 * pi / 180,
        redirect_bearing_threshold=0.35,
        redirect_bearing_width=0.12,
        redirect_response_threshold=0.40,
        redirect_response_width=0.05,
        redirect_yaw_rate_scale=0.30,
        anterior_redirect_limit=6.0 * pi / 180,
        allocation_range_center_L=3.0,
        allocation_range_width_L=0.75,
        joint_acceleration_limit=1800.0 * pi / 180,
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

    # Material body -x is forward. Normalized target geometry keeps the
    # controller scale-free and reflection-equivariant after a target pass.
    target_forward = -target_x / target_norm
    target_lateral = target_y / target_norm
    bearing = atan(
        target_lateral,
        max(target_forward, params.los_forward_floor),
    )

    velocity_x = _finite_or(state.velocity_body_U[1], 0.0)
    velocity_y = _finite_or(state.velocity_body_U[2], 0.0)
    rigid_speed = hypot(velocity_x, velocity_y)

    # For a stationary target this is its inertial line-of-sight angular rate.
    # Rotation into the body frame leaves the scalar unchanged, and speed
    # gating suppresses startup recoil without a small forward-speed divisor.
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

    # Remove sampled joint-correlated recoil before applying the reversible
    # posterior curvature response.
    measured_yaw_rate = _finite_or(state.heading_rate, 0.0)
    phase_conditioned_yaw_rate =
        measured_yaw_rate +
        params.yaw_recoil_q1_gain * qd1 +
        params.yaw_recoil_q2_gain * qd2
    yaw_rate_error = target_yaw_rate - phase_conditioned_yaw_rate
    mean_tail_curvature =
        params.mean_tail_curvature_limit *
        tanh(yaw_rate_error / max(params.yaw_rate_error_scale, 1.0e-6))

    # Retain the evaluated large-bearing recruitment, but do not let it fade
    # during the sampled mid-approach bearing lull when the bounded LOS route
    # demand remains near saturation. Both paths release continuously.
    bearing_redirect_weight = 0.5 * (1 + tanh(
        (abs(bearing) - params.redirect_bearing_threshold) /
        max(params.redirect_bearing_width, 1.0e-6),
    ))
    response_redirect_weight = 0.5 * (1 + tanh(
        (abs(target_yaw_rate) - params.redirect_response_threshold) /
        max(params.redirect_response_width, 1.0e-6),
    ))
    redirect_weight = max(
        bearing_redirect_weight,
        response_redirect_weight,
    )
    route_anterior_mean_curvature =
        params.anterior_redirect_limit *
        redirect_weight *
        tanh(
            target_yaw_rate /
            max(params.redirect_yaw_rate_scale, 1.0e-6),
        )

    # Transfer only same-sign slow steering, conserve its total across the two
    # joints, and restrict the transfer to the normalized terminal range. This
    # retains the sampled far-field carrier and every opposing posterior yaw
    # correction while testing the inherited low-effort allocation near capture.
    normalized_anterior_curvature = clamp(
        route_anterior_mean_curvature /
        max(params.anterior_redirect_limit, 1.0e-6),
        -1.0,
        1.0,
    )
    normalized_posterior_curvature = clamp(
        mean_tail_curvature /
        max(params.mean_tail_curvature_limit, 1.0e-6),
        -1.0,
        1.0,
    )
    curvature_coherence =
        normalized_anterior_curvature * normalized_posterior_curvature
    sign_coherent_weight = max(0.0, tanh(curvature_coherence))
    near_allocation_weight = 0.5 * (1 + tanh(
        (params.allocation_range_center_L - distance) /
        max(params.allocation_range_width_L, 1.0e-6),
    ))
    allocation_weight = near_allocation_weight * sign_coherent_weight
    allocated_mean_curvature = allocation_weight * mean_tail_curvature
    anterior_mean_curvature =
        route_anterior_mean_curvature + allocated_mean_curvature
    posterior_mean_curvature =
        mean_tail_curvature - allocated_mean_curvature

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
        mean_tail_curvature=mean_tail_curvature,
        bearing_redirect_weight=bearing_redirect_weight,
        response_redirect_weight=response_redirect_weight,
        redirect_weight=redirect_weight,
        route_anterior_mean_curvature=route_anterior_mean_curvature,
        normalized_anterior_curvature=normalized_anterior_curvature,
        normalized_posterior_curvature=normalized_posterior_curvature,
        curvature_coherence=curvature_coherence,
        sign_coherent_weight=sign_coherent_weight,
        near_allocation_weight=near_allocation_weight,
        allocation_weight=allocation_weight,
        allocated_mean_curvature=allocated_mean_curvature,
        anterior_mean_curvature=anterior_mean_curvature,
        posterior_mean_curvature=posterior_mean_curvature,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    q1 = _finite_or(state.phi[1], 0.0)
    q2 = _finite_or(state.phi[2], 0.0)
    qd1 = _finite_or(state.phi_dot[1], 0.0)
    qd2 = _finite_or(state.phi_dot[2], 0.0)

    guidance = target_guidance(state, qd1, qd2, params)

    # Oscillate around the bounded anterior route-response center. Expressing
    # the posterior wave relative to this center preserves the traveling bend.
    centered_q1 = q1 - guidance.anterior_mean_curvature
    vdp_drive = params.oscillator_mu *
        (1 - (centered_q1 / params.oscillator_amplitude)^2) * qd1
    anterior_accel = vdp_drive - omega^2 * centered_q1

    posterior_target =
        guidance.posterior_mean_curvature - centered_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(Float64))
    posterior_accel =
        omega^2 * (posterior_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Match the episode's physical actuator envelope at the policy boundary.
    acceleration_limit = max(
        params.joint_acceleration_limit,
        eps(Float64),
    )
    feasible_anterior_accel = clamp(
        anterior_accel,
        -acceleration_limit,
        acceleration_limit,
    )
    feasible_posterior_accel = clamp(
        posterior_accel,
        -acceleration_limit,
        acceleration_limit,
    )

    return (
        phi_ddot=(feasible_anterior_accel, feasible_posterior_accel),
    )
end
