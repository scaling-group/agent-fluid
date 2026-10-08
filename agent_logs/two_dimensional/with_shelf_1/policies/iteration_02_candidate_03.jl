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
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Keep propulsion centered: phase is encoded by joint state, not time, and
    # steering does not move the oscillator equilibrium.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1

    # Posterior velocity lag maintains a directed traveling bend.
    phase_lag_target = -q1 - params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    # Persistent body-frame target error adds a bounded turning asymmetry
    # outside the propulsive carrier. A smaller posterior share preserves lag.
    steering = params.steering_acceleration *
        tanh(Float64(state.bearing) / params.steering_bearing_scale)

    return (
        phi_ddot=(
            a1 + steering,
            a2 + params.tail_steering_ratio * steering,
        ),
    )
end
