function target_policy_params()
    return (
        control_period=0.72,
        oscillator_amplitude=22.0 * pi / 180,
        oscillator_mu=0.4,
        bearing_scale=25.0 * pi / 180,
        bearing_rate_scale=0.5,
        bearing_rate_damping=0.2,
        closing_speed_scale=0.05,
        half_cycle_asymmetry=0.3,
        phase_softness=0.35,
        tail_lag_gain=0.65,
        tail_redirect_asymmetry=0.15,
        tail_damping=0.7,
        moment_scale=0.08,
        moment_rejection_gain=0.15,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

    # Persistent body-frame bearing owns the route. Qualify its windowed-rate
    # damping with measured target-distance progress: alignment change alone
    # can be body spin, while positive closing speed confirms useful response.
    # This keeps the redirect firm until it produces translation, then restores
    # the sampled damping continuously without a hidden mode or time schedule.
    bearing_error = Float64(state.bearing) / params.bearing_scale
    bearing_rate = tanh(
        Float64(state.bearing_window_rate) / params.bearing_rate_scale,
    )
    closing_progress = tanh(
        max(Float64(state.window_closing_speed_L), 0.0) /
        params.closing_speed_scale,
    )
    route_turn = tanh(
        bearing_error +
        params.bearing_rate_damping * closing_progress * bearing_rate,
    )

    # Retain the evidenced smaller, direct normalized yaw-load residual. It
    # trims fast wake disturbances without concentrating authority near zero
    # bearing or assuming an external vortex phase.
    wake_turn = params.moment_rejection_gain * tanh(
        Float64(state.moment_z_L2) / params.moment_scale,
    )
    turn_request = clamp(route_turn + wake_turn, -1.0, 1.0)

    # Infer the active beat side from joint state and strengthen only the
    # requested half-cycle. The restoring equilibrium stays at zero, retaining
    # the successful alternating propulsion while route and wake terms vanish.
    phase_coordinate = (q1 + qd1 / max(omega, eps(omega))) / amp
    beat_side = tanh(phase_coordinate / params.phase_softness)
    half_cycle_amplitude = amp * (
        1 + params.half_cycle_asymmetry * turn_request * beat_side
    )

    normalized_position = q1 / half_cycle_amplitude
    normalized_velocity = qd1 / (omega * half_cycle_amplitude)
    radius_squared = normalized_position^2 + normalized_velocity^2
    radial_drive = params.oscillator_mu * omega *
        (1 - clamp(radius_squared, 0.0, 4.0)) * qd1
    a1 = radial_drive - omega^2 * q1

    # Recruit posterior curvature only for a large redirect that has not yet
    # produced target-distance closure. Unlike persistent tail route sharing,
    # this state-feedback burst releases continuously once useful translation
    # appears, restoring the ordinary lagged traveling wave for the approach.
    redirect_gate = abs(route_turn) * (1 - closing_progress)
    tail_wave = -params.tail_lag_gain * qd1 / max(omega, eps(omega))
    tail_phase_scale = max(
        params.tail_lag_gain * amp * params.phase_softness,
        eps(amp),
    )
    tail_side = tanh(tail_wave / tail_phase_scale)
    tail_redirect_gain = 1 +
        params.tail_redirect_asymmetry * redirect_gate * route_turn * tail_side
    tail_target = -q1 + tail_redirect_gain * tail_wave
    a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
