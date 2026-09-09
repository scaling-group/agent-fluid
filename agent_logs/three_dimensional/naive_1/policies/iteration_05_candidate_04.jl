# Actuator-aware differential-curvature redirect for the moving-window lane.
# Target geometry owns turn sign; joint-rate feedback relieves only acceleration
# that would drive an already-fast joint farther into its velocity envelope.

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
        rate_guard_start_fraction=0.80,
        acceleration_limit=1800.0 * pi / 180,
    )
end

function rate_guarded_acceleration(raw_acceleration, joint_rate, params)
    rate_limit = max(params.joint_rate_limit, eps(params.joint_rate_limit))
    guard_start = clamp(params.rate_guard_start_fraction, 0.0, 1.0) * rate_limit
    guard_width = max(rate_limit - guard_start, eps(rate_limit))

    # Preserve braking and phase reversal.  Only same-sign acceleration is
    # released as measured rate enters the top of its admissible envelope.
    outward_gate = clamp(
        (rate_limit - abs(joint_rate)) / guard_width,
        0.0,
        1.0,
    )
    guarded = raw_acceleration * joint_rate > 0.0 ?
        outward_gate * raw_acceleration : raw_acceleration
    return clamp(
        guarded,
        -params.acceleration_limit,
        params.acceleration_limit,
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

    a1 = rate_guarded_acceleration(raw_a1, qd1, params)
    a2 = rate_guarded_acceleration(raw_a2, qd2, params)

    return (phi_ddot=(a1, a2),)
end
