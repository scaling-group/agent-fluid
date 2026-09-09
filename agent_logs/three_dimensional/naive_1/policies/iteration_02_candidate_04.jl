# Target-regulated half-cycle steering for the 3D moving-window EvE lane.
# Propulsive phase remains entirely in joint state; body-frame bearing changes
# posterior beat authority without imposing a persistent joint offset.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        turn_signal_scale=0.30,
        half_cycle_asymmetry=0.55,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Van der Pol drive: oscillation phase lives in (q1, qd1), not clock time.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1

    # Positive posterior emphasis produces the negative-yaw sign required by
    # positive body-frame bearing in this FSI body. The request reverses
    # continuously when the target changes side.
    bearing = Float64(state.bearing)
    turn_request = tanh(
        bearing / max(params.turn_signal_scale, eps(params.turn_signal_scale)),
    )

    # Infer beat side from the lagged tail wave itself. Multiplying its signed
    # amplitude by the same-sign smooth side indicator strengthens one
    # half-cycle and relieves the other. The gain stays positive, preserves the
    # seed phase lag, and leaves zero equilibrium curvature when bearing is zero.
    lagged_tail_wave = -q1 - params.tail_lag_gain * qd1 / max(omega, eps(omega))
    beat_side = tanh(lagged_tail_wave / max(amp, eps(amp)))
    tail_gain = 1 + params.half_cycle_asymmetry * turn_request * beat_side
    phase_lag_target = tail_gain * lagged_tail_wave
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
