# State-feedback traveling-wave carrier with bounded target-relative curvature.
# Oscillation phase remains entirely in joint state; steering uses normalized
# body-frame geometry and measured body response, never time or world position.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        bearing_scale=0.30,
        turn_rate_scale=1.0,
        turn_rate_damping=0.35,
        mean_curvature_limit=14.0 * pi / 180,
        anterior_curvature_share=0.30,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Positive body-frame bearing requires positive mean bend for this spine
    # convention.  Positive measured yaw rate is added because positive bend
    # produces negative yaw; the term therefore opposes accumulated rotation.
    bearing = clamp(Float64(state.bearing), -1.0, 1.0)
    turn_rate = if hasproperty(state, :turn_rate_recent)
        Float64(state.turn_rate_recent)
    elseif hasproperty(state, :heading_rate)
        Float64(state.heading_rate)
    else
        0.0
    end
    turn_request = tanh(
        bearing / params.bearing_scale +
        params.turn_rate_damping * tanh(turn_rate / params.turn_rate_scale),
    )
    mean_curvature = params.mean_curvature_limit * turn_request

    # Center the anterior state-feedback oscillator on a share of the requested
    # curvature so its amplitude envelope remains propulsive during a turn.
    anterior_center = params.anterior_curvature_share * mean_curvature
    q1_wave = q1 - anterior_center
    vdp_drive = params.oscillator_mu * (1 - (q1_wave / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1_wave

    # The posterior target completes the same total mean curvature while
    # retaining the seed's observed state-dependent phase lag.
    phase_lag_target =
        mean_curvature - q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
