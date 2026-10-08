# Posterior-only target-turn-rate steering around the naive state-feedback
# carrier. Propulsive phase remains in joint state; all task feedback is
# normalized and expressed in the body frame.

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
        steering_turn_rate_limit=0.18,
        steering_turn_rate_measurement_limit=0.60,
        steering_turn_rate_error_scale=0.12,
        steering_curvature_limit=12.0 * pi / 180,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Preserve the sampled carrier: moving this oscillator's mean into the
    # anterior joint suppressed both its limit cycle and its 3D wake.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1

    raw_bearing = Float64(state.bearing)
    bearing = isfinite(raw_bearing) ? clamp(raw_bearing, -pi / 2, pi / 2) : 0.0
    bearing_rate = if hasproperty(state, :bearing_window_rate)
        Float64(state.bearing_window_rate)
    elseif hasproperty(state, :bearing_rate)
        Float64(state.bearing_rate)
    else
        0.0
    end
    bearing_rate = isfinite(bearing_rate) ? clamp(
        bearing_rate,
        -params.steering_bearing_rate_limit,
        params.steering_bearing_rate_limit,
    ) : 0.0
    predicted_bearing = bearing + params.steering_lookahead_T * bearing_rate

    # In the observed convention, a positive target bearing was served by a
    # positive posterior mean tangent and a negative body-yaw response. Close
    # that response loop on the slow observed turn rate so the bias releases
    # before crossing the target line and reverses after an overshoot.
    desired_turn_rate = -params.steering_turn_rate_limit * tanh(
        predicted_bearing / params.steering_bearing_scale,
    )
    measured_turn_rate = if hasproperty(state, :turn_rate_recent)
        Float64(state.turn_rate_recent)
    else
        Float64(state.heading_rate)
    end
    measured_turn_rate = isfinite(measured_turn_rate) ? clamp(
        measured_turn_rate,
        -params.steering_turn_rate_measurement_limit,
        params.steering_turn_rate_measurement_limit,
    ) : 0.0
    turn_rate_residual = measured_turn_rate - desired_turn_rate
    turn_command = tanh(
        turn_rate_residual / params.steering_turn_rate_error_scale,
    )
    mean_tail_tangent = params.steering_curvature_limit * turn_command

    phase_lag_target = mean_tail_tangent - q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
