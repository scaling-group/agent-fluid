# State-feedback traveling bend with bounded target-directed mean curvature.
# Oscillator phase remains encoded only in observed joint position/velocity.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        bearing_scale=0.28,
        bearing_rate_scale=1.0,
        maximum_mean_bend=8.0 * pi / 180,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # A persistent target error shifts mean curvature, while the recent
    # bearing response releases the bend as alignment improves.  Both inputs
    # are normalized body-frame observations, and tanh bounds the request.
    bearing = clamp(Float64(state.bearing), -1.0, 1.0)
    bearing_rate = Float64(state.bearing_window_rate)
    turn_request = tanh(
        bearing / params.bearing_scale +
        bearing_rate / params.bearing_rate_scale,
    )
    mean_bend = params.maximum_mean_bend * turn_request

    # Center the original Van der Pol drive on the requested mean bend.  At a
    # zero turn request this is exactly the naive seed's propulsion equation.
    centered_q1 = q1 - mean_bend
    vdp_drive = params.oscillator_mu * (1 - (centered_q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * centered_q1

    # Apply the same mean bend to the posterior joint while retaining its
    # lagged, oppositely signed oscillatory component and damping.
    phase_lag_target = mean_bend - centered_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
