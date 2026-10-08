function target_policy_params()
    return (
        control_period=0.80,
        oscillator_amplitude=22.0 * pi / 180,
        oscillator_energy_gain=3.0,
        steering_limit=12.0 * pi / 180,
        bearing_scale=12.0 * pi / 180,
        heading_rate_horizon=0.12,
        heading_rate_limit=0.8,
        tail_lag_gain=0.65,
        tail_steering_gain=0.25,
        tail_damping=0.80,
        acceleration_soft_limit=20.0,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Forward is body -x, so positive bearing places the target to the fish's
    # right and requests negative curvature. Limit the measured yaw rate before
    # adding derivative damping so one wake impulse cannot dominate steering.
    bounded_heading_rate = params.heading_rate_limit *
        tanh(state.heading_rate / params.heading_rate_limit)
    steering_error = state.bearing +
        params.heading_rate_horizon * bounded_heading_rate
    steering_center = -params.steering_limit *
        tanh(steering_error / params.bearing_scale)

    # Energy regulation grows a wake-seeded state oscillator to a finite target
    # amplitude without an external clock. The higher gain develops useful
    # propulsion before passive downstream advection can end the rollout.
    oscillator_position = q1 - steering_center
    oscillator_energy = (oscillator_position / amp)^2 +
        (qd1 / (omega * amp))^2
    oscillator_drive = params.oscillator_energy_gain *
        (1 - oscillator_energy) * qd1
    a1_raw = oscillator_drive - omega^2 * oscillator_position

    # Oppose and lag only the oscillatory anterior bend. A small same-sign mean
    # tail bend carries steering through the cumulative body tangent.
    tail_target = -oscillator_position +
        params.tail_steering_gain * steering_center -
        params.tail_lag_gain * qd1 / omega
    a2_raw = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Bound energy-error and wake transients below the episode's hard envelope
    # while retaining magnitude information inside the normal operating band.
    a1 = params.acceleration_soft_limit *
        tanh(a1_raw / params.acceleration_soft_limit)
    a2 = params.acceleration_soft_limit *
        tanh(a2_raw / params.acceleration_soft_limit)

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
