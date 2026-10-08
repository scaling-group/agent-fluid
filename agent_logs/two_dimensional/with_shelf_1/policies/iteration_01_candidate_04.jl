function target_policy_params()
    return (
        control_period=0.9,
        oscillator_amplitude=18.0 * pi / 180,
        oscillator_mu=0.5,
        tail_lag_gain=0.8,
        tail_damping=0.8,
        bearing_limit=1.2,
        steer_gain=2.0,
        steer_angle_limit=10.0 * pi / 180,
        tail_steer_gain=0.55,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Persistent body-frame target error shifts the oscillator's mean
    # curvature, while tanh keeps the bend request inside a fixed angle bound.
    bearing = clamp(Float64(state.bearing), -params.bearing_limit, params.bearing_limit)
    curvature_bias = params.steer_angle_limit * tanh(params.steer_gain * bearing)

    # State-only reflex oscillator: phase remains encoded by joint state.  The
    # centered coordinate lets steering bias the mean without replacing the
    # propulsive rhythm with a static bend.
    q1_wave = q1 - curvature_bias
    vdp_drive = params.oscillator_mu * (1 - (q1_wave / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1_wave

    # The posterior joint retains the seed's velocity-dependent lag and takes
    # only a smaller share of the mean curvature, preserving wave direction.
    phase_lag_wave = -q1_wave - params.tail_lag_gain * qd1 / max(omega, eps(omega))
    tail_target = phase_lag_wave + params.tail_steer_gain * curvature_bias
    a2 = omega^2 * (tail_target - q2) - 2 * params.tail_damping * omega * qd2

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
