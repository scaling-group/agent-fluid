function target_policy_params()
    return (
        control_period=0.75,
        oscillator_amplitude=11.0 * pi / 180,
        oscillator_mu=0.30,
        tail_lag_gain=0.65,
        tail_damping=0.90,
        steering_max_bias=15.0 * pi / 180,
        steering_softness=0.35,
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

    # The phase remains encoded in joint state, so propulsion needs no clock or
    # case-specific route.  The lower-amplitude, slower oscillator avoids using
    # the episode's hard acceleration envelope as its normal gait generator.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1_raw = vdp_drive - omega^2 * q1

    # Forward is body -x in the task observation.  A positive bearing places
    # the target toward body +y; this bounded negative tail-tangent bias tests
    # the corresponding corrective turn and vanishes smoothly on alignment.
    bearing = clamp(state.bearing, -pi / 2, pi / 2)
    steering_bias = -params.steering_max_bias *
        tanh(bearing / params.steering_softness)
    tail_target = -q1 - params.tail_lag_gain * qd1 / max(omega, eps(omega)) +
        steering_bias
    a2_raw = omega^2 * (tail_target - q2) -
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
