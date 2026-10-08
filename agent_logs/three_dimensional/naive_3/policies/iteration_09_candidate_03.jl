# Full-quadrant, response-released posterior phase-lag steering around the
# demonstrated bearing/slip carrier. Joint velocity supplies observed phase.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_lag_modulation=0.30,
        tail_damping=0.65,
        turn_curvature_limit=12.0 * pi / 180,
        full_bearing_limit=pi,
        bearing_scale=0.20,
        lateral_velocity_limit=0.8,
        lateral_velocity_feedback=0.45,
        phase_error_on=0.65,
        phase_error_width=0.45,
        recent_turn_rate_limit=2.0,
        corrective_release_rate=0.50,
        phase_velocity_angle=10.0 * pi / 180,
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
    # Measure around the head-facing body -x axis so a correction remains
    # signed and available after the fish passes the target.
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

    # Preserve the zero-centered, undamped anterior carrier exactly. This
    # avoids the sampled center-shift and stiffness-asymmetry failures.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1

    # Do not disturb the demonstrated broad approach. Once full-quadrant
    # target error is large, measured recent yaw makes the phase correction
    # stronger for wrong-way response and releases it for corrective response.
    error_fraction = clamp(
        (abs(full_bearing) - params.phase_error_on) /
        max(params.phase_error_width, eps(Float64)),
        0.0,
        1.0,
    )
    error_gate = error_fraction^2 * (3.0 - 2.0 * error_fraction)

    raw_recent_turn_rate = Float64(state.turn_rate_recent)
    recent_turn_rate = isfinite(raw_recent_turn_rate) ?
        clamp(
            raw_recent_turn_rate,
            -params.recent_turn_rate_limit,
            params.recent_turn_rate_limit,
        ) : 0.0
    response_coordinate = clamp(
        0.5 + 0.5 * turn_request * recent_turn_rate /
            max(params.corrective_release_rate, eps(Float64)),
        0.0,
        1.0,
    )
    response_gate = response_coordinate^2 *
        (3.0 - 2.0 * response_coordinate)

    # The derivative quadrature reconstructs beat phase from state. Modulating
    # its coefficient advances one posterior half-stroke and delays the other,
    # adding target-signed curvature during fast motion without attenuating
    # the carrier or moving either joint equilibrium.
    phase_velocity_side = tanh(
        qd1 / max(
            omega * params.phase_velocity_angle,
            eps(Float64),
        ),
    )
    lag_shift = params.tail_lag_modulation * turn_request *
        phase_velocity_side * error_gate * response_gate
    effective_tail_lag = params.tail_lag_gain - lag_shift

    # Retain the demonstrated posterior mean-curvature channel. The new test
    # changes coordinated wave timing rather than another scalar carrier gain.
    mean_tail_tangent = params.turn_curvature_limit * turn_request
    carrier_tail_target = -q1 -
        effective_tail_lag * qd1 / max(omega, eps(omega))
    tail_target = mean_tail_tangent + carrier_tail_target
    a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
