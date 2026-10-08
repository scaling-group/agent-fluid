function target_policy_params()
    return (
        control_period=1.0,
        oscillator_amplitude=12.0 * pi / 180,
        oscillator_mu=0.55,
        tail_lag_gain=0.65,
        tail_damping=0.85,
        steering_limit=16.0 * pi / 180,
        bearing_gain=3.0,
        bearing_rate_gain=0.18,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Smooth target-relative curvature stays bounded even during a rapid wake
    # disturbance. The windowed bearing rate damps turning without a clock.
    turn_signal = params.bearing_gain * state.bearing +
        params.bearing_rate_gain * state.bearing_window_rate
    steering_center = -params.steering_limit * tanh(turn_signal)

    # The oscillator remains state-encoded in joint position and velocity, but
    # now oscillates about the target-relative steering center.
    q1_error = q1 - steering_center
    vdp_drive = params.oscillator_mu * (1 - (q1_error / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1_error

    # Cancelling only the oscillatory part at the posterior joint preserves the
    # steering curvature while retaining a velocity-dependent traveling lag.
    phase_lag_target = -q1_error -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
