# Bearing-gated posterior half-cycle controller.
#
# The joint-state oscillator and posterior lag retain the sampled coherent
# traveling bend.  Steering uses one actuator mechanism: body-frame bearing
# smoothly strengthens one desired posterior half-cycle and weakens the other.
# It adds neither static curvature nor beat-scale course/yaw-rate feedback.

function target_policy_params()
    return (
        version="dogfish3d_bearing_halfcycle_tail_v1",
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.80,
        tail_damping=0.65,
        bearing_limit=1.20,
        bearing_scale=0.35,
        posterior_phase_scale=12.0 * pi / 180,
        halfcycle_asymmetry_limit=0.24,
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

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amplitude = params.oscillator_amplitude
    q1 = _policy_safe(state.phi[1], 0.0)
    q2 = _policy_safe(state.phi[2], 0.0)
    qd1 = _policy_safe(state.phi_dot[1], 0.0)
    qd2 = _policy_safe(state.phi_dot[2], 0.0)

    # Phase remains entirely in observed joint state.  The anterior oscillator
    # is unchanged from the coherent sampled gait and is never recentered by
    # steering, so zero target error exactly recovers symmetric propulsion.
    vdp_drive =
        params.oscillator_mu *
        (1 - (q1 / max(amplitude, eps(Float64)))^2) *
        qd1
    head_accel = vdp_drive - omega^2 * q1

    # This lagged state reference is the desired posterior traveling-wave
    # phase.  Its smooth sign identifies the current half-cycle without a
    # clock, step counter, or mutable oscillator state.
    posterior_reference =
        -q1 - params.tail_lag_gain * qd1 / max(omega, eps(Float64))
    posterior_side = tanh(
        posterior_reference /
        max(params.posterior_phase_scale, eps(Float64)),
    )

    # Sampled 3D response establishes that positive mean posterior tangent
    # reduces positive body-frame bearing.  Multiplying the positive target
    # half-cycle up and the negative one down produces that cycle-mean sign
    # while retaining both halves of the propulsive wave.
    bearing = clamp(
        _policy_safe(state.bearing, 0.0),
        -params.bearing_limit,
        params.bearing_limit,
    )
    turn_command = tanh(
        bearing / max(params.bearing_scale, eps(Float64)),
    )
    halfcycle_gate =
        1.0 +
        params.halfcycle_asymmetry_limit * turn_command * posterior_side
    tail_target = posterior_reference * halfcycle_gate
    tail_accel =
        omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (
        phi_ddot=(
            _policy_soft_limit(head_accel, params.command_accel_limit),
            _policy_soft_limit(tail_accel, params.command_accel_limit),
        ),
    )
end
