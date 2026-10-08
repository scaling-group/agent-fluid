# State-feedback traveling-bend carrier with slip-unloaded steering. Small
# errors use phase-speed rectification; large errors hand off to an anterior
# mean-curvature center while the posterior joint retains a zero-mean lag.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        steering_bearing_scale=0.25,
        lateral_velocity_feedback=1.2,
        rectified_acceleration_limit=10.0,
        phase_velocity_limit=1.0,
        curvature_bearing_start=0.22,
        curvature_bearing_full=0.65,
        curvature_bias_limit=10.0 * pi / 180,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Body-frame target geometry supplies the slow route request. Positive
    # lateral velocity is already target-side motion for a positive bearing,
    # so it unloads the turn rather than allowing persistent oversteer.
    bearing = Float64(state.bearing)
    lateral_velocity = Float64(state.velocity_body_U[2])
    route_error = bearing -
        params.lateral_velocity_feedback * lateral_velocity
    turn_request = tanh(route_error / params.steering_bearing_scale)

    # A smooth geometry-only gate distinguishes small alignment corrections
    # from a persistent redirect. No clock phase or maneuver stage is needed.
    curvature_progress = clamp(
        (abs(bearing) - params.curvature_bearing_start) /
            max(
                params.curvature_bearing_full - params.curvature_bearing_start,
                eps(params.curvature_bearing_full),
            ),
        0.0,
        1.0,
    )
    curvature_gate = curvature_progress^2 * (3 - 2 * curvature_progress)

    # Large errors move the anterior oscillator's mean curvature. The Van der
    # Pol state remains the displacement from that center, so a redirect does
    # not replace the beat or require an external oscillator phase.
    curvature_center = params.curvature_bias_limit *
        curvature_gate * turn_request
    carrier_q1 = q1 - curvature_center
    vdp_drive = params.oscillator_mu *
        (1 - (carrier_q1 / amp)^2) * qd1

    # Preserve the strongest sampled policy's bounded phase-speed rectifier for
    # small errors. It hands authority to mean curvature as the gate rises,
    # avoiding two full-strength steering residuals acting at once.
    phase_speed = clamp(
        abs(qd1) / max(omega * amp, eps(omega * amp)),
        0.0,
        params.phase_velocity_limit,
    )
    half_cycle_rectification = params.rectified_acceleration_limit *
        turn_request * phase_speed * (1 - curvature_gate)

    a1 = vdp_drive - omega^2 * carrier_q1 + half_cycle_rectification

    # Remove the anterior mean from the tail target. Steering therefore stays
    # at the empirically favored anterior joint, while the tail preserves the
    # inherited zero-mean traveling-wave lag that produced a coherent wake.
    phase_lag_target = -carrier_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
