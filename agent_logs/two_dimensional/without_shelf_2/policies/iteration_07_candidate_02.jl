function target_policy_params()
    return (
        control_period=0.75,
        oscillator_amplitude=22.0 * pi / 180,
        oscillator_energy_gain=2.0,
        steering_gain=0.75,
        steering_limit=10.0 * pi / 180,
        tail_steering_gain=0.60,
        tail_lag_gain=0.55,
        tail_damping=0.65,
        acceleration_limit=29.0,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Retain the evaluated 0.75/10-degree pure-bearing response. Nearby 0.745
    # and 0.77 gains both took longer, less compact routes under the common
    # wake, so this candidate does not continue the static-gain interpolation.
    steering_center = params.steering_limit * tanh(
        params.steering_gain * state.bearing / params.steering_limit,
    )

    # Encode phase in joint state and regulate bend energy without a clock.
    # This propulsion package is retained from the target-reaching sample.
    oscillator_position = q1 - steering_center
    oscillator_energy = (oscillator_position / amp)^2 +
        (qd1 / (omega * amp))^2
    oscillator_drive = params.oscillator_energy_gain *
        (1 - oscillator_energy) * qd1
    raw_a1 = oscillator_drive - omega^2 * oscillator_position

    # Oppose and lag only the oscillatory component while sharing part of the
    # low-frequency steering curvature with the posterior joint.
    tail_target = params.tail_steering_gain * steering_center -
        oscillator_position -
        params.tail_lag_gain * qd1 / omega
    raw_a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Test a small release of the active candidate guard while staying below
    # the task's 31.42 rad/time^2 hard acceleration envelope. The successful
    # anchor touched both 28 rad/time^2 guards but retained joint-state margin.
    accel_limit = params.acceleration_limit
    a1 = clamp(raw_a1, -accel_limit, accel_limit)
    a2 = clamp(raw_a2, -accel_limit, accel_limit)

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
