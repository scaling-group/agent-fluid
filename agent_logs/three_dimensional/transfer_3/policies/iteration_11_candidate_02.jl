# Phase-2 candidate: response-released distributed bend on the coherent
# line-of-sight-rate controller. A large body-frame route error transitions
# posterior-only steering into opposite-polarity joint-center allocation;
# observed yaw response releases or reverses both shares together.

function target_policy_params()
    return (
        version="dogfish3d_response_released_distributed_bend_v1",
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
        redirect_transition_width=0.12,
        distributed_curvature_share=0.60,
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

    # Material body -x is forward. Range normalization keeps the redirect
    # independent of L and reflection-equivariant.
    target_forward = -target_x / target_norm
    target_lateral = target_y / target_norm
    bearing = atan(
        target_lateral,
        max(target_forward, params.los_forward_floor),
    )

    velocity_x = _finite_or(state.velocity_body_U[1], 0.0)
    velocity_y = _finite_or(state.velocity_body_U[2], 0.0)
    rigid_speed = hypot(velocity_x, velocity_y)

    # For a stationary target this is the inertial target-line angular rate;
    # rotation to the body frame leaves it unchanged. Speed gating suppresses
    # startup recoil without dividing by a small forward-speed component.
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

    # Remove the sampled joint-correlated recoil before comparing rigid yaw
    # with route demand. The resulting residual owns all steering centers, so
    # observed response can release or reverse them together.
    measured_yaw_rate = _finite_or(state.heading_rate, 0.0)
    phase_conditioned_yaw_rate =
        measured_yaw_rate +
        params.yaw_recoil_q1_gain * qd1 +
        params.yaw_recoil_q2_gain * qd2
    yaw_rate_error = target_yaw_rate - phase_conditioned_yaw_rate
    steering_curvature =
        params.mean_tail_curvature_limit *
        tanh(yaw_rate_error / max(params.yaw_rate_error_scale, 1.0e-6))

    # Small route error retains the evaluated posterior-only LOS controller.
    # Large bearing recruits a coordinated bend. Rollout comparisons show
    # opposite joint-coordinate yaw polarities, so the anterior and posterior
    # centers receive opposite shares of the same response residual.
    redirect_weight = 0.5 * (1 + tanh(
        (abs(bearing) - params.redirect_bearing_threshold) /
        max(params.redirect_transition_width, 1.0e-6),
    ))
    distributed_share = clamp(params.distributed_curvature_share, 0.0, 1.0)
    anterior_center =
        redirect_weight * distributed_share * steering_curvature
    posterior_mean_curvature =
        (1 - redirect_weight) * steering_curvature -
        redirect_weight * distributed_share * steering_curvature

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
        steering_curvature=steering_curvature,
        redirect_weight=redirect_weight,
        anterior_center=anterior_center,
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

    # Centering both oscillator relations on the slow steering allocation
    # preserves the relative traveling bend and its joint-state phase.
    centered_q1 = q1 - guidance.anterior_center
    vdp_drive = params.oscillator_mu *
        (1 - (centered_q1 / params.oscillator_amplitude)^2) * qd1
    anterior_accel = vdp_drive - omega^2 * centered_q1

    posterior_target =
        guidance.posterior_mean_curvature - centered_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(Float64))
    posterior_accel =
        omega^2 * (posterior_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(anterior_accel, posterior_accel),)
end
