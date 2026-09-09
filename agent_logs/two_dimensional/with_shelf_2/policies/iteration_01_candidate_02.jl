function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        bearing_gain=2.2,
        curvature_limit=14.0 * pi / 180,
        tail_curvature_share=0.45,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Convert dimensionless body-frame target geometry into a bounded mean
    # curvature.  The limit leaves room for the existing oscillation inside the
    # joint-angle envelope, and uses neither a clock nor a memorized route.
    bearing = clamp(Float64(state.bearing), -pi / 2, pi / 2)
    turn_cmd = tanh(params.bearing_gain * bearing)
    curvature_bias = params.curvature_limit * turn_cmd

    # Keep the state-only reflex rhythm, but oscillate around the requested
    # steering curvature instead of around a target-blind straight pose.
    q1_wave = q1 - curvature_bias
    vdp_drive = params.oscillator_mu * (1 - (q1_wave / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1_wave

    # Preserve the posterior phase lag and give the tail a smaller compatible
    # share of the mean bend, rather than adding a residual that actuator
    # clipping could erase.
    phase_lag_target = params.tail_curvature_share * curvature_bias -
        q1_wave - params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
