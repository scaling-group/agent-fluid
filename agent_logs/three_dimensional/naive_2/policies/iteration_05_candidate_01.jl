# Phase-compensated traveling bend with distance-conditioned approach control.
# Joint state carries phase; normalized body-frame geometry and response steer,
# while proximity smoothly reallocates carrier authority from thrust to turn.

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
        approach_outer_distance_L=6.0,
        approach_inner_distance_L=3.0,
        minimum_approach_carrier_scale=0.65,
        head_asymmetry_share=0.65,
        tail_asymmetry_share=1.0,
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

    # Preserve the evidenced joint-state oscillator and posterior lag. The
    # unscaled carrier also provides the beat-side magnitude for steering.
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

    # Remove the sampled carrier-correlated yaw before interpreting heading
    # rate as directional response. Correct-side residual yaw releases the
    # request; wrong-side response reinforces it without damping the beat.
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

    # Wrong-side lateral response gates the stronger evidenced redirect. The
    # product is reflection invariant, while the request remains signed.
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

    # The prior controller reached 3.17L at nearly 1L/T with its steering
    # already saturated. Inside a normalized approach band, smoothly reduce
    # only the symmetric carrier. Keeping the signed half-cycle term unscaled
    # trades thrust for turn authority without a clock, route, or global brake.
    distance_L = isfinite(state.distance_L) ?
        max(Float64(state.distance_L), 0.0) :
        params.approach_outer_distance_L
    approach_span = max(
        params.approach_outer_distance_L -
            params.approach_inner_distance_L,
        eps(Float64),
    )
    approach_fraction = clamp(
        (params.approach_outer_distance_L - distance_L) / approach_span,
        0.0,
        1.0,
    )
    approach_gate = approach_fraction^2 * (3.0 - 2.0 * approach_fraction)
    carrier_scale = 1.0 - approach_gate *
        (1.0 - params.minimum_approach_carrier_scale)

    steering_a1 = params.head_asymmetry_share * asymmetry * abs(carrier_a1)
    steering_a2 = params.tail_asymmetry_share * asymmetry * abs(carrier_a2)
    raw_a1 = carrier_scale * carrier_a1 + steering_a1
    raw_a2 = carrier_scale * carrier_a2 + steering_a2

    # Posterior emphasis retains a traveling bend, and smooth saturation stays
    # inside the acceleration envelope before downstream actuator clipping.
    limit = params.maximum_joint_acceleration
    bounded_a1 = limit * tanh(raw_a1 / limit)
    bounded_a2 = limit * tanh(raw_a2 / limit)

    return (
        phi_ddot=(bounded_a1, bounded_a2),
    )
end
