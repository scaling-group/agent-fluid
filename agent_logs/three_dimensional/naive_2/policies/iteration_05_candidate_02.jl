# State-feedback traveling bend with phase-separated response steering.
# Shared half-cycle steering preserves propulsion; a response-gated posterior
# curvature pulse supplies extra redirect authority only at large target error.

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
        redirect_curvature_limit=8.0 * pi / 180,
        redirect_bearing_scale=0.45,
        redirect_response_scale=0.10,
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

    # Preserve the sampled long-running carrier and posterior lag exactly;
    # the candidate changes only the actuator structure used for redirect.
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

    # Beat-scale yaw is strongly correlated with joint phase in the sampled
    # traces. Remove that carrier component before treating yaw as directional
    # response; raw yaw-rate damping previously suppressed useful propulsion.
    carrier_phase_yaw = -params.carrier_yaw_head_rate_gain * qd1 -
        params.carrier_yaw_tail_rate_gain * qd2
    yaw_residual = clamp(
        heading_rate - carrier_phase_yaw,
        -params.maximum_yaw_residual,
        params.maximum_yaw_residual,
    )

    # Retain the evidenced half-cycle request and its wrong-side-slip gate.
    turn_signal = bounded_bearing -
        params.lateral_velocity_gain * bounded_lateral_velocity +
        params.yaw_residual_gain * yaw_residual
    turn_request = tanh(
        turn_signal / max(params.steering_softness, eps(Float64)),
    )

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

    # A large bearing recruits a bounded posterior-curvature pulse. Correct
    # phase-compensated yaw has the opposite sign to bearing and releases the
    # pulse continuously; absent or wrong-way response keeps it active. The
    # gate is reflection invariant and vanishes with target error, so this is
    # a response-gated redirect rather than persistent mean curvature.
    large_error_gate = tanh(
        abs(bounded_bearing) /
        max(params.redirect_bearing_scale, eps(Float64)),
    )
    correct_yaw_response = max(-bounded_bearing * yaw_residual, 0.0)
    response_release = tanh(
        correct_yaw_response /
        max(params.redirect_response_scale, eps(Float64)),
    )
    curvature_gate = large_error_gate * (1 - response_release)
    bearing_request = tanh(
        bounded_bearing / max(params.steering_softness, eps(Float64)),
    )
    posterior_curvature = params.redirect_curvature_limit *
        curvature_gate * bearing_request

    # Signed carrier magnitude retains the sampled half-cycle modulation.
    # Posterior curvature enters as a target displacement through omega^2,
    # while smooth action saturation remains inside the actuator envelope.
    raw_a1 = carrier_a1 +
        params.head_asymmetry_share * asymmetry * abs(carrier_a1)
    raw_a2 = carrier_a2 +
        params.tail_asymmetry_share * asymmetry * abs(carrier_a2) +
        omega^2 * posterior_curvature
    limit = params.maximum_joint_acceleration
    bounded_a1 = limit * tanh(raw_a1 / limit)
    bounded_a2 = limit * tanh(raw_a2 / limit)

    return (
        phi_ddot=(bounded_a1, bounded_a2),
    )
end
