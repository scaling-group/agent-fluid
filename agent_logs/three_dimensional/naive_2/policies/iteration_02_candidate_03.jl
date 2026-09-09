# State-feedback traveling bend with body-frame half-cycle steering.
# Oscillator phase remains in joint state; no clock, route, or wake phase is used.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        steering_bearing_scale=0.30,
        steering_slip_gain=0.75,
        tail_asymmetry_fraction=0.45,
        tail_phase_softness=0.12,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Preserve the seed's state-only anterior propulsion carrier unchanged.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1

    # Bearing supplies the route request. In still water, positive relative
    # crossflow accompanies motion toward body-negative y, so this soft term
    # reinforces the initial turn and releases it as lateral slip reverses.
    bearing = isfinite(state.bearing) ? Float64(state.bearing) : 0.0
    relative_crossflow = isfinite(state.relative_flow_velocity_body_U[2]) ?
        Float64(state.relative_flow_velocity_body_U[2]) : 0.0
    steering_signal = clamp(bearing, -1.2, 1.2) +
        params.steering_slip_gain * clamp(relative_crossflow, -0.4, 0.4)
    turn_request = tanh(
        steering_signal / max(params.steering_bearing_scale, eps(Float64)),
    )

    # Infer posterior beat side from the seed's lagged state target. Amplify
    # the requested half-cycle and weaken its mirror by the same bounded
    # fraction, creating turn authority without a static curvature center.
    posterior_wave = -q1 - params.tail_lag_gain * qd1 / max(omega, eps(omega))
    beat_side = tanh(
        posterior_wave / max(params.tail_phase_softness, eps(Float64)),
    )
    asymmetry_scale = 1 +
        params.tail_asymmetry_fraction * turn_request * beat_side
    tail_target = asymmetry_scale * posterior_wave
    a2 = omega^2 * (tail_target - q2) - 2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
