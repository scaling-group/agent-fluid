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
        redirect_burst_asymmetry=0.30,
    )
end

@inline function half_cycle_steering(
    steering,
    steering_direction,
    phase_velocity,
    asymmetry,
)
    bounded_asymmetry = clamp(asymmetry, 0.0, 0.75)
    alignment = tanh(steering_direction * phase_velocity)
    return steering * (1.0 + bounded_asymmetry * alignment)
end

@inline function response_scheduled_asymmetry(
    bearing,
    bearing_window_rate,
    heading_rate,
    control_period,
    bearing_scale,
    base_asymmetry,
    burst_asymmetry,
)
    scale = max(bearing_scale, eps(Float64))
    raw_bearing = Float64(bearing)
    error_strength = tanh(abs(raw_bearing) / scale)

    # A smooth bearing sign makes response detection continuous through target
    # alignment. The dimensionless response is the bearing removed in one beat
    # relative to the same angular scale used by the steering residual.
    soft_sign = raw_bearing / hypot(raw_bearing, 0.25 * scale)
    closing_rate = max(
        -soft_sign * Float64(bearing_window_rate),
        0.0,
    )
    period = max(control_period, 0.0)
    bearing_response = tanh(closing_rate * period / scale)

    # Bearing closure includes both translation and rotation. Direct body yaw
    # is a complementary fast response cue: when the fish is already rotating
    # toward the raw body-frame bearing request, release only surplus redirect
    # burst. Opposing yaw retains all established steering authority.
    assisting_yaw_rate = max(
        soft_sign * Float64(heading_rate),
        0.0,
    )
    yaw_response = tanh(assisting_yaw_rate * period / scale)
    response = 1.0 - (1.0 - bearing_response) * (1.0 - yaw_response)
    unmet_redirect = error_strength * (1.0 - response)

    return clamp(
        base_asymmetry + max(burst_asymmetry, 0.0) * unmet_redirect,
        0.0,
        0.75,
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

    # Course feedback damps curvature already expressed as targetward lateral
    # motion. Its soft normalization remains bounded and continuous at rest.
    velocity_forward = Float64(state.velocity_body_U[1])
    velocity_lateral = Float64(state.velocity_body_U[2])
    speed = hypot(velocity_forward, velocity_lateral)
    course_slip = velocity_lateral /
        (speed + max(params.course_speed_scale, eps(Float64)))
    bearing = Float64(state.bearing)
    steering_error = bearing - params.course_response_gain * course_slip

    # A bounded mean-curvature residual turns the traveling bend toward the
    # target. Both inputs are dimensionless and body-fixed, so no world-frame
    # route or prescribed wake phase is encoded.
    steering_direction = tanh(
        steering_error / params.steering_bearing_scale,
    )
    mean_steering = params.steering_acceleration * steering_direction

    # Preserve the mean-curvature request while moving a bounded share of it
    # toward the observed half-cycle already traveling in the requested turn
    # direction. A raw-bearing response reflex adds redirect authority only
    # while neither recent bearing closure nor targetward body yaw already
    # supplies the requested response. Beat phase comes from joint state, not a
    # clock or wake route.
    phase_velocity_scale = max(omega * amp, eps(Float64))
    active_asymmetry = response_scheduled_asymmetry(
        bearing,
        state.bearing_window_rate,
        state.heading_rate,
        params.control_period,
        params.steering_bearing_scale,
        params.half_cycle_asymmetry,
        params.redirect_burst_asymmetry,
    )
    steering = half_cycle_steering(
        mean_steering,
        steering_direction,
        qd1 / phase_velocity_scale,
        active_asymmetry,
    )
    tail_steering = params.tail_steering_ratio * half_cycle_steering(
        mean_steering,
        steering_direction,
        qd2 / phase_velocity_scale,
        active_asymmetry,
    )

    # Raw target geometry, rather than the slip-corrected residual, owns the
    # actuator reservation. This preserves redirect authority during large
    # errors while course response only removes redundant curvature demand.
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
