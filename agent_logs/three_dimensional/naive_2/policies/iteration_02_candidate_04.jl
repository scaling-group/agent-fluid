# Target-relative half-cycle steering around the naive state-feedback carrier.
# Joint state supplies beat phase; no clock, route, or mutable state is used.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        steering_bearing_scale=0.30,
        steering_yaw_rate_lead=0.20,
        half_cycle_accel_limit=16.0,
        half_cycle_gate_softness=0.20,
        requested_accel_limit=30.0,
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

    # Positive common curvature produces negative yaw in this body, matching a
    # positive body-frame bearing.  Measured yaw rate leads the request so an
    # established correct-sign turn releases before the bearing crosses zero.
    bearing = isfinite(state.bearing) ? Float64(state.bearing) : 0.0
    heading_rate = isfinite(state.heading_rate) ? Float64(state.heading_rate) : 0.0
    turn_signal = bearing + params.steering_yaw_rate_lead * heading_rate
    turn_request = tanh(
        turn_signal / max(params.steering_bearing_scale, eps(Float64)),
    )

    # Act only on the half-cycle opposed to the requested bend.  This weakens
    # that excursion instead of moving both joint equilibria into static
    # curvature; the posterior target below propagates the asymmetric wave.
    phase_position = clamp(q1 / max(amp, eps(amp)), -1.0, 1.0)
    opposed_phase = turn_request * phase_position
    phase_gate = 0.5 * (
        1.0 - tanh(opposed_phase / params.half_cycle_gate_softness)
    )
    a1 += params.half_cycle_accel_limit * turn_request * phase_gate

    phase_lag_target = -q1 - params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    # A smooth symmetric bound stays inside the episode envelope without
    # creating a controller-owned bang-bang plateau at the limit.
    limit = params.requested_accel_limit
    return (phi_ddot=(limit * tanh(a1 / limit), limit * tanh(a2 / limit)),)
end
