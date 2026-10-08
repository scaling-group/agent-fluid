function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        steering_acceleration=10.0,
        steering_bearing_scale=0.35,
        steering_lookahead_fraction=0.40,
        steering_lead_limit=0.25,
        tail_steering_ratio=0.55,
        acceleration_envelope=30.0,
        steering_reserve_fraction=0.20,
    )
end

@inline function bounded_residual_mix(carrier, steering, envelope, reserve_fraction)
    reserve = clamp(reserve_fraction, 0.0, 1.0) * steering
    residual = carrier + (1.0 - clamp(reserve_fraction, 0.0, 1.0)) * steering
    residual_envelope = max(envelope - abs(reserve), eps(envelope))
    return reserve + clamp(residual, -residual_envelope, residual_envelope)
end

@inline function predicted_bearing(
    bearing,
    bearing_window_rate,
    control_period,
    lookahead_fraction,
    lead_limit,
)
    lookahead_time = max(lookahead_fraction, 0.0) * control_period
    bounded_lead = clamp(
        lookahead_time * bearing_window_rate,
        -abs(lead_limit),
        abs(lead_limit),
    )
    return bearing + bounded_lead
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # State-only reflex oscillator: the phase is encoded in (q1, qd1), not time.
    # This carrier supplies a target-blind propulsive rhythm.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1

    # Tail follows the first joint with a velocity-dependent lag, producing a
    # smooth traveling bend without prescribing a clocked waveform.
    phase_lag_target = -q1 - params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    # Predict bearing by a bounded fraction of one beat using the filtered
    # body-frame error trend. This releases steering when a correct-sign turn
    # is already developing and reinforces it when the target is diverging.
    steering_bearing = predicted_bearing(
        Float64(state.bearing),
        Float64(state.bearing_window_rate),
        params.control_period,
        params.steering_lookahead_fraction,
        params.steering_lead_limit,
    )
    steering = params.steering_acceleration *
        tanh(steering_bearing / params.steering_bearing_scale)
    tail_steering = params.tail_steering_ratio * steering

    # Keep a small steering share available inside a candidate-owned envelope,
    # then fit the carrier plus remaining residual into the available budget.
    # This prevents symmetric episode clipping from erasing direction feedback.
    command1 = bounded_residual_mix(
        a1,
        steering,
        params.acceleration_envelope,
        params.steering_reserve_fraction,
    )
    command2 = bounded_residual_mix(
        a2,
        tail_steering,
        params.acceleration_envelope,
        params.steering_reserve_fraction,
    )

    return (
        phi_ddot=(
            command1,
            command2,
        ),
    )
end
