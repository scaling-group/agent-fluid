function target_policy_params()
    return (
        control_period=0.60,
        oscillator_amplitude=24.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.65,
        tail_damping=0.75,
        steering_gain=0.75,
        steering_limit=10.0 * pi / 180,
        tail_steering_ratio=1.0,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Shift the oscillator's mean curvature using only bounded, body-frame
    # target geometry. Joint dynamics low-pass this bias without a clock or a
    # hard-coded route.
    bearing_error = clamp(state.bearing, -pi / 2, pi / 2)
    steering_bias = clamp(
        -params.steering_gain * bearing_error,
        -params.steering_limit,
        params.steering_limit,
    )

    # The self-excited state oscillator retains the seed's useful propulsive
    # rhythm, while operating about the steering bias instead of zero bend.
    oscillation = q1 - steering_bias
    vdp_drive = params.oscillator_mu * (1 - (oscillation / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * oscillation

    # The posterior joint shares the mean bend but remains phase-lagged on the
    # oscillatory component, so steering does not erase the traveling wave.
    phase_lag_target = params.tail_steering_ratio * steering_bias - oscillation -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
