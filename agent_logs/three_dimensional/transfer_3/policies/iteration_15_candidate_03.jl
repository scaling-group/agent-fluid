# Phase-2 candidate: preserve the completed distributed C-bend while removing
# slow commanded curvature from both quadratures of the joint-recoil observer.

function target_policy_params()
    return (
        version="dogfish3d_self_centered_phase_recoil_v1",
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
        yaw_recoil_q1_position_gain=-0.102,
        yaw_recoil_q2_position_gain=-0.218,
        yaw_rate_error_scale=0.25,
        recoil_center_solve_iterations=16,
        mean_tail_curvature_limit=10.0 * pi / 180,
        redirect_bearing_threshold=0.35,
        redirect_bearing_width=0.12,
        redirect_response_threshold=0.40,
        redirect_response_width=0.05,
        redirect_yaw_rate_scale=0.30,
        anterior_redirect_limit=6.0 * pi / 180,
        joint_acceleration_limit=1800.0 * pi / 180,
    )
end

@inline function _finite_or(value, fallback)
    parsed = Float64(value)
    return isfinite(parsed) ? parsed : fallback
end

@inline function _centered_mean_tail_curvature(
    uncompensated_yaw_error,
    omega,
    params,
)
    curvature_limit = max(
        params.mean_tail_curvature_limit,
        eps(Float64),
    )
    error_scale = max(params.yaw_rate_error_scale, 1.0e-6)
    posterior_position_feedback =
        omega * params.yaw_recoil_q2_position_gain

    # q2 must be centered by the mean curvature being solved for. With the
    # evaluated negative posterior position gain this residual is strictly
    # increasing on the bounded interval, so bisection gives the unique
    # reflection-equivariant equilibrium without memory or an external phase.
    lower_curvature = -curvature_limit
    upper_curvature = curvature_limit
    for _ in 1:max(params.recoil_center_solve_iterations, 0)
        midpoint_curvature = 0.5 * (
            lower_curvature + upper_curvature
        )
        midpoint_residual =
            midpoint_curvature -
            curvature_limit * tanh(
                (
                    uncompensated_yaw_error +
                    posterior_position_feedback * midpoint_curvature
                ) / error_scale,
            )
        if midpoint_residual < 0
            lower_curvature = midpoint_curvature
        else
            upper_curvature = midpoint_curvature
        end
    end
    return 0.5 * (lower_curvature + upper_curvature)
end

function target_guidance(state, q1, q2, qd1, qd2, params)
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
    anterior_mean_curvature =
        params.anterior_redirect_limit *
        redirect_weight *
        tanh(
            target_yaw_rate /
            max(params.redirect_yaw_rate_scale, 1.0e-6),
        )

    # Separate the carrier's two phase quadratures from slow commanded bends.
    # The posterior center is implicit because it is also the yaw response;
    # solve that one bounded scalar relation instead of letting the slow route
    # offset feed back as if it were periodic recoil.
    omega = 2 * pi / max(params.control_period, eps(Float64))
    centered_q1 = q1 - anterior_mean_curvature
    velocity_phase_recoil =
        params.yaw_recoil_q1_gain * qd1 +
        params.yaw_recoil_q2_gain * qd2
    uncentered_position_phase_recoil = omega * (
        params.yaw_recoil_q1_position_gain * centered_q1 +
        params.yaw_recoil_q2_position_gain * q2
    )
    measured_yaw_rate = _finite_or(state.heading_rate, 0.0)
    uncompensated_yaw_error =
        target_yaw_rate -
        measured_yaw_rate -
        velocity_phase_recoil -
        uncentered_position_phase_recoil
    mean_tail_curvature = _centered_mean_tail_curvature(
        uncompensated_yaw_error,
        omega,
        params,
    )
    centered_q2 = q2 - mean_tail_curvature
    position_phase_recoil = omega * (
        params.yaw_recoil_q1_position_gain * centered_q1 +
        params.yaw_recoil_q2_position_gain * centered_q2
    )
    phase_conditioned_yaw_rate =
        measured_yaw_rate +
        velocity_phase_recoil +
        position_phase_recoil
    yaw_rate_error = target_yaw_rate - phase_conditioned_yaw_rate

    return (
        bearing=bearing,
        rigid_speed=rigid_speed,
        los_rate=los_rate,
        response_gate=response_gate,
        bearing_yaw_rate=bearing_yaw_rate,
        response_yaw_rate=response_yaw_rate,
        target_yaw_rate=target_yaw_rate,
        centered_q1=centered_q1,
        centered_q2=centered_q2,
        velocity_phase_recoil=velocity_phase_recoil,
        uncentered_position_phase_recoil=uncentered_position_phase_recoil,
        position_phase_recoil=position_phase_recoil,
        measured_yaw_rate=measured_yaw_rate,
        phase_conditioned_yaw_rate=phase_conditioned_yaw_rate,
        yaw_rate_error=yaw_rate_error,
        uncompensated_yaw_error=uncompensated_yaw_error,
        mean_tail_curvature=mean_tail_curvature,
        bearing_redirect_weight=bearing_redirect_weight,
        response_redirect_weight=response_redirect_weight,
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

    guidance = target_guidance(state, q1, q2, qd1, qd2, params)

    # Oscillate around the bounded anterior route-response center. Expressing
    # the posterior wave relative to this center preserves the traveling bend.
    centered_q1 = guidance.centered_q1
    vdp_drive = params.oscillator_mu *
        (1 - (centered_q1 / params.oscillator_amplitude)^2) * qd1
    anterior_accel = vdp_drive - omega^2 * centered_q1

    posterior_target =
        guidance.mean_tail_curvature - centered_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(Float64))
    posterior_accel =
        omega^2 * (posterior_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Match the episode's componentwise physical acceleration projection at
    # the public policy boundary; all observer dynamics occur before it.
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
