# Target-directed half-cycle asymmetry on a state-feedback traveling bend.
# Oscillator phase remains encoded in joint state; no clock or route is used.

function target_policy_params()
    return (
        control_period=0.90,
        oscillator_amplitude=18.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        bearing_limit=1.0,
        bearing_scale=0.35,
        max_turn_rate_ratio=0.08,
        turn_rate_ratio_limit=0.35,
        turn_rate_error_scale=0.08,
        half_cycle_velocity_scale=0.60,
        half_cycle_acceleration=8.0,
        acceleration_limit=30.0,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

    # Keep the sampled sub-limit carrier; phase lives in observed joint state.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    carrier_a1 = vdp_drive - omega^2 * q1

    # Positive bearing requests negative yaw.  Express both requested and
    # observed yaw rates relative to gait frequency, then reinforce only the
    # anterior half-stroke moving toward the requested turn side.  This changes
    # beat asymmetry without imposing a static curvature or external phase.
    bearing = clamp(
        Float64(state.bearing),
        -params.bearing_limit,
        params.bearing_limit,
    )
    turn_rate_ratio = clamp(
        Float64(state.heading_rate) / max(omega, eps(omega)),
        -params.turn_rate_ratio_limit,
        params.turn_rate_ratio_limit,
    )
    desired_turn_rate_ratio = -params.max_turn_rate_ratio *
        tanh(bearing / params.bearing_scale)
    turn_side = tanh(
        (desired_turn_rate_ratio - turn_rate_ratio) /
        params.turn_rate_error_scale,
    )
    phase_velocity = tanh(
        qd1 /
        (max(omega * amp, eps(omega)) * params.half_cycle_velocity_scale),
    )
    half_cycle_drive = 0.5 * params.half_cycle_acceleration * (
        turn_side + abs(turn_side) * phase_velocity
    )
    a1 = carrier_a1 + half_cycle_drive

    # Posterior propulsion remains a lagged follower of the asymmetric
    # anterior wave, so the alternating traveling bend is preserved.
    phase_lag_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    limit = params.acceleration_limit
    return (
        phi_ddot=(
            clamp(a1, -limit, limit),
            clamp(a2, -limit, limit),
        ),
    )
end
