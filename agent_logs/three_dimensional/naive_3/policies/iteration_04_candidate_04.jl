# Distance-scheduled approach control around the demonstrated body-frame
# bearing/slip carrier. Propulsive phase remains entirely in joint state.

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
        approach_distance_L=4.0,
        approach_min_drive_scale=0.30,
        approach_shape=2.0,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

    # Distance continuously schedules the carrier envelope. Far from the
    # target this is exactly the sampled slip-feedback gait; near the target,
    # propulsion is relieved without switching modes or suppressing steering.
    raw_distance = Float64(state.distance_L)
    distance = isfinite(raw_distance) ? max(raw_distance, 0.0) : params.approach_distance_L
    approach_fraction = clamp(
        distance / max(params.approach_distance_L, eps(Float64)),
        0.0,
        1.0,
    )
    minimum_drive = clamp(params.approach_min_drive_scale, eps(Float64), 1.0)
    drive_scale = minimum_drive + (1.0 - minimum_drive) *
        approach_fraction^max(params.approach_shape, eps(Float64))

    # Van der Pol drive: oscillation phase lives in (q1, qd1), not clock time.
    scheduled_amplitude = max(amp * drive_scale, eps(Float64))
    vdp_drive = params.oscillator_mu *
        (1 - (q1 / scheduled_amplitude)^2) * qd1
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

    # Body-frame slip anticipates accumulated lateral target error. The
    # steering residual keeps full authority as the oscillatory carrier fades.
    steering_signal = bearing -
        params.lateral_velocity_feedback * lateral_velocity
    mean_tail_tangent = params.turn_curvature_limit * tanh(
        steering_signal / max(params.bearing_scale, eps(Float64)),
    )

    carrier_tail_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(Float64))
    tail_target = mean_tail_tangent + drive_scale * carrier_tail_target
    a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
