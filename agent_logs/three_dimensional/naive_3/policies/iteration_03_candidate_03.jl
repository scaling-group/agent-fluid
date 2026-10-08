# Body-frame lateral-slip damping around the strongest sampled traveling-bend
# carrier. Oscillator phase remains entirely in observed joint state.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        turn_curvature_limit=12.0 * pi / 180,
        bearing_limit=pi / 2,
        bearing_scale=0.20,
        lateral_velocity_limit=0.8,
        lateral_velocity_feedback=0.45,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

    # Van der Pol drive: propulsion phase lives in (q1, qd1), never in time.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1

    raw_bearing = Float64(state.bearing)
    raw_lateral_velocity = Float64(state.velocity_body_U[2])
    bearing = isfinite(raw_bearing) ?
        clamp(raw_bearing, -params.bearing_limit, params.bearing_limit) : 0.0
    lateral_velocity = isfinite(raw_lateral_velocity) ?
        clamp(
            raw_lateral_velocity,
            -params.lateral_velocity_limit,
            params.lateral_velocity_limit,
        ) : 0.0

    # With the head-facing (-x) convention, positive target bearing requests
    # positive mean tail tangent and negative yaw. Subtracting lateral body
    # velocity releases the bend when translation is already target-directed
    # and strengthens it when the fish slips across or away from the target.
    steering_signal = bearing -
        params.lateral_velocity_feedback * lateral_velocity
    mean_tail_tangent = params.turn_curvature_limit * tanh(
        steering_signal / max(params.bearing_scale, eps(Float64)),
    )

    # Superpose the bounded steering residual on the demonstrated posterior
    # traveling-wave target without shifting the anterior oscillator center.
    phase_lag_target = mean_tail_tangent - q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(Float64))
    a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
