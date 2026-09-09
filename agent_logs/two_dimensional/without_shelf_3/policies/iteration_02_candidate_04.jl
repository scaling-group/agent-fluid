function target_policy_params()
    return (
        control_period=0.90,
        oscillator_amplitude=18.0 * pi / 180,
        oscillator_mu=0.8,
        tail_lag_gain=0.55,
        tail_damping=1.0,
        bearing_gain=0.45,
        turn_rate_damping_gain=0.04,
        steering_limit=12.0 * pi / 180,
        steering_joint_share=0.35,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # The sampled positive-bearing curvature produced the only sustained
    # upstream progress. Oppose measured yaw so that correction does not grow
    # into the large reorientations and load spike of that rollout.
    steering_request =
        params.bearing_gain * state.bearing -
        params.turn_rate_damping_gain * state.turn_rate_recent
    steering_bias = params.steering_limit * tanh(
        steering_request / params.steering_limit,
    )

    # Regulate the full phase radius rather than joint angle alone. This keeps
    # phase in joint state while damping excess velocity about the slowly
    # moving anterior share of the steering shape.
    q1_center = params.steering_joint_share * steering_bias
    oscillator_state = q1 - q1_center
    phase_velocity_scale = max(omega * amp, eps(omega * amp))
    phase_radius2 =
        (oscillator_state / amp)^2 +
        (qd1 / phase_velocity_scale)^2
    radial_drive = params.oscillator_mu * (1 - phase_radius2) * qd1
    a1 = radial_drive - omega^2 * oscillator_state

    # Split the mean curvature across the joints. The posterior target opposes
    # and lags only the oscillatory part, preserving the traveling bend without
    # cancelling the target-relative steering equilibrium.
    q2_center = (1 - params.steering_joint_share) * steering_bias
    phase_lag_target = q2_center - oscillator_state -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
