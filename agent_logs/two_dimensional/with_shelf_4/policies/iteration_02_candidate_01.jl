function target_policy_params()
    return (
        control_period=0.85,
        oscillator_amplitude=20.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.75,
        tail_damping=0.6,
        steer_gain=2.5,
        turn_damping=0.35,
        bearing_rate_scale=1.0,
        max_half_cycle_asymmetry=0.35,
        phase_transition=0.4,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Persistent body-frame target error requests a bounded half-cycle
    # asymmetry. The windowed bearing rate releases the request while the
    # target direction is already converging.
    bearing_error = tanh(Float64(state.bearing))
    bearing_rate = tanh(
        params.bearing_rate_scale * Float64(state.bearing_window_rate),
    )
    turn_request = tanh(
        params.steer_gain * bearing_error + params.turn_damping * bearing_rate,
    )

    # Infer beat side smoothly from joint state, not time. On the bend side
    # requested by target geometry, enlarge the oscillator radius; shrink the
    # opposite side. This supplies mean yaw without a persistent curvature
    # offset that can collapse pursuit into a tight circle.
    phase_coordinate = q1 / amp + qd1 / (omega * amp)
    beat_side = tanh(phase_coordinate / params.phase_transition)
    amplitude_scale = 1 +
        params.max_half_cycle_asymmetry * turn_request * beat_side
    effective_amplitude = amp * amplitude_scale
    normalized_position = q1 / effective_amplitude
    normalized_velocity = qd1 / (omega * effective_amplitude)
    radius_squared = normalized_position^2 + normalized_velocity^2
    radial_drive = params.oscillator_mu * omega *
        (1 - clamp(radius_squared, 0.0, 4.0)) * qd1
    a1 = radial_drive - omega^2 * q1

    # Apply the same geometric half-cycle preference to the lagged posterior
    # wave. This gives both joints a compatible average bend while retaining
    # the sign-changing traveling component rather than imposing an offset.
    tail_wave = -q1 - params.tail_lag_gain * qd1 / max(omega, eps(omega))
    tail_side = tanh(
        tail_wave / (params.phase_transition * amp),
    )
    tail_amplitude_scale = 1 +
        params.max_half_cycle_asymmetry * turn_request * tail_side
    phase_lag_target = tail_amplitude_scale * tail_wave
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
