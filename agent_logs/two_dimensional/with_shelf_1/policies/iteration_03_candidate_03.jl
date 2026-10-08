function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        steering_acceleration=10.0,
        steering_bearing_scale=0.35,
        tail_steering_ratio=0.55,
        acceleration_envelope=30.0,
        steering_reserve_fraction=0.20,
        joint_velocity_envelope=260.0 * pi / 180,
        velocity_guard_start_fraction=0.88,
    )
end

@inline function carrier_speed_guard(carrier, velocity, envelope, start_fraction)
    start = clamp(start_fraction, 0.0, 1.0 - eps(Float64))
    speed_fraction = abs(velocity) / max(envelope, eps(Float64))
    guard_phase = clamp((speed_fraction - start) / (1.0 - start), 0.0, 1.0)
    smooth_gate = guard_phase^2 * (3.0 - 2.0 * guard_phase)

    # Attenuate only acceleration that would push farther into the speed
    # envelope. Opposing carrier acceleration remains available for braking.
    return carrier * velocity > 0.0 ? (1.0 - smooth_gate) * carrier : carrier
end

@inline function bounded_residual_mix(carrier, steering, envelope, reserve_fraction)
    reserve_share = clamp(reserve_fraction, 0.0, 1.0)
    reserve = reserve_share * steering
    residual = carrier + (1.0 - reserve_share) * steering
    residual_envelope = max(envelope - abs(reserve), eps(Float64))
    return reserve + clamp(residual, -residual_envelope, residual_envelope)
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Joint-state phase sustains the sampled successful traveling-bend carrier.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    raw_carrier1 = vdp_drive - omega^2 * q1

    phase_lag_target = -q1 - params.tail_lag_gain * qd1 / max(omega, eps(Float64))
    raw_carrier2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Normalize current joint speed by a candidate-owned envelope. The guard
    # changes carrier allocation only near the observed speed cap; it does not
    # alter the proven oscillator gains or erase opposing acceleration.
    carrier1 = carrier_speed_guard(
        raw_carrier1,
        qd1,
        params.joint_velocity_envelope,
        params.velocity_guard_start_fraction,
    )
    carrier2 = carrier_speed_guard(
        raw_carrier2,
        qd2,
        params.joint_velocity_envelope,
        params.velocity_guard_start_fraction,
    )

    # Positive normalized body-frame bearing uses the empirically validated
    # steering sign. A small reserved share survives carrier-envelope fitting.
    steering = params.steering_acceleration *
        tanh(Float64(state.bearing) / params.steering_bearing_scale)
    tail_steering = params.tail_steering_ratio * steering

    command1 = bounded_residual_mix(
        carrier1,
        steering,
        params.acceleration_envelope,
        params.steering_reserve_fraction,
    )
    command2 = bounded_residual_mix(
        carrier2,
        tail_steering,
        params.acceleration_envelope,
        params.steering_reserve_fraction,
    )

    return (
        phi_ddot=(
            command1,
            command2,
        ),
    )
end
