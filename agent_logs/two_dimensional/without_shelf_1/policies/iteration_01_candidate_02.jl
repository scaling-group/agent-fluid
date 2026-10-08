function target_policy_params()
    return (
        control_period=1.10,
        oscillator_amplitude=11.0 * pi / 180,
        oscillator_mu=0.55,
        tail_lag_gain=0.55,
        tail_damping=0.90,
        bearing_gain=3.0,
        maximum_curvature_bias=12.0 * pi / 180,
        command_acceleration_limit=14.0,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # The propulsion phase remains encoded in joint state rather than time.  A
    # longer period keeps the nominal oscillator inside the joint rate and
    # acceleration envelope seen to saturate in the sampled rollout.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1_raw = vdp_drive - omega^2 * q1

    # Forward is negative body x in this observation convention, so a positive
    # target bearing calls for a negative mean tail tangent.  Saturation makes
    # the curvature command bounded even when the target passes abeam.
    curvature_bias = -params.maximum_curvature_bias *
        tanh(params.bearing_gain * state.bearing)
    tail_target = curvature_bias - q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2_raw = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    limit = params.command_acceleration_limit
    a1 = clamp(a1_raw, -limit, limit)
    a2 = clamp(a2_raw, -limit, limit)

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
