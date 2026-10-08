# Target-relative posterior curvature with hydrodynamic-moment rejection.
# Propulsive phase remains in two-joint state. A slow body-frame route request
# and a small fast yaw-disturbance residual remain independently bounded.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        steering_bearing_limit=pi / 2,
        steering_bearing_scale=0.30,
        steering_lookahead_T=0.20,
        steering_bearing_rate_limit=1.20,
        steering_curvature_limit=12.0 * pi / 180,
        moment_rejection_scale=0.006,
        moment_rejection_curvature_limit=4.0 * pi / 180,
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

    # Preserve the sampled best carrier: phase lives in joint state, not time.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1

    # Keep the parent's slow target request in normalized body-frame geometry.
    raw_bearing = Float64(state.bearing)
    bearing = isfinite(raw_bearing) ? clamp(
        raw_bearing,
        -params.steering_bearing_limit,
        params.steering_bearing_limit,
    ) : 0.0
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
    route_curvature = params.steering_curvature_limit * tanh(
        predicted_bearing / params.steering_bearing_scale,
    )

    # Moment_z_L2 robustly tracks yaw acceleration in every sampled rollout.
    # Positive posterior mean tangent produces negative yaw in the evaluated
    # convention, so a positive-moment residual opposes positive yaw forcing.
    raw_moment = Float64(state.moment_z_L2)
    moment = isfinite(raw_moment) ? raw_moment : 0.0
    moment_curvature = params.moment_rejection_curvature_limit * tanh(
        moment / params.moment_rejection_scale,
    )
    mean_tail_tangent = clamp(
        route_curvature + moment_curvature,
        -(params.steering_curvature_limit + params.moment_rejection_curvature_limit),
        params.steering_curvature_limit + params.moment_rejection_curvature_limit,
    )

    posterior_wave = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    phase_lag_target = clamp(
        posterior_wave + mean_tail_tangent,
        -params.posterior_target_limit,
        params.posterior_target_limit,
    )
    a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    a1 = clamp(a1, -params.acceleration_limit, params.acceleration_limit)
    a2 = clamp(a2, -params.acceleration_limit, params.acceleration_limit)

    return (phi_ddot=(a1, a2),)
end
