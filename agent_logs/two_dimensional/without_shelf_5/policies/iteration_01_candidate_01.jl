function target_policy_params()
    return (
        control_period=1.1,
        oscillator_amplitude=22.0 * pi / 180,
        oscillator_mu=0.45,
        tail_lag_gain=0.65,
        tail_damping=0.85,
        bearing_gain=0.9,
        bearing_limit=1.1,
        lateral_velocity_gain=0.35,
        lateral_velocity_limit=0.6,
        moment_gain=0.25,
        moment_limit=0.25,
        steering_limit=12.0 * pi / 180,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # The fish's forward direction is the negative body-x axis, so positive
    # bearing calls for negative mean curvature. Lateral velocity and moment
    # feedback resist the advected yaw seen in the seed rollout. Every signal
    # and contribution is bounded before it shifts the oscillator center.
    bearing = clamp(Float64(state.bearing), -params.bearing_limit, params.bearing_limit)
    lateral_velocity = clamp(
        Float64(state.velocity_body_U[2]),
        -params.lateral_velocity_limit,
        params.lateral_velocity_limit,
    )
    moment = clamp(Float64(state.moment_z_L2), -params.moment_limit, params.moment_limit)
    steering = clamp(
        -params.bearing_gain * bearing +
        params.lateral_velocity_gain * lateral_velocity -
        params.moment_gain * moment,
        -params.steering_limit,
        params.steering_limit,
    )

    # State-only oscillator: phase remains encoded in joint state, while the
    # moving equilibrium supplies target-aware curvature without a clock.
    oscillatory_q1 = q1 - steering
    vdp_drive = params.oscillator_mu * (1 - (oscillatory_q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * oscillatory_q1

    # The posterior joint follows only the oscillatory part of q1. This keeps
    # the steering offset as net tail curvature instead of canceling it.
    phase_lag_target =
        -oscillatory_q1 - params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
