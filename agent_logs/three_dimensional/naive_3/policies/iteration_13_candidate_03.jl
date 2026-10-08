# Full-quadrant carrier with a receding-gated anterior counterstroke brake.
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
        radial_velocity_limit=1.5,
        recovery_bearing_on=0.75,
        recovery_bearing_width=0.45,
        receding_speed_scale=0.25,
        counterstroke_rate_scale=1.5,
        counterstroke_center_width=16.0 * pi / 180,
        counterstroke_damping=0.12,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

    # Recover a signed full-quadrant angle around the head-facing body -x
    # axis. The adapter's scalar bearing folds the rear half-plane, so it is
    # retained only as a finite fallback for invalid target geometry.
    raw_target_x = Float64(state.target_body_L[1])
    raw_target_y = Float64(state.target_body_L[2])
    raw_folded_bearing = Float64(state.bearing)
    target_x = isfinite(raw_target_x) ? raw_target_x : -1.0
    target_y = isfinite(raw_target_y) ? raw_target_y : 0.0
    fallback_bearing = isfinite(raw_folded_bearing) ?
        raw_folded_bearing : 0.0
    raw_full_bearing = isfinite(raw_target_x) && isfinite(raw_target_y) ?
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

    # Body-frame radial closing separates the demonstrated broad approach
    # from the post-pass escape. Positive projection is target-closing; only
    # bounded negative projection can recruit cyclic recovery work.
    raw_forward_velocity = Float64(state.velocity_body_U[1])
    forward_velocity = isfinite(raw_forward_velocity) ?
        clamp(
            raw_forward_velocity,
            -params.radial_velocity_limit,
            params.radial_velocity_limit,
        ) : 0.0
    radial_lateral_velocity = isfinite(raw_lateral_velocity) ?
        clamp(
            raw_lateral_velocity,
            -params.radial_velocity_limit,
            params.radial_velocity_limit,
        ) : 0.0
    target_distance = hypot(target_x, target_y)
    radial_closing = target_distance > eps(Float64) ?
        (forward_velocity * target_x +
            radial_lateral_velocity * target_y) / target_distance : 0.0
    receding_fraction = clamp(
        -radial_closing / max(params.receding_speed_scale, eps(Float64)),
        0.0,
        1.0,
    )
    receding_gate = receding_fraction^2 *
        (3.0 - 2.0 * receding_fraction)

    error_fraction = clamp(
        (abs(full_bearing) - params.recovery_bearing_on) /
        max(params.recovery_bearing_width, eps(Float64)),
        0.0,
        1.0,
    )
    error_gate = error_fraction^2 * (3.0 - 2.0 * error_fraction)

    # Broad-approach traces associate anterior-joint sign with yaw-moment
    # sign, while requested yaw has sign opposite turn_request. Thus velocity
    # entering the q1 side that shares turn_request is counter-moment motion.
    # Smooth damping is applied only near the zero crossing on that stroke;
    # the useful half-cycle is never amplified or damped.
    counterward_fraction = clamp(
        turn_request * qd1 /
        max(params.counterstroke_rate_scale, eps(Float64)),
        0.0,
        1.0,
    )
    counterward_gate = counterward_fraction^2 *
        (3.0 - 2.0 * counterward_fraction)
    center_fraction = clamp(
        1.0 - abs(q1) /
        max(params.counterstroke_center_width, eps(Float64)),
        0.0,
        1.0,
    )
    center_gate = center_fraction^2 *
        (3.0 - 2.0 * center_fraction)
    counterstroke_gate = error_gate * receding_gate *
        counterward_gate * center_gate

    # Preserve the zero-centered Van der Pol carrier. The added term is
    # strictly dissipative and state-released, so it cannot form the held
    # bends or add the carrier energy seen in prior recovery failures.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    counterstroke_brake = 2 * params.counterstroke_damping * omega *
        counterstroke_gate * qd1
    a1 = vdp_drive - omega^2 * q1 - counterstroke_brake

    # Retain the demonstrated full posterior traveling bend and bounded mean
    # curvature. Steering changes only through anterior half-cycle work after
    # a measured pass; alignment or restored closing recovers exact symmetry.
    mean_tail_tangent = params.turn_curvature_limit * turn_request
    carrier_tail_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    tail_target = mean_tail_tangent + carrier_tail_target
    a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
