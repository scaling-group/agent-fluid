function target_policy_params()
    return (
        control_period=0.70,
        oscillator_amplitude=22.0 * pi / 180,
        oscillator_energy_gain=3.0,
        oscillator_energy_error_limit=1.0,
        steering_limit=10.0 * pi / 180,
        bearing_scale=30.0 * pi / 180,
        bearing_rate_horizon=0.25,
        bearing_rate_limit=1.0,
        tail_lag_gain=0.65,
        tail_damping=0.80,
        acceleration_soft_limit=26.0,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Windowed bearing rate strengthens correction only while target error is
    # growing. Both it and the resulting target-relative curvature are smooth
    # and bounded so a wake impulse cannot create an abrupt steering switch.
    bearing_rate = params.bearing_rate_limit *
        tanh(state.bearing_window_rate / params.bearing_rate_limit)
    steering_error = state.bearing + params.bearing_rate_horizon * bearing_rate
    steering_center = -params.steering_limit *
        tanh(steering_error / params.bearing_scale)

    # Phase remains encoded in joint state. Energy feedback starts the gait
    # promptly from the nonzero target-relative center and regulates its size
    # without prescribing a clocked waveform.
    oscillator_position = q1 - steering_center
    oscillator_energy = (oscillator_position / amp)^2 +
        (qd1 / (omega * amp))^2
    energy_error = clamp(
        1 - oscillator_energy,
        -params.oscillator_energy_error_limit,
        params.oscillator_energy_error_limit,
    )
    oscillator_drive = params.oscillator_energy_gain * energy_error * qd1
    raw_a1 = oscillator_drive - omega^2 * oscillator_position

    # Cancel only the oscillatory anterior component at the posterior joint.
    # The cumulative mean bend therefore keeps the steering-center sign while
    # the velocity lag retains a posterior traveling wave.
    tail_target = -oscillator_position -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    raw_a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Keep normal operation below the episode hard acceleration envelope while
    # preserving the magnitude and sign of strong corrective requests.
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
