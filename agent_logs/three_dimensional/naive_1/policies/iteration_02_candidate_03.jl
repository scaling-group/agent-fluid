# Target-relative half-cycle steering around the seed's zero-centered
# state-feedback oscillator.  Oscillation phase remains entirely in joint
# state, and steering cannot create a nonzero static joint equilibrium.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        bearing_scale=20.0 * pi / 180,
        heading_rate_scale=2.0,
        heading_rate_feedback=0.35,
        half_cycle_authority=0.35,
        half_cycle_softness=5.0 * pi / 180,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Positive bearing calls for the positive-curvature half-cycle, which the
    # sampled startup maps to negative yaw.  Same-direction negative yaw rate
    # unloads that request.  Both observations are normalized and bounded
    # before they affect the carrier.
    turn_signal = Float64(state.bearing) / params.bearing_scale +
        params.heading_rate_feedback * Float64(state.heading_rate) /
        params.heading_rate_scale
    turn_command = tanh(turn_signal)

    # Favor a bend side by weakening its restoring half-cycle and strengthening
    # the opposite one.  The multiplier stays positive, while its modulation
    # vanishes continuously at q1=0; it therefore cannot pin the joint at a
    # steering offset as the sampled mean-curvature policies did.
    bend_side = tanh(q1 / params.half_cycle_softness)
    restoring_scale = 1 -
        params.half_cycle_authority * turn_command * bend_side
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * restoring_scale * q1

    # Preserve the seed's posterior traveling-bend construction.  Steering
    # reaches the tail through the asymmetric anterior wave rather than a
    # separate static posterior bias.
    phase_lag_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
