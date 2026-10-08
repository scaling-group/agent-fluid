function target_policy_params()
    return (
        control_period=0.75,
        oscillator_amplitude=22.0 * pi / 180,
        oscillator_mu=0.5,
        tail_lag_gain=0.55,
        tail_damping=0.9,
        steering_gain=0.75,
        steering_limit=16.0 * pi / 180,
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

    # Target bearing is body-frame and scale-free.  A smooth bounded curvature
    # bias rejects large wake-driven course errors without encoding a route.
    steering = params.steering_limit * tanh(
        params.steering_gain * state.bearing / params.steering_limit,
    )
    anterior_bias = params.anterior_steering_fraction * steering
    posterior_bias = (1 - params.anterior_steering_fraction) * steering

    # Preserve the seed's state-encoded oscillator, but run it about the
    # steering equilibrium instead of about a target-blind straight posture.
    centered_q1 = q1 - anterior_bias
    vdp_drive = params.oscillator_mu * (1 - (centered_q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * centered_q1

    # The posterior joint carries most of the mean steering curvature while
    # retaining a velocity-dependent traveling-bend lag for propulsion.
    phase_lag_target = posterior_bias - centered_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
