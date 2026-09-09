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
        max_tail_asymmetry=0.35,
        half_cycle_width=0.4,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Persistent target error requests a bounded half-cycle asymmetry.  The
    # windowed rate term releases steering as the bearing converges, without a
    # hidden mode, clock, or world-frame route.
    bearing_error = tanh(Float64(state.bearing))
    bearing_rate = tanh(
        params.bearing_rate_scale * Float64(state.bearing_window_rate),
    )
    turn_request = tanh(
        params.steer_gain * bearing_error + params.turn_damping * bearing_rate,
    )

    # Keep the anterior traveling-wave driver centered.  This preserves the
    # parent's realizable propulsive rhythm instead of replacing it with a
    # persistent curvature equilibrium.
    normalized_position = q1 / amp
    normalized_velocity = qd1 / (omega * amp)
    radius_squared = normalized_position^2 + normalized_velocity^2
    radial_drive = params.oscillator_mu * omega *
        (1 - clamp(radius_squared, 0.0, 4.0)) * qd1
    a1 = radial_drive - omega^2 * q1

    # Infer beat side from the lagged tail-wave target.  For a positive turn
    # request the positive tail half-cycle is strengthened and the negative one
    # is weakened (and vice versa).  The multiplier remains in [0.65, 1.35],
    # so steering biases the posterior rhythm without suppressing alternation.
    tail_wave_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    side_width = max(params.half_cycle_width * amp, eps(amp))
    tail_side = tanh(tail_wave_target / side_width)
    tail_gain = 1.0 +
        params.max_tail_asymmetry * turn_request * tail_side
    tail_target = tail_gain * tail_wave_target
    a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
