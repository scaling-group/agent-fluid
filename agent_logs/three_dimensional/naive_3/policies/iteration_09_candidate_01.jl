# Full-quadrant, phase-referenced target-yaw servo around the demonstrated
# bearing/slip traveling carrier. Joint state remains the only carrier phase.

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
        phase_yaw_rate_gain1=0.75,
        phase_yaw_rate_gain2=0.15,
        phase_yaw_rate_limit=1.0,
        target_yaw_rate=0.18,
        yaw_rate_error_scale=0.20,
        yaw_rate_curvature_limit=6.0 * pi / 180,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

    # Preserve rear-half-plane information that the scalar bearing folds
    # through abs(x). The angle is measured about the head-facing body -x axis.
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

    # The sampled carrier's raw body yaw is dominated by repeatable reaction
    # to joint rates. Remove that observed phase component before comparing
    # body response with a small target-relative desired yaw rate. Positive
    # turn request requires negative yaw in this body convention.
    raw_heading_rate = Float64(state.heading_rate)
    heading_rate = isfinite(raw_heading_rate) ? raw_heading_rate : 0.0
    phase_referenced_yaw_rate = clamp(
        heading_rate +
            params.phase_yaw_rate_gain1 * qd1 +
            params.phase_yaw_rate_gain2 * qd2,
        -params.phase_yaw_rate_limit,
        params.phase_yaw_rate_limit,
    )
    desired_yaw_rate = -params.target_yaw_rate * turn_request
    yaw_rate_error = phase_referenced_yaw_rate - desired_yaw_rate
    yaw_rate_correction = tanh(
        yaw_rate_error / max(params.yaw_rate_error_scale, eps(Float64)),
    )

    # Keep the zero-centered anterior oscillator and the full posterior
    # carrier. The new bounded residual changes posterior mean curvature only;
    # it remains active at stalled yaw and reverses with target geometry.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1

    mean_tail_tangent =
        params.turn_curvature_limit * turn_request +
        params.yaw_rate_curvature_limit * yaw_rate_correction
    carrier_tail_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    tail_target = mean_tail_tangent + carrier_tail_target
    a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
