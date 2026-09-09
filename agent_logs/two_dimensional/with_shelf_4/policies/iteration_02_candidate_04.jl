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
        half_cycle_asymmetry=0.28,
        tail_half_cycle_asymmetry=0.14,
        phase_velocity_weight=0.35,
        phase_side_scale=0.4,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Bearing supplies the slow route error; its windowed rate damps a turn as
    # alignment improves. Both signals are body-frame and smoothly bounded.
    bearing_error = tanh(Float64(state.bearing))
    bearing_rate = tanh(
        params.bearing_rate_scale * Float64(state.bearing_window_rate),
    )
    turn_request = tanh(
        params.steer_gain * bearing_error +
        params.turn_damping * bearing_rate,
    )

    # Infer the active half-cycle from joint state rather than a clock. A turn
    # request enlarges the target-side excursion and shrinks the opposite one,
    # avoiding the persistent shifted equilibrium that produced tight loops.
    normalized_position = q1 / amp
    normalized_velocity = qd1 / (omega * amp)
    phase_projection = normalized_position +
        params.phase_velocity_weight * normalized_velocity
    beat_side = tanh(phase_projection / params.phase_side_scale)
    amplitude_scale = 1 +
        params.half_cycle_asymmetry * turn_request * beat_side
    effective_amp = amp * amplitude_scale

    # Preserve the actuator-feasible radial oscillator from the only sampled
    # full-horizon controller, but regulate each half-cycle to its modulated
    # envelope while keeping a zero mean restoring equilibrium.
    radial_position = q1 / effective_amp
    radial_velocity = qd1 / (omega * effective_amp)
    radius_squared = radial_position^2 + radial_velocity^2
    radial_drive = params.oscillator_mu * omega *
        (1 - clamp(radius_squared, 0.0, 4.0)) * qd1
    a1 = radial_drive - omega^2 * q1

    # Apply the same half-cycle mechanism to the lagged posterior target. This
    # keeps both joint means on the requested turn side without a static offset.
    tail_wave_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    tail_side = tanh(
        tail_wave_target / (params.phase_side_scale * amp),
    )
    tail_amplitude_scale = 1 +
        params.tail_half_cycle_asymmetry * turn_request * tail_side
    tail_target = tail_amplitude_scale * tail_wave_target
    a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
