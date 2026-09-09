# Phase-coherent posterior steering for the L64 direct-uniform target lane.
# Preserve the joint-state traveling wave; use joint phase to compensate the
# bearing and to pulse, rather than hold, a bounded posterior curvature bias.

function target_policy_params()
    return (
        version="dogfish3d_phase_coherent_tail_pulse_v1",
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.80,
        tail_damping=0.65,
        bearing_limit=1.20,
        bearing_phase_gain=0.32,
        bearing_scale=0.40,
        forward_speed_scale=0.30,
        steering_authority_floor=0.15,
        midstroke_scale=0.55,
        tail_pulse_limit=10.0 * pi / 180,
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
    amplitude = max(params.oscillator_amplitude, eps(Float64))
    q1 = _policy_safe(state.phi[1], 0.0)
    q2 = _policy_safe(state.phi[2], 0.0)
    qd1 = _policy_safe(state.phi_dot[1], 0.0)
    qd2 = _policy_safe(state.phi_dot[2], 0.0)

    # The anterior oscillator is unchanged from the coherent self-propelled
    # samples. Its state remains the only gait phase.
    vdp_drive =
        params.oscillator_mu *
        (1 - (q1 / amplitude)^2) *
        qd1
    head_drive = vdp_drive - omega^2 * q1

    # A small q1 correction removes the repeatable joint-phase component of
    # body-frame bearing seen across the sampled traces. Persistent target
    # geometry still owns the sign; no yaw-rate or inertial route is used.
    bearing = clamp(
        _policy_safe(state.bearing, 0.0),
        -params.bearing_limit,
        params.bearing_limit,
    )
    phase_compensated_bearing = clamp(
        bearing + params.bearing_phase_gain * q1,
        -params.bearing_limit,
        params.bearing_limit,
    )
    turn_request = tanh(
        phase_compensated_bearing /
        max(params.bearing_scale, eps(Float64)),
    )

    # Steering authority grows only after the body has developed observed
    # forward translation. The mid-stroke gate is derived from joint state and
    # pulses posterior curvature without imposing a clock or a static bend.
    forward_speed = max(
        -_policy_safe(state.velocity_body_U[1], 0.0),
        0.0,
    )
    speed_gate = tanh(
        forward_speed /
        max(params.forward_speed_scale, eps(Float64)),
    )
    steering_authority =
        params.steering_authority_floor +
        (1 - params.steering_authority_floor) * speed_gate
    normalized_midstroke = abs(qd1) / max(omega * amplitude, eps(Float64))
    midstroke_gate = tanh(
        normalized_midstroke /
        max(params.midstroke_scale, eps(Float64)),
    )
    posterior_pulse =
        params.tail_pulse_limit *
        turn_request *
        steering_authority *
        midstroke_gate

    # Posterior lag preserves the traveling bend. Only the phase-coherent
    # pulse redirects it; the anterior oscillator equilibrium is not shifted.
    tail_target =
        posterior_pulse -
        q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(Float64))
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
