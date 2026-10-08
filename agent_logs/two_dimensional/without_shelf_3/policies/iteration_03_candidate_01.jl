function target_policy_params()
    return (
        control_period=0.95,
        oscillator_amplitude=15.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.55,
        tail_damping=1.0,
        bearing_gain=0.40,
        turn_rate_damping_gain=0.06,
        steering_limit=10.0 * pi / 180,
        steering_joint_share=0.35,
        acceleration_soft_limit=1000.0 * pi / 180,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Positive body-frame bearing curvature is the only sampled steering sign
    # that produced meaningful upstream progress. Oppose measured yaw so the
    # bounded correction does not grow into the sampled abrupt reorientation.
    steering_request =
        params.bearing_gain * state.bearing -
        params.turn_rate_damping_gain * state.turn_rate_recent
    steering_bias = params.steering_limit * tanh(
        steering_request /
        max(params.steering_limit, eps(params.steering_limit)),
    )

    # Restore the angle-only state-feedback oscillator that generated the
    # sampled upstream motion. Its smaller amplitude, slower frequency, and
    # lower excitation put the expected limit cycle inside the joint envelope.
    q1_center = params.steering_joint_share * steering_bias
    oscillator_state = q1 - q1_center
    radial_drive =
        params.oscillator_mu * (1 - (oscillator_state / amp)^2) * qd1
    raw_a1 = radial_drive - omega^2 * oscillator_state

    # The posterior joint carries most of the steering curvature and retains
    # the velocity-dependent lag that turns the anterior rhythm into a
    # traveling bend.
    q2_center = (1 - params.steering_joint_share) * steering_bias
    phase_lag_target = q2_center - oscillator_state -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    raw_a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Smoothly remain well below the evaluator's hard acceleration cap when a
    # wake impulse or steering transient creates a large joint-state error.
    accel_limit = params.acceleration_soft_limit
    a1 = accel_limit * tanh(raw_a1 / accel_limit)
    a2 = accel_limit * tanh(raw_a2 / accel_limit)

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
