# Target-bearing mean-curvature controller for the 3D moving-window EvE lane.
# The traveling bend remains state-driven; only its slowly varying centerline
# is biased from normalized body-frame target geometry.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        steering_bearing_scale=0.25,
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

    # Positive body-frame bearing requests positive mean curvature.  The 3D
    # turn sanity establishes that this curvature produces negative yaw, which
    # is the correction required for a target on the fish's positive-y side.
    bearing = Float64(state.bearing)
    bearing_scale = max(params.steering_bearing_scale, eps(Float64))
    turn_request = tanh(bearing / bearing_scale)
    head_bias = params.head_bias_limit * turn_request
    tail_bias = params.tail_bias_limit * turn_request

    # Van der Pol drive about the requested centerline.  Oscillation phase
    # remains in observed joint state rather than clock time.
    q1_centered = q1 - head_bias
    vdp_drive = params.oscillator_mu * (1 - (q1_centered / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1_centered

    # Apply the same signed mean bend posteriorly while preserving the seed's
    # lagged alternating component.
    phase_lag_target = tail_bias - q1_centered -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
