# Sign-calibrated target curvature around the demonstrated traveling carrier.
# Beat phase remains entirely in observed joint state.

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
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

    # Preserve the zero-centered anterior oscillator that generated coherent
    # propulsion in every sampled direct-still-water rollout.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1

    # Recover the signed target angle about the head-facing (-x) body axis.
    # The adapter's scalar bearing folds a rearward target through abs(x), so
    # target_body_L is needed to retain the full quadrant after a close pass.
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

    # Sampled trajectories establish the plant sign: negative posterior mean
    # bend accompanies decreasing body angle. Applying the same sign as the
    # target residual therefore reinforced the post-crossing bearing error.
    # Negate the complete bearing/slip residual to close that loop while
    # leaving the rhythmic carrier, amplitude, and lag untouched.
    steering_residual = full_bearing -
        params.lateral_velocity_feedback * lateral_velocity
    corrective_turn = -tanh(
        steering_residual / max(params.bearing_scale, eps(Float64)),
    )
    mean_tail_tangent = params.turn_curvature_limit * corrective_turn

    carrier_tail_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(Float64))
    tail_target = mean_tail_tangent + carrier_tail_target
    a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
