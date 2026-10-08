function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        bearing_scale=20.0 * pi / 180,
        halfcycle_asymmetry=0.35,
        halfcycle_sharpness=4.0,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Bearing selects a turn direction, but does not recenter the anterior
    # oscillator: inherited equilibrium-bias variants lost the seed's upstream
    # propulsive transient and were advected out of the downstream boundary.
    bearing = clamp(Float64(state.bearing), -pi / 2, pi / 2)
    turn_cmd = tanh(bearing / max(params.bearing_scale, eps(Float64)))

    # Preserve the seed's evidenced propulsion scaffold exactly at joint 1.
    # Oscillator phase remains encoded only in observed joint state.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1

    # The seed's velocity-lagged term is the desired total tail tangent. Apply
    # a smooth target-side half-cycle asymmetry to that observable phase, then
    # convert the total tangent back to the incremental second-joint target.
    tail_tangent_wave = -params.tail_lag_gain * qd1 / max(omega, eps(omega))
    tail_phase_scale = max(params.tail_lag_gain * amp, eps(Float64))
    tail_side = tanh(
        params.halfcycle_sharpness * tail_tangent_wave / tail_phase_scale,
    )
    halfcycle_gain = 1 + params.halfcycle_asymmetry * turn_cmd * tail_side
    tail_tangent_target = halfcycle_gain * tail_tangent_wave
    q2_target = tail_tangent_target - q1
    a2 = omega^2 * (q2_target - q2) - 2 * params.tail_damping * omega * qd2

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
