# Full-quadrant, response-released half-cycle redirect around the demonstrated
# bearing/slip traveling carrier. Beat phase remains in observed joint state.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        turn_curvature_limit=12.0 * pi / 180,
        full_bearing_limit=pi,
        bearing_scale=0.20,
        lateral_velocity_limit=0.8,
        lateral_velocity_feedback=0.45,
        redirect_bearing_on=0.35,
        redirect_bearing_width=0.45,
        heading_rate_limit=4.0,
        response_rate_scale=0.25,
        phase_velocity_weight=0.5,
        phase_transition=0.30,
        redirect_head_curvature=8.0 * pi / 180,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

    # The scalar adapter bearing folds the rear half-plane through abs(x).
    # Recover the signed angle about the head-facing body -x axis so steering
    # remains available after the target moves behind the fish.
    target_x = Float64(state.target_body_L[1])
    target_y = Float64(state.target_body_L[2])
    raw_folded_bearing = Float64(state.bearing)
    fallback_bearing = isfinite(raw_folded_bearing) ?
        raw_folded_bearing : 0.0
    raw_full_bearing = isfinite(target_x) && isfinite(target_y) ?
        atan(target_y, -target_x) : fallback_bearing
    full_bearing = clamp(
        raw_full_bearing,
        -params.full_bearing_limit,
        params.full_bearing_limit,
    )

    raw_lateral_velocity = Float64(state.velocity_body_U[2])
    lateral_velocity = isfinite(raw_lateral_velocity) ?
        clamp(
            raw_lateral_velocity,
            -params.lateral_velocity_limit,
            params.lateral_velocity_limit,
        ) : 0.0
    steering_signal = full_bearing -
        params.lateral_velocity_feedback * lateral_velocity
    turn_request = tanh(
        steering_signal / max(params.bearing_scale, eps(Float64)),
    )

    error_fraction = clamp(
        (abs(full_bearing) - params.redirect_bearing_on) /
        max(params.redirect_bearing_width, eps(Float64)),
        0.0,
        1.0,
    )
    error_gate = error_fraction^2 * (3.0 - 2.0 * error_fraction)

    # Positive turn request requires negative yaw in this convention. Thus a
    # positive product is wrong-way yaw and a negative product is corrective.
    # Unlike the inherited positive-only gate, this sigmoid retains half its
    # authority at stalled yaw and releases only after a corrective response.
    raw_heading_rate = Float64(state.heading_rate)
    heading_rate = isfinite(raw_heading_rate) ?
        clamp(
            raw_heading_rate,
            -params.heading_rate_limit,
            params.heading_rate_limit,
        ) : 0.0
    response_alignment = turn_request * heading_rate
    response_gate = 0.5 * (1.0 + tanh(
        response_alignment /
        max(params.response_rate_scale, eps(Float64)),
    ))
    redirect_gate = error_gate * response_gate

    # Predict the current bend side from joint state alone. The smooth selector
    # is reflection invariant: reflecting q, qdot, and the target changes the
    # acceleration sign but not which relative half-cycle is recruited.
    phase_coordinate = (
        q1 + params.phase_velocity_weight * qd1 /
        max(omega, eps(omega))
    ) / max(amp, eps(Float64))
    turn_side_half_cycle = 0.5 * (1.0 + tanh(
        turn_request * phase_coordinate /
        max(params.phase_transition, eps(Float64)),
    ))

    # Keep the carrier oscillator zero-centered. A bounded reference acts only
    # on the turn-side half-cycle, so stalled joints are actively restarted
    # instead of being captured by a moving equilibrium.
    half_cycle_reference = params.redirect_head_curvature * turn_request *
        redirect_gate * turn_side_half_cycle
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * (q1 - half_cycle_reference)

    # Preserve posterior lag and the demonstrated mean-curvature request. The
    # asymmetric anterior stroke propagates through this unchanged carrier;
    # no additional tail drive or carrier attenuation is introduced.
    mean_tail_tangent = params.turn_curvature_limit * turn_request
    carrier_tail_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    tail_target = mean_tail_tangent + carrier_tail_target
    a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
