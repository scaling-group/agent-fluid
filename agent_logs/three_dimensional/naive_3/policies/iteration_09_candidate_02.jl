# Full-quadrant posterior phase-lag steering around the demonstrated
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
        lag_modulation_bearing_on=0.30,
        lag_modulation_bearing_width=0.45,
        lag_asymmetry=0.25,
        lag_phase_angle=10.0 * pi / 180,
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
    # Recover the signed target angle around the head-facing body -x axis from
    # normalized geometry so correction remains available after a high pass.
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

    # Leave the demonstrated broad-approach carrier exactly unchanged. Large
    # full-quadrant error recruits posterior phase allocation continuously,
    # including after the target has passed behind the head.
    error_fraction = clamp(
        (abs(full_bearing) - params.lag_modulation_bearing_on) /
        max(params.lag_modulation_bearing_width, eps(Float64)),
        0.0,
        1.0,
    )
    error_gate = error_fraction^2 * (3.0 - 2.0 * error_fraction)

    # Preserve the zero-centered anterior oscillator. The sampled anterior
    # stiffness asymmetry increased effort and weakened approach, so steering
    # acts only through the timing of the posterior traveling bend.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1

    # Broad-approach measurements associate negative-q1 halves with negative
    # yaw moment and positive-q1 halves with positive yaw moment. Positive
    # turn request needs negative yaw in this convention, so extend lag on the
    # negative half; reflection reverses both signs and preserves the rule.
    phase_side = tanh(
        q1 / max(params.lag_phase_angle, eps(Float64)),
    )
    lag_scale = 1.0 - params.lag_asymmetry *
        turn_request * phase_side * error_gate
    modulated_lag_gain = params.tail_lag_gain * lag_scale

    # Retain the bounded mean-curvature/slip channel while changing only the
    # posterior phase lag. Alignment makes error_gate zero and exactly
    # restores the demonstrated carrier without a clock or mutable mode.
    mean_tail_tangent = params.turn_curvature_limit * turn_request
    carrier_tail_target = -q1 -
        modulated_lag_gain * qd1 / max(omega, eps(omega))
    tail_target = mean_tail_tangent + carrier_tail_target
    a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
