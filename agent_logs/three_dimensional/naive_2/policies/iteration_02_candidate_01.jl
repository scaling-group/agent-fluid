# State-feedback traveling bend with body-response half-cycle steering.
# Joint state carries phase; normalized body-frame target geometry selects the
# stronger beat side without a clock, static curvature, or world-frame route.

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
        maximum_half_cycle_asymmetry=0.35,
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

    # Positive bearing requests the curvature side calibrated by the sampled
    # acceleration-bias rollout. Body-frame lateral velocity is a slower
    # response cue than beat-scale yaw: motion toward that side releases the
    # request, while slip away from it strengthens the request.
    bearing = isfinite(state.bearing) ? Float64(state.bearing) : 0.0
    lateral_velocity = isfinite(state.velocity_body_U[2]) ?
        Float64(state.velocity_body_U[2]) : 0.0
    turn_signal = clamp(
        bearing,
        -params.maximum_bearing,
        params.maximum_bearing,
    ) - params.lateral_velocity_gain * clamp(
        lateral_velocity,
        -params.maximum_lateral_velocity,
        params.maximum_lateral_velocity,
    )
    turn_request = tanh(
        turn_signal / max(params.steering_softness, eps(Float64)),
    )
    asymmetry = params.maximum_half_cycle_asymmetry * turn_request

    # Adding signed |carrier acceleration| strengthens the requested
    # half-cycle and weakens its opposite without imposing a static joint
    # equilibrium. Posterior emphasis retains a traveling rather than standing
    # bend. Smooth action saturation stays inside the physical envelope without
    # replacing beat structure with repeated downstream hard clipping.
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
