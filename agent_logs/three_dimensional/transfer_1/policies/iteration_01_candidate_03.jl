# Phase-2 candidate: target-vector mean curvature around a state-feedback
# traveling bend. The policy has no clock, route, case identity, or mutable
# phase; joint position and velocity carry the oscillator phase.

function target_policy_params(; L::Int=64)
    return (
        version="dogfish_3d_bodyframe_mean_curvature_v1",
        control_period=0.80,
        drive_amplitude=22.0 * pi / 180,
        drive_mu=0.35,
        tail_lag_gain=0.80,
        tail_damping_ratio=0.65,
        bearing_forward_floor_L=0.25,
        bearing_limit=1.35,
        bearing_scale=0.28,
        turn_bias_limit=10.0 * pi / 180,
        head_bias_share=1.0,
        tail_bias_share=1.0,
        acceleration_soft_limit=1600.0 * pi / 180,
    )
end

@inline function _finite_or(value, fallback)
    parsed = Float64(value)
    return isfinite(parsed) ? parsed : fallback
end

function body_frame_turn_request(state, params)
    # The fish's forward direction is negative body x. Both components are
    # already normalized by L in the observation contract.
    target_x = _finite_or(state.target_body_L[1], -1.0)
    target_y = _finite_or(state.target_body_L[2], 0.0)
    forward = -target_x
    bearing = atan(target_y, max(forward, params.bearing_forward_floor_L))
    bounded_bearing = clamp(bearing, -params.bearing_limit, params.bearing_limit)
    return tanh(bounded_bearing / max(params.bearing_scale, eps(Float64)))
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amplitude = params.drive_amplitude

    q1 = _finite_or(state.phi[1], 0.0)
    q2 = _finite_or(state.phi[2], 0.0)
    qd1 = _finite_or(state.phi_dot[1], 0.0)
    qd2 = _finite_or(state.phi_dot[2], 0.0)

    # Positive body-frame target bearing requests positive mean joint bend.
    # The verified 3D plant convention maps that bend to negative yaw.
    turn_request = body_frame_turn_request(state, params)
    bend_bias = params.turn_bias_limit * turn_request
    head_bias = params.head_bias_share * bend_bias
    tail_bias = params.tail_bias_share * bend_bias

    # Sustain the anterior rhythm around the steering equilibrium. This is a
    # state-feedback oscillator: no elapsed time or hidden phase is used.
    centered_q1 = q1 - head_bias
    vdp_drive =
        params.drive_mu * (1 - (centered_q1 / max(amplitude, eps(Float64)))^2) * qd1
    head_accel = vdp_drive - omega^2 * centered_q1

    # The posterior joint follows a lagged version of the centered anterior
    # rhythm while sharing its mean bend. Thus steering does not erase the
    # posterior traveling-wave component that produced the sampled coherent wake.
    tail_target =
        tail_bias - centered_q1 - params.tail_lag_gain * qd1 / max(omega, eps(Float64))
    tail_accel =
        omega^2 * (tail_target - q2) -
        2 * params.tail_damping_ratio * omega * qd2

    limit = params.acceleration_soft_limit
    return (
        phi_ddot=(
            clamp(head_accel, -limit, limit),
            clamp(tail_accel, -limit, limit),
        ),
    )
end
