function target_policy_params()
    return (
        control_period=0.78,
        oscillator_amplitude=22.0 * pi / 180,
        oscillator_mu=0.8,
        tail_lag_gain=0.55,
        tail_damping=0.9,
        steering_limit=12.0 * pi / 180,
        steering_gain=0.50,
        anterior_steering_fraction=0.35,
        acceleration_soft_limit=1700.0 * pi / 180,
        acceleration_softness_power=8.0,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Keep the evidence-backed steering direction body-relative and bounded.
    # The smaller gain preserves more of the initial targetward diagonal.
    steering = params.steering_limit * tanh(
        params.steering_gain * state.bearing /
        max(params.steering_limit, eps(params.steering_limit)),
    )
    q1_center = params.anterior_steering_fraction * steering
    q2_center = (1 - params.anterior_steering_fraction) * steering

    # Joint state encodes oscillator phase. Radial energy feedback regulates
    # both angle and rate around the moving steering equilibrium.
    oscillator_state = q1 - q1_center
    phase_speed_scale = max(omega * amp, eps(omega * amp))
    phase_radius2 =
        (oscillator_state / amp)^2 +
        (qd1 / phase_speed_scale)^2
    radial_drive = params.oscillator_mu * (1 - phase_radius2) * qd1
    raw_a1 = radial_drive - omega^2 * oscillator_state

    # The posterior target keeps a velocity-dependent traveling lag and carries
    # most of the mean curvature without cancelling the anterior oscillation.
    phase_lag_target = q2_center - oscillator_state -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    raw_a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Bound late, near the action envelope. The high-order smooth denominator
    # preserves nominal gait authority better than a tanh command limiter.
    accel_limit = params.acceleration_soft_limit
    softness = params.acceleration_softness_power
    a1 = raw_a1 /
        (1 + abs(raw_a1 / accel_limit)^softness)^(1 / softness)
    a2 = raw_a2 /
        (1 + abs(raw_a2 / accel_limit)^softness)^(1 / softness)

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
