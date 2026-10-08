# Phase-separated target steering on a state-feedback traveling bend.
# Joint state supplies gait phase; target geometry remains normalized and
# body-relative, with no clock, world route, or mutable controller state.

function target_policy_params()
    return (
        control_period=0.90,
        oscillator_amplitude=18.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        bearing_limit=1.25,
        bearing_scale=0.40,
        phase_yaw_velocity_gain=0.44,
        residual_turn_rate_limit=0.30,
        max_turn_rate_ratio=0.10,
        turn_rate_error_scale=0.08,
        phase_velocity_scale=0.60,
        phase_support_acceleration=5.0,
        half_cycle_steering_acceleration=5.0,
        steering_angle_soft_limit=40.0 * pi / 180,
        steering_speed_soft_limit=230.0 * pi / 180,
        headroom_exponent=4.0,
        acceleration_limit=28.0,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

    # Retain the sampled state-feedback carrier.  The long finite rollout
    # showed that its lagged traveling bend makes a coherent propulsive wake.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    carrier_a1 = vdp_drive - omega^2 * q1

    phase_velocity = tanh(
        qd1 /
        (max(omega * amp, eps(Float64)) * params.phase_velocity_scale),
    )

    # Sampled rollouts share a nearly invariant beat-scale relation
    # heading_rate ~= -0.44*phi_dot1. Remove that component before closing the
    # slow turn loop, so joint phase cannot masquerade as target response.
    residual_turn_rate_ratio = clamp(
        (
            Float64(state.heading_rate) +
            params.phase_yaw_velocity_gain * qd1
        ) / max(omega, eps(Float64)),
        -params.residual_turn_rate_limit,
        params.residual_turn_rate_limit,
    )
    bearing = clamp(
        Float64(state.bearing),
        -params.bearing_limit,
        params.bearing_limit,
    )
    desired_turn_rate_ratio = -params.max_turn_rate_ratio *
        tanh(bearing / params.bearing_scale)
    turn_side = tanh(
        (desired_turn_rate_ratio - residual_turn_rate_ratio) /
        params.turn_rate_error_scale,
    )

    # Preserve the symmetric phase support that made the best sampled policy
    # survive, then superimpose target-directed support on only one half-cycle.
    # Both contributions fade before the observed angle and speed hard limits.
    angle_ratio = abs(q1) / params.steering_angle_soft_limit
    speed_ratio = abs(qd1) / params.steering_speed_soft_limit
    angle_headroom = clamp(
        1 - angle_ratio^params.headroom_exponent,
        0.0,
        1.0,
    )
    speed_headroom = clamp(
        1 - speed_ratio^params.headroom_exponent,
        0.0,
        1.0,
    )
    extra_headroom = min(angle_headroom, speed_headroom)
    phase_support = params.phase_support_acceleration * phase_velocity
    half_cycle_steering = 0.5 * params.half_cycle_steering_acceleration * (
        turn_side + abs(turn_side) * phase_velocity
    )
    a1 = carrier_a1 +
        extra_headroom * (phase_support + half_cycle_steering)

    # The posterior joint remains a damped, lagged follower rather than a
    # second steering actuator, preserving a directed body wave.
    tail_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(Float64))
    a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    limit = params.acceleration_limit
    return (
        phi_ddot=(
            clamp(a1, -limit, limit),
            clamp(a2, -limit, limit),
        ),
    )
end
