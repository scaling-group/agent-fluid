function target_policy_params()
    return (
        control_period=1.05,
        oscillator_amplitude=22.0 * pi / 180,
        oscillator_mu=0.45,
        tail_lag_gain=0.55,
        tail_damping=0.85,
        bearing_gain=0.90,
        turn_rate_damping=0.85,
        steering_limit=14.0 * pi / 180,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Forward is body -x, so a positive bearing is a target on the fish's
    # right and requests negative curvature. Heading-rate feedback opposes an
    # established turn before it grows into the seed's domain-exit spiral.
    steering_bias = clamp(
        -params.bearing_gain * state.bearing -
        params.turn_rate_damping * state.heading_rate,
        -params.steering_limit,
        params.steering_limit,
    )

    # Keep oscillator phase in joint state, but center it on the bounded
    # curvature command. No elapsed time, route, or world coordinate is used.
    oscillator_state = q1 - steering_bias
    vdp_drive = params.oscillator_mu * (1 - (oscillator_state / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * oscillator_state

    # Cancel only the oscillatory anterior component at the posterior joint.
    # The remaining low-frequency body bend steers, while the velocity lag
    # retains the seed's useful traveling-wave propulsion mechanism.
    phase_lag_target = -oscillator_state -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
