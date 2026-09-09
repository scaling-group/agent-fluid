# Phase-2 candidate: target-gated posterior half-cycle asymmetry around an
# envelope-compatible traveling bend. Phase comes only from joint state, and
# steering uses normalized body-frame target geometry rather than a route.

function target_policy_params()
    return (
        version="dogfish3d_posterior_halfcycle_pursuit_v1",
        control_period=0.85,
        oscillator_amplitude=12.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.80,
        tail_damping=0.65,
        los_forward_floor=0.20,
        los_error_limit=1.35,
        los_error_scale=0.40,
        halfcycle_phase_scale=12.0 * pi / 180,
        halfcycle_asymmetry=0.35,
        minimum_wave_scale=0.65,
        maximum_wave_scale=1.35,
        command_acceleration_limit=1700.0 * pi / 180,
    )
end

@inline function _finite_or(value, fallback)
    parsed = Float64(value)
    return isfinite(parsed) ? parsed : fallback
end

function target_guidance(state, params)
    distance = max(_finite_or(state.distance_L, 1.0), 1.0e-6)
    target_x = _finite_or(state.target_body_L[1], -distance)
    target_y = _finite_or(state.target_body_L[2], 0.0)

    # Material forward is body -x. Normalization makes this independent of L
    # and range; the forward floor preserves a signed turn request after a pass.
    forward = -target_x / distance
    lateral = target_y / distance
    los_error = clamp(
        atan(lateral, max(forward, params.los_forward_floor)),
        -params.los_error_limit,
        params.los_error_limit,
    )
    turn_command = tanh(
        los_error / max(params.los_error_scale, 1.0e-6),
    )
    return (los_error=los_error, turn_command=turn_command)
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amplitude = params.oscillator_amplitude
    q1 = _finite_or(state.phi[1], 0.0)
    q2 = _finite_or(state.phi[2], 0.0)
    qd1 = _finite_or(state.phi_dot[1], 0.0)
    qd2 = _finite_or(state.phi_dot[2], 0.0)

    # A zero-mean anterior Van der Pol oscillator sustains the carrier.
    vdp_drive =
        params.oscillator_mu * (1.0 - (q1 / amplitude)^2) * qd1
    anterior_accel = vdp_drive - omega^2 * q1

    # The posterior target retains its lag and both bend directions. Target
    # error only strengthens the consistent half-cycle and weakens its mirror;
    # this produces mean turning without imposing a static C-bend.
    posterior_wave_target =
        -q1 - params.tail_lag_gain * qd1 / max(omega, eps(Float64))
    guidance = target_guidance(state, params)
    wave_side = tanh(
        posterior_wave_target /
        max(params.halfcycle_phase_scale, 1.0e-6),
    )
    wave_scale = clamp(
        1.0 + params.halfcycle_asymmetry * guidance.turn_command * wave_side,
        params.minimum_wave_scale,
        params.maximum_wave_scale,
    )
    posterior_target = wave_scale * posterior_wave_target
    posterior_accel =
        omega^2 * (posterior_target - q2) -
        2.0 * params.tail_damping * omega * qd2

    limit = max(params.command_acceleration_limit, 1.0e-6)
    return (
        phi_ddot=(
            clamp(anterior_accel, -limit, limit),
            clamp(posterior_accel, -limit, limit),
        ),
    )
end
