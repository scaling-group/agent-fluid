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
        redirect_bearing_scale=0.60,
        posterior_redirect_share=0.0,
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

    # Correct the curvature request for lateral motion already carrying the
    # fish toward the target. This normalized body-frame slip proxy is bounded
    # by construction and vanishes continuously with speed.
    bearing = Float64(state.bearing)
    velocity_forward = Float64(state.velocity_body_U[1])
    velocity_lateral = Float64(state.velocity_body_U[2])
    speed = hypot(velocity_forward, velocity_lateral)
    course_slip = velocity_lateral /
        (speed + max(params.course_speed_scale, eps(Float64)))
    steering_error = bearing - params.course_slip_gain * course_slip

    # The bounded residual follows the corrected body-frame route error. The
    # raw bearing remains a separate persistent-geometry signal for authority
    # allocation below, rather than letting transient course response suppress
    # both the steering command and the reservation that protects it.
    steering = params.steering_acceleration *
        tanh(steering_error / params.steering_bearing_scale)
    tail_steering = params.tail_steering_ratio * steering

    # Large observed bearing errors temporarily prioritize the turning
    # half-cycle. Allocation depends only on target geometry; course slip
    # modulates the residual without prematurely releasing finite authority.
    anterior_reserve_fraction = bearing_scheduled_reserve(
        bearing,
        params.steering_reserve_fraction,
        params.redirect_reserve_gain,
        params.redirect_bearing_scale,
    )

    # Use the anterior joint to protect the extra redirect authority while the
    # posterior joint preserves the evaluated phase-lagged propulsive carrier.
    # The share parameter makes this actuator-role split explicit without
    # changing the base reservation that both joints already validated.
    posterior_reserve_fraction = clamp(
        params.steering_reserve_fraction +
        clamp(params.posterior_redirect_share, 0.0, 1.0) *
        (anterior_reserve_fraction - params.steering_reserve_fraction),
        0.0,
        1.0,
    )

    command1 = bounded_residual_mix(
        a1,
        steering,
        params.acceleration_envelope,
        anterior_reserve_fraction,
    )
    command2 = bounded_residual_mix(
        a2,
        tail_steering,
        params.acceleration_envelope,
        posterior_reserve_fraction,
    )

    return (
        phi_ddot=(
            command1,
            command2,
        ),
    )
end
