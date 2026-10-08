# Response-gated posterior burst redirect for the 3D moving-window lane. The
# strongest sampled bearing/trend carrier is unchanged at small target error;
# large error can temporarily trade tail-beat amplitude for corrective bend.

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
        bearing_trend_lead=0.15,
        bearing_trend_limit=2.0,
        redirect_error_onset=0.35,
        redirect_error_full=0.80,
        redirect_max_blend=0.75,
        redirect_curvature_limit=28.0 * pi / 180,
        lateral_velocity_limit=1.0,
        target_side_velocity_threshold=0.08,
        target_side_velocity_scale=0.12,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

    # Propulsion phase remains entirely in observed joint state.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1

    raw_bearing = Float64(state.bearing)
    raw_bearing_trend = Float64(state.bearing_window_rate)
    raw_lateral_velocity = Float64(state.velocity_body_U[2])
    bearing = isfinite(raw_bearing) ?
        clamp(raw_bearing, -params.bearing_limit, params.bearing_limit) : 0.0
    bearing_trend = isfinite(raw_bearing_trend) ?
        clamp(raw_bearing_trend, -params.bearing_trend_limit, params.bearing_trend_limit) : 0.0
    lateral_velocity = isfinite(raw_lateral_velocity) ?
        clamp(
            raw_lateral_velocity,
            -params.lateral_velocity_limit,
            params.lateral_velocity_limit,
        ) : 0.0

    # This is the strongest sampled cruise controller. It is exact whenever
    # the large-error redirect gate below is closed.
    predicted_bearing = bearing + params.bearing_trend_lead * bearing_trend
    turn_command = tanh(
        predicted_bearing / max(params.bearing_scale, eps(Float64)),
    )
    carrier_target = -q1 - params.tail_lag_gain * qd1 / max(omega, eps(Float64))
    cruise_target = params.turn_curvature_limit * turn_command + carrier_target

    # C-start-inspired redirect, translated without a timer or stored mode.
    # The smooth error gate opens only after broad target alignment has failed.
    # The response gate is high when lateral motion is absent or points away
    # from the target side, and releases once target-side motion develops.
    error_fraction = clamp(
        (abs(bearing) - params.redirect_error_onset) /
            max(params.redirect_error_full - params.redirect_error_onset, eps(Float64)),
        0.0,
        1.0,
    )
    error_gate = error_fraction^2 * (3.0 - 2.0 * error_fraction)
    target_side_velocity = turn_command * lateral_velocity
    response_gate = 0.5 * (
        1.0 + tanh(
            (params.target_side_velocity_threshold - target_side_velocity) /
                max(params.target_side_velocity_scale, eps(Float64)),
        )
    )
    redirect_blend = params.redirect_max_blend * error_gate * response_gate
    redirect_target = params.redirect_curvature_limit * turn_command
    phase_lag_target =
        (1.0 - redirect_blend) * cruise_target + redirect_blend * redirect_target

    a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
