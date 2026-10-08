function target_policy_params()
    return (
        control_period=0.80,
        oscillator_amplitude=20.0 * pi / 180,
        oscillator_mu=0.9,
        tail_lag_gain=0.45,
        tail_damping=1.05,
        steering_gain=0.65,
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

    # Preserve the evaluated sign that produced upstream target progress, but
    # leave joint-angle margin by bounding the total mean curvature more tightly.
    steering = params.steering_limit * tanh(
        params.steering_gain * state.bearing / params.steering_limit,
    )
    anterior_bias = params.anterior_steering_fraction * steering
    posterior_bias = (1 - params.anterior_steering_fraction) * steering

    # Joint state encodes phase. Regulating the full angle/velocity radius
    # damps wake-driven excursions outside the requested orbit.
    centered_q1 = q1 - anterior_bias
    phase_radius2 =
        (centered_q1 / amp)^2 +
        (qd1 / max(omega * amp, eps(omega * amp)))^2
    radial_drive = params.oscillator_mu * (1 - phase_radius2) * qd1
    a1 = radial_drive - omega^2 * centered_q1

    # The posterior joint carries most of the mean curvature while retaining a
    # smaller velocity-dependent lag for propulsion without exhausting the
    # 45-degree joint envelope under nominal combined steering and oscillation.
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
