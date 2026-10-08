# Full-quadrant, error-gated redirect around the demonstrated bearing/slip
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
        redirect_bearing_on=0.50,
        redirect_bearing_width=0.40,
        redirect_head_curvature=10.0 * pi / 180,
        redirect_head_damping=0.25,
        redirect_carrier_floor=0.45,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

    # The adapter's scalar bearing folds the rear half-plane through abs(x).
    # Retain whether the target is ahead or behind by measuring its angle from
    # the head-facing (-x) body axis directly from normalized target geometry.
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

    # A smooth geometry gate is exactly zero on the demonstrated broad
    # approach. Large error trades some rhythmic authority for a temporary
    # same-sign bend at both joints; recovered alignment releases the bend.
    redirect_fraction = clamp(
        (abs(full_bearing) - params.redirect_bearing_on) /
        max(params.redirect_bearing_width, eps(Float64)),
        0.0,
        1.0,
    )
    redirect_gate = redirect_fraction^2 * (3.0 - 2.0 * redirect_fraction)
    head_center = redirect_gate * params.redirect_head_curvature * turn_request
    centered_q1 = q1 - head_center

    # Preserve the state-feedback oscillator, but damp its centered rhythmic
    # component during a redirect rather than persistently recentering it.
    vdp_drive = params.oscillator_mu *
        (1 - (centered_q1 / amp)^2) * qd1
    redirect_damping = 2 * redirect_gate *
        params.redirect_head_damping * omega * qd1
    a1 = vdp_drive - omega^2 * centered_q1 - redirect_damping

    # The original posterior mean-curvature channel retains its cap. During a
    # redirect the oscillatory lag yields authority to a distributed C-like
    # bend; it returns continuously as the full-quadrant error recovers.
    mean_tail_tangent = params.turn_curvature_limit * turn_request
    carrier_scale = 1.0 - redirect_gate *
        (1.0 - params.redirect_carrier_floor)
    carrier_tail_target = -centered_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(Float64))
    tail_target = mean_tail_tangent + carrier_scale * carrier_tail_target
    a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
