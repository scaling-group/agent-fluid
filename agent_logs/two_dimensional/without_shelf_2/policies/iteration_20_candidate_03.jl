function target_policy_params()
    return (
        control_period=0.75,
        oscillator_amplitude=22.0 * pi / 180,
        oscillator_energy_gain=2.1,
        steering_gain=0.75,
        steering_limit=10.0 * pi / 180,
        tail_steering_gain=0.70,
        tail_lag_gain=0.55,
        tail_damping=0.65,
        tail_speed_damping_gain=0.025,
        tail_speed_threshold=1.0,
        tail_speed_transition=0.08,
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

    # Preserve the evaluated static 2.1 recovery law; its 2.075 midpoint took a
    # deeper, slower, more highly loaded route on the common wake snapshot.
    oscillator_position = q1 - steering_center
    oscillator_energy = (oscillator_position / amp)^2 +
        (qd1 / (omega * amp))^2
    oscillator_drive = params.oscillator_energy_gain *
        (1 - oscillator_energy) * qd1
    raw_a1 = oscillator_drive - omega^2 * oscillator_position

    # Preserve the evaluated posterior share that retained the compact route.
    # The inherited static increase to 0.75 selected a deeper lower correction,
    # so do not interpolate posterior curvature sharing here.
    tail_target = params.tail_steering_gain * steering_center -
        oscillator_position -
        params.tail_lag_gain * qd1 / omega

    # Localize the demonstrated 0.025 damping increment to the observed
    # posterior-speed peak. Two sampled copies of this normalized smooth gate
    # tightened capture and reduced effort and load versus constant damping.
    normalized_tail_speed = abs(qd2) / (omega * amp)
    tail_speed_gate = 0.5 * (1 + tanh(
        (normalized_tail_speed - params.tail_speed_threshold) /
        params.tail_speed_transition,
    ))
    effective_tail_damping = params.tail_damping +
        params.tail_speed_damping_gain * tail_speed_gate
    raw_a2 = omega^2 * (tail_target - q2) -
        2 * effective_tail_damping * omega * qd2

    # Retain the reproducible common guard; static guard interpolation and
    # extra authority both produced less compact, more highly loaded routes.
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
