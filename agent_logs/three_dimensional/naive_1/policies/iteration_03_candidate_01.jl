# State-feedback traveling-bend carrier with target-driven anterior duty-ratio
# asymmetry. Oscillator phase and bend side remain in observed joint state.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        turn_bearing_scale=20.0 * pi / 180,
        turn_heading_rate_scale=1.5,
        turn_heading_rate_feedback=0.35,
        duty_ratio_asymmetry=0.22,
        bend_side_scale=8.0 * pi / 180,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Positive bearing requests the positive bend side observed to reduce the
    # initial target error. Negative yaw is that response, so it unloads a
    # positive request and strengthens a negative corrective request.
    turn_signal = Float64(state.bearing) / params.turn_bearing_scale +
        params.turn_heading_rate_feedback * Float64(state.heading_rate) /
        params.turn_heading_rate_scale
    turn_request = tanh(turn_signal)

    # Duty-ratio steering changes residence time rather than adding a static
    # equilibrium or an always-on acceleration. Slow the restoring motion on
    # the requested bend side and speed it on the opposite side. The bounded
    # positive scale preserves alternating zero crossings and reflection
    # symmetry while giving target feedback a different actuator from the
    # sampled amplitude-asymmetry laws.
    bend_side = tanh(q1 / params.bend_side_scale)
    frequency_scale = 1 -
        params.duty_ratio_asymmetry * turn_request * bend_side

    # Van der Pol drive: oscillation phase lives in (q1, qd1), not clock time.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    steered_omega = omega * frequency_scale
    a1 = vdp_drive - steered_omega^2 * q1

    # Preserve the inherited posterior traveling-wave relation. Steering acts
    # through the anterior carrier rather than replacing posterior lag.
    phase_lag_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
