function target_policy_params()
    return (
        control_period=0.95,
        oscillator_amplitude=15.0 * pi / 180,
        oscillator_mu=0.50,
        tail_lag_gain=0.55,
        tail_damping=0.90,
        steering_amplitude=8.0 * pi / 180,
        bearing_gain=2.20,
        heading_rate_damping=0.18,
        lateral_velocity_damping=0.80,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Keep phase in joint state, but leave actuator headroom for steering by
    # using an unsaturated gait at the configured velocity/acceleration caps.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1

    # Positive body-frame bearing needs a clockwise correction under this
    # model's forward-axis convention, hence the negative posterior bias.
    # Heading rate and lateral velocity damp a correction already in progress;
    # tanh keeps wake impulses from turning it into a bang-bang command.
    steering_signal =
        params.bearing_gain * state.bearing +
        params.heading_rate_damping * state.heading_rate -
        params.lateral_velocity_damping * state.velocity_body_U[2]
    steering_offset = -params.steering_amplitude * tanh(steering_signal)

    # The posterior joint preserves the lagged traveling bend while carrying
    # the bounded target-bearing curvature correction.
    phase_lag_target =
        -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega)) +
        steering_offset
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
