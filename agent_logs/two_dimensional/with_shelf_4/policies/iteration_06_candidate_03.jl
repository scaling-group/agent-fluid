function target_policy_params()
    return (
        control_period=0.72,
        oscillator_amplitude=22.0 * pi / 180,
        oscillator_mu=0.4,
        bearing_scale=25.0 * pi / 180,
        bearing_rate_scale=0.5,
        bearing_rate_damping=0.2,
        half_cycle_asymmetry=0.3,
        phase_softness=0.35,
        tail_lag_gain=0.65,
        tail_damping=0.7,
        moment_scale=0.08,
        moment_rejection_gain=0.15,
        yaw_rate_scale=0.5,
        yaw_rate_damping=0.08,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

    # Persistent body-frame bearing owns the route. Its windowed rate releases
    # part of the request while alignment is improving and restores it when
    # bearing diverges, without a hidden mode or elapsed-time schedule.
    bearing_error = Float64(state.bearing) / params.bearing_scale
    bearing_rate = tanh(
        Float64(state.bearing_window_rate) / params.bearing_rate_scale,
    )
    route_turn = tanh(
        bearing_error + params.bearing_rate_damping * bearing_rate,
    )

    # Retain the evidenced direct normalized load residual, and add a smaller
    # response-damping residual from normalized body yaw rate. Positive mean
    # bend produces negative yaw for this body map, so the positive sign makes
    # the new term oppose positive rotation. Both are bounded corrections;
    # neither can become an external wake phase or persistent route owner.
    wake_turn = params.moment_rejection_gain * tanh(
        Float64(state.moment_z_L2) / params.moment_scale,
    )
    yaw_damping_turn = params.yaw_rate_damping * tanh(
        Float64(state.heading_rate) / params.yaw_rate_scale,
    )
    turn_request = clamp(
        route_turn + wake_turn + yaw_damping_turn,
        -1.0,
        1.0,
    )

    # Infer the active beat side from joint state and strengthen only the
    # requested half-cycle. The restoring equilibrium stays at zero, retaining
    # the successful alternating propulsion while all feedback terms vanish.
    phase_coordinate = (q1 + qd1 / max(omega, eps(omega))) / amp
    beat_side = tanh(phase_coordinate / params.phase_softness)
    half_cycle_amplitude = amp * (
        1 + params.half_cycle_asymmetry * turn_request * beat_side
    )

    # Regulate the phase-plane radius to the selected half-cycle envelope. The
    # joint state, rather than time, remains the oscillator phase.
    normalized_position = q1 / half_cycle_amplitude
    normalized_velocity = qd1 / (omega * half_cycle_amplitude)
    radius_squared = normalized_position^2 + normalized_velocity^2
    radial_drive = params.oscillator_mu * omega *
        (1 - clamp(radius_squared, 0.0, 4.0)) * qd1
    a1 = radial_drive - omega^2 * q1

    # Retain a posterior-lagged traveling bend. Steering residuals act only
    # through the anterior envelope, so they cannot replace the tail's
    # alternating propulsive target with a separate steering offset.
    tail_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
