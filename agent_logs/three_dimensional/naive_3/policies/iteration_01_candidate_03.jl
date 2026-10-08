# Target-referenced mean-curvature steering around the seed's autonomous
# traveling-bend carrier.  Oscillation phase remains entirely in joint state.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        bearing_limit=1.2,
        bearing_scale=0.35,
        bearing_prediction_T=0.10,
        bearing_rate_limit=1.5,
        head_bias_limit=8.0 * pi / 180,
        tail_bias_limit=11.0 * pi / 180,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Predict a short distance in the same body-frame target coordinate.  A
    # converging bearing therefore releases mean curvature before overshoot.
    bearing = clamp(Float64(state.bearing), -params.bearing_limit, params.bearing_limit)
    bearing_rate = clamp(
        Float64(state.bearing_window_rate),
        -params.bearing_rate_limit,
        params.bearing_rate_limit,
    )
    predicted_bearing = bearing + params.bearing_prediction_T * bearing_rate
    turn_command = tanh(predicted_bearing / max(params.bearing_scale, eps(params.bearing_scale)))

    # Bounded joint centers add mean curvature without replacing the propulsive
    # wave.  The posterior center is slightly stronger to retain tail authority.
    head_center = params.head_bias_limit * turn_command
    tail_center = params.tail_bias_limit * turn_command

    # Van der Pol drive around the requested head-joint center.  Oscillation
    # phase lives in (q1, qd1), never elapsed time or a mutable controller state.
    head_wave = q1 - head_center
    vdp_drive = params.oscillator_mu * (1 - (head_wave / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * head_wave

    phase_lag_target = tail_center - head_wave -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
