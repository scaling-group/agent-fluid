# Closing-aware approach hold around an approach-scheduled course redirect.
# All route and response cues are normalized and body-frame.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        steering_bearing_scale=0.30,
        steering_crossflow_scale=0.25,
        steering_crossflow_weight=0.75,
        steering_course_speed_scale=0.20,
        steering_course_error_scale=0.80,
        steering_course_error_weight=0.55,
        course_bearing_window=0.30,
        course_alignment_exponent=4,
        anterior_course_curvature_limit=4.0 * pi / 180,
        approach_start_distance_L=6.5,
        approach_full_distance_L=3.0,
        hold_distance_scale=5.0,
        hold_distance_exponent=4,
        hold_closing_speed_reference=0.30,
        hold_closing_speed_scale=0.15,
        hold_min_amplitude_fraction=0.45,
        steering_yaw_rate_scale=1.0,
        steering_yaw_rate_weight=0.45,
        steering_curvature_limit=12.0 * pi / 180,
        actuation_soft_limit=1800.0 * pi / 180,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    bearing_value = Float64(state.bearing)
    bearing = isfinite(bearing_value) ? bearing_value : 0.0
    crossflow_value = Float64(state.relative_flow_velocity_body_U[2])
    crossflow = isfinite(crossflow_value) ? crossflow_value : 0.0

    # Target-to-velocity angle anticipates a lateral target-line crossing. It
    # is silent near rest and contributes to the posterior command only in the
    # already validated small-bearing window.
    target_x_value = Float64(state.target_body_L[1])
    target_y_value = Float64(state.target_body_L[2])
    velocity_x_value = Float64(state.velocity_body_U[1])
    velocity_y_value = Float64(state.velocity_body_U[2])
    target_x = isfinite(target_x_value) ? target_x_value : 0.0
    target_y = isfinite(target_y_value) ? target_y_value : 0.0
    velocity_x = isfinite(velocity_x_value) ? velocity_x_value : 0.0
    velocity_y = isfinite(velocity_y_value) ? velocity_y_value : 0.0
    target_norm = hypot(target_x, target_y)
    velocity_norm = hypot(velocity_x, velocity_y)
    course_cross = target_x * velocity_y - target_y * velocity_x
    course_dot = target_x * velocity_x + target_y * velocity_y
    course_error = target_norm > eps(Float64) &&
        velocity_norm > eps(Float64) ?
        clamp(atan(course_cross, course_dot), -pi / 2, pi / 2) : 0.0
    forward_speed = max(-velocity_x, 0.0)
    course_speed_gate = tanh(
        forward_speed /
        max(params.steering_course_speed_scale, eps(Float64)),
    )^2
    course_core = course_speed_gate * tanh(
        course_error /
        max(params.steering_course_error_scale, eps(Float64)),
    )
    alignment_ratio = abs(bearing) /
        max(params.course_bearing_window, eps(Float64))
    centerline_gate = 1 / (
        1 + alignment_ratio^params.course_alignment_exponent
    )
    course_signal = centerline_gate * course_core
    course_brake = params.steering_course_error_weight * course_signal

    # Preserve the far-field course redistribution exactly. During approach,
    # smoothly relax only its bearing window so the same measured course cue
    # retains a small anterior lever while the target is lateral. This is zero
    # outside the approach range and remains capped at the tested four degrees.
    distance_value = Float64(state.distance_L)
    distance = isfinite(distance_value) ? max(distance_value, 0.0) : Inf
    approach_span = max(
        params.approach_start_distance_L -
        params.approach_full_distance_L,
        eps(Float64),
    )
    approach_progress = clamp(
        (params.approach_start_distance_L - distance) / approach_span,
        0.0,
        1.0,
    )
    redistribution_gate =
        approach_progress^2 * (3 - 2 * approach_progress)
    head_course_gate = centerline_gate +
        redistribution_gate * (1 - centerline_gate)
    head_course_center = params.anterior_course_curvature_limit *
        head_course_gate * course_core

    # Distance alone relieved the carrier before a productive approach was
    # complete. Instead compare measured radial closing with a modest closure
    # reference: full amplitude survives decisive targetward translation, and
    # only weak or negative closure near the target activates the hold. The
    # target/velocity dot product is rotation invariant and avoids a noisy
    # world-frame route or a hidden episode stage.
    radial_closing = target_norm > eps(Float64) ?
        course_dot / target_norm : 0.0
    hold_distance_ratio = distance /
        max(params.hold_distance_scale, eps(Float64))
    proximity_gate = 1 / (
        1 + hold_distance_ratio^params.hold_distance_exponent
    )
    closing_deficit_gate = 0.5 * (
        1 + tanh(
            (params.hold_closing_speed_reference - radial_closing) /
            max(params.hold_closing_speed_scale, eps(Float64)),
        )
    )
    hold_gate = proximity_gate * closing_deficit_gate
    minimum_amplitude_fraction = clamp(
        params.hold_min_amplitude_fraction,
        eps(Float64),
        1.0,
    )
    carrier_scale = 1 -
        (1 - minimum_amplitude_fraction) * hold_gate
    approach_amp = amp * carrier_scale

    q1_carrier = q1 - head_course_center
    vdp_drive = params.oscillator_mu *
        (1 - (q1_carrier / approach_amp)^2) * qd1
    a1_raw = vdp_drive - omega^2 * q1_carrier

    # Bearing and relative crossflow retain route authority. Recent yaw stays a
    # bounded recoil term, while the centerline course brake releases delayed
    # steering. The total posterior mean is unchanged by the anterior shift.
    yaw_rate_value = Float64(state.turn_rate_recent)
    yaw_rate = isfinite(yaw_rate_value) ? yaw_rate_value : 0.0
    turn_state =
        bearing / max(params.steering_bearing_scale, eps(Float64)) +
        params.steering_crossflow_weight * tanh(
            crossflow /
            max(params.steering_crossflow_scale, eps(Float64)),
        ) +
        course_brake +
        params.steering_yaw_rate_weight * tanh(
            yaw_rate / max(params.steering_yaw_rate_scale, eps(Float64)),
        )
    mean_tail_tangent = params.steering_curvature_limit * tanh(turn_state)
    phase_lag_target =
        mean_tail_tangent - q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2_raw = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    accel_limit = params.actuation_soft_limit
    a1 = accel_limit * tanh(a1_raw / accel_limit)
    a2 = accel_limit * tanh(a2_raw / accel_limit)

    return (phi_ddot=(a1, a2),)
end
