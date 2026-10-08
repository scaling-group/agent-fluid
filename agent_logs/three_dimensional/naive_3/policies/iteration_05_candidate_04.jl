# State-gated active redirect around the demonstrated body-frame bearing/slip
# carrier. Propulsive phase remains entirely in observed joint state.

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
        redirect_distance_L=4.5,
        redirect_distance_width_L=1.0,
        redirect_bearing_start=0.35,
        redirect_bearing_width=0.35,
        redirect_closing_speed_scale=0.60,
        redirect_head_curvature_limit=8.0 * pi / 180,
        redirect_carrier_floor=0.75,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

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
    turn_fraction = tanh(
        steering_signal / max(params.bearing_scale, eps(Float64)),
    )
    mean_tail_tangent = params.turn_curvature_limit * turn_fraction

    # A smooth, memoryless redirect gate distinguishes an imminent
    # misaligned pass from ordinary far-field swimming. Distance alone cannot
    # engage it, and a receding fish releases it instead of entering a hidden
    # approach mode.
    raw_distance = Float64(state.distance_L)
    distance = isfinite(raw_distance) ?
        max(raw_distance, 0.0) :
        params.redirect_distance_L + params.redirect_distance_width_L
    raw_closing_speed = Float64(state.closing_speed_L)
    closing_speed = isfinite(raw_closing_speed) ? max(raw_closing_speed, 0.0) : 0.0

    distance_width = max(params.redirect_distance_width_L, eps(Float64))
    distance_fraction = clamp(
        0.5 + 0.5 * (params.redirect_distance_L - distance) / distance_width,
        0.0,
        1.0,
    )
    distance_gate = distance_fraction^2 * (3.0 - 2.0 * distance_fraction)

    bearing_width = max(params.redirect_bearing_width, eps(Float64))
    bearing_fraction = clamp(
        (abs(steering_signal) - params.redirect_bearing_start) / bearing_width,
        0.0,
        1.0,
    )
    bearing_gate = bearing_fraction^2 * (3.0 - 2.0 * bearing_fraction)

    closing_fraction = clamp(
        closing_speed / max(params.redirect_closing_speed_scale, eps(Float64)),
        0.0,
        1.0,
    )
    closing_gate = closing_fraction^2 * (3.0 - 2.0 * closing_fraction)
    redirect_gate = distance_gate * bearing_gate * closing_gate

    # Recruit a modest anterior mean bend only during the active redirect,
    # while retaining a nonzero limit cycle. Both joint means share the
    # target-relative sign, producing a bounded C-bend rather than passive
    # coasting. Alignment or loss of closing urgency restores the carrier.
    head_mean = redirect_gate *
        params.redirect_head_curvature_limit * turn_fraction
    carrier_floor = clamp(params.redirect_carrier_floor, eps(Float64), 1.0)
    carrier_scale = 1.0 - redirect_gate * (1.0 - carrier_floor)
    centered_q1 = q1 - head_mean

    scheduled_amplitude = max(amp * carrier_scale, eps(Float64))
    vdp_drive = params.oscillator_mu *
        (1 - (centered_q1 / scheduled_amplitude)^2) * qd1
    a1 = vdp_drive - omega^2 * centered_q1

    carrier_tail_target = -centered_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(Float64))
    tail_target = mean_tail_tangent + carrier_tail_target
    a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
