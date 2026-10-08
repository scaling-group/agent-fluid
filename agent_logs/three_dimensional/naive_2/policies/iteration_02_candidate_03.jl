# Joint-state traveling bend with body-frame, yaw-damped posterior half-cycle
# asymmetry. No clock or persistent static joint center supplies phase.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        steering_bearing_scale=0.30,
        steering_yaw_rate_scale=1.0,
        steering_yaw_rate_weight=0.45,
        tail_half_cycle_asymmetry_limit=0.32,
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

    # Preserve the coherent carrier found in the direct-uniform seed. Its
    # phase remains encoded in (q1, qd1), and steering cannot shift or quench
    # the anterior limit cycle.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1_raw = vdp_drive - omega^2 * q1

    # Positive bearing requires negative yaw for the calibrated body/FSI sign.
    # Recent yaw has the same sign in the request so the induced counter-moment
    # releases a turn already rotating toward the target and damps overshoot.
    bearing_value = Float64(state.bearing)
    bearing = isfinite(bearing_value) ? bearing_value : 0.0
    yaw_rate_value = Float64(state.turn_rate_recent)
    yaw_rate = isfinite(yaw_rate_value) ? yaw_rate_value : 0.0
    turn_state =
        bearing / max(params.steering_bearing_scale, eps(Float64)) +
        params.steering_yaw_rate_weight * tanh(
            yaw_rate / max(params.steering_yaw_rate_scale, eps(Float64)),
        )
    turn_command = tanh(turn_state)

    # Infer carrier half-cycle from the phase-lagged tail target. The even
    # phase envelope makes the signed target request an odd reflection while
    # forcing steering to vanish at each carrier crossing; unlike a static
    # offset, it cannot hold the fish in a bend after oscillation disappears.
    carrier_tail_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    phase_envelope = min(abs(carrier_tail_target), amp)
    steering_offset = params.tail_half_cycle_asymmetry_limit *
        turn_command * phase_envelope
    tail_target = carrier_tail_target + steering_offset
    a2_raw = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Stay smoothly inside the released acceleration envelope instead of
    # relying on downstream hard clipping of the seed's largest requests.
    accel_limit = params.actuation_soft_limit
    a1 = accel_limit * tanh(a1_raw / accel_limit)
    a2 = accel_limit * tanh(a2_raw / accel_limit)

    return (phi_ddot=(a1, a2),)
end
