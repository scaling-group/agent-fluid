# Full-quadrant, response-gated posterior half-cycle allocation around the
# demonstrated bearing/slip carrier. Beat phase remains in observed joint state.

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
        phase_bearing_on=0.35,
        phase_bearing_width=0.45,
        heading_rate_limit=4.0,
        wrong_way_rate_scale=0.75,
        tail_counterstroke_relief=0.55,
        moment_phase_angle=10.0 * pi / 180,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

    # Preserve the zero-centered anterior carrier exactly. The sampled
    # anterior stiffness and head-center edits weakened propulsion or settled
    # into held bends, so cyclic steering is confined to the posterior wave.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1

    # The adapter's scalar bearing folds the rear half-plane through abs(x).
    # Recover a signed angle around the head-facing body -x axis directly from
    # normalized target geometry so feedback remains valid after a high pass.
    raw_target_x = Float64(state.target_body_L[1])
    raw_target_y = Float64(state.target_body_L[2])
    raw_folded_bearing = Float64(state.bearing)
    target_x = isfinite(raw_target_x) ? raw_target_x : -1.0
    target_y = isfinite(raw_target_y) ? raw_target_y : 0.0
    fallback_bearing = isfinite(raw_folded_bearing) ?
        raw_folded_bearing : 0.0
    raw_full_bearing = isfinite(raw_target_x) && isfinite(raw_target_y) ?
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

    # Large angular error alone must not disturb the evidenced approach. The
    # cyclic allocation is recruited only while yaw moves opposite the request:
    # positive request requires negative yaw in this body convention.
    error_fraction = clamp(
        (abs(full_bearing) - params.phase_bearing_on) /
        max(params.phase_bearing_width, eps(Float64)),
        0.0,
        1.0,
    )
    error_gate = error_fraction^2 * (3.0 - 2.0 * error_fraction)
    raw_heading_rate = Float64(state.heading_rate)
    heading_rate = isfinite(raw_heading_rate) ?
        clamp(
            raw_heading_rate,
            -params.heading_rate_limit,
            params.heading_rate_limit,
        ) : 0.0
    wrong_way_rate = max(0.0, turn_request * heading_rate)
    response_fraction = clamp(
        wrong_way_rate / max(params.wrong_way_rate_scale, eps(Float64)),
        0.0,
        1.0,
    )
    response_gate = response_fraction^2 *
        (3.0 - 2.0 * response_fraction)

    # Sampled 4--12T traces associate yaw-moment sign with q1 sign. Required
    # yaw has sign -turn_request, so q1 halves with sign turn_request are the
    # measured counter-moment halves. Reduce only their posterior carrier
    # work; the opposite, useful half remains at full amplitude.
    phase_side = tanh(
        q1 / max(params.moment_phase_angle, eps(Float64)),
    )
    counter_moment_phase = clamp(
        turn_request * phase_side,
        0.0,
        1.0,
    )
    relief_gate = error_gate * response_gate * counter_moment_phase
    carrier_scale = 1.0 -
        params.tail_counterstroke_relief * relief_gate

    # Retain the bounded mean-curvature/slip channel and original posterior
    # phase lag. Correct-sign yaw or alignment makes the modulation vanish and
    # restores the demonstrated symmetric traveling bend continuously.
    mean_tail_tangent = params.turn_curvature_limit * turn_request
    carrier_tail_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    tail_target = mean_tail_tangent + carrier_scale * carrier_tail_target
    a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
