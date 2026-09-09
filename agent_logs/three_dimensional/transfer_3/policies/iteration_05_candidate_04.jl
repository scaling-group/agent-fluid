# Phase-2 candidate: slip-anticipated pursuit on the coherent state-feedback
# carrier. Both observed joint rates project carrier recoil out of rigid yaw;
# normalized body-frame target and velocity geometry supplies the slow route
# correction through bounded posterior mean curvature.

function target_policy_params()
    return (
        version="dogfish3d_two_joint_phase_slip_pursuit_v1",
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.80,
        tail_damping=0.65,
        los_forward_floor=0.25,
        velocity_forward_floor=0.20,
        slip_activation_speed=0.35,
        slip_angle_gain=0.35,
        route_error_scale=0.35,
        target_yaw_rate_limit=0.45,
        recoil_q1_velocity_gain=0.82,
        recoil_q2_velocity_gain=0.12,
        yaw_rate_error_scale=0.25,
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

    # Material body -x is forward. Range normalization makes bearing
    # independent of L and keeps the target term reflection-equivariant.
    forward = -target_x / distance
    lateral = target_y / distance
    bearing = atan(lateral, max(forward, params.los_forward_floor))

    # The velocity angle anticipates lateral route crossing. Suppress it near
    # rest, where a ratio of two tiny velocities would be a noisy direction.
    velocity_x = _finite_or(state.velocity_body_U[1], 0.0)
    velocity_y = _finite_or(state.velocity_body_U[2], 0.0)
    forward_speed = max(-velocity_x, 0.0)
    slip_angle = atan(
        velocity_y,
        max(forward_speed, params.velocity_forward_floor),
    )
    slip_gate = tanh(
        forward_speed / max(params.slip_activation_speed, 1.0e-6),
    )
    route_error = bearing - params.slip_angle_gain * slip_gate * slip_angle
    target_yaw_rate =
        -params.target_yaw_rate_limit *
        tanh(route_error / max(params.route_error_scale, 1.0e-6))

    # Instantaneous rigid yaw is dominated by the two-joint carrier. The
    # evidenced projection leaves the slow response for the direction loop.
    measured_yaw_rate = _finite_or(state.heading_rate, 0.0)
    phase_conditioned_yaw_rate =
        measured_yaw_rate +
        params.recoil_q1_velocity_gain * qd1 +
        params.recoil_q2_velocity_gain * qd2
    yaw_rate_error = target_yaw_rate - phase_conditioned_yaw_rate
    mean_tail_curvature =
        params.mean_tail_curvature_limit *
        tanh(yaw_rate_error / max(params.yaw_rate_error_scale, 1.0e-6))

    return (
        bearing=bearing,
        slip_angle=slip_angle,
        slip_gate=slip_gate,
        route_error=route_error,
        target_yaw_rate=target_yaw_rate,
        measured_yaw_rate=measured_yaw_rate,
        phase_conditioned_yaw_rate=phase_conditioned_yaw_rate,
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

    # Preserve the sampled self-propelled traveling-bend carrier.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amplitude)^2) * qd1
    anterior_accel = vdp_drive - omega^2 * q1

    guidance = target_guidance(state, qd1, qd2, params)
    posterior_target =
        guidance.mean_tail_curvature - q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(Float64))
    posterior_accel =
        omega^2 * (posterior_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(anterior_accel, posterior_accel),)
end
