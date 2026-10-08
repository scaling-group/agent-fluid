# Rear-aware half-cycle propulsion with phase-compensated posterior steering.
# Normalized target geometry sets direction; measured yaw response sets release.

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
        yaw_phase_compensation=0.48,
        yaw_response_scale=0.35,
        posterior_steering_limit=12.0 * pi / 180,
        posterior_direction_scale_L=0.25,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

    # The head points along negative body x. Full angle distinguishes true
    # alignment from a target passed abeam or behind.
    target_forward = -Float64(state.target_body_L[1])
    target_lateral = Float64(state.target_body_L[2])
    target_error = atan(target_lateral, target_forward)

    # Preserve the evidenced slip-aware anterior center. Target-side slip
    # unloads it, while wrong-side slip strengthens it.
    target_direction = tanh(
        target_lateral / params.posterior_direction_scale_L,
    )
    signed_target_error = abs(target_error) * target_direction
    lateral_velocity = Float64(state.velocity_body_U[2])
    route_error = signed_target_error -
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
    maneuver_gate = redirect_gate * abs(target_direction)

    # Retain the strongest sampled anterior oscillator and half-cycle residual.
    # Joint state remains the only carrier-phase observation.
    curvature_center = params.curvature_bias_limit * turn_request
    carrier_q1 = q1 - curvature_center
    vdp_drive = params.oscillator_mu *
        (1 - (carrier_q1 / amp)^2) * qd1
    phase_speed = clamp(
        abs(qd1) / max(omega * amp, eps(omega * amp)),
        0.0,
        params.phase_velocity_limit,
    )
    anterior_redirect = params.redirect_acceleration_limit *
        maneuver_gate * target_direction * phase_speed
    a1 = vdp_drive - omega^2 * carrier_q1 + anterior_redirect

    # Preserve the sampled posterior half-cycle redistribution and lagged
    # traveling wave. Alignment restores the full symmetric carrier.
    normalized_stroke_rate = target_direction * qd1 /
        max(omega * amp, eps(omega * amp))
    useful_stroke_gate = 0.5 * (
        1 + tanh(
            normalized_stroke_rate / params.stroke_transition_scale,
        )
    )
    symmetric_tail_scale = 1 -
        params.tail_carrier_relief * maneuver_gate
    tail_carrier_scale = clamp(
        symmetric_tail_scale +
            params.tail_stroke_asymmetry * maneuver_gate *
            (2 * useful_stroke_gate - 1),
        0.0,
        1.0,
    )

    # Fast body yaw is strongly coupled to the anterior stroke. Remove that
    # evidenced joint-phase component before deciding whether the slower route
    # turn is responding. Positive target error requires negative body yaw, so
    # target_direction*yaw_rate is the wrong-way component. Apply the
    # FSI-calibrated posterior counter-bend mainly during that component and
    # release it smoothly when target-side yaw appears.
    slow_yaw_rate = Float64(state.heading_rate) +
        params.yaw_phase_compensation * qd1
    wrong_way_yaw = target_direction * slow_yaw_rate
    yaw_response_gate = 0.5 * (
        1 + tanh(wrong_way_yaw / params.yaw_response_scale)
    )
    posterior_steering = -params.posterior_steering_limit *
        maneuver_gate * target_direction * yaw_response_gate

    lagged_carrier = -carrier_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    phase_lag_target = tail_carrier_scale * lagged_carrier +
        posterior_steering
    a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
