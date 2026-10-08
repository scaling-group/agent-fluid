# State-feedback traveling bend with target-directed mean tail curvature.
# Oscillator phase remains encoded in joint state; no clock or route is used.

function target_policy_params()
    return (
        control_period=1.10,
        oscillator_amplitude=10.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        bearing_limit=1.0,
        bearing_scale=0.30,
        max_target_turn_rate=0.65,
        turn_rate_observation_limit=3.0,
        turn_rate_error_scale=0.45,
        max_tail_mean_bend=10.0 * pi / 180,
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
    # The lower carrier scale keeps the traveling bend away from actuator caps.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1

    # Positive body-frame bearing requests negative yaw.  Measured turn-rate
    # feedback releases and reverses the mean bend after the response develops.
    bearing = clamp(
        Float64(state.bearing),
        -params.bearing_limit,
        params.bearing_limit,
    )
    turn_rate = clamp(
        Float64(state.turn_rate_recent),
        -params.turn_rate_observation_limit,
        params.turn_rate_observation_limit,
    )
    desired_turn_rate = -params.max_target_turn_rate *
        tanh(bearing / params.bearing_scale)
    turn_rate_error = desired_turn_rate - turn_rate
    mean_tail_bend = -params.max_tail_mean_bend *
        tanh(turn_rate_error / params.turn_rate_error_scale)

    phase_lag_target = mean_tail_bend - q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
