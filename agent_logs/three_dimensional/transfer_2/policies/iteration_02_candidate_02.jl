# Tail-only response-gated redirect for the L64 moving-window target task.
# Preserve the coherent traveling bend while separating modest route curvature
# from stronger measured-response braking near target alignment.

function target_policy_params()
    return (
        version="dogfish3d_tail_route_response_brake_v2",
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.80,
        tail_damping=0.65,
        bearing_limit=1.20,
        bearing_scale=0.45,
        route_curvature_limit=4.0 * pi / 180,
        turn_rate_scale=0.55,
        brake_bearing_scale=0.75,
        brake_curvature_limit=11.0 * pi / 180,
        total_curvature_limit=12.0 * pi / 180,
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

    # Keep the anterior oscillator centered at zero.  The sampled distributed
    # mean-bend policy lost translation when steering shifted this equilibrium.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amplitude)^2) * qd1
    head_drive = vdp_drive - omega^2 * q1

    bearing = clamp(
        _policy_safe(state.bearing, 0.0),
        -params.bearing_limit,
        params.bearing_limit,
    )
    turn_rate = hasproperty(state, :turn_rate_recent) ?
        _policy_safe(state.turn_rate_recent, 0.0) :
        _policy_safe(state.heading_rate, 0.0)

    # Positive body-frame bearing needs positive tail curvature, whose sampled
    # 3D response is negative yaw.  Keep this route request deliberately small.
    route_curvature =
        params.route_curvature_limit *
        tanh(bearing / max(params.bearing_scale, eps(Float64)))

    # Same-sign rate curvature opposes the measured yaw response: positive
    # curvature drives negative yaw and negative curvature drives positive yaw.
    # Near alignment it can dominate the route term; for large bearing its
    # authority recedes smoothly so that redirection is not frozen.
    normalized_bearing =
        bearing / max(params.brake_bearing_scale, eps(Float64))
    alignment_gate = 1 / (1 + normalized_bearing^2)
    response_brake =
        params.brake_curvature_limit *
        alignment_gate *
        tanh(turn_rate / max(params.turn_rate_scale, eps(Float64)))
    mean_tail_tangent = _policy_soft_limit(
        route_curvature + response_brake,
        params.total_curvature_limit,
    )

    # Steering enters only through the posterior target, leaving the anterior
    # propulsive limit cycle intact and retaining the evidenced phase lag.
    tail_target =
        mean_tail_tangent - q1 -
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
