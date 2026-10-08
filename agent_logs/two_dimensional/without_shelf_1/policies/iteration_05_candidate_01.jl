function target_policy_params()
    return (
        control_period=0.90,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        steering_bias_limit=10.0 * pi / 180,
        bearing_scale=25.0 * pi / 180,
        posterior_target_limit=40.0 * pi / 180,
        steering_fade_distance_L=0.75,
        steering_fade_width_L=0.75,
        acceleration_command_limit=1650.0 * pi / 180,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Restore the finite approach anchor's upstream-capable gait unchanged.
    # Oscillator phase remains encoded in joint state rather than time.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    raw_a1 = vdp_drive - omega^2 * q1

    # Retain the evidence-backed positive posterior-only bearing sign. Both
    # sampled rate paths changed loop timing without preventing the top exit.
    fade_coordinate = clamp(
        (state.distance_L - params.steering_fade_distance_L) /
            max(params.steering_fade_width_L, eps(params.steering_fade_width_L)),
        0.0,
        1.0,
    )
    steering_fade = fade_coordinate^2 * (3 - 2 * fade_coordinate)
    steering_bias = params.steering_bias_limit * steering_fade *
        tanh(state.bearing / params.bearing_scale)

    # Preserve the unsteered traveling bend exactly. Clip only the steering
    # contribution when it would reinforce the propulsive posterior target
    # beyond a guard five degrees inside the documented hard angle limit.
    propulsive_q2_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    steering_direction = sign(steering_bias)
    steering_headroom = max(
        params.posterior_target_limit -
            steering_direction * propulsive_q2_target,
        0.0,
    )
    guarded_steering_bias = steering_direction * min(
        abs(steering_bias),
        steering_headroom,
    )
    q2_target = propulsive_q2_target + guarded_steering_bias
    raw_a2 = omega^2 * (q2_target - q2) -
        2 * params.tail_damping * omega * qd2

    limit = params.acceleration_command_limit
    a1 = clamp(raw_a1, -limit, limit)
    a2 = clamp(raw_a2, -limit, limit)

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
