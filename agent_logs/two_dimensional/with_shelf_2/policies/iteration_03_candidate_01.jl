function target_policy_params()
    return (
        control_period=0.68,
        oscillator_amplitude=22.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.65,
        tail_damping=0.75,
        bearing_scale=0.35,
        bearing_lead_periods=0.50,
        bearing_rate_contribution_limit=0.35,
        half_cycle_asymmetry=0.45,
        posterior_asymmetry_share=0.55,
        acceleration_soft_limit=29.0,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Preserve the sampled zero-centered traveling bend: unlike a steering
    # equilibrium, it does not subtract the release bend before propulsion
    # develops.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    symmetric_a1 = vdp_drive - omega^2 * q1

    # Project the observed bearing trend over part of one owned gait period.
    # Growing target error receives earlier correction; a bearing already
    # returning to zero sheds steering authority. Bound the rate contribution
    # separately so a short wake-induced yaw event cannot command a full turn.
    bearing = clamp(Float64(state.bearing), -pi / 2, pi / 2)
    bearing_rate_lead = clamp(
        params.bearing_lead_periods * params.control_period *
            Float64(state.bearing_window_rate),
        -params.bearing_rate_contribution_limit,
        params.bearing_rate_contribution_limit,
    )
    lead_bearing = clamp(bearing + bearing_rate_lead, -pi / 2, pi / 2)
    turn_fraction = tanh(lead_bearing / params.bearing_scale)

    # Bias the acceleration half-cycle instead of moving the oscillator's mean.
    # Zero bearing and zero bearing trend recover the symmetric propulsive gait.
    asymmetric_a1 = symmetric_a1 +
        params.half_cycle_asymmetry * turn_fraction * abs(symmetric_a1)

    # Retain posterior phase lag and apply a smaller compatible share of the
    # same turn request so the anti-phase follower does not cancel the bend.
    tail_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    symmetric_a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2
    asymmetric_a2 = symmetric_a2 + params.posterior_asymmetry_share *
        params.half_cycle_asymmetry * turn_fraction * abs(symmetric_a2)

    # Keep the experiment inside a smooth candidate-owned ceiling below the
    # episode's harder acceleration clip.
    limit = params.acceleration_soft_limit
    a1 = limit * tanh(asymmetric_a1 / limit)
    a2 = limit * tanh(asymmetric_a2 / limit)

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
