# State-feedback traveling-bend carrier with slip-damped half-cycle
# rectification. Oscillator phase remains encoded only in observed joint state.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        steering_bearing_scale=0.25,
        lateral_velocity_feedback=1.2,
        rectified_acceleration_limit=10.0,
        phase_velocity_limit=1.0,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Keep the inherited zero-centered carrier so steering cannot replace the
    # traveling bend with a static joint offset.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1

    # Positive bearing requests the positive bend side, which produces
    # negative yaw for this head-at-negative-x body convention. Positive
    # body-frame lateral motion is already target-side motion, so it unloads
    # that request; wrong-side slip strengthens the correction.
    bearing = Float64(state.bearing)
    lateral_velocity = Float64(state.velocity_body_U[2])
    route_error = bearing -
        params.lateral_velocity_feedback * lateral_velocity
    turn_request = tanh(route_error / params.steering_bearing_scale)

    # Rectify observed carrier speed rather than prescribing phase. The same
    # signed residual strengthens motion toward the requested side and brakes
    # the opposing stroke. It vanishes at reversals and remains bounded.
    phase_speed = clamp(
        abs(qd1) / max(omega * amp, eps(omega * amp)),
        0.0,
        params.phase_velocity_limit,
    )
    half_cycle_rectification = params.rectified_acceleration_limit *
        turn_request * phase_speed
    a1 += half_cycle_rectification

    # Steering reaches the posterior joint only through the inherited lagged
    # traveling-wave target, preserving a single anterior steering actuator.
    phase_lag_target = -q1 - params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
