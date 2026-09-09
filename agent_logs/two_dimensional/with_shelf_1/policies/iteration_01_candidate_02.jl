function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        steering_max_bias=10.0 * pi / 180,
        steering_lateral_scale=0.30,
        steering_tail_share=0.40,
        steering_direction=-1.0,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # The nose points along negative body x, so positive body-y target error
    # requests negative mean curvature.  Distance normalization makes this a
    # bounded angular error without embedding a world-frame route.
    target_lateral_ratio = state.target_body_L[2] / max(state.distance_L, eps(state.distance_L))
    steering_cmd = tanh(target_lateral_ratio / params.steering_lateral_scale)
    head_bias = (
        params.steering_direction *
        params.steering_max_bias *
        steering_cmd
    )

    # Keep the state-only oscillator as the propulsive carrier, but center it
    # on the target-driven mean bend.  Its phase remains encoded in (q1, qd1).
    centered_q1 = q1 - head_bias
    vdp_drive = params.oscillator_mu * (1 - (centered_q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * centered_q1

    # Tail follows the oscillatory part of joint 1 with velocity-dependent lag
    # and shares a smaller same-sign bias.  This preserves the traveling bend
    # while making the mean tail tangent steer with the target error.
    phase_lag_target = (
        -centered_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega)) +
        params.steering_tail_share * head_bias
    )
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
