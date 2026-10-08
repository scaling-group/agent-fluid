function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        steer_curvature_limit=8.0 * pi / 180,
        steer_bearing_scale=0.35,
        tail_curvature_share=0.65,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Convert only the scale-free body-frame target bearing into a bounded
    # mean bend. The smooth saturation prevents a large wake-induced bearing
    # excursion from replacing the propulsive rhythm with static curvature.
    bearing = clamp(Float64(state.bearing), -pi / 2, pi / 2)
    turn_fraction = tanh(bearing / params.steer_bearing_scale)
    mean_bend = params.steer_curvature_limit * turn_fraction

    # Keep the oscillator state-only, but run it about the requested mean bend
    # so its zero-mean component remains a propulsion phase coordinate.
    q1_wave = q1 - mean_bend
    vdp_drive = params.oscillator_mu * (1 - (q1_wave / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1_wave

    # Construct the posterior traveling component from q1_wave, then add a
    # smaller same-sign mean bend for coherent two-joint curvature steering.
    tail_wave_target = -q1_wave - params.tail_lag_gain * qd1 / max(omega, eps(omega))
    tail_target = tail_wave_target + params.tail_curvature_share * mean_bend
    a2 = omega^2 * (tail_target - q2) - 2 * params.tail_damping * omega * qd2

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
