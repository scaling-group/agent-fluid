# State-feedback traveling bend with one-sided posterior phase authority.
# Oscillator phase remains entirely in joint state. Target steering weakens
# only the carrier-acceleration lobe that opposes the requested turn.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        steering_bearing_scale=0.30,
        steering_lookahead_T=0.20,
        steering_bearing_rate_limit=1.20,
        steering_bias_limit=12.0 * pi / 180,
        steering_phase_gate_scale=0.15,
        acceleration_reference=1800.0 * pi / 180,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Van der Pol carrier: phase lives in (q1, qd1), not clock time.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1

    raw_bearing = Float64(state.bearing)
    bearing = isfinite(raw_bearing) ? clamp(raw_bearing, -pi / 2, pi / 2) : 0.0
    raw_bearing_rate = if hasproperty(state, :bearing_window_rate)
        Float64(state.bearing_window_rate)
    elseif hasproperty(state, :bearing_rate)
        Float64(state.bearing_rate)
    else
        0.0
    end
    bearing_rate = isfinite(raw_bearing_rate) ? clamp(
        raw_bearing_rate,
        -params.steering_bearing_rate_limit,
        params.steering_bearing_rate_limit,
    ) : 0.0
    predicted_bearing = bearing + params.steering_lookahead_T * bearing_rate
    turn_request = tanh(
        predicted_bearing /
        max(params.steering_bearing_scale, eps(params.steering_bearing_scale)),
    )

    posterior_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    carrier_a2 = omega^2 * (posterior_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Positive target bearing requires positive posterior bias in the observed
    # convention. Under reflection, both turn_request and carrier_a2 reverse,
    # so their product and this phase gate are invariant. Authority approaches
    # one only when the unsteered carrier acceleration points against the turn;
    # the same-signed, already limit-prone lobe is left nearly unchanged.
    normalized_opposition = -turn_request * carrier_a2 /
        max(params.acceleration_reference, eps(params.acceleration_reference))
    phase_authority = 0.5 * (1 + tanh(
        normalized_opposition /
        max(params.steering_phase_gate_scale, eps(params.steering_phase_gate_scale)),
    ))
    steering_bias = params.steering_bias_limit * turn_request * phase_authority
    a2 = carrier_a2 + omega^2 * steering_bias

    return (phi_ddot=(a1, a2),)
end
