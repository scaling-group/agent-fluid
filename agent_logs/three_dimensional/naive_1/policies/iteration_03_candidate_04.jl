# Persistent line-of-sight differential curvature for the moving-window lane.
# Propulsive phase remains in joint state. Normalized body-frame bearing sets
# opposite mean bends at the two joints without a clock or world-frame route.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        bearing_scale=0.30,
        bearing_limit=1.40,
        head_bias_limit=4.0 * pi / 180,
        tail_bias_limit=10.0 * pi / 180,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Positive bearing requires negative yaw for the measured 3D convention.
    # Opposite-sign joint offsets combine the sampled anterior and posterior
    # yaw authority. Bearing, unlike beat-scale recent yaw rate, retains its
    # sign throughout the strongest sampled miss.
    bearing = clamp(
        Float64(state.bearing),
        -params.bearing_limit,
        params.bearing_limit,
    )
    turn_request = tanh(
        bearing / max(params.bearing_scale, eps(params.bearing_scale)),
    )
    head_bias = -params.head_bias_limit * turn_request
    tail_bias = params.tail_bias_limit * turn_request

    # Preserve the state-feedback carrier about the bounded anterior offset.
    centered_q1 = q1 - head_bias
    vdp_drive = params.oscillator_mu * (1 - (centered_q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * centered_q1

    # Retain the posterior traveling-wave lag around its compatible offset.
    phase_lag_target = tail_bias - centered_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
