# Distance-and-alignment posterior allocation around the strongest sampled
# bearing/slip carrier. Joint state remains the only source of beat phase.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        turn_curvature_limit=12.0 * pi / 180,
        bearing_limit=pi / 2,
        bearing_scale=0.20,
        lateral_velocity_limit=0.8,
        lateral_velocity_feedback=0.45,
        approach_distance_L=5.0,
        approach_distance_width_L=1.0,
        approach_bearing_scale=0.45,
        approach_tail_relief=0.65,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

    # Preserve the demonstrated zero-centered anterior oscillator.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1

    raw_bearing = Float64(state.bearing)
    raw_lateral_velocity = Float64(state.velocity_body_U[2])
    bearing = isfinite(raw_bearing) ?
        clamp(raw_bearing, -params.bearing_limit, params.bearing_limit) : 0.0
    lateral_velocity = isfinite(raw_lateral_velocity) ?
        clamp(
            raw_lateral_velocity,
            -params.lateral_velocity_limit,
            params.lateral_velocity_limit,
        ) : 0.0

    # Body-frame target error requests mean curvature; lateral motion releases
    # that request when it is already target-directed and strengthens it when
    # the body is slipping across the desired course.
    steering_signal = bearing -
        params.lateral_velocity_feedback * lateral_velocity
    mean_tail_tangent = params.turn_curvature_limit * tanh(
        steering_signal / max(params.bearing_scale, eps(Float64)),
    )

    # The best sampled trajectory makes useful progress until it enters the
    # middle approach with a large bearing error, where the posterior channel
    # is already limit-heavy. Smoothly reduce only the oscillatory tail share
    # in that joint condition. Far away or aligned, this multiplier tends to
    # one and exactly recovers the sampled carrier; it never boosts a peak.
    raw_distance_L = Float64(state.distance_L)
    proximity = isfinite(raw_distance_L) ?
        0.5 * (1 + tanh(
            (params.approach_distance_L - max(raw_distance_L, 0.0)) /
            max(params.approach_distance_width_L, eps(Float64)),
        )) : 0.0
    misalignment = tanh(
        abs(bearing) / max(params.approach_bearing_scale, eps(Float64)),
    )^2
    tail_relief = clamp(
        params.approach_tail_relief * proximity * misalignment,
        0.0,
        params.approach_tail_relief,
    )
    carrier_multiplier = 1.0 - tail_relief

    carrier_tail_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    phase_lag_target = mean_tail_tangent +
        carrier_multiplier * carrier_tail_target
    a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
