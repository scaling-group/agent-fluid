# Target-relative mean-curvature steering around the seed's state-feedback
# propulsive oscillator.  Oscillation phase remains entirely in joint state.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        turn_bias_limit=8.0 * pi / 180,
        bearing_scale=20.0 * pi / 180,
        heading_rate_scale=1.0,
        heading_rate_feedback=0.45,
        tail_turn_share=0.6,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Positive bearing is the curvature direction that reduces target error in
    # this body's head-at-negative-x convention.  Same-direction yaw unloads
    # the request, while wrong-direction yaw strengthens it.  tanh keeps the
    # resulting mean bend inside the joint envelope without a hidden mode.
    turn_signal = Float64(state.bearing) / params.bearing_scale +
        params.heading_rate_feedback * Float64(state.heading_rate) /
        params.heading_rate_scale
    turn_bias = params.turn_bias_limit * tanh(turn_signal)

    # Center the Van der Pol drive on the requested mean curvature.  The
    # oscillation still derives its phase from (q1, qd1), never elapsed time.
    q1_oscillation = q1 - turn_bias
    vdp_drive = params.oscillator_mu *
        (1 - (q1_oscillation / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1_oscillation

    # Retain the seed's posterior lag and add only a smaller same-sign mean
    # bend, leaving most posterior authority available for propulsion.
    phase_lag_target = params.tail_turn_share * turn_bias - q1_oscillation -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
