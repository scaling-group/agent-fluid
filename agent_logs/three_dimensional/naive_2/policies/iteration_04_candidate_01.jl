# Response-gated anterior redirect around a crossflow-regulated posterior
# traveling bend. All steering remains odd, bounded, and body-frame based.

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
        steering_curvature_limit=12.0 * pi / 180,
        redirect_bearing_scale=0.55,
        redirect_gate_exponent=4,
        redirect_head_curvature_limit=7.0 * pi / 180,
        redirect_response_scale=1.0,
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

    bearing_value = Float64(state.bearing)
    bearing = isfinite(bearing_value) ? bearing_value : 0.0
    crossflow_value = Float64(state.relative_flow_velocity_body_U[2])
    crossflow = isfinite(crossflow_value) ? crossflow_value : 0.0
    yaw_rate_value = Float64(state.turn_rate_recent)
    yaw_rate = isfinite(yaw_rate_value) ? yaw_rate_value : 0.0

    # Preserve the strongest sampled route signal: target bearing supplies
    # geometry, relative crossflow anticipates lateral drift, and recent yaw
    # releases posterior curvature after the requested rotation develops.
    turn_state =
        bearing / max(params.steering_bearing_scale, eps(Float64)) +
        params.steering_crossflow_weight * tanh(
            crossflow /
            max(params.steering_crossflow_scale, eps(Float64)),
        ) +
        params.steering_yaw_rate_weight * tanh(
            yaw_rate /
            max(params.steering_yaw_rate_scale, eps(Float64)),
        )
    turn_command = tanh(turn_state)

    # The sampled posterior controllers retained thrust but could not reverse
    # wrong-signed yaw before the upper exit. Activate a whole-body redirect
    # only for large bearing error, and release it continuously once yaw has
    # the corrective sign. The fourth-order gate is negligible near alignment,
    # unlike the failed permanent anterior-center policies.
    redirect_scale = max(params.redirect_bearing_scale, eps(Float64))
    route_direction = tanh(bearing / redirect_scale)
    error_ratio = abs(bearing) / redirect_scale
    error_power = error_ratio^params.redirect_gate_exponent
    error_gate = error_power / (1 + error_power)
    responding_yaw = max(
        -route_direction * yaw_rate /
        max(params.redirect_response_scale, eps(Float64)),
        0.0,
    )
    response_release = 1 / (1 + responding_yaw^2)
    head_redirect =
        params.redirect_head_curvature_limit *
        route_direction * error_gate * response_release

    # Shift the oscillator state only during the redirect so its carrier is
    # unchanged at small route error. Build the posterior wave from the same
    # centered state, preserving phase lag around the transient body curve.
    q1_carrier = q1 - head_redirect
    vdp_drive = params.oscillator_mu * (1 - (q1_carrier / amp)^2) * qd1
    a1_raw = vdp_drive - omega^2 * q1_carrier

    posterior_wave =
        -q1_carrier -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    mean_tail_tangent = params.steering_curvature_limit * turn_command
    tail_target = mean_tail_tangent + posterior_wave
    a2_raw = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    accel_limit = params.actuation_soft_limit
    a1 = accel_limit * tanh(a1_raw / accel_limit)
    a2 = accel_limit * tanh(a2_raw / accel_limit)

    return (phi_ddot=(a1, a2),)
end
