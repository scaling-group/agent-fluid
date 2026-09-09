function target_policy_params()
    return (
        control_period=0.75,
        oscillator_amplitude=20.0 * pi / 180,
        oscillator_mu=0.45,
        tail_lag_gain=0.65,
        tail_damping=0.85,
        bearing_gain=0.8,
        heading_rate_gain=0.75,
        steering_limit=14.0 * pi / 180,
        front_steering_fraction=0.35,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Positive body-frame bearing requires negative heading correction under
    # the testbed's headward (-x) convention. Heading-rate feedback arrests the
    # turn instead of allowing a persistent curved escape. The bias is bounded
    # independently of distance, wake phase, and global coordinates.
    steering = clamp(
        -params.bearing_gain * state.bearing -
        params.heading_rate_gain * state.heading_rate,
        -params.steering_limit,
        params.steering_limit,
    )

    # The oscillator retains phase in joint state. It runs around a small share
    # of the steering shape so propulsion continues while the body turns.
    q1_center = params.front_steering_fraction * steering
    q1_oscillation = q1 - q1_center
    vdp_drive = params.oscillator_mu * (1 - (q1_oscillation / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1_oscillation

    # Make the mean cumulative tail tangent equal the steering command while
    # retaining the velocity-dependent lag that produces a traveling bend.
    phase_lag_target =
        steering - q1 - params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
