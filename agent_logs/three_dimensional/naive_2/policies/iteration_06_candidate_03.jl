# Phase-separated full-circle pursuit on a traveling-bend carrier.
# Joint state predicts beat-correlated body yaw so persistent target geometry,
# rather than instantaneous carrier motion, drives the approach redirect.

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
        carrier_yaw_head_gain=0.65,
        carrier_yaw_tail_gain=0.22,
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

    # Body forward is -x. Full-circle pursuit retains the fore/aft distinction
    # lost by the adapter's restricted bearing. The joint-angle term is the
    # integral of the evidenced carrier-yaw-rate model: subtracting it removes
    # predictable beat yaw before target geometry is interpreted.
    raw_pursuit = isfinite(target_x) && isfinite(target_y) ?
        atan(target_y, -target_x) : fallback_bearing
    carrier_phase_yaw = -params.carrier_yaw_head_gain * q1 -
        params.carrier_yaw_tail_gain * q2
    pursuit_residual = atan(
        sin(raw_pursuit - carrier_phase_yaw),
        cos(raw_pursuit - carrier_phase_yaw),
    )
    bounded_bearing = clamp(
        pursuit_residual,
        -params.maximum_bearing,
        params.maximum_bearing,
    )
    bounded_lateral_velocity = clamp(
        lateral_velocity,
        -params.maximum_lateral_velocity,
        params.maximum_lateral_velocity,
    )

    # Apply the corresponding derivative model to measured heading rate. A
    # correct-sign residual response releases the turn; a wrong-sign response
    # reinforces it without damping the propulsive beat.
    carrier_phase_yaw_rate = -params.carrier_yaw_head_gain * qd1 -
        params.carrier_yaw_tail_gain * qd2
    yaw_residual = clamp(
        heading_rate - carrier_phase_yaw_rate,
        -params.maximum_yaw_residual,
        params.maximum_yaw_residual,
    )
    turn_signal = bounded_bearing -
        params.lateral_velocity_gain * bounded_lateral_velocity +
        params.yaw_residual_gain * yaw_residual
    turn_request = tanh(
        turn_signal / max(params.steering_softness, eps(Float64)),
    )

    # Wrong-side lateral response gates stronger shared-joint redirection.
    # Both the gate and signed request now use phase-separated target geometry.
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

    # Near a badly misaligned target, reduce only the symmetric carrier while
    # retaining signed half-cycle steering. Alignment restores cruise drive;
    # the far-field carrier is unchanged.
    distance_width = max(params.approach_distance_width, eps(Float64))
    approach_proximity = 0.5 * (
        1 - tanh((distance - params.approach_distance) / distance_width)
    )
    approach_misalignment = tanh(
        abs(bounded_bearing) /
        max(params.approach_angle_scale, eps(Float64)),
    )
    approach_redirect = approach_proximity * approach_misalignment
    carrier_scale = 1 -
        (1 - params.minimum_carrier_scale) * approach_redirect

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
