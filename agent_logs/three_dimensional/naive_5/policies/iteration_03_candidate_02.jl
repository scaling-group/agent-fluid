# Slip-corrected anterior half-cycle steering on a traveling bend.
# Oscillator phase remains encoded in joint state; normalized body-frame
# feedback selects the steering stroke without a clock or memorized route.

function target_policy_params()
    return (
        control_period=0.90,
        oscillator_amplitude=18.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        bearing_limit=1.25,
        bearing_scale=0.35,
        lateral_speed_scale=0.25,
        lateral_course_gain=0.30,
        turn_direction_scale=0.10,
        half_cycle_velocity_scale=0.60,
        half_cycle_acceleration=6.0,
        steering_soft_angle=36.0 * pi / 180,
        steering_soft_speed=220.0 * pi / 180,
        tail_target_limit=36.0 * pi / 180,
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

    # Keep the sampled carrier; phase lives in observed joint state.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    carrier_a1 = vdp_drive - omega^2 * q1

    # Positive bearing requests negative yaw. Positive body-frame lateral
    # speed is the upward-slip signature in the parent rollout and requests the
    # opposite, positive-yaw correction before bearing grows large.
    bearing = clamp(
        Float64(state.bearing),
        -params.bearing_limit,
        params.bearing_limit,
    )
    lateral_speed = tanh(
        Float64(state.velocity_body_U[2]) / params.lateral_speed_scale,
    )
    course_request = -bearing + params.lateral_course_gain * lateral_speed
    turn_direction = tanh(course_request / params.turn_direction_scale)
    turn_strength = tanh(abs(course_request) / params.bearing_scale)

    # Reinforce only the half-stroke moving toward the requested turn side.
    # Unlike instantaneous yaw-rate tracking, the course request does not
    # switch merely because yaw oscillates inside one tail beat.
    phase_velocity = tanh(
        qd1 / (
            max(omega * amp, eps(omega)) *
            params.half_cycle_velocity_scale
        ),
    )
    compatible_half_cycle = 0.5 * (1 + turn_direction * phase_velocity)

    # Withdraw added steering before it can create the parent's persistent
    # angle/speed clipping.  The margins are normalized by the nominal
    # oscillator amplitude and speed, so they remain joint-state feedback.
    angle_margin_scale = max(
        params.steering_soft_angle - amp,
        eps(amp),
    )
    speed_margin_scale = max(
        params.steering_soft_speed - omega * amp,
        eps(omega),
    )
    angle_authority = clamp(
        (params.steering_soft_angle - abs(q1)) / angle_margin_scale,
        0.0,
        1.0,
    )
    speed_authority = clamp(
        (params.steering_soft_speed - abs(qd1)) / speed_margin_scale,
        0.0,
        1.0,
    )
    steering_authority = min(angle_authority, speed_authority)
    half_cycle_drive = params.half_cycle_acceleration * turn_direction *
        turn_strength * compatible_half_cycle * steering_authority
    a1 = carrier_a1 + half_cycle_drive

    # Posterior propulsion remains a lagged follower of the asymmetric wave.
    # Smooth target limiting keeps that lag from converting a fast anterior
    # stroke into a persistent posterior angle-limit contact.
    raw_phase_lag_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    phase_lag_target = params.tail_target_limit * tanh(
        raw_phase_lag_target / params.tail_target_limit,
    )
    a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    limit = params.acceleration_limit
    return (
        phi_ddot=(
            clamp(a1, -limit, limit),
            clamp(a2, -limit, limit),
        ),
    )
end
