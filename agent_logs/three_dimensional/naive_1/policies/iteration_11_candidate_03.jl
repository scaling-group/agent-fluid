# Posterior-half-cycle differential-curvature redirect for the moving-window
# lane. Target geometry owns turn sign; observed caudal joint phase
# redistributes only the posterior steering share of the traveling carrier.

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

    # A normalized body-frame direction cosine owns route sign and magnitude;
    # no instantaneous velocity residual can add to or subtract from it.
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

    # Differential mean curvature gives prompt anterior steering while its
    # larger posterior share preserves the caudal traveling-wave emphasis.
    base_head_bias = -params.head_bias_limit * turn_request
    base_tail_bias = params.tail_bias_limit * turn_request

    # Keep anterior route authority steady. Redistribute only posterior bias
    # across observed caudal displacement: the target-aligned half-cycle gets
    # more and the opposed half-cycle less. The scale remains positive, so it
    # cannot invert the target-owned sign or create a clocked control mode.
    head_bias = base_head_bias
    base_centered_q2 = q2 - base_tail_bias
    desired_tail_side = sign(base_tail_bias)
    phase_alignment = clamp(
        desired_tail_side * base_centered_q2 / max(amp, eps(amp)),
        -1.0,
        1.0,
    )
    half_cycle_fraction = clamp(
        params.half_cycle_steering_fraction,
        0.0,
        1.0,
    )
    phase_steering_scale = 1.0 + half_cycle_fraction * phase_alignment
    tail_bias = base_tail_bias * phase_steering_scale

    centered_q1 = q1 - head_bias
    vdp_drive = params.oscillator_mu * (1 - (centered_q1 / amp)^2) * qd1
    raw_a1 = vdp_drive - omega^2 * centered_q1

    phase_lag_target = tail_bias - centered_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    raw_a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Own the same hard acceleration envelope already applied by joint
    # integration. This removes unrealizable public demand without changing
    # the evidenced carrier, route feedback, or applied plant action.
    a1 = clamp(raw_a1, -params.acceleration_limit, params.acceleration_limit)
    a2 = clamp(raw_a2, -params.acceleration_limit, params.acceleration_limit)

    return (phi_ddot=(a1, a2),)
end
