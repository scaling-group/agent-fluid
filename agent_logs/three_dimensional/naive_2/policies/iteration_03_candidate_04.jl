# Joint-state traveling bend with a body-frame, response-gated posterior
# redirect. No clock, world route, or persistent anterior offset is used.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        steering_bearing_scale=0.30,
        lateral_velocity_scale=0.25,
        lateral_velocity_weight=0.35,
        steering_yaw_rate_scale=1.0,
        steering_yaw_rate_weight=0.55,
        cruise_tail_curvature=10.0 * pi / 180,
        redirect_tail_curvature=12.0 * pi / 180,
        redirect_error_scale=0.45,
        redirect_wave_relief=0.45,
        tail_target_limit=42.0 * pi / 180,
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

    # Preserve the coherent carrier found in the direct-uniform rollouts. Its
    # phase remains encoded in (q1, qd1), and steering never shifts the
    # anterior limit-cycle center.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1_raw = vdp_drive - omega^2 * q1

    # Positive bearing requires negative yaw for the calibrated body/FSI sign.
    # Lateral body velocity supplies a bounded look-ahead: positive sideslip
    # subtracts from the route error and requests the corrective positive yaw
    # before bearing alone grows. Recent yaw opposes a request once the desired
    # rotation is present.
    bearing_value = Float64(state.bearing)
    bearing = isfinite(bearing_value) ? clamp(bearing_value, -1.4, 1.4) : 0.0
    lateral_velocity_value = Float64(state.velocity_body_U[2])
    lateral_velocity = isfinite(lateral_velocity_value) ?
        lateral_velocity_value : 0.0
    yaw_rate_value = Float64(state.turn_rate_recent)
    yaw_rate = isfinite(yaw_rate_value) ? yaw_rate_value : 0.0
    route_error = bearing - params.lateral_velocity_weight * tanh(
        lateral_velocity /
        max(params.lateral_velocity_scale, eps(Float64)),
    )
    turn_state =
        route_error / max(params.steering_bearing_scale, eps(Float64)) +
        params.steering_yaw_rate_weight * tanh(
            yaw_rate / max(params.steering_yaw_rate_scale, eps(Float64)),
        )
    turn_command = tanh(turn_state)

    # A large route error activates a bounded posterior redirect. If yaw has
    # the requested sign, response_release restores the propulsive tail wave;
    # no hidden timer or discrete mode is needed. The tail target stays below
    # the joint envelope even when the strongest redirect and wave align.
    route_direction = tanh(
        route_error / max(params.steering_bearing_scale, eps(Float64)),
    )
    error_ratio = abs(route_error) /
        max(params.redirect_error_scale, eps(Float64))
    error_gate = error_ratio^2 / (1 + error_ratio^2)
    responding_yaw = max(
        -route_direction * yaw_rate /
        max(params.steering_yaw_rate_scale, eps(Float64)),
        0.0,
    )
    response_release = 1 / (1 + responding_yaw^2)
    redirect_gate = error_gate * response_release

    tail_curvature_limit = params.cruise_tail_curvature +
        params.redirect_tail_curvature * redirect_gate
    mean_tail_tangent = tail_curvature_limit * turn_command
    posterior_wave = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    posterior_wave_scale = 1 - params.redirect_wave_relief * redirect_gate
    tail_target = clamp(
        mean_tail_tangent + posterior_wave_scale * posterior_wave,
        -params.tail_target_limit,
        params.tail_target_limit,
    )
    a2_raw = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Stay smoothly inside the released acceleration envelope instead of
    # relying on downstream hard clipping of the seed's largest requests.
    accel_limit = params.actuation_soft_limit
    a1 = accel_limit * tanh(a1_raw / accel_limit)
    a2 = accel_limit * tanh(a2_raw / accel_limit)

    return (phi_ddot=(a1, a2),)
end
