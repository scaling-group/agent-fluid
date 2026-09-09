function target_policy_params()
    return (
        control_period=1.05,
        oscillator_amplitude=24.0 * pi / 180,
        oscillator_mu=0.45,
        bearing_limit=60.0 * pi / 180,
        steering_gain=0.8,
        steering_rate_gain=4.0 * pi / 180,
        steering_rate_scale=0.35,
        steering_bias_limit=12.0 * pi / 180,
        tail_steering_gain=0.7,
        tail_lag_gain=0.65,
        tail_damping=0.8,
        acceleration_soft_limit=28.0,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Target-relative mean curvature. The windowed bearing rate damps a turn as
    # the target returns toward the body axis without introducing a clock or a
    # memorized route.
    bearing = clamp(state.bearing, -params.bearing_limit, params.bearing_limit)
    rate_feedback = params.steering_rate_gain *
        tanh(state.bearing_window_rate / params.steering_rate_scale)
    steering_request = params.steering_gain * bearing + rate_feedback
    steering_bias = params.steering_bias_limit *
        tanh(steering_request / params.steering_bias_limit)

    # The first joint remains a state-phase oscillator, now centered on the
    # steering bias. Its slower nominal rhythm stays below the hard actuator
    # acceleration cap before wake disturbances are added.
    centered_q1 = q1 - steering_bias
    vdp_drive = params.oscillator_mu * (1 - (centered_q1 / amp)^2) * qd1
    raw_a1 = vdp_drive - omega^2 * centered_q1

    # The posterior joint shares the steering sign but opposes and lags the
    # oscillatory component, preserving a traveling bend around that curvature.
    tail_target = params.tail_steering_gain * steering_bias - centered_q1 -
        params.tail_lag_gain * qd1 / omega
    raw_a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Smooth limiting avoids turning the evaluator's hard cap into the normal
    # operating regime while keeping all outputs finite under a strong wake.
    accel_limit = params.acceleration_soft_limit
    a1 = accel_limit * tanh(raw_a1 / accel_limit)
    a2 = accel_limit * tanh(raw_a2 / accel_limit)

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
