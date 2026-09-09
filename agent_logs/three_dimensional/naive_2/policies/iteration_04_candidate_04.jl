# State-feedback traveling bend with polarity-corrected burst redirect.
# Joint state carries phase; normalized body-frame target geometry and lateral
# response select the stronger beat side without a clock or world-frame route.

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
        cruise_half_cycle_asymmetry=0.35,
        redirect_half_cycle_asymmetry=0.65,
        wrong_side_slip_scale=0.08,
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

    # Preserve the common seed's joint-state oscillator and posterior lag as
    # the propulsive carrier evidenced by the coherent alternating wake.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    carrier_a1 = vdp_drive - omega^2 * q1
    phase_lag_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    carrier_a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Bearing requests the turn and target-side lateral response releases it.
    # The minus sign is deliberate: the observation frame's forward swimming
    # direction is body -x, and paired rollouts show that the inherited
    # same-sign half-cycle mapping drives world motion away from the target.
    bearing = isfinite(state.bearing) ? Float64(state.bearing) : 0.0
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
    turn_signal = bounded_bearing -
        params.lateral_velocity_gain * bounded_lateral_velocity
    turn_request = -tanh(
        turn_signal / max(params.steering_softness, eps(Float64)),
    )

    # Opposite-signed target error and lateral response indicate motion away
    # from the requested side. Their reflection-invariant product gates a
    # stronger C-start-like redirect while keeping both half-cycles active.
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

    # Signed |carrier acceleration| strengthens one half-cycle without adding
    # a static joint equilibrium. Posterior emphasis retains the traveling
    # bend, and smooth saturation stays inside the physical acceleration cap.
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
