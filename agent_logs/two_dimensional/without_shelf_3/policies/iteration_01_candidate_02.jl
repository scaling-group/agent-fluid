function target_policy_params()
    return (
        control_period=0.85,
        oscillator_amplitude=20.0 * pi / 180,
        oscillator_mu=1.1,
        tail_lag_gain=0.65,
        tail_damping=0.75,
        steering_limit=14.0 * pi / 180,
        steering_joint_share=0.5,
        bearing_gain=2.4,
        turn_rate_damping_gain=0.2,
        moment_damping_gain=0.4,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Positive bearing is on the +body-y side while the fish swims toward
    # -body-x. Negative mean curvature therefore turns toward positive bearing.
    steering_signal =
        params.bearing_gain * state.bearing +
        params.turn_rate_damping_gain * state.turn_rate_recent +
        params.moment_damping_gain * state.moment_z_L2
    steering_bias = -params.steering_limit * tanh(steering_signal)

    # The oscillator remains autonomous: joint position and velocity encode
    # phase. Radial energy feedback regulates the amplitude without a clock or
    # actuator clipping, around the slowly moving steering equilibrium.
    q1_center = params.steering_joint_share * steering_bias
    oscillator_state = q1 - q1_center
    phase_radius2 =
        (oscillator_state / amp)^2 +
        (qd1 / max(omega * amp, eps(omega * amp)))^2
    radial_drive = params.oscillator_mu * (1 - phase_radius2) * qd1
    a1 = radial_drive - omega^2 * oscillator_state

    # Split the steering curvature across both joints. The oscillatory part of
    # the posterior target opposes and lags joint one to preserve a body wave.
    q2_center = (1 - params.steering_joint_share) * steering_bias
    phase_lag_target =
        -oscillator_state + q2_center -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
