function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        steering_acceleration=10.0,
        steering_bearing_scale=0.35,
        course_response_gain=0.10,
        course_speed_scale=0.10,
        tail_steering_ratio=0.55,
        acceleration_envelope=30.0,
        steering_reserve_fraction=0.20,
        redirect_reserve_gain=0.25,
        redirect_bearing_scale=0.60,
        half_cycle_asymmetry=0.25,
        asymmetry_error_scale=0.35,
    )
end

@inline function response_gated_half_cycle_steering(
    steering,
    steering_direction,
    phase_velocity,
    steering_error,
    asymmetry,
    error_scale,
)
    bounded_asymmetry = clamp(asymmetry, 0.0, 0.75)
    response_gate = tanh(
        abs(Float64(steering_error)) / max(error_scale, eps(Float64)),
    )
    alignment = tanh(steering_direction * phase_velocity)
    return steering * (1.0 + bounded_asymmetry * response_gate * alignment)
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

    # Course feedback removes curvature already expressed as targetward
    # lateral motion. Its soft normalization is bounded and continuous at
    # rest, and both observations are body-fixed.
    velocity_forward = Float64(state.velocity_body_U[1])
    velocity_lateral = Float64(state.velocity_body_U[2])
    speed = hypot(velocity_forward, velocity_lateral)
    course_slip = velocity_lateral /
        (speed + max(params.course_speed_scale, eps(Float64)))
    bearing = Float64(state.bearing)
    steering_error = bearing - params.course_response_gain * course_slip

    # A bounded mean-curvature residual turns the traveling bend toward the
    # target. Preserve its average request while biasing the observed joint
    # half-cycle already moving in the requested curvature direction.
    steering_direction = tanh(
        steering_error / params.steering_bearing_scale,
    )
    mean_steering = params.steering_acceleration * steering_direction
    phase_velocity_scale = max(omega * amp, eps(Float64))

    # Large route error admits the evaluated asymmetric redirect. As measured
    # targetward course response removes that error, the state-only gate
    # continuously returns the residual toward symmetric propulsion.
    steering = response_gated_half_cycle_steering(
        mean_steering,
        steering_direction,
        qd1 / phase_velocity_scale,
        steering_error,
        params.half_cycle_asymmetry,
        params.asymmetry_error_scale,
    )
    tail_steering = params.tail_steering_ratio *
        response_gated_half_cycle_steering(
            mean_steering,
            steering_direction,
            qd2 / phase_velocity_scale,
            steering_error,
            params.half_cycle_asymmetry,
            params.asymmetry_error_scale,
        )

    # Raw target geometry owns finite redirect authority. Transient course
    # response can release the asymmetry without prematurely releasing the
    # reservation that protects the persistent route request.
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
