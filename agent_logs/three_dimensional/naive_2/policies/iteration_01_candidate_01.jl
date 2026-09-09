# State-feedback propulsion with body-frame mean-curvature steering.
# Oscillator phase remains entirely in joint state; no clock or route is used.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        steering_curvature_limit=14.0 * pi / 180,
        steering_bearing_scale=0.35,
        steering_yaw_rate_lead=0.30,
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

    # Positive body-frame bearing asks for positive mean tail curvature.  The
    # measured yaw rate leads the request so an established turn releases and
    # reverses its curvature before it sweeps past the target direction.
    bearing = isfinite(state.bearing) ? Float64(state.bearing) : 0.0
    heading_rate = isfinite(state.heading_rate) ? Float64(state.heading_rate) : 0.0
    steering_signal = bearing + params.steering_yaw_rate_lead * heading_rate
    mean_curvature = params.steering_curvature_limit *
        tanh(steering_signal / max(params.steering_bearing_scale, eps(Float64)))

    phase_lag_target = mean_curvature - q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
