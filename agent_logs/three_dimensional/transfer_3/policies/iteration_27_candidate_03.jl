# Phase-2 candidate: preserve carrier-demodulated phase allocation while
# withdrawing only phase authority that drives tail velocity farther outward.

function target_policy_params()
    return (
        version="dogfish3d_velocity_headroom_phase_allocation_v1",
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.80,
        tail_damping=0.65,
        los_forward_floor=0.25,
        bearing_error_scale=0.35,
        bearing_yaw_rate_limit=0.40,
        route_response_activation_speed=0.30,
        los_rate_scale=0.08,
        los_rate_yaw_limit=0.35,
        combined_yaw_rate_limit=0.50,
        yaw_recoil_q1_gain=0.82,
        yaw_recoil_q2_gain=0.12,
        yaw_rate_error_scale=0.25,
        mean_tail_curvature_limit=10.0 * pi / 180,
        redirect_bearing_threshold=0.35,
        redirect_bearing_width=0.12,
        redirect_response_threshold=0.40,
        redirect_response_width=0.05,
        redirect_yaw_rate_scale=0.30,
        anterior_redirect_limit=6.0 * pi / 180,
        tail_wave_asymmetry_limit=0.20,
        tail_phase_response_limit=6.0 * pi / 180,
        tail_phase_activation_fraction=0.85,
        tail_phase_activation_width=0.10,
        carrier_moment_q1_gain=0.0169,
        carrier_moment_q2_gain=0.0029,
        carrier_moment_qd1_gain=0.0077,
        carrier_moment_qd2_gain=-0.0055,
        fluid_moment_residual_scale=0.0024,
        fluid_residual_phase_fraction=0.20,
        joint_velocity_limit=260.0 * pi / 180,
        posterior_velocity_activation_fraction=0.90,
        posterior_velocity_activation_width=0.05,
        posterior_phase_outward_scale=0.04,
        joint_acceleration_limit=1800.0 * pi / 180,
    )
end

@inline function _finite_or(value, fallback)
    parsed = Float64(value)
    return isfinite(parsed) ? parsed : fallback
end

