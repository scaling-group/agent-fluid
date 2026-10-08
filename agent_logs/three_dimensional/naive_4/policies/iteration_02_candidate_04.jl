# Target-relative half-cycle steering for the 3D moving-window EvE lane.
# Propulsive phase remains entirely in the observed two-joint state. Steering
# asymmetrically scales the posterior wave without moving the anterior carrier.

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
        steering_asymmetry_limit=0.65,
        steering_phase_gate_scale=0.40,
        posterior_target_limit=42.0 * pi / 180,
        acceleration_limit=1800.0 * pi / 180,
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

    # Predict the body-frame bearing over a short observed-response horizon.
    # The bounded rate term releases/reverses curvature while crossing the
    # target line, rather than allowing the seed's large unregulated yaw arc.
    bearing = clamp(Float64(state.bearing), -pi / 2, pi / 2)
    bearing_rate = if hasproperty(state, :bearing_window_rate)
        Float64(state.bearing_window_rate)
    elseif hasproperty(state, :bearing_rate)
        Float64(state.bearing_rate)
    else
        0.0
    end
    bearing_rate = clamp(
        bearing_rate,
        -params.steering_bearing_rate_limit,
        params.steering_bearing_rate_limit,
    )
    predicted_bearing = bearing + params.steering_lookahead_T * bearing_rate
    turn_command = tanh(predicted_bearing / params.steering_bearing_scale)
    # Infer the posterior wave side from joint state. A positive turn request
    # strengthens the positive half-cycle and weakens the negative half-cycle;
    # reflection reverses both signs and therefore preserves equivariance.
    posterior_wave = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    normalized_wave = posterior_wave / max(amp, eps(amp))
    beat_side = tanh(normalized_wave / params.steering_phase_gate_scale)
    half_cycle_scale = 1 +
        params.steering_asymmetry_limit * turn_command * beat_side
    phase_lag_target = clamp(
        posterior_wave * half_cycle_scale,
        -params.posterior_target_limit,
        params.posterior_target_limit,
    )
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    # Match the returned policy command to the fixed downstream actuator
    # envelope instead of relying on large, repeatedly clipped raw requests.
    a1 = clamp(a1, -params.acceleration_limit, params.acceleration_limit)
    a2 = clamp(a2, -params.acceleration_limit, params.acceleration_limit)

    return (phi_ddot=(a1, a2),)
end
