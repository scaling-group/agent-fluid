# State-feedback traveling-bend carrier with bounded body-frame curvature
# steering. Oscillator phase remains in joint state; no clock or route enters.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        turn_bias_limit=6.0 * pi / 180,
        tail_turn_bias_ratio=0.65,
        bearing_scale=0.20,
        bearing_lookahead_T=0.08,
        bearing_rate_limit=2.0,
        command_acceleration_limit=1800.0 * pi / 180,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

    # Bearing is already a normalized body-frame target angle. A short
    # state-history projection releases or reverses curvature before the fish
    # sweeps far across the target centerline.
    bearing_raw = Float64(state.bearing)
    bearing = isfinite(bearing_raw) ? clamp(bearing_raw, -1.0, 1.0) : 0.0
    bearing_rate_raw = if hasproperty(state, :bearing_window_rate)
        Float64(state.bearing_window_rate)
    elseif hasproperty(state, :bearing_rate)
        Float64(state.bearing_rate)
    else
        0.0
    end
    bearing_rate = isfinite(bearing_rate_raw) ?
        clamp(bearing_rate_raw, -params.bearing_rate_limit, params.bearing_rate_limit) : 0.0
    projected_bearing = clamp(
        bearing + params.bearing_lookahead_T * bearing_rate,
        -1.0,
        1.0,
    )

    # The matched FSI sign audit gives positive common bias -> negative yaw,
    # which is the correcting response for positive bearing in this body frame.
    turn_bias = params.turn_bias_limit * tanh(
        projected_bearing / max(params.bearing_scale, eps(Float64)),
    )
    tail_turn_bias = params.tail_turn_bias_ratio * turn_bias

    # Centering the existing oscillator on the requested bend preserves its
    # state-only phase and makes steering a mean-curvature change, not a route.
    centered_q1 = q1 - turn_bias
    vdp_drive = params.oscillator_mu * (1 - (centered_q1 / amp)^2) * qd1
    a1_raw = vdp_drive - omega^2 * centered_q1

    phase_lag_target = tail_turn_bias - centered_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2_raw = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Return commands within the frozen actuator envelope. The shifted centers
    # make clipping asymmetric, retaining bounded steering authority instead
    # of allowing the high-amplitude carrier to erase an additive correction.
    accel_limit = params.command_acceleration_limit
    a1 = clamp(a1_raw, -accel_limit, accel_limit)
    a2 = clamp(a2_raw, -accel_limit, accel_limit)

    return (phi_ddot=(a1, a2),)
end
