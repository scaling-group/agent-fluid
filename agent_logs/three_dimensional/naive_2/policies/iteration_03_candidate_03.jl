# State-feedback traveling bend with course-residual half-cycle steering.
# Joint state carries phase; normalized body-frame target geometry and motion
# select the stronger beat side while a rate barrier preserves control reserve.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        maximum_bearing=pi / 2,
        maximum_course_crossflow=1.0,
        steering_softness=0.35,
        course_residual_gain=0.8,
        maximum_half_cycle_asymmetry=0.35,
        head_asymmetry_share=0.65,
        tail_asymmetry_share=1.0,
        joint_rate_soft_limit=230.0 * pi / 180,
        joint_rate_barrier_width=20.0 * pi / 180,
        joint_rate_barrier_acceleration=12.0,
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

    # Preserve the common seed's joint-state oscillator and posterior lag as
    # the propulsive carrier evidenced by the coherent alternating wake.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    carrier_a1 = vdp_drive - omega^2 * q1
    phase_lag_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    carrier_a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Positive bearing requests the curvature side calibrated by the sampled
    # acceleration-bias rollout. The signed cross product between the target
    # direction and translational velocity is a body-frame course residual:
    # motion across the line of sight strengthens or releases the request
    # without treating beat-scale yaw as a slow heading estimate.
    bearing = isfinite(state.bearing) ? Float64(state.bearing) : 0.0
    target_x = isfinite(state.target_body_L[1]) ?
        Float64(state.target_body_L[1]) : -1.0
    target_y = isfinite(state.target_body_L[2]) ?
        Float64(state.target_body_L[2]) : 0.0
    target_norm = max(hypot(target_x, target_y), 0.25)
    target_direction_x = target_x / target_norm
    target_direction_y = target_y / target_norm
    velocity_x = isfinite(state.velocity_body_U[1]) ?
        Float64(state.velocity_body_U[1]) : 0.0
    velocity_y = isfinite(state.velocity_body_U[2]) ?
        Float64(state.velocity_body_U[2]) : 0.0
    course_crossflow = target_direction_x * velocity_y -
        target_direction_y * velocity_x
    turn_signal = clamp(
        bearing,
        -params.maximum_bearing,
        params.maximum_bearing,
    ) + params.course_residual_gain * clamp(
        course_crossflow,
        -params.maximum_course_crossflow,
        params.maximum_course_crossflow,
    )
    turn_request = tanh(
        turn_signal / max(params.steering_softness, eps(Float64)),
    )
    asymmetry = params.maximum_half_cycle_asymmetry * turn_request

    # Adding signed |carrier acceleration| strengthens the requested
    # half-cycle and weakens its opposite without imposing a static joint
    # equilibrium. Posterior emphasis retains a traveling rather than standing
    # bend. A smooth high-rate barrier acts only near the physical rate limit;
    # it prevents the carrier from consuming all phase/steering authority.
    soft_rate = params.joint_rate_soft_limit
    rate_width = max(params.joint_rate_barrier_width, eps(Float64))
    rate_gate1 = 0.5 * (1 + tanh((abs(qd1) - soft_rate) / rate_width))
    rate_gate2 = 0.5 * (1 + tanh((abs(qd2) - soft_rate) / rate_width))
    rate_barrier1 = -params.joint_rate_barrier_acceleration *
        rate_gate1 * tanh(qd1 / max(soft_rate, eps(Float64)))
    rate_barrier2 = -params.joint_rate_barrier_acceleration *
        rate_gate2 * tanh(qd2 / max(soft_rate, eps(Float64)))
    raw_a1 = carrier_a1 +
        params.head_asymmetry_share * asymmetry * abs(carrier_a1) +
        rate_barrier1
    raw_a2 = carrier_a2 +
        params.tail_asymmetry_share * asymmetry * abs(carrier_a2) +
        rate_barrier2
    limit = params.maximum_joint_acceleration
    bounded_a1 = limit * tanh(raw_a1 / limit)
    bounded_a2 = limit * tanh(raw_a2 / limit)

    return (
        phi_ddot=(bounded_a1, bounded_a2),
    )
end
