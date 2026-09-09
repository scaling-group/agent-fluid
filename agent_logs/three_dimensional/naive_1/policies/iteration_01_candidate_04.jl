# Target-directed mean-curvature carrier for the 3D moving-window EvE lane.
# Oscillation phase remains entirely in joint state; body-frame bearing moves
# the mean bend without prescribing a clock, world route, or vortex phase.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        bearing_limit=1.0,
        bearing_scale=0.30,
        head_bias_limit=9.0 * pi / 180,
        tail_bias_limit=9.0 * pi / 180,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # A smooth body-frame target request shifts mean curvature.  The measured
    # 3D FSI sign is non-geometric: positive joint bias produces negative yaw,
    # which is the correction requested by positive bearing in this adapter.
    bearing = clamp(
        Float64(state.bearing),
        -params.bearing_limit,
        params.bearing_limit,
    )
    turn_command = tanh(bearing / max(params.bearing_scale, eps(params.bearing_scale)))
    head_bias = params.head_bias_limit * turn_command
    tail_bias = params.tail_bias_limit * turn_command

    # Run the seed carrier relative to the requested mean bend.  This keeps the
    # useful state-feedback rhythm and posterior lag instead of spending a
    # separate acceleration correction against an already saturated carrier.
    q1_oscillatory = q1 - head_bias
    vdp_drive = params.oscillator_mu * (1 - (q1_oscillatory / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1_oscillatory

    phase_lag_target = tail_bias - q1_oscillatory -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
