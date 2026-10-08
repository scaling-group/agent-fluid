function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        steering_acceleration=10.0,
        steering_bearing_scale=0.35,
        moment_assist_relief_fraction=0.25,
        moment_assist_scale=0.18,
        tail_steering_ratio=0.55,
        acceleration_envelope=30.0,
        steering_reserve_fraction=0.20,
        redirect_reserve_gain=0.25,
        redirect_bearing_scale=0.60,
    )
end

@inline function bearing_scheduled_reserve(
    bearing,
    base_fraction,
    reserve_gain,
    bearing_scale,
)
    normalized_error = tanh(abs(Float64(bearing)) / max(bearing_scale, eps(Float64)))
    return clamp(base_fraction + max(reserve_gain, 0.0) * normalized_error^2, 0.0, 1.0)
end

@inline function assist_aware_steering(
    turn_request,
    moment_z_L2,
    acceleration,
    relief_fraction,
    moment_scale,
)
    # Positive alignment means that the measured hydrodynamic moment is
    # already turning the body in the target-requested direction. Unload only
    # that assistance; an opposing moment retains the evaluated command.
    assisting_moment = max(turn_request * moment_z_L2, 0.0)
    relief = clamp(
        max(relief_fraction, 0.0) *
        tanh(assisting_moment / max(moment_scale, eps(Float64))),
        0.0,
        0.9,
    )
    return acceleration * turn_request * (1.0 - relief)
end

@inline function bounded_residual_mix(carrier, steering, envelope, reserve_fraction)
    reserve = clamp(reserve_fraction, 0.0, 1.0) * steering
    residual = carrier + (1.0 - clamp(reserve_fraction, 0.0, 1.0)) * steering
    residual_envelope = max(envelope - abs(reserve), eps(envelope))
    return reserve + clamp(residual, -residual_envelope, residual_envelope)
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # State-only reflex oscillator: the phase is encoded in (q1, qd1), not time.
    # This seed supplies only a target-blind propulsion rhythm.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1

    # Tail follows the first joint with a velocity-dependent lag, producing a
    # smooth traveling bend without prescribing a clocked waveform.
    phase_lag_target = -q1 - params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    # A bounded mean-curvature residual turns the traveling bend toward the
    # target. Bearing is dimensionless and body-fixed, so the command follows
    # current target geometry instead of a world-frame route.
    bearing = Float64(state.bearing)
    turn_request = tanh(bearing / params.steering_bearing_scale)
    steering = assist_aware_steering(
        turn_request,
        Float64(state.moment_z_L2),
        params.steering_acceleration,
        params.moment_assist_relief_fraction,
        params.moment_assist_scale,
    )
    tail_steering = params.tail_steering_ratio * steering

    # Large observed direction errors temporarily prioritize the turning
    # half-cycle. Alignment returns continuously to the evaluated cruise
    # reservation, so the mechanism neither adds a hidden stage nor raises the
    # successful candidate-owned acceleration envelope.
    reserve_fraction = bearing_scheduled_reserve(
        bearing,
        params.steering_reserve_fraction,
        params.redirect_reserve_gain,
        params.redirect_bearing_scale,
    )

    command1 = bounded_residual_mix(
        a1,
        steering,
        params.acceleration_envelope,
        reserve_fraction,
    )
    command2 = bounded_residual_mix(
        a2,
        tail_steering,
        params.acceleration_envelope,
        reserve_fraction,
    )

    return (
        phi_ddot=(
            command1,
            command2,
        ),
    )
end
