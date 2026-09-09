function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.80,
        tail_damping=0.65,
        bearing_scale=25.0 * pi / 180,
        halfcycle_asymmetry=0.45,
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

    # Retain the sampled seed's zero-centered state-feedback oscillator: it is
    # the only completed scaffold that produced upstream motion in this wake.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1

    # The fish points along body -x, so positive bearing puts the target on its
    # right. Positive tail-half-cycle bias is the lane's left-turn convention.
    bearing = clamp(Float64(state.bearing), -pi / 2, pi / 2)
    turn_direction = -tanh(bearing / params.bearing_scale)

    # The seed's lag term is the commanded total tail tangent after adding the
    # two incremental joint bends. Use it as an observed phase coordinate and
    # strengthen only the target-useful half-cycle; no static joint offset is
    # introduced, so posterior wave propagation remains the propulsion source.
    tail_tangent_wave = -params.tail_lag_gain * qd1 / max(omega, eps(omega))
    phase_scale = max(params.tail_lag_gain * amp, eps(Float64))
    beat_side = tanh(params.halfcycle_sharpness * tail_tangent_wave / phase_scale)
    tail_gain = 1 + params.halfcycle_asymmetry * turn_direction * beat_side
    tail_tangent_target = tail_gain * tail_tangent_wave
    q2_target = tail_tangent_target - q1
    a2 = omega^2 * (q2_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
