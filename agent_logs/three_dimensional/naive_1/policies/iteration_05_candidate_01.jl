# Differential-curvature redirect with a joint-state actuator envelope.
# Target geometry still owns turn sign; the envelope only tapers acceleration
# that pushes an already-fast joint farther toward its rate limit.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        target_lateral_scale=0.30,
        response_rate_scale=1.0,
        response_release_fraction=0.35,
        turn_rate_limit=2.5,
        head_bias_limit=4.0 * pi / 180,
        tail_bias_limit=10.0 * pi / 180,
        joint_rate_limit=260.0 * pi / 180,
        joint_rate_guard_fraction=0.85,
        joint_acceleration_limit=1800.0 * pi / 180,
    )
end

function bounded_joint_acceleration(raw_acceleration, joint_rate, params)
    guard_start = params.joint_rate_guard_fraction * params.joint_rate_limit
    guard_width = max(
        params.joint_rate_limit - guard_start,
        eps(params.joint_rate_limit),
    )

    # Preserve full acceleration below the guard and full braking everywhere.
    # Only a command that increases |joint_rate| is tapered near the envelope.
    outward_guard = if raw_acceleration * joint_rate > 0
        clamp(
            (params.joint_rate_limit - abs(joint_rate)) / guard_width,
            0.0,
            1.0,
        )
    else
        1.0
    end
    guarded_acceleration = outward_guard * raw_acceleration
    return clamp(
        guarded_acceleration,
        -params.joint_acceleration_limit,
        params.joint_acceleration_limit,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Use a bounded lateral direction cosine rather than a world heading or
    # route.  Positive lateral error requires the measured negative-yaw bend.
    distance = max(Float64(state.distance_L), eps(Float64))
    lateral_fraction = clamp(
        Float64(state.target_body_L[2]) / distance,
        -1.0,
        1.0,
    )
    route_request = tanh(
        lateral_fraction /
        max(params.target_lateral_scale, eps(params.target_lateral_scale)),
    )

    # A yaw rate with sign opposite route_request is already correcting the
    # target error.  Release only a bounded fraction in that case.  Unlike the
    # sampled rate-error servo, fast yaw oscillation cannot reverse route sign.
    turn_rate = clamp(
        Float64(state.turn_rate_recent),
        -params.turn_rate_limit,
        params.turn_rate_limit,
    )
    correcting_response = clamp(
        -route_request * turn_rate /
        max(params.response_rate_scale, eps(params.response_rate_scale)),
        0.0,
        1.0,
    )
    response_gate = 1.0 -
        params.response_release_fraction * correcting_response
    turn_request = route_request * response_gate

    # Opposite-sign means use the sampled yaw allocation: the anterior bend
    # supplies prompt steering while posterior curvature preserves the
    # thrust-producing traveling wave and caudal emphasis.
    head_bias = -params.head_bias_limit * turn_request
    tail_bias = params.tail_bias_limit * turn_request

    centered_q1 = q1 - head_bias
    vdp_drive = params.oscillator_mu * (1 - (centered_q1 / amp)^2) * qd1
    raw_a1 = vdp_drive - omega^2 * centered_q1

    phase_lag_target = tail_bias - centered_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    raw_a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Shape the completed carrier/steering request rather than changing either
    # mechanism.  Braking authority is never released by the rate barrier.
    a1 = bounded_joint_acceleration(raw_a1, qd1, params)
    a2 = bounded_joint_acceleration(raw_a2, qd2, params)

    return (phi_ddot=(a1, a2),)
end
