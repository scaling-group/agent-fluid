# Phase-conditioned yaw-residual steering for the 3D moving-window lane. The
# carrier remains clock-free, and all route feedback stays in the body frame.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        steering_bearing_scale=0.30,
        steering_crossflow_scale=0.25,
        steering_crossflow_weight=0.75,
        steering_yaw_rate_scale=1.0,
        steering_yaw_rate_weight=0.45,
        carrier_yaw_phase_velocity_weight=2.8,
        steering_curvature_limit=12.0 * pi / 180,
        actuation_soft_limit=1800.0 * pi / 180,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Preserve the uncentered anterior oscillator and posterior traveling-wave
    # scaffold that provide propulsion in direct-uniform still water.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1_raw = vdp_drive - omega^2 * q1

    bearing_value = Float64(state.bearing)
    bearing = isfinite(bearing_value) ? bearing_value : 0.0
    crossflow_value = Float64(state.relative_flow_velocity_body_U[2])
    crossflow = isfinite(crossflow_value) ? crossflow_value : 0.0
    yaw_rate_value = Float64(state.turn_rate_recent)
    yaw_rate = isfinite(yaw_rate_value) ? yaw_rate_value : 0.0

    # Anterior joint velocity supplies an observable carrier phase. Remove its
    # odd, repeatable yaw component before using body rotation as route damping,
    # so propulsive recoil is not mistaken for a persistent steering response.
    phase_velocity = clamp(
        qd1 / max(omega * amp, eps(Float64)),
        -1.0,
        1.0,
    )
    normalized_yaw = yaw_rate /
        max(params.steering_yaw_rate_scale, eps(Float64))
    carrier_yaw = -params.carrier_yaw_phase_velocity_weight * phase_velocity
    yaw_residual = normalized_yaw - carrier_yaw

    # Bearing sets the route request and relative crossflow corrects lateral
    # slip. Only the carrier-conditioned yaw residual releases or reinforces
    # that request, while steering remains a bounded posterior mean tangent.
    turn_state =
        bearing / max(params.steering_bearing_scale, eps(Float64)) +
        params.steering_crossflow_weight * tanh(
            crossflow /
            max(params.steering_crossflow_scale, eps(Float64)),
        ) +
        params.steering_yaw_rate_weight * tanh(yaw_residual)
    mean_tail_tangent = params.steering_curvature_limit * tanh(turn_state)

    phase_lag_target =
        mean_tail_tangent - q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2_raw =
        omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Smoothly respect the released acceleration envelope.
    accel_limit = params.actuation_soft_limit
    a1 = accel_limit * tanh(a1_raw / accel_limit)
    a2 = accel_limit * tanh(a2_raw / accel_limit)

    return (phi_ddot=(a1, a2),)
end
