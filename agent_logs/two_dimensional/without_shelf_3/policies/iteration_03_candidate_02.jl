function target_policy_params()
    return (
        control_period=0.80,
        oscillator_amplitude=20.0 * pi / 180,
        oscillator_mu=0.45,
        tail_lag_gain=0.55,
        tail_damping=1.0,
        bearing_gain=0.45,
        steering_limit=10.0 * pi / 180,
        steering_joint_share=0.35,
        acceleration_limit=1500.0 * pi / 180,
        acceleration_linear_fraction=0.85,
    )
end

function wake_smooth_limit(value, limit, linear_fraction)
    magnitude = abs(value)
    knee = linear_fraction * limit
    magnitude <= knee && return value

    shoulder = max(limit - knee, eps(limit))
    bounded_magnitude = knee + shoulder * tanh((magnitude - knee) / shoulder)
    return copysign(bounded_magnitude, value)
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Positive body-frame bearing curvature produced the only sampled active
    # upstream motion. Keep that sign, but lower and bound the mean curvature
    # so it cannot grow into the progress rollout's folded terminal turn.
    steering_request = params.bearing_gain * state.bearing
    steering_bias = params.steering_limit * tanh(
        steering_request / params.steering_limit,
    )

    # Preserve position-only self-excitation: the sampled phase-radius
    # descendants stayed low-load but became effectively flow-following.
    q1_center = params.steering_joint_share * steering_bias
    oscillator_state = q1 - q1_center
    oscillator_drive =
        params.oscillator_mu * (1 - (oscillator_state / amp)^2) * qd1
    raw_a1 = oscillator_drive - omega^2 * oscillator_state

    # Split the mean curvature across the joints. The posterior target opposes
    # and lags only the oscillatory part, preserving the traveling bend without
    # cancelling the target-relative steering equilibrium.
    q2_center = (1 - params.steering_joint_share) * steering_bias
    phase_lag_target = q2_center - oscillator_state -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    raw_a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Leave the nominal gait in the limiter's linear region and smoothly
    # shoulder exceptional commands below the evaluator's hard action cap.
    accel_limit = params.acceleration_limit
    linear_fraction = params.acceleration_linear_fraction
    a1 = wake_smooth_limit(raw_a1, accel_limit, linear_fraction)
    a2 = wake_smooth_limit(raw_a2, accel_limit, linear_fraction)

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
