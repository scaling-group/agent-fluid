# Response-gated posterior lag relief around the evidenced body-frame
# bearing/slip carrier. Joint state remains the only source of beat phase.

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
        heading_rate_limit=4.0,
        wrong_way_rate_scale=1.0,
        maximum_lag_relief=0.55,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

    # Preserve the demonstrated zero-centered anterior oscillator without a
    # distance stage or a target-dependent change in its drive envelope.
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

    # Retain the sampled target-relative slip residual and its bounded mean
    # tail curvature. Positive turn command requests negative yaw under the
    # established head-facing convention.
    steering_signal = bearing -
        params.lateral_velocity_feedback * lateral_velocity
    turn_command = tanh(
        steering_signal / max(params.bearing_scale, eps(Float64)),
    )
    mean_tail_tangent = params.turn_curvature_limit * turn_command

    # Heading rate is dominated by the propulsive beat, so use it only as a
    # sign-sensitive response gate. turn_command*heading_rate is positive
    # exactly when observed yaw opposes the requested turn. On those phases,
    # relieve part of the posterior lag so mean curvature is not repeatedly
    # cancelled by the carrier. Correct-sign phases retain the full wave.
    raw_heading_rate = Float64(state.heading_rate)
    heading_rate = isfinite(raw_heading_rate) ? clamp(
        raw_heading_rate,
        -params.heading_rate_limit,
        params.heading_rate_limit,
    ) : 0.0
    wrong_way_rate = max(turn_command * heading_rate, 0.0)
    response_gate = tanh(
        wrong_way_rate / max(params.wrong_way_rate_scale, eps(Float64)),
    )
    lag_relief = clamp(
        params.maximum_lag_relief * abs(turn_command) * response_gate,
        0.0,
        params.maximum_lag_relief,
    )
    effective_tail_lag = params.tail_lag_gain * (1.0 - lag_relief)

    phase_lag_target = mean_tail_tangent - q1 -
        effective_tail_lag * qd1 / max(omega, eps(Float64))
    a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
