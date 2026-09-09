# Phase-qualified terminal lateral-velocity redirect for the moving-window
# lane. Target geometry owns turn sign; anterior joint state protects the
# useful steering half-cycle while preserving the projected propulsive carrier.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        target_lateral_scale=0.30,
        lateral_velocity_scale=0.35,
        lateral_velocity_lead_gain=0.12,
        lateral_velocity_activation_distance_L=2.5,
        lateral_velocity_full_distance_L=1.5,
        useful_halfcycle_protection=0.50,
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

    # Target side remains the sole route authority. In the terminal regime,
    # motion toward that side may release curvature but can never invert it.
    distance = max(Float64(state.distance_L), eps(Float64))
    lateral_fraction = clamp(
        Float64(state.target_body_L[2]) / distance,
        -1.0,
        1.0,
    )
    target_side = sign(lateral_fraction)
    lateral_velocity = clamp(
        Float64(state.velocity_body_U[2]),
        -1.0,
        1.0,
    )
    toward_lateral_speed = target_side * lateral_velocity
    approach_width = max(
        params.lateral_velocity_activation_distance_L -
        params.lateral_velocity_full_distance_L,
        eps(params.lateral_velocity_activation_distance_L),
    )
    approach_gate = clamp(
        (params.lateral_velocity_activation_distance_L - distance) /
        approach_width,
        0.0,
        1.0,
    )

    # The requested anterior mean bend has sign opposite target_side. Protect
    # that useful half-cycle from beat-scale slip release, while allowing the
    # full evidenced release on the counter-turn half-cycle. Joint state, not
    # time, supplies oscillator phase.
    useful_bend_fraction = clamp(
        -target_side * q1 / max(amp, eps(amp)),
        0.0,
        1.0,
    )
    phase_release_gate = 1.0 -
        params.useful_halfcycle_protection * useful_bend_fraction
    lead_correction = approach_gate * phase_release_gate *
        params.lateral_velocity_lead_gain * tanh(
            toward_lateral_speed /
            max(params.lateral_velocity_scale, eps(params.lateral_velocity_scale)),
        )
    steering_fraction = clamp(
        abs(lateral_fraction) - lead_correction,
        0.0,
        1.0,
    )
    route_request = target_side * tanh(
        steering_fraction /
        max(params.target_lateral_scale, eps(params.target_lateral_scale)),
    )

    # Correctly signed measured yaw may release a bounded share of curvature,
    # but neither yaw nor terminal slip may reverse the geometry-owned route.
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
    head_bias = -params.head_bias_limit * turn_request
    tail_bias = params.tail_bias_limit * turn_request

    centered_q1 = q1 - head_bias
    vdp_drive = params.oscillator_mu * (1 - (centered_q1 / amp)^2) * qd1
    raw_a1 = vdp_drive - omega^2 * centered_q1

    phase_lag_target = tail_bias - centered_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    raw_a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Own the plant's existing hard acceleration envelope without adding the
    # rate-dependent phase distortion that failed in inherited evaluations.
    a1 = clamp(raw_a1, -params.acceleration_limit, params.acceleration_limit)
    a2 = clamp(raw_a2, -params.acceleration_limit, params.acceleration_limit)

    return (phi_ddot=(a1, a2),)
end
