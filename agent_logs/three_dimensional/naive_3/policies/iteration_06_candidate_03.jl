# Full-quadrant, phase-aware lag steering around the demonstrated
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
        phase_redirect_on=0.20,
        phase_redirect_width=0.45,
        phase_velocity_scale=0.35,
        phase_lag_asymmetry=0.30,
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

    # A smooth response gate leaves the demonstrated broad carrier unchanged.
    # Unlike a distance schedule, body-frame slip can recruit correction
    # before the high pass even while the target angle itself is still small.
    redirect_fraction = clamp(
        (abs(steering_signal) - params.phase_redirect_on) /
        max(params.phase_redirect_width, eps(Float64)),
        0.0,
        1.0,
    )
    redirect_gate = redirect_fraction^2 * (3.0 - 2.0 * redirect_fraction)

    # Preserve the zero-centered oscillator exactly; the inherited gated
    # C-bend settled at its shifted equilibrium and left the fish coasting.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1

    # Modulate posterior lag by the observed anterior velocity half-cycle.
    # For a requested turn, lag grows on the same-sign tail stroke and shrinks
    # on the opposing stroke. The bounded modulation is reflection-equivariant
    # and cannot suppress either half-cycle or create a static posture.
    normalized_phase_velocity = qd1 / max(omega * amp, eps(Float64))
    phase_side = tanh(
        normalized_phase_velocity /
        max(params.phase_velocity_scale, eps(Float64)),
    )
    modulated_lag_gain = params.tail_lag_gain -
        redirect_gate * params.phase_lag_asymmetry *
        turn_request * phase_side

    # Retain the demonstrated bounded mean-turn channel. Full-quadrant target
    # geometry keeps its sign after the head passes the target.
    mean_tail_tangent = params.turn_curvature_limit * turn_request
    carrier_tail_target = -q1 -
        modulated_lag_gain * qd1 / max(omega, eps(Float64))
    tail_target = mean_tail_tangent + carrier_tail_target
    a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
