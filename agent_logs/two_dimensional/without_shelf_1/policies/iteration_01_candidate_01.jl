function target_policy_params()
    return (
        control_period=0.90,
        oscillator_amplitude=22.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.65,
        tail_damping=0.85,
        steering_gain=0.90,
        steering_rate_gain=0.12,
        turn_rate_gain=0.06,
        steering_limit=12.0 * pi / 180,
        bearing_limit=90.0 * pi / 180,
        feedback_rate_limit=1.5,
        acceleration_limit=1500.0 * pi / 180,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Body -x is forward, so a target at positive body y needs a negative
    # steering bend.  Windowed bearing motion and measured turn rate damp the
    # correction while keeping every feedback term bounded.
    bearing = clamp(state.bearing, -params.bearing_limit, params.bearing_limit)
    bearing_rate = clamp(
        state.bearing_window_rate,
        -params.feedback_rate_limit,
        params.feedback_rate_limit,
    )
    turn_rate = clamp(
        state.turn_rate_recent,
        -params.feedback_rate_limit,
        params.feedback_rate_limit,
    )
    steering = clamp(
        -params.steering_gain * bearing -
        params.steering_rate_gain * bearing_rate -
        params.turn_rate_gain * turn_rate,
        -params.steering_limit,
        params.steering_limit,
    )

    # The oscillator phase remains encoded in joint state rather than time.
    # Centering it on the steering bend lets target feedback reject wake-driven
    # yaw without suppressing the traveling propulsion wave.
    centered_q1 = q1 - steering
    vdp_drive = params.oscillator_mu * (1 - (centered_q1 / amp)^2) * qd1
    a1_raw = vdp_drive - omega^2 * centered_q1

    # The second joint follows only the oscillatory part of the first joint.
    # Consequently the mean bend remains in the cumulative tail tangent rather
    # than being canceled by the phase-lag target.
    phase_lag_target = -centered_q1 - params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2_raw = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2
    a1 = clamp(a1_raw, -params.acceleration_limit, params.acceleration_limit)
    a2 = clamp(a2_raw, -params.acceleration_limit, params.acceleration_limit)

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
