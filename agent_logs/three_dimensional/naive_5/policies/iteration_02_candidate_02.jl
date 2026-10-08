# Turn-response-gated posterior half-cycle asymmetry on a state-feedback
# traveling bend. Oscillator phase comes only from joint state; target steering
# uses normalized body-frame geometry and no clock, route, or window position.

function target_policy_params()
    return (
        control_period=0.85,
        oscillator_amplitude=14.0 * pi / 180,
        oscillator_mu=0.35,
        tail_amplitude_ratio=1.15,
        tail_phase_lag=0.5 * pi,
        tail_damping=0.85,
        bearing_limit=1.0,
        bearing_scale=0.30,
        turn_rate_scale=0.80,
        turn_rate_damping=0.35,
        tail_half_cycle_bend=10.0 * pi / 180,
        tail_phase_gate_width=0.35,
        acceleration_limit=28.0,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

    # Keep the anterior carrier centered. Its nominal cadence and amplitude
    # leave authority for the posterior steering stroke within the fixed
    # acceleration, speed, and angle envelope.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1

    # Reconstruct the posterior phase from anterior joint state. This retains
    # a directed, posterior-emphasized wave without an external phase source.
    base_tail_target = params.tail_amplitude_ratio * (
        cos(params.tail_phase_lag) * q1 -
        sin(params.tail_phase_lag) * qd1 / max(omega, eps(omega))
    )

    # Positive bearing calls for negative yaw in the lane convention. Recent
    # measured yaw releases a correct response and reverses an overshoot. The
    # requested yaw selects the opposite-signed tail bend established by the
    # sampled mean-bend response.
    bearing = clamp(
        Float64(state.bearing),
        -params.bearing_limit,
        params.bearing_limit,
    )
    recent_turn_rate = Float64(state.turn_rate_recent)
    turn_request = -bearing - params.turn_rate_damping * tanh(
        recent_turn_rate / params.turn_rate_scale,
    )
    turn_command = tanh(turn_request / params.bearing_scale)
    selected_tail_side = -turn_command

    # Enlarge only the already-compatible posterior half-stroke. Unlike a
    # persistent curvature bias, this gives the next opposite half-cycle a
    # clean opportunity to reverse the turn and leaves joint 1 propulsive.
    tail_phase_scale = max(params.tail_amplitude_ratio * amp, eps(amp))
    normalized_tail_phase = base_tail_target / tail_phase_scale
    compatible_half_cycle = 0.5 * (1 + tanh(
        selected_tail_side * normalized_tail_phase /
        params.tail_phase_gate_width,
    ))
    steering_bend = params.tail_half_cycle_bend * selected_tail_side *
        abs(turn_command) * compatible_half_cycle
    tail_target = base_tail_target + steering_bend
    a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    limit = params.acceleration_limit
    return (phi_ddot=(clamp(a1, -limit, limit), clamp(a2, -limit, limit)),)
end
