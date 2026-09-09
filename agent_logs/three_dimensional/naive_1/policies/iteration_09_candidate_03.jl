# Envelope-projected half-cycle redirect for the moving-window lane. Target
# geometry owns turn sign; observed posterior phase allocates a bounded extra
# share of curvature to the already useful steering half-cycle.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        target_lateral_scale=0.30,
        half_cycle_gain=0.20,
        half_cycle_phase_scale=0.50,
        response_rate_scale=1.0,
        response_release_fraction=0.35,
        turn_rate_limit=2.5,
        head_bias_limit=4.0 * pi / 180,
        tail_bias_limit=10.0 * pi / 180,
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

    # A bounded body-frame direction cosine makes persistent target geometry
    # own the route sign without a world heading or a memorized path.
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

    # Differential mean curvature gives prompt anterior steering. Posterior
    # displacement relative to its mean target supplies an observable phase:
    # the target-aligned half-cycle receives a little more posterior curvature
    # and the opposing half-cycle a little less, without an external clock.
    head_bias = -params.head_bias_limit * turn_request
    base_tail_bias = params.tail_bias_limit * turn_request
    posterior_phase = (q2 - base_tail_bias) / max(
        amp * params.half_cycle_phase_scale,
        eps(amp),
    )
    half_cycle_alignment = tanh(turn_request * posterior_phase)
    half_cycle_gate = 1.0 +
        params.half_cycle_gain * half_cycle_alignment
    tail_bias = base_tail_bias * half_cycle_gate

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
