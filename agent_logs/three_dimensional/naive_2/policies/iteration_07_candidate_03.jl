# State-feedback traveling bend with posterior-state burst release.
# Full-circle target geometry recruits a near redirect; requested-side tail
# bend releases both steering and drive relief before the posterior joint pins.

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
        approach_distance=6.0,
        approach_distance_width=1.0,
        approach_angle_scale=0.5,
        minimum_carrier_scale=0.35,
        burst_release_tail_bend=32.0 * pi / 180,
        burst_release_softness=4.0 * pi / 180,
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

    # Preserve the evidenced propulsive carrier and posterior traveling bend.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    carrier_a1 = vdp_drive - omega^2 * q1
    phase_lag_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    carrier_a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    fallback_bearing = isfinite(state.bearing) ? Float64(state.bearing) : 0.0
    target_x = isfinite(state.target_body_L[1]) ?
        Float64(state.target_body_L[1]) : -1.0
    target_y = isfinite(state.target_body_L[2]) ?
        Float64(state.target_body_L[2]) : 0.0
    distance = isfinite(state.distance_L) ?
        max(Float64(state.distance_L), 0.0) :
        params.approach_distance + 4 * params.approach_distance_width
    lateral_velocity = isfinite(state.velocity_body_U[2]) ?
        Float64(state.velocity_body_U[2]) : 0.0
    heading_rate = isfinite(state.heading_rate) ?
        Float64(state.heading_rate) : 0.0

    # Body forward is -x. Full-circle pursuit keeps the fore/aft distinction
    # that is folded by the adapter's restricted bearing.
    pursuit_bearing = isfinite(target_x) && isfinite(target_y) ?
        atan(target_y, -target_x) : fallback_bearing
    bounded_bearing = clamp(
        pursuit_bearing,
        -params.maximum_bearing,
        params.maximum_bearing,
    )
    bounded_lateral_velocity = clamp(
        lateral_velocity,
        -params.maximum_lateral_velocity,
        params.maximum_lateral_velocity,
    )

    # Remove joint-phase-correlated yaw before treating yaw as directional
    # response. Correct-sign residual yaw releases the target turn.
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

    # Wrong-side lateral response recruits the stronger redirect while both
    # propulsive half-cycles remain available.
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

    # Near a badly misaligned target, trade symmetric drive for steering. The
    # assigned parent's mean-bend release freed the anterior joint but left the
    # posterior joint pinned. Use the requested-side posterior bend directly:
    # once the tail consumes its bend reserve, fade steering while restoring
    # the carrier. The product is invariant under left/right reflection.
    distance_width = max(params.approach_distance_width, eps(Float64))
    approach_proximity = 0.5 * (
        1 - tanh((distance - params.approach_distance) / distance_width)
    )
    approach_misalignment = tanh(
        abs(bounded_bearing) /
        max(params.approach_angle_scale, eps(Float64)),
    )
    burst_request = approach_proximity * approach_misalignment
    signed_tail_bend = turn_request * q2
    bend_release_softness = max(
        params.burst_release_softness,
        eps(Float64),
    )
    tail_bend_reserve = 0.5 * (
        1 - tanh(
            (signed_tail_bend - params.burst_release_tail_bend) /
            bend_release_softness,
        )
    )
    active_burst = burst_request * tail_bend_reserve
    carrier_scale = 1 -
        (1 - params.minimum_carrier_scale) * active_burst
    steering_scale = 1 - burst_request * (1 - tail_bend_reserve)
    asymmetry = asymmetry_limit * turn_request * steering_scale

    # Signed carrier magnitude strengthens only the requested half-cycle.
    # Smooth saturation remains within the acceleration envelope.
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
