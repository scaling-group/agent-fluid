# Broadside curvature-reserve policy for the moving-window lane.
# Target geometry owns turn sign and the gait envelope; a separate smooth
# body-frame gate adds bounded redirect authority before an overshoot.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        target_lateral_scale=0.30,
        turn_amplitude_relief_fraction=0.15,
        broadside_onset_fraction=0.55,
        broadside_full_fraction=0.90,
        broadside_forward_scale=0.35,
        broadside_curvature_reserve_fraction=0.20,
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
    # This adapter's body x-axis points aft, so forward target distance is the
    # negative first component (the same convention used by its bearing).
    forward_fraction = clamp(
        -Float64(state.target_body_L[1]) / distance,
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

    # The inherited miss became broadside while its route tanh was already
    # saturated and the target was still ahead.  Add a separate smooth reserve
    # directly to mean curvature instead of multiplying that saturated route
    # argument.  Target geometry still owns sign, and correcting yaw releases
    # the reserve through the same non-inverting response gate.
    broadside_span = max(
        params.broadside_full_fraction - params.broadside_onset_fraction,
        eps(params.broadside_full_fraction),
    )
    broadside_phase = clamp(
        (abs(lateral_fraction) - params.broadside_onset_fraction) /
        broadside_span,
        0.0,
        1.0,
    )
    broadside_gate = broadside_phase^2 * (3.0 - 2.0 * broadside_phase)
    target_ahead_gate = clamp(
        forward_fraction /
        max(params.broadside_forward_scale, eps(params.broadside_forward_scale)),
        0.0,
        1.0,
    )
    broadside_direction = clamp(
        lateral_fraction /
        max(abs(lateral_fraction), params.broadside_onset_fraction),
        -1.0,
        1.0,
    )
    broadside_turn = broadside_direction *
        params.broadside_curvature_reserve_fraction * broadside_gate *
        target_ahead_gate * response_gate

    # Differential mean curvature gives prompt anterior steering while the
    # larger posterior share preserves the caudal traveling-wave emphasis.
    curvature_request = turn_request + broadside_turn
    base_head_bias = -params.head_bias_limit * curvature_request
    base_tail_bias = params.tail_bias_limit * curvature_request

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
