# Phase-2 candidate: yaw-response-gated posterior half-cycle steering.
# Rhythm and steering phase come only from observed joint state. Target pursuit
# uses normalized body-frame geometry; no clock, route, or world coordinate is
# encoded in the controller.

function target_policy_params()
    return (
        version="dogfish3d_halfcycle_yaw_response_v1",
        control_period=0.70,
        oscillator_amplitude=12.0 * pi / 180,
        oscillator_mu=0.35,
        posterior_lag_gain=0.72,
        posterior_damping=0.72,
        los_forward_floor=0.20,
        los_error_scale=0.30,
        desired_turn_rate_limit=0.22,
        turn_rate_error_scale=0.28,
        halfcycle_asymmetry_gain=0.38,
        halfcycle_phase_scale=8.0 * pi / 180,
        halfcycle_scale_min=0.68,
        halfcycle_scale_max=1.32,
        command_acceleration_limit=1600.0 * pi / 180,
    )
end

@inline function _finite_or(value, fallback)
    parsed = Float64(value)
    return isfinite(parsed) ? parsed : fallback
end

@inline function _soft_limit(value, limit)
    safe_limit = max(_finite_or(limit, 1.0), 1.0e-6)
    return safe_limit * tanh(_finite_or(value, 0.0) / safe_limit)
end

function yaw_response_guidance(state, params)
    distance = max(_finite_or(state.distance_L, 1.0), 1.0e-6)
    target_x = _finite_or(state.target_body_L[1], -distance)
    target_y = _finite_or(state.target_body_L[2], 0.0)

    # Material body -x points forward. Normalize by range so the request is
    # resolution- and distance-independent while retaining the behind-target
    # distinction that the evaluator's abs-x bearing intentionally omits.
    forward = -target_x / distance
    lateral = target_y / distance
    los_error = atan(lateral, max(forward, params.los_forward_floor))

    measured_turn_rate = hasproperty(state, :turn_rate_recent) ?
        _finite_or(state.turn_rate_recent, 0.0) :
        _finite_or(state.heading_rate, 0.0)
    desired_turn_rate =
        -params.desired_turn_rate_limit *
        tanh(los_error / max(params.los_error_scale, 1.0e-6))
    turn_rate_error = desired_turn_rate - measured_turn_rate
    turn_response = tanh(
        turn_rate_error / max(params.turn_rate_error_scale, 1.0e-6),
    )

    return (
        los_error=los_error,
        measured_turn_rate=measured_turn_rate,
        desired_turn_rate=desired_turn_rate,
        turn_response=turn_response,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amplitude = params.oscillator_amplitude
    q1 = _finite_or(state.phi[1], 0.0)
    q2 = _finite_or(state.phi[2], 0.0)
    qd1 = _finite_or(state.phi_dot[1], 0.0)
    qd2 = _finite_or(state.phi_dot[2], 0.0)

    # State-feedback anterior oscillator: no elapsed-time phase is required.
    vdp_drive = params.oscillator_mu * (1.0 - (q1 / amplitude)^2) * qd1
    anterior_raw = vdp_drive - omega^2 * q1

    # The unsteered posterior target is a directed, lagged traveling bend.
    # Smoothly strengthen the half-cycle whose sign matches the requested yaw
    # response and weaken its opposite. This creates average turning authority
    # without imposing a static posterior curvature that can collapse thrust.
    guidance = yaw_response_guidance(state, params)
    posterior_wave =
        -q1 - params.posterior_lag_gain * qd1 / max(omega, eps(Float64))
    wave_side = tanh(
        posterior_wave / max(params.halfcycle_phase_scale, 1.0e-6),
    )
    halfcycle_scale = clamp(
        1.0 +
        params.halfcycle_asymmetry_gain * guidance.turn_response * wave_side,
        params.halfcycle_scale_min,
        params.halfcycle_scale_max,
    )
    posterior_target = halfcycle_scale * posterior_wave
    posterior_raw =
        omega^2 * (posterior_target - q2) -
        2.0 * params.posterior_damping * omega * qd2

    limit = params.command_acceleration_limit
    return (
        phi_ddot=(
            _soft_limit(anterior_raw, limit),
            _soft_limit(posterior_raw, limit),
        ),
    )
end
