# Response-gated posterior wave-shape redirect around the demonstrated
# bearing/slip traveling carrier. Beat phase remains entirely in joint state.

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
        redirect_bearing_on=0.30,
        redirect_bearing_width=0.50,
        redirect_heading_rate_scale=0.75,
        redirect_phase_scale=0.55,
        redirect_phase_blend=0.15,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

    # Preserve the evidenced zero-centered anterior limit cycle exactly. The
    # redirect introduces neither a shifted equilibrium nor extra damping.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1

    # Recover target direction over the full body-frame quadrant. The scalar
    # adapter bearing folds a target behind the head into the forward half.
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

    # A large full-quadrant error requests a redirect. Smoothly release it once
    # measured yaw has the target-directed sign: positive body-frame bearing
    # corresponds to decreasing inertial heading in this head-facing frame.
    error_fraction = clamp(
        (abs(full_bearing) - params.redirect_bearing_on) /
        max(params.redirect_bearing_width, eps(Float64)),
        0.0,
        1.0,
    )
    error_gate = error_fraction^2 * (3.0 - 2.0 * error_fraction)

    raw_heading_rate = Float64(state.heading_rate)
    heading_rate = isfinite(raw_heading_rate) ? raw_heading_rate : 0.0
    response_fraction = clamp(
        -turn_request * heading_rate /
        max(params.redirect_heading_rate_scale, eps(Float64)),
        0.0,
        1.0,
    )
    response_gate = response_fraction^2 * (3.0 - 2.0 * response_fraction)
    unresolved_gate = error_gate * (1.0 - response_gate)

    # Only the target-supporting anterior half-cycle is reshaped. Blending the
    # posterior target toward q1 creates a transient same-sign C-like bend;
    # the opposing half and small-error travel retain the full lagged carrier.
    target_side_fraction = clamp(
        turn_request * q1 /
        max(params.redirect_phase_scale * amp, eps(Float64)),
        0.0,
        1.0,
    )
    target_side_gate = target_side_fraction^2 *
        (3.0 - 2.0 * target_side_fraction)
    phase_blend = clamp(
        params.redirect_phase_blend * unresolved_gate * target_side_gate,
        0.0,
        params.redirect_phase_blend,
    )

    carrier_tail_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    modulated_tail_target =
        (1.0 - phase_blend) * carrier_tail_target + phase_blend * q1
    tail_target = mean_tail_tangent + modulated_tail_target
    a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
