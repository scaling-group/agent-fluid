# State-feedback traveling bend with bounded body-frame mean-curvature
# steering. The propulsive phase remains encoded only by joint state.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        max_turn_bias=8.0 * pi / 180,
        turn_bearing_scale=25.0 * pi / 180,
        tail_turn_bias_ratio=0.55,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Persistent target error moves the center of the propulsive rhythm.  The
    # smooth bound preserves oscillation authority even for a target far off
    # the current heading and avoids a hard steering switch.
    bearing = clamp(Float64(state.bearing), -pi / 2, pi / 2)
    turn_bias = params.max_turn_bias * tanh(
        bearing / params.turn_bearing_scale,
    )
    tail_turn_bias = params.tail_turn_bias_ratio * turn_bias

    # Van der Pol drive: oscillation phase lives in centered joint state, not
    # clock time. Centering adds mean curvature without changing the seed gait.
    q1_centered = q1 - turn_bias
    vdp_drive = params.oscillator_mu *
        (1 - (q1_centered / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1_centered

    phase_lag_target = tail_turn_bias - q1_centered -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
