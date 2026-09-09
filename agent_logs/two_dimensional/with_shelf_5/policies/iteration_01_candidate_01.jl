function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        turn_bias_max=12.0 * pi / 180,
        turn_bearing_scale=25.0 * pi / 180,
        tail_turn_ratio=0.75,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Convert persistent target error into bounded mean curvature.  Bearing is
    # already a normalized body-frame observation, so this remains independent
    # of world coordinates, body length, and wake phase.
    bearing = clamp(Float64(state.bearing), -pi / 2, pi / 2)
    turn_bias = params.turn_bias_max * tanh(
        bearing / max(params.turn_bearing_scale, eps(params.turn_bearing_scale)),
    )

    # Preserve the state-only reflex oscillator but run it around the requested
    # mean bend.  Its phase still lives in joint angle and velocity, not time.
    q1_osc = q1 - turn_bias
    vdp_drive = params.oscillator_mu * (1 - (q1_osc / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1_osc

    # Tail follows the first joint with a velocity-dependent lag, producing a
    # traveling bend about a compatible posterior steering bias.
    phase_lag_target = params.tail_turn_ratio * turn_bias - q1_osc -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
