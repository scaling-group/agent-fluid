function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        max_turn_curvature=12.0 * pi / 180,
        bearing_scale=20.0 * pi / 180,
        anterior_bias_fraction=0.45,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Treat steering authority as one bounded total-curvature budget. Splitting
    # it between the joint attractors prevents the anterior bias from consuming
    # the traveling wave while retaining a target-signed average body bend.
    bearing = clamp(Float64(state.bearing), -pi / 2, pi / 2)
    turn_curvature = params.max_turn_curvature * tanh(
        bearing / max(params.bearing_scale, eps(params.bearing_scale)),
    )
    anterior_fraction = clamp(params.anterior_bias_fraction, 0.0, 1.0)
    q1_center = anterior_fraction * turn_curvature
    q2_center = (1 - anterior_fraction) * turn_curvature
    q1_wave = q1 - q1_center

    # The zero-mean propulsive phase remains encoded only in joint state.
    vdp_drive = params.oscillator_mu * (1 - (q1_wave / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1_wave

    # Retain the velocity-derived posterior lag around the posterior share of
    # the same curvature request, yielding coherent steering and propulsion.
    phase_lag_target = q2_center - q1_wave -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
