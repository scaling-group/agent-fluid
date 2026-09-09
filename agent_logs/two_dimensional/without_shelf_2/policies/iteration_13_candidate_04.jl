function target_policy_params()
    return (
        control_period=0.75,
        oscillator_amplitude=22.0 * pi / 180,
        oscillator_energy_gain=2.1,
        oscillator_excess_gain=2.2,
        steering_gain=0.75,
        steering_limit=10.0 * pi / 180,
        tail_steering_gain=0.60,
        tail_lag_gain=0.55,
        tail_damping=0.65,
        acceleration_limit=28.0,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Retain the sampled interior pure-bearing response without adding the
    # failed rate lead or interpolating its wake-sensitive gain.
    steering_center = params.steering_limit * tanh(
        params.steering_gain * state.bearing / params.steering_limit,
    )

    # Preserve the evaluated 2.1 recovery below the requested orbit. Apply the
    # sampled 2.2 coefficient only above it, where the signed term opposes
    # velocity; the uniform 2.2 rollout reduced peak state slightly but lost
    # route quality when it also strengthened below-orbit energy injection.
    oscillator_position = q1 - steering_center
    oscillator_energy = (oscillator_position / amp)^2 +
        (qd1 / (omega * amp))^2
    energy_gain = oscillator_energy <= 1 ?
        params.oscillator_energy_gain : params.oscillator_excess_gain
    oscillator_drive = energy_gain *
        (1 - oscillator_energy) * qd1
    raw_a1 = oscillator_drive - omega^2 * oscillator_position

    # Oppose and lag only the oscillatory component while sharing a fraction of
    # the mean curvature, retaining a traveling bend during a target turn.
    tail_target = params.tail_steering_gain * steering_center -
        oscillator_position -
        params.tail_lag_gain * qd1 / omega
    raw_a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Restore the reproducible common guard: posterior trimming and extra
    # global authority both produced less compact, more highly loaded routes.
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
