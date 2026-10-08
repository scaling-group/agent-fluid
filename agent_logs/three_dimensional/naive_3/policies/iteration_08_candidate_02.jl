# Full-quadrant anterior half-cycle dwell around the evidenced bearing/slip
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
        redirect_bearing_on=0.25,
        redirect_bearing_width=0.45,
        redirect_phase_scale=0.35,
        supporting_half_cycle_relief=0.25,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

    # Recover signed target direction around the head-facing body -x axis.
    # The scalar adapter bearing folds the rear half-plane through abs(x), so
    # normalized target geometry is required to keep steering valid after a
    # high pass.
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

    # Material full-quadrant error recruits a duty-like anterior asymmetry.
    # Alignment is the only release signal, avoiding beat-scale yaw-rate
    # reversals and any hidden maneuver state.
    error_fraction = clamp(
        (abs(full_bearing) - params.redirect_bearing_on) /
        max(params.redirect_bearing_width, eps(Float64)),
        0.0,
        1.0,
    )
    error_gate = error_fraction^2 * (3.0 - 2.0 * error_fraction)

    # The requested-side half-cycle receives less restoring stiffness and
    # therefore more dwell, while the opposite half-cycle remains nominal.
    # Restoring acceleration is never amplified, q1=0 remains the sole
    # equilibrium, and Van der Pol anti-damping keeps that equilibrium
    # unstable so the redirect cannot become a static C-posture.
    phase_alignment = tanh(
        turn_request * q1 /
        max(params.redirect_phase_scale * amp, eps(Float64)),
    )
    supporting_weight = 0.5 * (1.0 + phase_alignment)
    stiffness_relief = clamp(
        params.supporting_half_cycle_relief * error_gate * supporting_weight,
        0.0,
        params.supporting_half_cycle_relief,
    )
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * (1.0 - stiffness_relief) * q1

    # Preserve the posterior mean-curvature channel and full lagged carrier.
    # The anterior dwell is propagated through this unchanged traveling-wave
    # relation instead of attenuating or recentering the tail.
    mean_tail_tangent = params.turn_curvature_limit * turn_request
    carrier_tail_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    tail_target = mean_tail_tangent + carrier_tail_target
    a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
