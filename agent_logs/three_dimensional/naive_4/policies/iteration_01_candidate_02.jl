# Target-relative mean-curvature candidate for the 3D moving-window EvE lane.
# Propulsive phase remains entirely in the observed two-joint state; steering
# uses only normalized body-frame target geometry and its observed trend.

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
    mean_tail_tangent = params.steering_curvature_limit * turn_command

    # A positive body-frame target bearing maps to the positive mean posterior
    # tangent that opposes the observed negative-heading overshoot. The
    # oscillatory posterior lag is otherwise identical to the sampled carrier.
    phase_lag_target = mean_tail_tangent - q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
