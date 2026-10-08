# Phase-referenced yaw-rate steering around the naive traveling-bend carrier.
# Target geometry requests slow rotation; observed joint state removes the
# beat-synchronous part of measured yaw before the posterior bend responds.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        bearing_limit=pi / 2,
        bearing_scale=0.20,
        bearing_trend_lead=0.15,
        bearing_trend_limit=2.0,
        desired_turn_rate_limit=0.45,
        measured_turn_rate_limit=3.5,
        residual_turn_rate_limit=1.2,
        turn_rate_error_scale=0.30,
        carrier_yaw_angle_gain=1.38,
        carrier_yaw_head_rate_gain=0.68,
        carrier_yaw_tail_rate_gain=0.38,
        carrier_yaw_speed_scale=0.20,
        steering_curvature_limit=12.0 * pi / 180,
        tail_target_limit=40.0 * pi / 180,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

    # Van der Pol drive: oscillation phase lives in (q1, qd1), not clock time.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1

    # Target geometry specifies a bounded desired body turn rate. With the
    # head-facing (-x) convention, positive bearing requires negative yaw.
    raw_bearing = Float64(state.bearing)
    raw_bearing_trend = Float64(state.bearing_window_rate)
    bearing = isfinite(raw_bearing) ?
        clamp(raw_bearing, -params.bearing_limit, params.bearing_limit) : 0.0
    bearing_trend = isfinite(raw_bearing_trend) ?
        clamp(
            raw_bearing_trend,
            -params.bearing_trend_limit,
            params.bearing_trend_limit,
        ) : 0.0
    predicted_bearing = bearing + params.bearing_trend_lead * bearing_trend
    desired_turn_rate = -params.desired_turn_rate_limit * tanh(
        predicted_bearing / max(params.bearing_scale, eps(Float64)),
    )

    # The sampled rollouts show that most instantaneous yaw is synchronized
    # with this carrier's observed joint phase. Remove that component before
    # regulating the slow course. The speed gate makes the estimate neutral at
    # release, before the moving body has developed a hydrodynamic response.
    raw_turn_rate = Float64(state.turn_rate_recent)
    measured_turn_rate = isfinite(raw_turn_rate) ?
        clamp(
            raw_turn_rate,
            -params.measured_turn_rate_limit,
            params.measured_turn_rate_limit,
        ) : 0.0
    velocity_x = Float64(state.velocity_body_U[1])
    velocity_y = Float64(state.velocity_body_U[2])
    body_speed = isfinite(velocity_x) && isfinite(velocity_y) ?
        hypot(velocity_x, velocity_y) : 0.0
    carrier_yaw_weight = tanh(
        body_speed / max(params.carrier_yaw_speed_scale, eps(Float64)),
    )
    carrier_yaw_rate = -carrier_yaw_weight * (
        params.carrier_yaw_angle_gain * q1 +
        params.carrier_yaw_head_rate_gain * qd1 +
        params.carrier_yaw_tail_rate_gain * qd2
    )
    residual_turn_rate = clamp(
        measured_turn_rate - carrier_yaw_rate,
        -params.residual_turn_rate_limit,
        params.residual_turn_rate_limit,
    )

    # Positive mean tail tangent produces negative yaw in the sampled traces.
    # Comparing actual residual yaw with the desired yaw therefore gives a
    # signed accelerate/brake request rather than an undamped bearing offset.
    turn_rate_error = residual_turn_rate - desired_turn_rate
    mean_tail_tangent = params.steering_curvature_limit * tanh(
        turn_rate_error / max(params.turn_rate_error_scale, eps(Float64)),
    )

    # Superpose the rate request on the demonstrated posterior lag, while
    # keeping the target inside a reserve below the physical 45-degree limit.
    carrier_tail_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    tail_target = clamp(
        mean_tail_tangent + carrier_tail_target,
        -params.tail_target_limit,
        params.tail_target_limit,
    )
    a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
