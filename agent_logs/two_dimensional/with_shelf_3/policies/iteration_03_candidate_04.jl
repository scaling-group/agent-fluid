function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        max_turn_curvature=12.0 * pi / 180,
        bearing_scale=20.0 * pi / 180,
        anterior_bias_fraction=0.45,
        tail_closing_speed_scale=0.30,
        max_tail_wave_boost=0.12,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Convert scale-free body-frame target error to one bounded curvature
    # request. Splitting the request keeps either joint center from replacing
    # the traveling propulsive component with a large static bend.
    bearing = clamp(Float64(state.bearing), -pi / 2, pi / 2)
    turn_curvature = params.max_turn_curvature * tanh(
        bearing / max(params.bearing_scale, eps(params.bearing_scale)),
    )
    anterior_fraction = clamp(params.anterior_bias_fraction, 0.0, 1.0)
    q1_center = anterior_fraction * turn_curvature
    q2_center = (1 - anterior_fraction) * turn_curvature

    # The oscillator phase remains encoded only in observed joint state, but
    # the traveling bend now runs around the target-signed anterior center.
    q1_wave = q1 - q1_center
    vdp_drive = params.oscillator_mu * (1 - (q1_wave / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1_wave

    # A windowed loss of normalized target closure requests a small posterior-
    # only thrust response. The smoothstep gate is zero once the evidenced
    # useful closure scale is met, and it cannot alter the steering curvature.
    closing_speed = Float64(state.window_closing_speed_L)
    closing_speed = isfinite(closing_speed) ? closing_speed : 0.0
    closing_scale = max(params.tail_closing_speed_scale, eps(params.tail_closing_speed_scale))
    closing_deficit = clamp((closing_scale - closing_speed) / closing_scale, 0.0, 1.0)
    closure_gate = closing_deficit^2 * (3 - 2 * closing_deficit)
    tail_wave_gain = 1 + max(params.max_tail_wave_boost, 0.0) * closure_gate

    # Retain the seed's velocity-derived lag and apply the progress response
    # only to the zero-mean posterior wave around its curvature share.
    tail_wave_target = tail_wave_gain * (
        -q1_wave - params.tail_lag_gain * qd1 / max(omega, eps(omega))
    )
    phase_lag_target = q2_center + tail_wave_target
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
