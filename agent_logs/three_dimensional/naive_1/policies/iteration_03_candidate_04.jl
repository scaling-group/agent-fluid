# State-feedback traveling-bend carrier with slip-damped push--pull
# half-cycle steering. Oscillator phase remains encoded in joint state.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        steering_acceleration_limit=8.0,
        steering_bearing_scale=0.30,
        lateral_slip_lead=0.50,
        phase_velocity_limit=1.0,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Van der Pol carrier: oscillation phase lives in (q1, qd1), not clock
    # time, and target feedback cannot move its zero-speed equilibrium.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1

    # Positive bearing requests the positive bend observed to produce negative
    # yaw. Body-frame motion toward that target side unloads the request;
    # opposite lateral slip reinforces it without introducing a world route.
    route_error = Float64(state.bearing) -
        params.lateral_slip_lead * Float64(state.velocity_body_U[2])
    turn_request = tanh(route_error / params.steering_bearing_scale)

    # Apply signed work throughout both moving halves: accelerate motion toward
    # the requested bend and brake motion toward the other bend. The speed gate
    # makes the residual vanish at a turning point or stopped carrier, avoiding
    # the static-curvature equilibria seen in phase-blind steering laws.
    phase_speed = clamp(
        abs(qd1) / max(omega * amp, eps(omega * amp)),
        0.0,
        params.phase_velocity_limit,
    )
    push_pull_steer = params.steering_acceleration_limit *
        turn_request * phase_speed
    a1 = vdp_drive - omega^2 * q1 + push_pull_steer

    # Steering reaches the tail only through the anterior traveling wave, so
    # the inherited posterior phase lag remains a propulsion scaffold.
    phase_lag_target = -q1 - params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
