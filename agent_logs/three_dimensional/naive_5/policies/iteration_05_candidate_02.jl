# Two-quadrature phase-rejected target steering on a traveling bend.
# Joint state supplies gait phase; all route feedback is normalized and
# body-relative, with no clock, world route, or mutable controller state.

function target_policy_params()
    return (
        control_period=0.90,
        oscillator_amplitude=18.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        bearing_limit=1.0,
        bearing_scale=0.35,
        max_turn_rate_ratio=0.04,
        yaw_residual_ratio_limit=0.20,
        yaw_error_scale=0.04,
        phase_yaw_velocity_ratio_gain=0.145,
        phase_yaw_position_ratio_gain=0.050,
        phase_velocity_scale=0.60,
        phase_pump_acceleration=6.0,
        half_cycle_acceleration=3.0,
        steering_angle_soft_limit=36.0 * pi / 180,
        steering_speed_soft_limit=230.0 * pi / 180,
        headroom_exponent=4.0,
        acceleration_limit=30.0,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

    # Preserve the evidenced carrier and make its useful symmetric phase pump
    # explicit. Both phase coordinates come only from observed joint state.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    carrier_a1 = vdp_drive - omega^2 * q1
    phase_position = q1 / max(amp, eps(Float64))
    phase_velocity = qd1 / max(omega * amp, eps(Float64))
    phase_pump = params.phase_pump_acceleration * tanh(
        phase_velocity / params.phase_velocity_scale,
    )

    # Remove both repeatable gait-synchronous yaw quadratures before closing
    # the slow target-response loop. A velocity-only subtraction leaves the
    # residual dominated by anterior joint position in the sampled carrier.
    yaw_rate_ratio = Float64(state.heading_rate) /
        max(omega, eps(Float64))
    yaw_residual_ratio = clamp(
        yaw_rate_ratio +
        params.phase_yaw_velocity_ratio_gain * phase_velocity -
        params.phase_yaw_position_ratio_gain * phase_position,
        -params.yaw_residual_ratio_limit,
        params.yaw_residual_ratio_limit,
    )

    # Positive body-frame bearing requests negative yaw. The sampled whole-beat
    # response maps a positive half-stroke selector to negative slow yaw, so
    # residual-minus-request is the evidence-calibrated feedback sign.
    bearing = clamp(
        Float64(state.bearing),
        -params.bearing_limit,
        params.bearing_limit,
    )
    desired_yaw_ratio = -params.max_turn_rate_ratio *
        tanh(bearing / params.bearing_scale)
    turn_side = tanh(
        (yaw_residual_ratio - desired_yaw_ratio) /
        params.yaw_error_scale,
    )
    phase_side = tanh(phase_velocity / params.phase_velocity_scale)
    half_cycle_drive = 0.5 * params.half_cycle_acceleration * (
        turn_side + abs(turn_side) * phase_side
    )

    # Fade only the added pump and steering authority before sampled angle and
    # speed limits. The restoring carrier remains active at zero headroom.
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
    a1 = carrier_a1 + extra_headroom * (phase_pump + half_cycle_drive)

    # Retain the lagged posterior follower that generated the coherent
    # three-dimensional wake in the long sampled rollouts.
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
