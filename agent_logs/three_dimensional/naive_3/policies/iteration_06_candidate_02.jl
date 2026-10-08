# Full-quadrant half-cycle steering around the demonstrated bearing/slip
# traveling carrier. Beat phase remains entirely in observed joint state.

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
        asymmetry_bearing_on=0.30,
        asymmetry_bearing_width=0.45,
        counterstroke_floor=0.50,
        phase_width=0.25,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

    # Preserve the demonstrated zero-centered anterior oscillator and its
    # broad-approach propulsion without a distance-dependent drive schedule.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1

    # The adapter's scalar bearing folds the rear half-plane through abs(x).
    # The normalized body-frame target vector retains full-quadrant geometry;
    # the fish's head-facing longitudinal direction is body -x.
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

    # Retain the sampled posterior mean-curvature channel. The new mechanism
    # below changes wave shape rather than increasing this static demand.
    mean_tail_tangent = params.turn_curvature_limit * turn_request
    carrier_tail_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))

    # Apply half-cycle asymmetry only after the target leaves the demonstrated
    # broad-approach angular corridor. Joint state supplies carrier phase: the
    # target-aligned tail half-cycle remains unattenuated, while only the
    # counter-turn half-cycle is smoothly reduced above a nonzero floor.
    asymmetry_fraction = clamp(
        (abs(full_bearing) - params.asymmetry_bearing_on) /
        max(params.asymmetry_bearing_width, eps(Float64)),
        0.0,
        1.0,
    )
    asymmetry_gate = asymmetry_fraction^2 *
        (3.0 - 2.0 * asymmetry_fraction)
    carrier_side = tanh(
        carrier_tail_target /
        max(params.phase_width * amp, eps(Float64)),
    )
    counterstroke = max(0.0, -turn_request * carrier_side)
    carrier_scale = 1.0 - asymmetry_gate *
        (1.0 - params.counterstroke_floor) * counterstroke

    tail_target = mean_tail_tangent + carrier_scale * carrier_tail_target
    a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
