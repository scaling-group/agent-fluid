# Bounded target-to-curvature feedback around the inherited state-feedback
# carrier. The route signal is normalized and body-fixed; no clock or world
# coordinate enters the controller.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        curvature_limit=8.0 * pi / 180,
        bearing_scale=0.35,
        bearing_rate_gain=0.025,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # A positive common bend produces negative yaw in this geometry. Positive
    # body-frame bearing therefore requests positive curvature. The short-rate
    # term only brakes an established turn; tanh bounds both noisy rates and
    # large target errors.
    route_error = Float64(state.bearing) +
        params.bearing_rate_gain * Float64(state.bearing_window_rate)
    curvature_bias = params.curvature_limit * tanh(route_error / params.bearing_scale)

    # Keep phase in observed joint state while moving the oscillator's mean.
    centered_q1 = q1 - curvature_bias
    vdp_drive = params.oscillator_mu * (1 - (centered_q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * centered_q1

    # Share the mean bend but preserve the inherited posterior traveling-wave
    # lag about that mean.
    phase_lag_target = curvature_bias - centered_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
