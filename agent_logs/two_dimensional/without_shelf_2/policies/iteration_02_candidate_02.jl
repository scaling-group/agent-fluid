function target_policy_params()
    return (
        control_period=0.82,
        oscillator_amplitude=30.0 * pi / 180,
        oscillator_energy_gain=0.80,
        steering_limit=8.0 * pi / 180,
        bearing_scale=24.0 * pi / 180,
        heading_rate_horizon=0.16,
        heading_rate_limit=0.80,
        tail_lag_gain=0.65,
        tail_steering_gain=0.65,
        tail_damping=0.85,
        acceleration_soft_limit=30.0,
        acceleration_linear_fraction=0.82,
    )
end

@inline function soft_acceleration_bound(value, limit, linear_fraction)
    knee = linear_fraction * limit
    magnitude = abs(value)
    magnitude <= knee && return value
    shoulder = limit - knee
    bounded_magnitude = knee + shoulder * tanh((magnitude - knee) / shoulder)
    return copysign(bounded_magnitude, value)
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Forward is body -x. Positive bearing is therefore the clockwise side of
    # the forward axis and needs negative mean curvature in this convention.
    # Bounded heading-rate lead strengthens that request only while yaw is
    # carrying the target farther to that side.
    bounded_heading_rate = params.heading_rate_limit *
        tanh(state.heading_rate / params.heading_rate_limit)
    steering_error = state.bearing +
        params.heading_rate_horizon * bounded_heading_rate
    steering_center = -params.steering_limit *
        tanh(steering_error / params.bearing_scale)

    # Encode phase in joint state and regulate bend energy without a clock.
    # The amplitude/period pair restores propulsion lost by the three sampled
    # slow descendants while keeping nominal acceleration below the hard cap.
    oscillator_position = q1 - steering_center
    oscillator_energy = (oscillator_position / amp)^2 +
        (qd1 / (omega * amp))^2
    energy_drive = params.oscillator_energy_gain *
        (1 - oscillator_energy) * qd1
    raw_a1 = energy_drive - omega^2 * oscillator_position

    # Oppose and lag only the oscillatory part at the posterior joint, while a
    # fraction of the low-frequency steering center bends both joints with the
    # same mean sign.
    tail_target = -oscillator_position +
        params.tail_steering_gain * steering_center -
        params.tail_lag_gain * qd1 / omega
    raw_a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Preserve the linear command through most of the admissible range and
    # smooth only its shoulder, avoiding routine evaluator-side hard clipping.
    accel_limit = params.acceleration_soft_limit
    linear_fraction = params.acceleration_linear_fraction
    a1 = soft_acceleration_bound(raw_a1, accel_limit, linear_fraction)
    a2 = soft_acceleration_bound(raw_a2, accel_limit, linear_fraction)

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
