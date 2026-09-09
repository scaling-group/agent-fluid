# Bearing-progress-qualified redirect for the moving-window lane. Target
# geometry owns turn sign and gait scheduling; observed displacement phase
# redistributes bounded curvature without a clock or velocity-led phase.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        target_lateral_scale=0.30,
        turn_amplitude_relief_fraction=0.15,
        bearing_progress_rate_scale=1.0,
        response_release_fraction=0.35,
        head_bias_limit=4.0 * pi / 180,
        tail_bias_limit=10.0 * pi / 180,
        half_cycle_steering_fraction=0.20,
        acceleration_limit=1800.0 * pi / 180,
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

    # Release curvature only while the persistent body-frame target bearing is
    # moving toward center. Body rotation alone is not route progress, and the
    # response gate can reduce but never reverse geometry-owned curvature.
    bearing_progress_rate = -route_request *
        Float64(state.bearing_window_rate)
    correcting_response = clamp(
        bearing_progress_rate /
        max(
            params.bearing_progress_rate_scale,
            eps(params.bearing_progress_rate_scale),
        ),
        0.0,
        1.0,
    )
    response_gate = 1.0 -
        params.response_release_fraction * correcting_response
    turn_request = route_request * response_gate

    # Opposite-sign means use the sampled yaw allocation: the anterior bend
    # supplies prompt steering while posterior curvature preserves the
    # thrust-producing traveling wave and caudal emphasis.
    base_head_bias = -params.head_bias_limit * turn_request
    base_tail_bias = params.tail_bias_limit * turn_request

    # Infer the current displacement half-cycle from joint state, not a clock.
    # A positive bounded scale shifts steering toward the requested bend side
    # without reversing target-owned sign or changing the bias allocation.
    base_centered_q1 = q1 - base_head_bias
    desired_bend_side = sign(base_head_bias)
    phase_alignment = clamp(
        desired_bend_side * base_centered_q1 / max(amp, eps(amp)),
        -1.0,
        1.0,
    )
    half_cycle_fraction = clamp(
        params.half_cycle_steering_fraction,
        0.0,
        1.0,
    )
    phase_steering_scale = 1.0 + half_cycle_fraction * phase_alignment
    head_bias = base_head_bias * phase_steering_scale
    tail_bias = base_tail_bias * phase_steering_scale

    # Preserve absolute curvature shares while mildly reducing the rhythmic
    # envelope during large target misalignment. The full captured carrier
    # returns continuously as the target comes back onto the forward axis.
    amplitude_relief = clamp(
        params.turn_amplitude_relief_fraction,
        0.0,
        1.0,
    ) * abs(lateral_fraction)
    effective_amp = max(amp * (1.0 - amplitude_relief), eps(amp))

    centered_q1 = q1 - head_bias
    vdp_drive = params.oscillator_mu *
        (1 - (centered_q1 / effective_amp)^2) * qd1
    raw_a1 = vdp_drive - omega^2 * centered_q1

    phase_lag_target = tail_bias - centered_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    raw_a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    # The episode already applies this exact projection before integrating the
    # joints. Owning it here removes out-of-envelope public commands without
    # the rate-dependent phase distortion that failed in inherited rollouts.
    a1 = clamp(raw_a1, -params.acceleration_limit, params.acceleration_limit)
    a2 = clamp(raw_a2, -params.acceleration_limit, params.acceleration_limit)

    return (phi_ddot=(a1, a2),)
end
