function target_policy_params()
    return (
        control_period=0.9,
        oscillator_amplitude=16.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.75,
        bearing_slope=3.0,
        max_head_bias=10.0 * pi / 180,
        tail_bias_ratio=0.65,
        heading_rate_scale=0.25,
        heading_rate_damping=0.35,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Slow target geometry sets mean curvature; measured yaw rate only damps
    # the response.  Both signals are body-frame/state feedback, so this does
    # not encode a route, release phase, or world direction.
    bearing = clamp(Float64(state.bearing), -pi / 2, pi / 2)
    target_turn = tanh(params.bearing_slope * bearing)
    heading_rate = hasproperty(state, :heading_rate) ?
        Float64(state.heading_rate) : 0.0
    yaw_feedback = params.heading_rate_damping * tanh(
        heading_rate / params.heading_rate_scale,
    )
    turn_cmd = clamp(target_turn - yaw_feedback, -1.0, 1.0)
    head_bias = params.max_head_bias * turn_cmd
    tail_bias = params.tail_bias_ratio * head_bias

    # Preserve a state-only propulsive oscillator, now centered on the bounded
    # curvature request.  Its phase remains encoded in joint state, not time.
    centered_q1 = q1 - head_bias
    vdp_drive = params.oscillator_mu * (1 - (centered_q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * centered_q1

    # The posterior joint keeps the seed's lagged, emphasized traveling bend
    # while sharing the mean bias needed for a coherent turn.
    phase_lag_target = tail_bias - centered_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
