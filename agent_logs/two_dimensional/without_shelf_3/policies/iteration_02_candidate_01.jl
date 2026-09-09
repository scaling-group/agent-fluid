function target_policy_params()
    return (
        control_period=0.9,
        oscillator_amplitude=18.0 * pi / 180,
        oscillator_mu=0.9,
        tail_lag_gain=0.6,
        tail_damping=0.95,
        steering_gain=0.5,
        steering_limit=12.0 * pi / 180,
        anterior_steering_fraction=0.35,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # The sampled positive cumulative-curvature convention produced the only
    # sustained upstream trajectory. Keep that sign, but bound both the large
    # bearing response and the mean curvature without a route or clock.
    steering = params.steering_limit * tanh(
        params.steering_gain * state.bearing / params.steering_limit,
    )
    q1_center = params.anterior_steering_fraction * steering
    q2_center = (1 - params.anterior_steering_fraction) * steering

    # Regulate the full phase radius, not position alone. This changes the
    # Van der Pol drive into damping whenever either bend or bend-rate exceeds
    # the requested gait amplitude, while retaining autonomous phase in state.
    q1_oscillation = q1 - q1_center
    velocity_scale = max(omega * amp, eps(omega * amp))
    phase_radius2 =
        (q1_oscillation / amp)^2 +
        (qd1 / velocity_scale)^2
    radial_drive = params.oscillator_mu * (1 - phase_radius2) * qd1
    a1 = radial_drive - omega^2 * q1_oscillation

    # The posterior joint carries most of the bounded mean curvature and
    # opposes the oscillatory anterior bend with a velocity-dependent lag.
    phase_lag_target = q2_center - q1_oscillation -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
