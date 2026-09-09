function target_policy_params()
    return (
        control_period=0.90,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        steering_bias_limit=10.0 * pi / 180,
        bearing_scale=25.0 * pi / 180,
        steering_fade_distance_L=0.75,
        steering_fade_width_L=0.75,
        posterior_target_limit=36.0 * pi / 180,
        anterior_command_limit=1650.0 * pi / 180,
        posterior_command_limit=1500.0 * pi / 180,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Keep the strongest finite sample's state-driven propulsion oscillator.
    # Steering does not shift this anterior equilibrium.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    raw_a1 = vdp_drive - omega^2 * q1

    # Preserve the evidence-backed positive body-frame bearing convention and
    # fade it only where the first-crossing target makes bearing ill-conditioned.
    fade_coordinate = clamp(
        (state.distance_L - params.steering_fade_distance_L) /
            max(params.steering_fade_width_L, eps(params.steering_fade_width_L)),
        0.0,
        1.0,
    )
    steering_fade = fade_coordinate^2 * (3 - 2 * fade_coordinate)
    steering_bias = params.steering_bias_limit * steering_fade *
        tanh(state.bearing / params.bearing_scale)

    # Apply steering only to the posterior mean tangent. Bound its requested
    # joint angle below the physical stop that every sampled rate variant hit.
    tail_tangent_target = steering_bias -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    raw_q2_target = tail_tangent_target - q1
    q2_target = clamp(
        raw_q2_target,
        -params.posterior_target_limit,
        params.posterior_target_limit,
    )
    raw_a2 = omega^2 * (q2_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (
        phi_ddot=(
            clamp(
                raw_a1,
                -params.anterior_command_limit,
                params.anterior_command_limit,
            ),
            clamp(
                raw_a2,
                -params.posterior_command_limit,
                params.posterior_command_limit,
            ),
        ),
    )
end
