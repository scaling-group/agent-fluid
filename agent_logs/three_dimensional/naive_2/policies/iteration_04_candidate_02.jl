# State-feedback traveling bend with course-gated half-cycle redirect.
# Joint state carries phase; normalized body-frame target geometry and motion
# steer without a clock, static curvature, or world-frame route.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        maximum_bearing=pi / 2,
        maximum_lateral_velocity=1.0,
        maximum_course_crossflow=1.0,
        steering_softness=0.35,
        lateral_velocity_gain=0.8,
        cruise_half_cycle_asymmetry=0.35,
        redirect_half_cycle_asymmetry=0.65,
        wrong_course_scale=0.08,
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

    # Preserve the common seed's evidenced propulsive carrier and posterior
    # lag; the controller changes steering structure rather than drive gains.
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
    longitudinal_velocity = isfinite(state.velocity_body_U[1]) ?
        Float64(state.velocity_body_U[1]) : 0.0
    lateral_velocity = isfinite(state.velocity_body_U[2]) ?
        Float64(state.velocity_body_U[2]) : 0.0
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

    # A line-of-sight course residual includes both forward and lateral
    # translation.  Its sign is reflection equivariant and, unlike lateral
    # velocity alone, still detects crossing the wrong side of an oblique
    # target line while the body is surging forward.
    target_norm = max(hypot(target_x, target_y), 0.25)
    target_direction_x = target_x / target_norm
    target_direction_y = target_y / target_norm
    course_crossflow = target_direction_x * bounded_lateral_velocity -
        target_direction_y * longitudinal_velocity
    bounded_course_crossflow = clamp(
        course_crossflow,
        -params.maximum_course_crossflow,
        params.maximum_course_crossflow,
    )

    # Bearing requests the turn; target-side lateral response releases it.
    # This retains the best sampled controller's slow response feedback.
    turn_signal = bounded_bearing -
        params.lateral_velocity_gain * bounded_lateral_velocity
    turn_request = tanh(
        turn_signal / max(params.steering_softness, eps(Float64)),
    )

    # Bearing and course residual with the same sign indicate motion away
    # from the current target line.  Their product is reflection invariant,
    # so it can gate a stronger C-start-like redirect while the signed request
    # stays reflection equivariant.  Authority remains below one, preserving
    # both half-cycles instead of replacing the traveling bend with bang-bang.
    wrong_course = max(
        bounded_bearing * bounded_course_crossflow,
        0.0,
    )
    redirect_gate = tanh(
        wrong_course / max(params.wrong_course_scale, eps(Float64)),
    )
    asymmetry_limit = params.cruise_half_cycle_asymmetry +
        redirect_gate * (
            params.redirect_half_cycle_asymmetry -
            params.cruise_half_cycle_asymmetry
        )
    asymmetry = asymmetry_limit * turn_request

    # Signed absolute carrier acceleration strengthens the requested
    # half-cycle without adding a static joint equilibrium.  Posterior
    # emphasis retains a traveling bend; smooth saturation stays inside the
    # physical acceleration envelope before downstream actuator clipping.
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
