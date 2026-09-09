function target_policy_params()
    return (
        control_period=0.75,
        oscillator_amplitude=11.0 * pi / 180,
        oscillator_mu=0.30,
        tail_lag_gain=0.65,
        tail_damping=0.90,
        steering_bias_limit=15.0 * pi / 180,
        steering_bearing_scale=0.35,
        acceleration_limit=26.0,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Bearing supplies a coordinate-free posterior curvature offset.  The
    # positive sign is the isolated alternative to the two sampled negative
    # posterior biases that turned down/right and exited without approaching.
    steering_bias = params.steering_bias_limit * tanh(
        clamp(state.bearing, -pi / 2, pi / 2) /
        params.steering_bearing_scale,
    )

    # Keep the anterior oscillator centered at zero.  The sampled positive
    # common-curvature controller centered this state on its steering bias and
    # settled into an almost static bend instead of sustaining propulsion.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1_raw = vdp_drive - omega^2 * q1

    # The posterior joint alone carries the mean steering bias while retaining
    # the state-only traveling-wave lag.  Commands remain below the episode's
    # acceleration envelope rather than relying on its hard clamp.
    phase_lag_target = steering_bias - q1 -
                       params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2_raw = omega^2 * (phase_lag_target - q2) -
             2 * params.tail_damping * omega * qd2

    a1 = clamp(a1_raw, -params.acceleration_limit, params.acceleration_limit)
    a2 = clamp(a2_raw, -params.acceleration_limit, params.acceleration_limit)

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
