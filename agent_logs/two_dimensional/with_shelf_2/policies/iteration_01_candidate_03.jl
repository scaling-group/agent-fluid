function target_policy_params()
    return (
        control_period=0.85,
        oscillator_amplitude=26.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.75,
        tail_damping=0.80,
        max_turn_curvature=20.0 * pi / 180,
        bearing_scale=0.35,
        anterior_turn_share=0.45,
        acceleration_soft_limit=24.0,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Body-frame target error supplies only a bounded mean curvature. The
    # oscillatory displacement remains state-phased, with no clock or route.
    turn_fraction = tanh(state.bearing / params.bearing_scale)
    mean_curvature = params.max_turn_curvature * turn_fraction
    q1_center = params.anterior_turn_share * mean_curvature
    q2_center = (1 - params.anterior_turn_share) * mean_curvature

    oscillatory_q1 = q1 - q1_center
    vdp_drive = params.oscillator_mu * (1 - (oscillatory_q1 / amp)^2) * qd1
    raw_a1 = vdp_drive - omega^2 * oscillatory_q1

    # Split the steering curvature across both joints while the posterior joint
    # retains the seed's anti-phase, velocity-lagged traveling component.
    tail_wave_target = -oscillatory_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    q2_target = q2_center + tail_wave_target
    raw_a2 = omega^2 * (q2_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Smooth candidate-owned limiting prevents the nominal policy from leaning
    # on the testbed's harder acceleration clip during steering transients.
    limit = params.acceleration_soft_limit
    a1 = limit * tanh(raw_a1 / limit)
    a2 = limit * tanh(raw_a2 / limit)

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
