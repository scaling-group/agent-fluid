function target_policy_params()
    return (
        control_period=0.72,
        oscillator_amplitude=22.0 * pi / 180,
        oscillator_mu=0.4,
        bearing_scale=25.0 * pi / 180,
        half_cycle_asymmetry=0.3,
        phase_softness=0.35,
        tail_lag_gain=0.65,
        tail_damping=0.7,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

    # Body-frame target error selects the stronger half-cycle without moving
    # the oscillator's equilibrium or prescribing a clock-driven phase.
    turn_request = tanh(Float64(state.bearing) / params.bearing_scale)
    phase_coordinate = (q1 + qd1 / max(omega, eps(omega))) / amp
    beat_side = tanh(phase_coordinate / params.phase_softness)
    half_cycle_amplitude = amp * (
        1 + params.half_cycle_asymmetry * turn_request * beat_side
    )

    # Regulate the anterior phase-plane radius to the selected half-cycle
    # envelope. The smooth bound leaves a sign-changing propulsive wave even
    # under persistent route error.
    normalized_position = q1 / half_cycle_amplitude
    normalized_velocity = qd1 / (omega * half_cycle_amplitude)
    radius_squared = normalized_position^2 + normalized_velocity^2
    radial_drive = params.oscillator_mu * omega *
        (1 - clamp(radius_squared, 0.0, 4.0)) * qd1
    a1 = radial_drive - omega^2 * q1

    # Keep route modulation at one coherent steering site. Joint 2 remains an
    # unmodulated posterior follower of the already asymmetric anterior wave,
    # preserving traveling-bend lag without a second steering residual.
    tail_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
