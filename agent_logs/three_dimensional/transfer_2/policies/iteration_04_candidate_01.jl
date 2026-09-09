# Speed-gated posterior lag-duty steering.
#
# The sampled coherent wakes support the centered joint-state oscillator and
# posterior velocity lag. Steering changes only that lag on the compatible
# observed velocity half-cycle; it adds no static curvature, direct amplitude
# scaling, yaw-rate servo, clock, or memorized route.

function target_policy_params()
    return (
        version="dogfish3d_speed_gated_lag_duty_v1",
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.80,
        tail_damping=0.65,
        bearing_limit=1.20,
        bearing_scale=0.35,
        forward_speed_scale=0.30,
        phase_velocity_transition=0.35,
        phase_lag_asymmetry=0.22,
        tail_lag_min=0.52,
        tail_lag_max=1.08,
        command_accel_limit=31.0,
    )
end

@inline function _policy_safe(value, fallback)
    parsed = Float64(value)
    return isfinite(parsed) ? parsed : fallback
end

@inline function _policy_soft_limit(value, limit)
    safe_limit = max(_policy_safe(limit, 1.0), eps(Float64))
    return safe_limit * tanh(_policy_safe(value, 0.0) / safe_limit)
end

function lag_duty_guidance(state, qd1, omega, amplitude, params)
    # `bearing` is already a normalized body-frame target angle. Positive
    # bearing requests the positive mean tail-tangent direction that produced
    # the useful descent in the inherited sign bracket; the actuator-specific
    # sign remains an explicit falsification target.
    bearing = clamp(
        _policy_safe(state.bearing, 0.0),
        -params.bearing_limit,
        params.bearing_limit,
    )
    route_request = tanh(
        bearing / max(params.bearing_scale, eps(Float64)),
    )

    # Establish observed self-propulsion before steering. The material fish
    # swims along negative body x, so this gate is invariant to world pose and
    # contains no hidden timing state.
    body_forward_speed = max(
        -_policy_safe(state.velocity_body_U[1], 0.0),
        0.0,
    )
    propulsion_gate = tanh(
        body_forward_speed / max(params.forward_speed_scale, eps(Float64)),
    )

    # Joint velocity supplies gait phase. Under lateral reflection, bearing,
    # qd1, and phase_side all reverse, leaving the lag coefficient unchanged
    # while joint targets reverse: the policy remains reflection-equivariant.
    normalized_phase_velocity =
        qd1 / max(amplitude * omega, eps(Float64))
    phase_side = tanh(
        normalized_phase_velocity /
        max(params.phase_velocity_transition, eps(Float64)),
    )
    lag_duty =
        params.phase_lag_asymmetry *
        propulsion_gate *
        route_request *
        phase_side
    effective_tail_lag = clamp(
        params.tail_lag_gain - lag_duty,
        params.tail_lag_min,
        params.tail_lag_max,
    )
    return (
        bearing=bearing,
        route_request=route_request,
        body_forward_speed=body_forward_speed,
        propulsion_gate=propulsion_gate,
        phase_side=phase_side,
        lag_duty=lag_duty,
        effective_tail_lag=effective_tail_lag,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amplitude = max(params.oscillator_amplitude, eps(Float64))
    q1 = _policy_safe(state.phi[1], 0.0)
    q2 = _policy_safe(state.phi[2], 0.0)
    qd1 = _policy_safe(state.phi_dot[1], 0.0)
    qd2 = _policy_safe(state.phi_dot[2], 0.0)

    # Preserve the evidenced centered state-feedback carrier. Phase is fully
    # observed in joint state rather than supplied by an external clock.
    vdp_drive =
        params.oscillator_mu *
        (1 - (q1 / amplitude)^2) *
        qd1
    head_drive = vdp_drive - omega^2 * q1

    guidance = lag_duty_guidance(
        state,
        qd1,
        omega,
        amplitude,
        params,
    )

    # Only posterior velocity lag is modulated. Reducing lag on one velocity
    # half-cycle and increasing it on the other creates bounded lag duty while
    # retaining positive lag and the base traveling-bend scaffold throughout.
    tail_target =
        -q1 -
        guidance.effective_tail_lag * qd1 / max(omega, eps(Float64))
    tail_drive =
        omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (
        phi_ddot=(
            _policy_soft_limit(head_drive, params.command_accel_limit),
            _policy_soft_limit(tail_drive, params.command_accel_limit),
        ),
    )
end
