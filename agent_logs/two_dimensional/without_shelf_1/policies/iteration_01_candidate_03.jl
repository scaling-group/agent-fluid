function target_policy_params()
    return (
        control_period=0.80,
        oscillator_amplitude=20.0 * pi / 180,
        oscillator_growth=0.70,
        tail_lag_gain=0.60,
        tail_damping=0.80,
        bearing_gain=0.80,
        heading_rate_gain=0.12,
        steering_limit=14.0 * pi / 180,
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

    # Smooth body-frame steering stays target-relative and bounded.  The rate
    # term resists the large one-way yaw seen in the parent rollout.
    steering_request =
        params.bearing_gain * state.bearing -
        params.heading_rate_gain * state.heading_rate
    steering_bias = params.steering_limit * tanh(
        steering_request / params.steering_limit,
    )

    # Joint state carries oscillator phase.  Regulating phase-plane radius
    # keeps propulsion finite without a clock or elapsed-time route.
    q1_osc = q1 - steering_bias
    oscillator_radius = sqrt(q1_osc^2 + (qd1 / omega)^2)
    energy_drive = params.oscillator_growth *
        (1 - (oscillator_radius / amp)^2) * qd1
    a1_raw = energy_drive - omega^2 * q1_osc

    # The posterior joint preserves the traveling bend while making the mean
    # tail tangent follow the same steering bias.
    tail_tangent_target =
        steering_bias - params.tail_lag_gain * qd1 / max(omega, eps(omega))
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
