# Phase-cancelled target-rate steering around the naive traveling-wave gait.
# Joint state removes carrier wobble from route feedback without a clock.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        bearing_phase_compensation=0.45,
        yaw_rate_phase_compensation=0.45,
        steering_bearing_scale=0.30,
        steering_yaw_rate_limit=0.45,
        steering_rate_measure_limit=3.0,
        steering_rate_error_scale=0.35,
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

    # Preserve the sampled carrier: phase remains entirely in joint state and
    # steering cannot shift the anterior oscillator's equilibrium.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1_raw = vdp_drive - omega^2 * q1

    bearing_value = Float64(state.bearing)
    bearing = isfinite(bearing_value) ? clamp(bearing_value, -1.4, 1.4) : 0.0
    heading_rate_value = Float64(state.heading_rate)
    heading_rate = isfinite(heading_rate_value) ? heading_rate_value : 0.0

    # The sampled body wobble is approximately opposite q1 and qd1.  Remove
    # those phase-correlated components before closing the slower route loop.
    route_bearing = clamp(
        bearing + params.bearing_phase_compensation * q1,
        -1.4,
        1.4,
    )
    route_yaw_rate = clamp(
        heading_rate + params.yaw_rate_phase_compensation * qd1,
        -params.steering_rate_measure_limit,
        params.steering_rate_measure_limit,
    )

    # Positive route bearing requires negative yaw for this body/FSI sign.
    # Curvature changes sign early when actual mean rotation outruns the
    # desired rate, rather than waiting for the instantaneous bearing to cross.
    desired_yaw_rate = -params.steering_yaw_rate_limit * tanh(
        route_bearing / max(params.steering_bearing_scale, eps(Float64)),
    )
    rate_error = route_yaw_rate - desired_yaw_rate
    turn_command = tanh(
        rate_error / max(params.steering_rate_error_scale, eps(Float64)),
    )
    mean_tail_tangent = params.steering_curvature_limit * turn_command

    phase_lag_target = mean_tail_tangent - q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2_raw = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    # The released hard limits remain downstream; this smooth envelope avoids
    # treating the acceleration cap as a drive target.
    accel_limit = params.actuation_soft_limit
    a1 = accel_limit * tanh(a1_raw / accel_limit)
    a2 = accel_limit * tanh(a2_raw / accel_limit)

    return (phi_ddot=(a1, a2),)
end
