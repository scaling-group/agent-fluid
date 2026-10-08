function target_policy_params()
    return (
        control_period=0.76,
        oscillator_amplitude=22.0 * pi / 180,
        oscillator_mu=0.4,
        bearing_scale=25.0 * pi / 180,
        half_cycle_asymmetry=0.3,
        phase_softness=0.35,
        moment_scale=0.08,
        moment_rejection_gain=0.22,
        tail_lag_gain=0.65,
        tail_damping=0.7,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

    # Keep persistent body-frame target geometry in charge of the route. The
    # successful sampled policy supplies both this sign and the smooth bound.
    route_turn = tanh(Float64(state.bearing) / params.bearing_scale)

    # Reject only a small share of measured yaw load and only through steering
    # authority not already required by the route. The scale is normalized and
    # anchored to successful-rollout moment levels; no wake phase is prescribed.
    moment_request = tanh(
        Float64(state.moment_z_L2) / params.moment_scale,
    )
    steering_headroom = max(0.0, 1.0 - abs(route_turn))
    turn_request = clamp(
        route_turn +
        params.moment_rejection_gain * steering_headroom * moment_request,
        -1.0,
        1.0,
    )

    # The requested bend side receives the stronger half-cycle while the
    # zero-mean oscillator preserves alternating propulsion.
    phase_coordinate = (q1 + qd1 / max(omega, eps(omega))) / amp
    beat_side = tanh(phase_coordinate / params.phase_softness)
    half_cycle_amplitude = amp * (
        1 + params.half_cycle_asymmetry * turn_request * beat_side
    )

    # Regulate phase-plane radius to the selected half-cycle envelope. Joint
    # state, rather than time or an external vortex signal, carries phase.
    normalized_position = q1 / half_cycle_amplitude
    normalized_velocity = qd1 / (omega * half_cycle_amplitude)
    radius_squared = normalized_position^2 + normalized_velocity^2
    radial_drive = params.oscillator_mu * omega *
        (1 - clamp(radius_squared, 0.0, 4.0)) * qd1
    a1 = radial_drive - omega^2 * q1

    # Retain the posterior-lagged traveling bend that produced the sampled
    # upstream target reach; the residual never replaces this propulsive wave.
    tail_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
