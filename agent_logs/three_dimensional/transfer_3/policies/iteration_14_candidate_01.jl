# Phase-2 candidate: keep the completed LOS-rate distributed C-bend, but
# release its anterior redirect continuously once observed terminal geometry
# defines a safe closing corridor. The posterior traveling bend remains live.

function target_policy_params()
    return (
        version="dogfish3d_response_released_terminal_cbend_v3",
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
        terminal_release_start_range=2.25,
        terminal_release_range_width=0.25,
        terminal_release_closing_threshold=0.45,
        terminal_release_closing_width=0.12,
        terminal_capture_corridor=0.55,
        terminal_capture_corridor_width=0.15,
        terminal_anterior_authority_floor=0.20,
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
    recruited_redirect_weight = max(
        bearing_redirect_weight,
        response_redirect_weight,
    )

    # A response-defined terminal release separates broad-body redirect from
    # posterior pursuit. Range alone cannot release steering: the fish must be
    # closing and its current rigid-velocity line must pass through a bounded
    # target corridor. A nonzero floor retains anterior authority if the
    # instantaneous collision-course estimate is optimistic.
    closing_speed = (
        target_x * velocity_x + target_y * velocity_y
    ) / target_norm
    predicted_miss_L = abs(
        target_y * velocity_x - target_x * velocity_y
    ) / max(rigid_speed, params.route_response_activation_speed)
    terminal_range_weight = 0.5 * (1 + tanh(
        (params.terminal_release_start_range - distance) /
        max(params.terminal_release_range_width, 1.0e-6),
    ))
    terminal_closing_weight = 0.5 * (1 + tanh(
        (closing_speed - params.terminal_release_closing_threshold) /
        max(params.terminal_release_closing_width, 1.0e-6),
    ))
    terminal_corridor_weight = 0.5 * (1 + tanh(
        (params.terminal_capture_corridor - predicted_miss_L) /
        max(params.terminal_capture_corridor_width, 1.0e-6),
    ))
    terminal_release_weight =
        terminal_range_weight *
        terminal_closing_weight *
        terminal_corridor_weight
    anterior_authority = 1 -
        (1 - params.terminal_anterior_authority_floor) *
        terminal_release_weight
    redirect_weight = recruited_redirect_weight * anterior_authority
    anterior_mean_curvature =
        params.anterior_redirect_limit *
        redirect_weight *
        tanh(
            target_yaw_rate /
            max(params.redirect_yaw_rate_scale, 1.0e-6),
        )

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
        recruited_redirect_weight=recruited_redirect_weight,
        closing_speed=closing_speed,
        predicted_miss_L=predicted_miss_L,
        terminal_range_weight=terminal_range_weight,
        terminal_closing_weight=terminal_closing_weight,
        terminal_corridor_weight=terminal_corridor_weight,
        terminal_release_weight=terminal_release_weight,
        anterior_authority=anterior_authority,
        redirect_weight=redirect_weight,
        anterior_mean_curvature=anterior_mean_curvature,
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
        guidance.mean_tail_curvature - centered_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(Float64))
    posterior_accel =
        omega^2 * (posterior_target - q2) -
        2 * params.tail_damping * omega * qd2

    # The episode applies the same componentwise physical limiter. Project at
    # the policy boundary as well so the controller never requests an
    # impossible acceleration while preserving the completed applied dynamics.
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
