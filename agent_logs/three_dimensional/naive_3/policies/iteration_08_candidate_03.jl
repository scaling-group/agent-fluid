# Full-quadrant anterior half-cycle steering around the demonstrated
# bearing/slip traveling carrier. Joint state is the only source of beat phase.

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
        half_cycle_bearing_on=0.25,
        half_cycle_bearing_width=0.35,
        half_cycle_stiffness_asymmetry=0.30,
        half_cycle_phase_angle=8.0 * pi / 180,
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

    # Preserve the zero-centered Van der Pol carrier. Once target error leaves
    # the broad-approach band, observed anterior angle identifies the beat
    # side. Relax restoring stiffness on the requested side and strengthen it
    # on the counter side without creating a static oscillator center.
    error_fraction = clamp(
        (abs(full_bearing) - params.half_cycle_bearing_on) /
        max(params.half_cycle_bearing_width, eps(Float64)),
        0.0,
        1.0,
    )
    error_gate = error_fraction^2 * (3.0 - 2.0 * error_fraction)
    phase_side = tanh(
        q1 / max(params.half_cycle_phase_angle, eps(Float64)),
    )
    stiffness_scale = 1.0 - params.half_cycle_stiffness_asymmetry *
        turn_request * phase_side * error_gate

    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * stiffness_scale * q1

    # Retain the demonstrated posterior mean-curvature channel and lagged
    # carrier. The posterior target follows the phase-shaped anterior stroke,
    # producing a traveling corrective bend instead of a held C-shape.
    mean_tail_tangent = params.turn_curvature_limit * turn_request
    carrier_tail_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    tail_target = mean_tail_tangent + carrier_tail_target
    a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
