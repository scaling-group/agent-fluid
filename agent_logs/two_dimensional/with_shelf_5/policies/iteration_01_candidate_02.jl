function target_policy_params()
    return (
        control_period=0.90,
        oscillator_amplitude=14.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.80,
        max_curvature_bias=10.0 * pi / 180,
        bearing_scale=30.0 * pi / 180,
        tail_bias_share=0.55,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # A persistent body-frame target error shifts the mean bend without a
    # world-frame route.  Saturation keeps large wake-driven bearing excursions
    # from replacing the propulsive rhythm with static curvature.
    bearing = Float64(state.bearing)
    mean_bend = params.max_curvature_bias * tanh(bearing / params.bearing_scale)

    # Keep oscillator phase in observed joint state, but form the rhythm about
    # the steering mean so turning and propulsion remain separable.
    oscillatory_q1 = q1 - mean_bend
    vdp_drive = params.oscillator_mu * (1 - (oscillatory_q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * oscillatory_q1

    # The posterior joint retains the seed's velocity-dependent lag, while a
    # smaller same-sign mean component supplies distributed turning curvature.
    phase_lag_target = params.tail_bias_share * mean_bend -
        oscillatory_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
