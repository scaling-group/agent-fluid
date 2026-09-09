# Phase-2 candidate: cue-redundant distributed C-bend on the coherent LOS-rate
# carrier. Bearing, bounded route demand, or a predicted unsafe closest pass
# can retain anterior steering; returned actions obey the physical envelope.

function target_policy_params()
    return (
        version="dogfish3d_cue_redundant_distributed_cbend_feasible_v1",
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
        redirect_response_threshold=0.40,
        redirect_response_transition_width=0.05,
        intercept_start_range=9.75,
        intercept_range_transition_width=0.75,
        intercept_closing_speed_threshold=0.25,
        intercept_closing_transition_width=0.12,
        intercept_speed_floor=0.30,
        intercept_miss_threshold=0.55,
        intercept_miss_transition_width=0.25,
        redirect_yaw_rate_scale=0.30,
        anterior_redirect_limit=6.0 * pi / 180,
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
    # startup recoil without dividing by a small forward-velocity component.
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

    # Remove the parent's sampled joint-correlated recoil before comparing
    # rigid yaw with route demand.
    measured_yaw_rate = _finite_or(state.heading_rate, 0.0)
    phase_conditioned_yaw_rate =
        measured_yaw_rate +
        params.yaw_recoil_q1_gain * qd1 +
        params.yaw_recoil_q2_gain * qd2
    yaw_rate_error = target_yaw_rate - phase_conditioned_yaw_rate
    mean_tail_curvature =
        params.mean_tail_curvature_limit *
        tanh(yaw_rate_error / max(params.yaw_rate_error_scale, 1.0e-6))

    # Fuse independently completed route cues. The response branch keeps the
    # anterior bend closed when bearing briefly aligns, while the closest-pass
    # branch catches unsafe closing geometry without time or mutable history.
    bearing_redirect_weight = 0.5 * (1 + tanh(
        (abs(bearing) - params.redirect_bearing_threshold) /
        max(params.redirect_transition_width, 1.0e-6),
    ))
    response_redirect_weight = 0.5 * (1 + tanh(
        (abs(target_yaw_rate) - params.redirect_response_threshold) /
        max(params.redirect_response_transition_width, 1.0e-6),
    ))
    closing_speed = (
        target_x * velocity_x + target_y * velocity_y
    ) / target_norm
    predicted_miss_L = abs(
        target_y * velocity_x - target_x * velocity_y
    ) / max(rigid_speed, params.intercept_speed_floor)
    intercept_range_weight = 0.5 * (1 + tanh(
        (params.intercept_start_range - distance) /
        max(params.intercept_range_transition_width, 1.0e-6),
    ))
    intercept_closing_weight = 0.5 * (1 + tanh(
        (closing_speed - params.intercept_closing_speed_threshold) /
        max(params.intercept_closing_transition_width, 1.0e-6),
    ))
    intercept_miss_weight = 0.5 * (1 + tanh(
        (predicted_miss_L - params.intercept_miss_threshold) /
        max(params.intercept_miss_transition_width, 1.0e-6),
    ))
    intercept_redirect_weight =
        intercept_range_weight *
        intercept_closing_weight *
        intercept_miss_weight
    redirect_weight = 1 -
        (1 - bearing_redirect_weight) *
        (1 - response_redirect_weight) *
        (1 - intercept_redirect_weight)
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
        closing_speed=closing_speed,
        predicted_miss_L=predicted_miss_L,
        intercept_range_weight=intercept_range_weight,
        intercept_closing_weight=intercept_closing_weight,
        intercept_miss_weight=intercept_miss_weight,
        intercept_redirect_weight=intercept_redirect_weight,
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

    # Oscillate around a bounded anterior mean only for a large route error.
    # Using the centered state in both oscillators preserves their relative
    # traveling bend while the two joints share the slow redirect curvature.
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
