# Target-relative mean-curvature candidate for the 3D moving-window lane.
# Oscillation phase remains entirely in observed joint state; target steering
# shifts the posterior mean tangent without using time or world coordinates.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        bearing_scale=0.35,
        bearing_prediction_horizon=0.22,
        bearing_rate_limit=1.5,
        max_tail_curvature=12.0 * pi / 180,
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

    # Predict a short distance along the measured bearing trend.  The tanh
    # bounds the mean curvature and lets it release before a centerline sweep
    # becomes the seed rollout's large wrong-way turn.
    bearing = clamp(Float64(state.bearing), -pi / 2, pi / 2)
    bearing_rate = clamp(
        Float64(state.bearing_window_rate),
        -params.bearing_rate_limit,
        params.bearing_rate_limit,
    )
    predicted_bearing = bearing + params.bearing_prediction_horizon * bearing_rate
    turn_command = tanh(predicted_bearing / params.bearing_scale)
    mean_tail_tangent = params.max_tail_curvature * turn_command

    phase_lag_target =
        mean_tail_tangent - q1 - params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
