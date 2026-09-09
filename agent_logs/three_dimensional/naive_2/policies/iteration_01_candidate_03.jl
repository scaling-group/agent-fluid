# Bounded target-relative mean-curvature steering around the naive seed's
# state-feedback traveling bend. No clock, world-frame route, or mutable phase
# is used: joint state carries the propulsive phase and body-frame observations
# close the steering loop.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        turn_bias_limit=10.0 * pi / 180,
        bearing_gain=2.5,
        heading_rate_damping=0.35,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Equal mean curvature on the two joints is the signed turn actuator. The
    # repository calibration gives positive curvature -> negative yaw. Bearing
    # and heading rate use body/time-normalized observations; tanh keeps the
    # requested curvature continuous and bounded during large heading errors.
    bearing = clamp(Float64(state.bearing), -pi / 2, pi / 2)
    heading_rate = Float64(state.heading_rate)
    turn_signal = params.bearing_gain * bearing +
        params.heading_rate_damping * heading_rate
    mean_curvature = params.turn_bias_limit * tanh(turn_signal)

    # Preserve the seed's self-excited carrier, but center it on the requested
    # curvature so steering changes the beat mean rather than adding a weak
    # acceleration offset that vanishes under the oscillator stiffness.
    q1_osc = q1 - mean_curvature
    vdp_drive = params.oscillator_mu * (1 - (q1_osc / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1_osc

    phase_lag_target = mean_curvature - q1_osc -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
