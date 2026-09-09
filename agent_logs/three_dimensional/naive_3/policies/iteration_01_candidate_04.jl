# Target-guided state-feedback carrier for the 3D moving-window EvE lane.
# Joint state supplies beat phase; body-frame bearing and measured yaw response
# supply a bounded mean-curvature request without a clock or world-frame route.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        turn_bearing_scale=20.0 * pi / 180,
        turn_rate_scale=0.75,
        turn_rate_damping=0.65,
        turn_curvature_limit=10.0 * pi / 180,
        head_curvature_share=0.25,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Positive curvature produces the verified negative-yaw (right-turn)
    # response. Yaw-rate feedback releases or reverses curvature once the body
    # is already rotating through the target bearing.
    bearing = clamp(Float64(state.bearing), -pi / 2, pi / 2)
    heading_rate = hasproperty(state, :heading_rate) ?
        Float64(state.heading_rate) : 0.0
    heading_rate = isfinite(heading_rate) ? heading_rate : 0.0
    turn_signal =
        bearing / max(params.turn_bearing_scale, eps(Float64)) +
        params.turn_rate_damping * heading_rate /
        max(params.turn_rate_scale, eps(Float64))
    mean_curvature = params.turn_curvature_limit * tanh(turn_signal)

    # Keep the seed's self-excited carrier, but let a small share of the slow
    # curvature request shift the anterior oscillator center.
    head_center = params.head_curvature_share * mean_curvature
    q1_wave = q1 - head_center
    vdp_drive = params.oscillator_mu * (1 - (q1_wave / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1_wave

    # The posterior follower carries the remaining mean bend while preserving
    # the observed traveling-wave lag and its coherent propulsive wake.
    phase_lag_target =
        mean_curvature - q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
