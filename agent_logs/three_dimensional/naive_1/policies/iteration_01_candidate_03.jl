# Target-regulated mean-curvature candidate for the 3D moving-window EvE lane.
# Propulsive phase remains entirely in joint state; steering uses only
# normalized body-frame target geometry and measured body turn rate.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        turn_curvature_limit=14.0 * pi / 180,
        turn_signal_scale=0.30,
        yaw_rate_damping=0.22,
        turn_rate_limit=2.0,
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

    # Positive mean joint curvature produces negative yaw for this FSI body.
    # Bearing requests that curvature, while the observed yaw rate brakes the
    # request before the fish sweeps through the target direction.  tanh keeps
    # the posterior bias bounded without clipping the propulsive oscillator.
    bearing = Float64(state.bearing)
    turn_rate = clamp(
        Float64(state.turn_rate_recent),
        -params.turn_rate_limit,
        params.turn_rate_limit,
    )
    turn_signal = bearing + params.yaw_rate_damping * turn_rate
    mean_curvature = params.turn_curvature_limit * tanh(
        turn_signal / max(params.turn_signal_scale, eps(params.turn_signal_scale)),
    )

    phase_lag_target = mean_curvature - q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
