# Posterior-preserving redirect/cruise policy for the moving-window lane.
# Target geometry owns turn sign and the anterior gait envelope; observed
# displacement phase carries the relieved wave into the posterior joint.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        target_lateral_scale=0.30,
        turn_amplitude_relief_fraction=0.15,
        posterior_wave_preservation_fraction=1.0,
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

    # A bounded lateral target direction cosine owns route sign; it contains
    # no world-frame heading, case identity, or memorized route.
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

    # When target lateral error is large, preserve absolute mean-curvature
    # shares while mildly reducing rhythmic amplitude. This continuously
    # prioritizes redirect authority; full cruise amplitude returns as the
    # target comes back onto the forward body axis.
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

    # The redirect schedule reduces anterior sweep, but a posteriorly
    # emphasized traveling wave remains the propulsion source. Compensate the
    # centered displacement-plus-lag component by the same bounded envelope
    # ratio; mean curvature is deliberately outside this scale. At alignment
    # the ratio is exactly one, recovering the evidenced carrier.
    envelope_ratio = amp / effective_amp
    posterior_wave_scale = 1.0 + clamp(
        params.posterior_wave_preservation_fraction,
        0.0,
        1.0,
    ) * (envelope_ratio - 1.0)
    centered_tail_wave = centered_q1 +
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    phase_lag_target = tail_bias - posterior_wave_scale * centered_tail_wave
    raw_a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Own the same hard acceleration envelope already applied by joint
    # integration. This removes unrealizable public demand without changing
    # the evidenced carrier, route feedback, or applied plant action.
    a1 = clamp(raw_a1, -params.acceleration_limit, params.acceleration_limit)
    a2 = clamp(raw_a2, -params.acceleration_limit, params.acceleration_limit)

    return (phi_ddot=(a1, a2),)
end
