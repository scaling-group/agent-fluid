# Full-target whole-body half-cycle steering with a terminal curvature-capture
# redirect. All maneuver scheduling uses normalized body-frame observations.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        steering_error_scale=0.25,
        lateral_velocity_feedback=1.2,
        curvature_bias_limit=8.0 * pi / 180,
        redirect_error_start=0.45,
        redirect_error_full=0.90,
        redirect_acceleration_limit=16.0,
        phase_velocity_limit=1.0,
        tail_carrier_relief=0.65,
        tail_stroke_asymmetry=0.30,
        stroke_transition_scale=0.20,
        capture_distance_start=6.0,
        capture_distance_full=4.0,
        capture_curvature_increment=12.0 * pi / 180,
        capture_velocity_damping=0.35,
        capture_tail_relief=0.50,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

    # The head points along negative body x. This full signed angle continues
    # to distinguish a rearward target from alignment after a close pass.
    target_forward = -Float64(state.target_body_L[1])
    target_lateral = Float64(state.target_body_L[2])
    target_error = atan(target_lateral, target_forward)
    geometric_turn = tanh(target_error / params.steering_error_scale)

    # Target-side lateral motion unloads the modest cruise center; wrong-side
    # slip strengthens it. Geometry alone fixes the maneuver's turn sign.
    lateral_velocity = Float64(state.velocity_body_U[2])
    route_error = target_error -
        params.lateral_velocity_feedback * lateral_velocity
    turn_request = tanh(route_error / params.steering_error_scale)

    redirect_progress = clamp(
        (abs(target_error) - params.redirect_error_start) /
            max(
                params.redirect_error_full - params.redirect_error_start,
                eps(params.redirect_error_full),
            ),
        0.0,
        1.0,
    )
    redirect_gate = redirect_progress^2 * (3 - 2 * redirect_progress)

    # The terminal gate is identically zero outside the evidenced near-miss
    # region. Large error near the target continuously recruits a C-start-like
    # curvature capture; alignment or increasing range restores cruise.
    capture_progress = clamp(
        (params.capture_distance_start - Float64(state.distance_L)) /
            max(
                params.capture_distance_start -
                    params.capture_distance_full,
                eps(params.capture_distance_start),
            ),
        0.0,
        1.0,
    )
    proximity_gate = capture_progress^2 * (3 - 2 * capture_progress)
    capture_gate = redirect_gate * proximity_gate

    curvature_center =
        params.curvature_bias_limit * turn_request +
        params.capture_curvature_increment * capture_gate * geometric_turn
    carrier_q1 = q1 - curvature_center

    # Away from capture, reproduce the sampled joint-state oscillator and its
    # phase-selective anterior redirect. During capture, smoothly replace
    # self-excitation with damping about the one-sided curvature center. This
    # trades cyclic thrust for a bounded redirect without a clock or stage.
    vdp_drive = params.oscillator_mu *
        (1 - (carrier_q1 / amp)^2) * qd1
    capture_damping =
        -params.capture_velocity_damping * omega * qd1
    anterior_drive =
        (1 - capture_gate) * vdp_drive +
        capture_gate * capture_damping
    phase_speed = clamp(
        abs(qd1) / max(omega * amp, eps(omega * amp)),
        0.0,
        params.phase_velocity_limit,
    )
    anterior_redirect = params.redirect_acceleration_limit *
        redirect_gate * (1 - capture_gate) *
        geometric_turn * phase_speed
    a1 = anterior_drive - omega^2 * carrier_q1 + anterior_redirect

    # Preserve the best sampled posterior half-cycle redistribution during
    # cruise. The capture mode further unloads both tail strokes so forward
    # thrust does not carry the fish through the tight turn.
    normalized_stroke_rate = geometric_turn * qd1 /
        max(omega * amp, eps(omega * amp))
    useful_stroke_gate = 0.5 * (
        1 + tanh(
            normalized_stroke_rate / params.stroke_transition_scale,
        )
    )
    symmetric_tail_scale = 1 -
        params.tail_carrier_relief * redirect_gate
    tail_carrier_scale = clamp(
        symmetric_tail_scale +
            params.tail_stroke_asymmetry * redirect_gate *
            (2 * useful_stroke_gate - 1),
        0.0,
        1.0,
    )
    tail_carrier_scale *= 1 -
        params.capture_tail_relief * capture_gate

    lagged_carrier = -carrier_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    phase_lag_target = tail_carrier_scale * lagged_carrier
    a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
