function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        steering_acceleration=10.0,
        steering_bearing_scale=0.35,
        course_slip_gain=0.10,
        course_speed_scale=0.10,
        tail_steering_ratio=0.55,
        acceleration_envelope=30.0,
        steering_reserve_fraction=0.20,
        redirect_reserve_gain=0.25,
        redirect_error_scale=0.60,
    )
end

@inline function error_scheduled_reserve(
    route_error,
    base_fraction,
    reserve_gain,
    error_scale,
)
    normalized_error = tanh(abs(route_error) / max(error_scale, eps(Float64)))
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

    # Separate persistent target error from lateral motion already carrying the
    # fish toward that target. The normalized body-frame course component is a
    # bounded slip proxy and vanishes continuously when the fish is stationary.
    velocity_forward = Float64(state.velocity_body_U[1])
    velocity_lateral = Float64(state.velocity_body_U[2])
    speed = hypot(velocity_forward, velocity_lateral)
    course_slip = velocity_lateral / (speed + params.course_speed_scale)
    steering_error = Float64(state.bearing) - params.course_slip_gain * course_slip

    # A bounded mean-curvature residual turns the traveling bend toward the
    # target while damping redundant lateral correction. Both observations are
    # dimensionless and body-fixed, so no world-frame route is prescribed.
    steering = params.steering_acceleration *
        tanh(steering_error / params.steering_bearing_scale)
    tail_steering = params.tail_steering_ratio * steering

    # Persistent route error gets more directional half-cycle authority. Using
    # the slip-corrected error avoids reserving extra steering merely because
    # lateral motion is already carrying the fish toward the target.
    reserve_fraction = error_scheduled_reserve(
        steering_error,
        params.steering_reserve_fraction,
        params.redirect_reserve_gain,
        params.redirect_error_scale,
    )

    # Preserve the successful carrier wherever commands fit the envelope, then
    # fit it and the unreserved residual into the remaining bounded budget.
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
