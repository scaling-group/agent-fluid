function target_policy_params()
    return (
        control_period=1.10,
        oscillator_amplitude=18.0 * pi / 180,
        oscillator_energy_gain=0.80,
        steering_limit=15.0 * pi / 180,
        bearing_scale=35.0 * pi / 180,
        heading_rate_horizon=0.20,
        heading_rate_limit=1.0,
        tail_lag_gain=0.65,
        tail_steering_gain=0.50,
        tail_damping=0.85,
        acceleration_soft_limit=18.0,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Positive bearing means that decreasing the target error requires a
    # positive body bend in this head-to-tail coordinate convention. Limit the
    # measured yaw rate before using it as derivative damping so a wake impulse
    # cannot reverse or saturate the steering command by itself.
    bounded_heading_rate = params.heading_rate_limit *
        tanh(state.heading_rate / params.heading_rate_limit)
    steering_error = state.bearing +
        params.heading_rate_horizon * bounded_heading_rate
    steering_center = params.steering_limit *
        tanh(steering_error / params.bearing_scale)

    # The oscillator phase remains encoded only in joint state. Energy
    # regulation sets a finite bend amplitude without a prescribed time signal;
    # centering it on steering_center makes propulsion target-aware.
    oscillator_position = q1 - steering_center
    oscillator_energy = (oscillator_position / amp)^2 +
        (qd1 / (omega * amp))^2
    oscillator_drive = params.oscillator_energy_gain *
        (1 - oscillator_energy) * qd1
    a1_raw = oscillator_drive - omega^2 * oscillator_position

    # Preserve a traveling posterior bend while carrying only a fraction of
    # the mean steering curvature into the cumulative tail tangent.
    tail_target = -q1 + params.tail_steering_gain * steering_center -
        params.tail_lag_gain * qd1 / omega
    a2_raw = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Stay below the episode's hard acceleration envelope smoothly so the
    # action retains magnitude information instead of persistent clipping.
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
