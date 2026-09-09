function target_policy_params()
    return (
        control_period=1.10,
        oscillator_amplitude=14.0 * pi / 180,
        oscillator_mu=0.50,
        tail_lag_gain=0.55,
        tail_damping=0.95,
        steering_bias_limit=8.0 * pi / 180,
        bearing_scale=30.0 * pi / 180,
        acceleration_command_limit=16.0,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Joint state carries phase. The slower, moderate oscillator keeps the
    # nominal gait away from the rate and acceleration saturation seen in the
    # target-blind release while retaining a self-propelled traveling bend.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    raw_a1 = vdp_drive - omega^2 * q1

    # In the sampled release, positive body-frame bearing was the steering
    # sign that produced upstream progress. Bias only the posterior mean tail
    # tangent so target feedback does not displace the propulsion oscillator.
    steering_bias = params.steering_bias_limit *
        tanh(state.bearing / params.bearing_scale)
    tail_tangent_target = steering_bias -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    q2_target = tail_tangent_target - q1
    raw_a2 = omega^2 * (q2_target - q2) -
        2 * params.tail_damping * omega * qd2

    limit = params.acceleration_command_limit
    a1 = clamp(raw_a1, -limit, limit)
    a2 = clamp(raw_a2, -limit, limit)

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
