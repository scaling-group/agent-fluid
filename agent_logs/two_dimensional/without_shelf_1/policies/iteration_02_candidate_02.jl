function target_policy_params()
    return (
        control_period=0.95,
        oscillator_amplitude=34.0 * pi / 180,
        oscillator_growth=0.55,
        tail_lag_gain=0.50,
        tail_damping=0.90,
        steering_bias_limit=6.0 * pi / 180,
        bearing_scale=25.0 * pi / 180,
        steering_fade_distance_L=0.75,
        steering_fade_width_L=0.75,
        acceleration_limit=1500.0 * pi / 180,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Keep propulsion independent of the steering request. The phase-plane
    # radius makes the requested anterior bend explicit and bounded without an
    # elapsed-time phase or a case-specific route.
    oscillator_radius = sqrt(q1^2 + (qd1 / omega)^2)
    energy_drive = params.oscillator_growth *
        (1 - (oscillator_radius / amp)^2) * qd1
    a1_raw = energy_drive - omega^2 * q1

    # Positive bearing means that the target lies on positive body y. In the
    # sampled geometry the positive posterior bias turned away and looped
    # upward, so use the opposite, smaller tangent bias. Fade only near capture,
    # where bearing becomes poorly conditioned.
    fade_coordinate = clamp(
        (state.distance_L - params.steering_fade_distance_L) /
            max(params.steering_fade_width_L, eps(params.steering_fade_width_L)),
        0.0,
        1.0,
    )
    steering_fade = fade_coordinate^2 * (3 - 2 * fade_coordinate)
    steering_bias = -params.steering_bias_limit * steering_fade *
        tanh(state.bearing / params.bearing_scale)

    # Apply steering only to the mean posterior tangent. Reduced phase lag and
    # stronger damping keep its nominal oscillation below the joint envelope.
    tail_tangent_target = steering_bias -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    q2_target = tail_tangent_target - q1
    a2_raw = omega^2 * (q2_target - q2) -
        2 * params.tail_damping * omega * qd2

    accel_limit = params.acceleration_limit
    a1 = clamp(a1_raw, -accel_limit, accel_limit)
    a2 = clamp(a2_raw, -accel_limit, accel_limit)

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
