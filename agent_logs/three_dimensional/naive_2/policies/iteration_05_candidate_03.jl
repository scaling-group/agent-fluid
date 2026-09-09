# Phase-compensated response steering with continuous approach hold.
# Joint state carries propulsive phase; normalized target geometry relieves
# symmetric drive near or beyond the target without removing steering.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        maximum_bearing=pi / 2,
        maximum_lateral_velocity=1.0,
        steering_softness=0.35,
        lateral_velocity_gain=0.8,
        carrier_yaw_head_rate_gain=0.65,
        carrier_yaw_tail_rate_gain=0.22,
        maximum_yaw_residual=0.5,
        yaw_residual_gain=0.6,
        cruise_half_cycle_asymmetry=0.35,
        redirect_half_cycle_asymmetry=0.65,
        wrong_side_slip_scale=0.08,
        head_asymmetry_share=0.65,
        tail_asymmetry_share=1.0,
        approach_distance=5.0,
        approach_softness=0.75,
        target_plane_softness=0.5,
        minimum_carrier_scale=0.35,
        maximum_joint_acceleration=30.0,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Preserve the strongest sample's traveling-bend carrier and posterior
    # lag. Approach scheduling is applied only when composing the final action.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    carrier_a1 = vdp_drive - omega^2 * q1
    phase_lag_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    carrier_a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    bearing = isfinite(state.bearing) ? Float64(state.bearing) : 0.0
    lateral_velocity = isfinite(state.velocity_body_U[2]) ?
        Float64(state.velocity_body_U[2]) : 0.0
    heading_rate = isfinite(state.heading_rate) ?
        Float64(state.heading_rate) : 0.0
    bounded_bearing = clamp(
        bearing,
        -params.maximum_bearing,
        params.maximum_bearing,
    )
    bounded_lateral_velocity = clamp(
        lateral_velocity,
        -params.maximum_lateral_velocity,
        params.maximum_lateral_velocity,
    )

    # Remove joint-phase-correlated yaw before treating yaw as directional
    # response. Correct-sign residual response releases the turn, while a
    # wrong-sign response reinforces the body-frame bearing request.
    carrier_phase_yaw = -params.carrier_yaw_head_rate_gain * qd1 -
        params.carrier_yaw_tail_rate_gain * qd2
    yaw_residual = clamp(
        heading_rate - carrier_phase_yaw,
        -params.maximum_yaw_residual,
        params.maximum_yaw_residual,
    )
    turn_signal = bounded_bearing -
        params.lateral_velocity_gain * bounded_lateral_velocity +
        params.yaw_residual_gain * yaw_residual
    turn_request = tanh(
        turn_signal / max(params.steering_softness, eps(Float64)),
    )

    # Opposite-signed bearing and lateral response indicate motion away from
    # the requested side. The invariant product gates stronger redirection
    # while retaining both propulsive half-cycles.
    wrong_side_slip = max(
        -bounded_bearing * bounded_lateral_velocity,
        0.0,
    )
    redirect_gate = tanh(
        wrong_side_slip / max(params.wrong_side_slip_scale, eps(Float64)),
    )
    asymmetry_limit = params.cruise_half_cycle_asymmetry +
        redirect_gate * (
            params.redirect_half_cycle_asymmetry -
            params.cruise_half_cycle_asymmetry
        )
    asymmetry = asymmetry_limit * turn_request

    # The strong sample reached the target's x station at high speed but
    # remained laterally outside capture. Reduce only symmetric carrier drive
    # inside the approach region. Positive target-body x means that the target
    # has passed behind the fish's head-facing (-x) direction, so the same
    # relief persists during recovery without a clock or memorized route.
    distance = isfinite(state.distance_L) ?
        max(Float64(state.distance_L), 0.0) : params.approach_distance
    target_x = isfinite(state.target_body_L[1]) ?
        Float64(state.target_body_L[1]) : -distance
    approach_gate = 0.5 * (
        1 + tanh(
            (params.approach_distance - distance) /
            max(params.approach_softness, eps(Float64)),
        )
    )
    passed_target_gate = 0.5 * (
        1 + tanh(
            target_x / max(params.target_plane_softness, eps(Float64)),
        )
    )
    hold_gate = 1 - (1 - approach_gate) * (1 - passed_target_gate)
    carrier_scale = 1 - hold_gate * (1 - params.minimum_carrier_scale)

    # Steering uses the unrelieved carrier magnitude, increasing directional
    # authority relative to drive only where the approach gate is active.
    # Smooth action saturation remains inside the acceleration envelope.
    raw_a1 = carrier_scale * carrier_a1 +
        params.head_asymmetry_share * asymmetry * abs(carrier_a1)
    raw_a2 = carrier_scale * carrier_a2 +
        params.tail_asymmetry_share * asymmetry * abs(carrier_a2)
    limit = params.maximum_joint_acceleration
    bounded_a1 = limit * tanh(raw_a1 / limit)
    bounded_a2 = limit * tanh(raw_a2 / limit)

    return (
        phi_ddot=(bounded_a1, bounded_a2),
    )
end
