# Target-rate half-cycle steering on a state-feedback traveling bend.
# Oscillation phase is inferred only from joint state; body-frame target error
# changes posterior half-cycle strength without prescribing a clock or route.

function target_policy_params()
    return (
        control_period=0.85,
        oscillator_amplitude=14.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.80,
        bearing_limit=1.25,
        bearing_scale=0.35,
        max_target_turn_rate=0.55,
        turn_rate_limit=2.0,
        turn_rate_error_scale=0.40,
        halfcycle_asymmetry_limit=0.45,
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

    # Preserve the seed's joint-state oscillator in a measured sub-limit
    # regime. The phase remains encoded in (q1, qd1), never in elapsed time.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1

    # Positive body-frame bearing requests negative yaw in this geometry.
    # Closing the request with recent yaw rate reverses the steering imbalance
    # whenever the body turns faster than the target error calls for.
    bearing = clamp(
        Float64(state.bearing),
        -params.bearing_limit,
        params.bearing_limit,
    )
    turn_rate = clamp(
        Float64(state.turn_rate_recent),
        -params.turn_rate_limit,
        params.turn_rate_limit,
    )
    desired_turn_rate = -params.max_target_turn_rate * tanh(
        bearing / params.bearing_scale,
    )
    turn_rate_error = desired_turn_rate - turn_rate
    halfcycle_asymmetry = -params.halfcycle_asymmetry_limit * tanh(
        turn_rate_error / params.turn_rate_error_scale,
    )

    # The seed's lagged posterior wave supplies propulsion. Adding a signed
    # fraction of its magnitude strengthens one half-cycle and weakens the
    # other; steering therefore vanishes at each wave crossing instead of
    # holding a static bend that can curl the fish out of the domain.
    tail_wave_target = -q1 - params.tail_lag_gain * qd1 / max(omega, eps(omega))
    asymmetric_tail_target = tail_wave_target +
        halfcycle_asymmetry * abs(tail_wave_target)
    a2 = omega^2 * (asymmetric_tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    limit = params.acceleration_limit
    return (phi_ddot=(clamp(a1, -limit, limit), clamp(a2, -limit, limit)),)
end
