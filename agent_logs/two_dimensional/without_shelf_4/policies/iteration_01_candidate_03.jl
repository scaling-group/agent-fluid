function target_policy_params()
    return (
        control_period=0.90,
        oscillator_amplitude=16.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.50,
        tail_damping=0.90,
        bearing_gain=1.0,
        turn_rate_gain=0.12,
        steering_limit=18.0 * pi / 180,
        anterior_steering_share=0.5,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # In this body convention, positive bearing requires a negative turn.  A
    # rate-damped, bounded tangent command corrects the gross one-sided yaw
    # while remaining relative to the target rather than to world coordinates.
    steering = clamp(
        -params.bearing_gain * state.bearing -
        params.turn_rate_gain * state.turn_rate_recent,
        -params.steering_limit,
        params.steering_limit,
    )

    # Keep oscillator phase in joint state, but center the anterior rhythm on
    # part of the steering bend.  At zero bearing this reduces to a symmetric
    # state-only propulsion oscillator.
    q1_center = params.anterior_steering_share * steering
    oscillator_state = q1 - q1_center
    vdp_drive = params.oscillator_mu *
                (1 - (oscillator_state / max(amp, eps(amp)))^2) * qd1
    a1 = vdp_drive - omega^2 * oscillator_state

    # The posterior target makes the total tail tangent approach the steering
    # command while retaining a velocity-dependent traveling-wave lag.
    phase_lag_target = steering - q1 -
                       params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