function target_guidance(state, qd1, qd2, params)
    distance = max(_finite_or(state.distance_L, 1.0), 1.0e-6)
    target_x = _finite_or(state.target_body_L[1], -distance)
    target_y = _finite_or(state.target_body_L[2], 0.0)
    target_norm = max(hypot(target_x, target_y), 1.0e-6)

    # Material body -x is forward. Normalized target geometry keeps the
    # controller scale-free and reflection-equivariant after a target pass.
    target_forward = -target_x / target_norm
    target_lateral = target_y / target_norm
    bearing = atan(
        target_lateral,
        max(target_forward, params.los_forward_floor),
    )

    velocity_x = _finite_or(state.velocity_body_U[1], 0.0)
    velocity_y = _finite_or(state.velocity_body_U[2], 0.0)
    rigid_speed = hypot(velocity_x, velocity_y)

    # For a stationary target this is its inertial line-of-sight angular rate.
    # Rotation into the body frame leaves the scalar unchanged, and speed
    # gating suppresses startup recoil without a small forward-speed divisor.
    los_rate = (
        target_y * velocity_x - target_x * velocity_y
    ) / max(target_norm^2, 1.0e-6)
    response_gate = tanh(
        rigid_speed /
        max(params.route_response_activation_speed, 1.0e-6),
    )
    bearing_yaw_rate =
        -params.bearing_yaw_rate_limit *
        tanh(bearing / max(params.bearing_error_scale, 1.0e-6))
    response_yaw_rate =
        params.los_rate_yaw_limit *
        response_gate *
        tanh(los_rate / max(params.los_rate_scale, 1.0e-6))
    target_yaw_rate = clamp(
        bearing_yaw_rate + response_yaw_rate,
        -params.combined_yaw_rate_limit,
        params.combined_yaw_rate_limit,
    )

    # Remove sampled joint-correlated recoil before applying the reversible
    # posterior curvature and half-cycle responses.
    measured_yaw_rate = _finite_or(state.heading_rate, 0.0)
    phase_conditioned_yaw_rate =
        measured_yaw_rate +
        params.yaw_recoil_q1_gain * qd1 +
        params.yaw_recoil_q2_gain * qd2
    yaw_rate_error = target_yaw_rate - phase_conditioned_yaw_rate
    mean_tail_curvature =
        params.mean_tail_curvature_limit *
        tanh(yaw_rate_error / max(params.yaw_rate_error_scale, 1.0e-6))

    # Retain the evaluated large-bearing recruitment, but do not let it fade
    # during a bearing lull while the bounded LOS route demand remains large.
    # Both response paths release continuously without a range or miss gate.
    bearing_redirect_weight = 0.5 * (1 + tanh(
        (abs(bearing) - params.redirect_bearing_threshold) /
        max(params.redirect_bearing_width, 1.0e-6),
    ))
    response_redirect_weight = 0.5 * (1 + tanh(
        (abs(target_yaw_rate) - params.redirect_response_threshold) /
        max(params.redirect_response_width, 1.0e-6),
    ))
    redirect_weight = max(
        bearing_redirect_weight,
        response_redirect_weight,
    )
    anterior_mean_curvature =
        params.anterior_redirect_limit *
        redirect_weight *
        tanh(
            target_yaw_rate /
            max(params.redirect_yaw_rate_scale, 1.0e-6),
        )

    return (
        bearing=bearing,
        rigid_speed=rigid_speed,
        los_rate=los_rate,
        response_gate=response_gate,
        bearing_yaw_rate=bearing_yaw_rate,
        response_yaw_rate=response_yaw_rate,
        target_yaw_rate=target_yaw_rate,
        measured_yaw_rate=measured_yaw_rate,
        phase_conditioned_yaw_rate=phase_conditioned_yaw_rate,
        yaw_rate_error=yaw_rate_error,
        mean_tail_curvature=mean_tail_curvature,
        bearing_redirect_weight=bearing_redirect_weight,
        response_redirect_weight=response_redirect_weight,
        redirect_weight=redirect_weight,
        anterior_mean_curvature=anterior_mean_curvature,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    q1 = _finite_or(state.phi[1], 0.0)
    q2 = _finite_or(state.phi[2], 0.0)
    qd1 = _finite_or(state.phi_dot[1], 0.0)
    qd2 = _finite_or(state.phi_dot[2], 0.0)

    guidance = target_guidance(state, qd1, qd2, params)

    # Oscillate around the bounded anterior route-response center. Expressing
    # the posterior wave relative to this center preserves the traveling bend.
    centered_q1 = q1 - guidance.anterior_mean_curvature
    vdp_drive = params.oscillator_mu *
        (1 - (centered_q1 / params.oscillator_amplitude)^2) * qd1
    anterior_accel = vdp_drive - omega^2 * centered_q1

    normalized_qd1 = qd1 / max(omega, eps(Float64))
    normalized_qd2 = qd2 / max(omega, eps(Float64))
    baseline_posterior_wave_target =
        -centered_q1 -
        params.tail_lag_gain * normalized_qd1

    # Use observed response, not a clock or fixed beat side, to select the
    # helpful tail half-cycle. Under reflection both yaw error and wave target
    # reverse, so their product and scale are invariant while the scaled wave
    # remains odd. When yaw outruns demand, the preference reverses smoothly.
    response_direction = tanh(
        guidance.yaw_rate_error /
        max(params.yaw_rate_error_scale, 1.0e-6),
    )
    baseline_tail_wave_phase = tanh(
        baseline_posterior_wave_target /
        max(params.oscillator_amplitude, 1.0e-6),
    )
    asymmetry_limit = clamp(
        params.tail_wave_asymmetry_limit,
        0.0,
        0.95,
    )
    baseline_tail_wave_scale = 1 +
        asymmetry_limit * response_direction * baseline_tail_wave_phase
    baseline_posterior_target =
        guidance.mean_tail_curvature +
        baseline_tail_wave_scale * baseline_posterior_wave_target

    # Predict whether the evaluated amplitude path has acceleration headroom.
    # The absolute normalized demand is reflection-invariant. A smooth gate
    # retains the replicated path below the envelope and recruits the sampled
    # coefficient-norm-preserving phase actuator as clipping approaches.
    acceleration_limit = max(
        params.joint_acceleration_limit,
        eps(Float64),
    )
    baseline_posterior_accel =
        omega^2 * (baseline_posterior_target - q2) -
        2 * params.tail_damping * omega * qd2
    predicted_acceleration_fraction =
        abs(baseline_posterior_accel) / acceleration_limit
    predicted_phase_activation = 0.5 * (1 + tanh(
        (predicted_acceleration_fraction -
            params.tail_phase_activation_fraction) /
        max(params.tail_phase_activation_width, 1.0e-6),
    ))

    # Distinguish persistent clipping from a high-demand beat reversal. The
    # signed product is positive only when current unclipped demand continues
    # on the same actuator side as the observed previous action. It is
    # reflection-invariant because both accelerations reverse together.
    previous_posterior_action =
        _finite_or(state.previous_action[2], 0.0)
    normalized_predicted_stress = clamp(
        baseline_posterior_accel / acceleration_limit,
        -1.0,
        1.0,
    )
    normalized_realized_stress = clamp(
        previous_posterior_action / acceleration_limit,
        -1.0,
        1.0,
    )
    actuator_consistency = clamp(
        normalized_predicted_stress * normalized_realized_stress,
        0.0,
        1.0,
    )
    # Remove the measured traveling-bend carrier from yaw moment. The remaining
    # reflection-odd fluid response can make only a bounded adjustment to the
    # already successful phase allocator.
    carrier_moment_estimate =
        params.carrier_moment_q1_gain * q1 +
        params.carrier_moment_q2_gain * q2 +
        params.carrier_moment_qd1_gain * normalized_qd1 +
        params.carrier_moment_qd2_gain * normalized_qd2
    hydrodynamic_yaw_moment =
        _finite_or(state.moment_z_L2, carrier_moment_estimate)
    fluid_moment_residual =
        hydrodynamic_yaw_moment - carrier_moment_estimate
    normalized_residual_response = tanh(
        fluid_moment_residual /
        max(params.fluid_moment_residual_scale, 1.0e-6),
    )
    residual_opposition =
        -response_direction * normalized_residual_response
    residual_phase_fraction = clamp(
        params.fluid_residual_phase_fraction,
        0.0,
        0.5,
    )
    residual_phase_multiplier =
        1 + residual_phase_fraction * residual_opposition
    requested_phase_activation = clamp(
        predicted_phase_activation *
        actuator_consistency *
        residual_phase_multiplier,
        0.0,
        1.0,
    )

    # Form the evaluated phase request first, so its incremental acceleration
    # relative to the half-cycle path can be tested against actuator velocity.
    phase_gradient =
        params.tail_lag_gain * centered_q1 - normalized_qd1
    phase_gradient_direction = tanh(
        phase_gradient /
        max(params.oscillator_amplitude, 1.0e-6),
    )
    phase_limit = clamp(
        params.tail_phase_response_limit,
        0.0,
        pi / 4,
    )
    requested_tail_phase_shift =
        requested_phase_activation *
        phase_limit *
        response_direction *
        phase_gradient_direction
    requested_phase_cos = cos(requested_tail_phase_shift)
    requested_phase_sin = sin(requested_tail_phase_shift)
    requested_position_coefficient =
        -requested_phase_cos +
        params.tail_lag_gain * requested_phase_sin
    requested_velocity_coefficient =
        -requested_phase_sin -
        params.tail_lag_gain * requested_phase_cos
    requested_phase_wave_target =
        requested_position_coefficient * centered_q1 +
        requested_velocity_coefficient * normalized_qd1
    requested_tail_wave_phase = tanh(
        requested_phase_wave_target /
        max(params.oscillator_amplitude, 1.0e-6),
    )
    requested_tail_wave_scale = 1 +
        asymmetry_limit * response_direction * requested_tail_wave_phase
    requested_posterior_target =
        guidance.mean_tail_curvature +
        requested_tail_wave_scale * requested_phase_wave_target
    incremental_phase_accel =
        omega^2 * (requested_posterior_target - baseline_posterior_target)

    # Anti-windup is directional: withdraw only the phase increment that would
    # accelerate an already near-limit posterior joint farther outward. A phase
    # increment that brakes the joint retains full authority. Velocity and
    # incremental acceleration both reverse under reflection, so the gate is
    # invariant while the resulting command remains odd.
    velocity_limit = max(
        params.joint_velocity_limit,
        eps(Float64),
    )
    posterior_velocity_fraction = abs(qd2) / velocity_limit
    posterior_velocity_activation = 0.5 * (1 + tanh(
        (posterior_velocity_fraction -
            params.posterior_velocity_activation_fraction) /
        max(params.posterior_velocity_activation_width, 1.0e-6),
    ))
    normalized_outward_phase_drive = max(
        (qd2 / velocity_limit) *
        (incremental_phase_accel / acceleration_limit),
        0.0,
    )
    outward_phase_weight = tanh(
        normalized_outward_phase_drive /
        max(params.posterior_phase_outward_scale, 1.0e-6),
    )
    velocity_headroom_weight = clamp(
        1 - posterior_velocity_activation * outward_phase_weight,
        0.0,
        1.0,
    )
    phase_activation =
        requested_phase_activation * velocity_headroom_weight

    # Reconstruct the coefficient-norm-preserving phase rotation after the
    # headroom allocation. At zero withdrawal this exactly recovers the
    # replicated carrier-demodulated parent; at full withdrawal it recovers
    # the evaluated half-cycle path.
    tail_phase_shift =
        phase_activation *
        phase_limit *
        response_direction *
        phase_gradient_direction
    phase_cos = cos(tail_phase_shift)
    phase_sin = sin(tail_phase_shift)
    position_coefficient =
        -phase_cos + params.tail_lag_gain * phase_sin
    velocity_coefficient =
        -phase_sin - params.tail_lag_gain * phase_cos
    phase_modulated_wave_target =
        position_coefficient * centered_q1 +
        velocity_coefficient * normalized_qd1

    # Keep the response-reversing half-cycle scale around the allocated phase
    # wave. The state-feedback carrier and distributed C-bend remain unchanged.
    modulated_tail_wave_phase = tanh(
        phase_modulated_wave_target /
        max(params.oscillator_amplitude, 1.0e-6),
    )
    modulated_tail_wave_scale = 1 +
        asymmetry_limit * response_direction * modulated_tail_wave_phase
    posterior_target =
        guidance.mean_tail_curvature +
        modulated_tail_wave_scale * phase_modulated_wave_target
    posterior_accel =
        omega^2 * (posterior_target - q2) -
        2 * params.tail_damping * omega * qd2

    # The episode applies the same componentwise physical limiter. Project at
    # the policy boundary so returned commands are feasible by construction.
    feasible_anterior_accel = clamp(
        anterior_accel,
        -acceleration_limit,
        acceleration_limit,
    )
    feasible_posterior_accel = clamp(
        posterior_accel,
        -acceleration_limit,
        acceleration_limit,
    )

    return (
        phi_ddot=(feasible_anterior_accel, feasible_posterior_accel),
    )
end
