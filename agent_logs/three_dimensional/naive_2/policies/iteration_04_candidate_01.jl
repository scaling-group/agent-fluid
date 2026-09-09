# State-feedback traveling bend with course-divergence-gated redirect.
# Joint state carries phase; normalized body-frame target geometry and motion
# gate stronger half-cycle steering without a clock, rate brake, or route.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        maximum_bearing=pi / 2,
        maximum_course_crossflow=1.0,
        course_residual_gain=0.8,
        course_divergence_scale=0.12,
        steering_softness=0.35,
        cruise_half_cycle_asymmetry=0.35,
        redirect_half_cycle_asymmetry=0.65,
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

    # Preserve the strongest sample's traveling-bend carrier. The anterior
    # joint sustains phase while the posterior target supplies propulsive lag.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    carrier_a1 = vdp_drive - omega^2 * q1
    phase_lag_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    carrier_a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

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

    # The signed target/velocity cross product measures motion across the
    # line of sight. Gate it by geometric error so beat-scale course swings
    # cannot reverse a small bearing request. The gate is unchanged by
    # left/right reflection; bearing and course_crossflow both change sign.
    bounded_bearing = clamp(
        bearing,
        -params.maximum_bearing,
        params.maximum_bearing,
    )
    course_crossflow = target_direction_x * velocity_y -
        target_direction_y * velocity_x
    bounded_course_crossflow = clamp(
        course_crossflow,
        -params.maximum_course_crossflow,
        params.maximum_course_crossflow,
    )
    divergence = abs(bounded_bearing * bounded_course_crossflow)
    response_gate = tanh(
        divergence / max(params.course_divergence_scale, eps(Float64)),
    )
    turn_signal = bounded_bearing + params.course_residual_gain *
        response_gate * bounded_course_crossflow
    turn_request = tanh(
        turn_signal / max(params.steering_softness, eps(Float64)),
    )

    # Course divergence continuously raises authority from the evidenced
    # cruise value to a sub-unity redirect value. Both half-cycles remain
    # active, and posterior emphasis retains a traveling rather than standing
    # bend. Smooth saturation stays inside the acceleration envelope.
    asymmetry_limit = params.cruise_half_cycle_asymmetry +
        response_gate * (
            params.redirect_half_cycle_asymmetry -
            params.cruise_half_cycle_asymmetry
        )
    asymmetry = asymmetry_limit * turn_request
    raw_a1 = carrier_a1 +
        params.head_asymmetry_share * asymmetry * abs(carrier_a1)
    raw_a2 = carrier_a2 +
        params.tail_asymmetry_share * asymmetry * abs(carrier_a2)
    limit = params.maximum_joint_acceleration
    bounded_a1 = limit * tanh(raw_a1 / limit)
    bounded_a2 = limit * tanh(raw_a2 / limit)

    return (
        phi_ddot=(bounded_a1, bounded_a2),
    )
end
