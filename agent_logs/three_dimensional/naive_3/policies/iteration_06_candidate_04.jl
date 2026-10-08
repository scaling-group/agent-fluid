# Close-pass half-cycle steering around the demonstrated bearing/slip carrier.
# Propulsive phase remains entirely in observed joint state.

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
        redirect_distance_L=5.0,
        redirect_distance_width_L=1.0,
        redirect_bearing_start=0.25,
        redirect_bearing_width=0.35,
        redirect_closing_speed_scale=0.60,
        half_cycle_phase_scale=0.35,
        opposing_half_cycle_relief=0.25,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

    # Preserve the demonstrated zero-centered anterior limit cycle. In
    # particular, the close-pass maneuver adds neither a shifted equilibrium
    # nor extra damping that could turn an active redirect into a static bend.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1

    # Recover the signed full quadrant from normalized body-frame geometry.
    # The scalar adapter bearing folds a rearward target through abs(x).
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
    mean_tail_tangent = params.turn_curvature_limit * turn_request

    # Geometry and measured closing response isolate an imminent misaligned
    # pass. The gate vanishes in broad travel, when aligned, and once distance
    # stops closing; no elapsed time or stored approach mode is required.
    raw_distance = Float64(state.distance_L)
    distance = isfinite(raw_distance) ?
        max(raw_distance, 0.0) :
        params.redirect_distance_L + params.redirect_distance_width_L
    raw_closing_speed = Float64(state.closing_speed_L)
    closing_speed = isfinite(raw_closing_speed) ?
        max(raw_closing_speed, 0.0) : 0.0

    distance_fraction = clamp(
        0.5 + 0.5 * (params.redirect_distance_L - distance) /
        max(params.redirect_distance_width_L, eps(Float64)),
        0.0,
        1.0,
    )
    distance_gate = distance_fraction^2 * (3.0 - 2.0 * distance_fraction)

    bearing_fraction = clamp(
        (abs(steering_signal) - params.redirect_bearing_start) /
        max(params.redirect_bearing_width, eps(Float64)),
        0.0,
        1.0,
    )
    bearing_gate = bearing_fraction^2 * (3.0 - 2.0 * bearing_fraction)

    closing_fraction = clamp(
        closing_speed /
        max(params.redirect_closing_speed_scale, eps(Float64)),
        0.0,
        1.0,
    )
    closing_gate = closing_fraction^2 * (3.0 - 2.0 * closing_fraction)
    redirect_gate = distance_gate * bearing_gate * closing_gate

    # Infer beat side from the same lagged joint-state carrier used for
    # propulsion. Preserve the turn-supporting half-cycle and relieve only the
    # opposing half. This retains an alternating wave and never amplifies the
    # oscillatory carrier above its demonstrated value.
    carrier_tail_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(Float64))
    phase_alignment = tanh(
        turn_request * carrier_tail_target /
        max(params.half_cycle_phase_scale * amp, eps(Float64)),
    )
    opposing_weight = 0.5 * (1.0 - phase_alignment)
    half_cycle_relief = clamp(
        params.opposing_half_cycle_relief * redirect_gate * opposing_weight,
        0.0,
        params.opposing_half_cycle_relief,
    )
    carrier_scale = 1.0 - half_cycle_relief

    tail_target = mean_tail_tangent + carrier_scale * carrier_tail_target
    a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
