# Body-wave-compensated half-cycle redistribution policy.
# Target geometry owns turn sign, while anterior displacement removes a
# bounded beat-synchronous body-axis component before the route is requested.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        target_lateral_scale=0.30,
        target_axis_joint_gain=0.25,
        target_axis_offset_limit=7.0 * pi / 180,
        turn_amplitude_relief_fraction=0.15,
        half_cycle_relief_redistribution=0.50,
        response_rate_scale=1.0,
        response_release_fraction=0.35,
        turn_rate_limit=2.5,
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

    # The raw lateral direction cosine remains the carrier-envelope signal.
    # It contains no world-frame heading, case identity, or memorized route.
    distance = max(Float64(state.distance_L), eps(Float64))
    target_forward = Float64(state.target_body_L[1])
    target_lateral = Float64(state.target_body_L[2])
    lateral_fraction = clamp(
        target_lateral / distance,
        -1.0,
        1.0,
    )

    # First estimate the existing mean-bias center from unmodified geometry.
    # It is used only to keep steady turn curvature out of the phase signal.
    turn_rate = clamp(
        Float64(state.turn_rate_recent),
        -params.turn_rate_limit,
        params.turn_rate_limit,
    )
    raw_route_request = tanh(
        lateral_fraction /
        max(params.target_lateral_scale, eps(params.target_lateral_scale)),
    )
    raw_correcting_response = clamp(
        -raw_route_request * turn_rate /
        max(params.response_rate_scale, eps(params.response_rate_scale)),
        0.0,
        1.0,
    )
    raw_response_gate = 1.0 -
        params.response_release_fraction * raw_correcting_response
    preliminary_head_bias =
        -params.head_bias_limit * raw_route_request * raw_response_gate

    # Rigid-body heading and raw target-lateral residuals are strongly locked
    # to anterior displacement in the sampled captures. Rotate the normalized
    # target vector through a small, bounded displacement-observed offset so
    # the mean-turn request does not chase that beat-synchronous body motion.
    target_axis_offset = clamp(
        params.target_axis_joint_gain * (q1 - preliminary_head_bias),
        -params.target_axis_offset_limit,
        params.target_axis_offset_limit,
    )
    axis_cos = cos(target_axis_offset)
    axis_sin = sin(target_axis_offset)
    compensated_target_lateral =
        -axis_sin * target_forward + axis_cos * target_lateral
    compensated_lateral_fraction = clamp(
        compensated_target_lateral / distance,
        -1.0,
        1.0,
    )
    route_request = tanh(
        compensated_lateral_fraction /
        max(params.target_lateral_scale, eps(params.target_lateral_scale)),
    )

    # A yaw rate with sign opposite route_request is already correcting the
    # target error.  Release only a bounded fraction in that case.  Unlike the
    # sampled rate-error servo, fast yaw oscillation cannot reverse route sign.
    correcting_response = clamp(
        -route_request * turn_rate /
        max(params.response_rate_scale, eps(params.response_rate_scale)),
        0.0,
        1.0,
    )
    response_gate = 1.0 -
        params.response_release_fraction * correcting_response
    turn_request = route_request * response_gate

    # Differential mean curvature gives prompt anterior steering while the
    # larger posterior share preserves the caudal traveling-wave emphasis.
    base_head_bias = -params.head_bias_limit * turn_request
    base_tail_bias = params.tail_bias_limit * turn_request

    # Redistribute the same bias allocation across the observed beat. The
    # target-aligned displacement half-cycle receives slightly more steering
    # and the opposed half-cycle slightly less. The positive bounded scale
    # preserves target-owned sign and the anterior/posterior bias ratio.
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

    # Preserve the parent's geometry-owned mean relief, but redistribute it
    # between observed displacement half-cycles. The target-aligned half gets
    # less relief and the opposed half gets more. This changes neither the
    # mean-curvature shares nor the posterior lag and introduces no clock.
    mean_amplitude_relief = clamp(
        params.turn_amplitude_relief_fraction,
        0.0,
        1.0,
    ) * abs(lateral_fraction)
    relief_redistribution = clamp(
        params.half_cycle_relief_redistribution,
        0.0,
        1.0,
    )
    amplitude_relief = clamp(
        mean_amplitude_relief *
        (1.0 - relief_redistribution * phase_alignment),
        0.0,
        1.0,
    )
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
