# Phase-aware posterior steering for the 3D moving-window EvE lane.  The
# anterior oscillator remains target-independent while body-frame feedback
# selects which posterior half-cycle receives more authority.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        turn_bearing_scale=0.30,
        turn_crossflow_scale=0.30,
        turn_crossflow_weight=0.75,
        turn_rate_scale=1.0,
        turn_rate_weight=0.25,
        halfcycle_phase_scale=0.35,
        max_halfcycle_asymmetry=0.40,
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

    # The unshifted anterior oscillator preserves the propulsive carrier.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1_raw = vdp_drive - omega^2 * q1

    bearing = Float64(state.bearing)
    bearing = isfinite(bearing) ? bearing : 0.0
    relative_crossflow = Float64(state.relative_flow_velocity_body_U[2])
    relative_crossflow = isfinite(relative_crossflow) ? relative_crossflow : 0.0
    turn_rate = Float64(state.turn_rate_recent)
    turn_rate = isfinite(turn_rate) ? turn_rate : 0.0

    # Positive bearing requests the calibrated positive-bend half-cycle.
    # Relative crossflow anticipates lateral slip, while turn rate releases
    # authority once the requested negative-yaw response develops.
    turn_state =
        bearing / max(params.turn_bearing_scale, eps(Float64)) +
        params.turn_crossflow_weight * tanh(
            relative_crossflow /
            max(params.turn_crossflow_scale, eps(Float64)),
        ) +
        params.turn_rate_weight * tanh(
            turn_rate / max(params.turn_rate_scale, eps(Float64)),
        )
    turn_request = tanh(turn_state)

    # Modulate the two signs of the posterior wave instead of imposing a
    # static joint center.  The positive gain bound preserves zero crossings.
    base_tail_target =
        -q1 - params.tail_lag_gain * qd1 / max(omega, eps(omega))
    phase_scale = max(params.halfcycle_phase_scale * amp, eps(Float64))
    tail_side = tanh(base_tail_target / phase_scale)
    asymmetry = params.max_halfcycle_asymmetry * turn_request
    tail_gain = clamp(
        1 + asymmetry * tail_side,
        1 - params.max_halfcycle_asymmetry,
        1 + params.max_halfcycle_asymmetry,
    )
    phase_lag_target = tail_gain * base_tail_target
    a2_raw = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    accel_limit = params.actuation_soft_limit
    a1 = accel_limit * tanh(a1_raw / accel_limit)
    a2 = accel_limit * tanh(a2_raw / accel_limit)

    return (phi_ddot=(a1, a2),)
end
