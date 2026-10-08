# Target-feedback half-cycle steering on a state-feedback traveling bend.
# Joint state supplies phase; no clock, world route, or moving-window position
# enters the policy.

function target_policy_params()
    return (
        control_period=1.10,
        oscillator_amplitude=18.0 * pi / 180,
        oscillator_mu=0.35,
        tail_amplitude_ratio=1.25,
        tail_phase_lag=85.0 * pi / 180,
        tail_damping=0.75,
        bearing_limit=1.20,
        bearing_scale=0.35,
        turn_rate_limit=3.0,
        turn_rate_scale=2.0,
        phase_radius_floor=4.0 * pi / 180,
        steering_amplitude1=2.5 * pi / 180,
        steering_amplitude2=3.0 * pi / 180,
        acceleration_limit=29.0,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

    # Recover a bounded phase representation from the anterior oscillator.
    # Under reflection, both phase components change sign while the second
    # harmonic is invariant, so the target command retains mirror equivariance.
    phase_velocity = qd1 / max(omega, eps(omega))
    phase_radius = max(
        hypot(q1, phase_velocity),
        params.phase_radius_floor,
    )
    sin_phase = q1 / phase_radius
    cos_phase = phase_velocity / phase_radius
    harmonic1 = cos_phase^2 - sin_phase^2

    # Positive body-frame bearing needs negative yaw. The common half-cycle
    # mode has that sign for a positive command; recent turn rate releases the
    # command and provides prompt braking after a bearing-sign change.
    bearing = clamp(
        Float64(state.bearing),
        -params.bearing_limit,
        params.bearing_limit,
    )
    turn_rate = clamp(
        Float64(state.turn_rate_recent),
        -params.turn_rate_limit,
        params.turn_rate_limit,
    )
    turn_command = tanh(
        bearing / params.bearing_scale +
        turn_rate / params.turn_rate_scale,
    )

    # Preserve the zero-centered carrier that produced an alternating wake
    # without physical saturation in the strongest feedback candidate.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    steering_accel1 = -4 * omega^2 * params.steering_amplitude1 *
        turn_command * harmonic1
    a1 = vdp_drive - omega^2 * q1 + steering_accel1

    # Reconstruct the posterior carrier and its phase-shifted second harmonic.
    # The latter changes half-cycle strength but has zero mean over an ideal
    # beat, avoiding the persistent curvature that failed in all parent samples.
    lag_cos = cos(params.tail_phase_lag)
    lag_sin = sin(params.tail_phase_lag)
    tail_target = params.tail_amplitude_ratio * (
        lag_cos * q1 - lag_sin * phase_velocity
    )
    tail_sin_phase = lag_cos * sin_phase - lag_sin * cos_phase
    tail_cos_phase = lag_cos * cos_phase + lag_sin * sin_phase
    harmonic2 = tail_cos_phase^2 - tail_sin_phase^2
    steering_accel2 = -4 * omega^2 * params.steering_amplitude2 *
        turn_command * harmonic2
    a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2 + steering_accel2

    limit = params.acceleration_limit
    return (phi_ddot=(clamp(a1, -limit, limit), clamp(a2, -limit, limit)),)
end
