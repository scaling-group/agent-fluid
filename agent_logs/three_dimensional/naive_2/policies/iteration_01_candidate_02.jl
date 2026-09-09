# State-feedback traveling bend with bounded body-frame target curvature.
# Oscillation phase remains entirely in joint state; there is no clock, route,
# case identity, or fixed world-frame direction.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        steering_accel_limit=8.0,
        bearing_softness=0.35,
        tail_steer_share=0.8,
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

    phase_lag_target = -q1 - params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    # Body-frame bearing is already normalized by the observation adapter.
    # A smooth acceleration bias changes mean curvature without replacing the
    # posterior-lagged propulsive wave. Saturation bounds far-target authority.
    bearing = clamp(Float64(state.bearing), -1.0, 1.0)
    steering = params.steering_accel_limit * tanh(bearing / params.bearing_softness)

    return (
        phi_ddot=(
            a1 + steering,
            a2 + params.tail_steer_share * steering,
        ),
    )
end
