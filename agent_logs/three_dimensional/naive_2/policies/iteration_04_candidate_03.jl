# Phase-separated posterior mean-curvature steering.  Joint state supplies
# both the clock-free carrier and a bounded estimate of its expected fast
# crossflow/yaw response; steering acts on the remaining slow residuals.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        steering_bearing_scale=0.30,
        steering_crossflow_scale=0.25,
        steering_crossflow_weight=0.75,
        steering_yaw_rate_scale=0.35,
        steering_yaw_rate_weight=0.45,
        phase_coordinate_limit=1.5,
        crossflow_phase_angle_gain=-0.062,
        crossflow_phase_velocity_gain=0.393,
        yaw_phase_angle_gain=0.701,
        yaw_phase_velocity_gain=-3.010,
        steering_curvature_limit=12.0 * pi / 180,
        actuation_soft_limit=1800.0 * pi / 180,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Preserve the released anterior oscillator: the sampled static-centering
    # policies suppressed propulsion, while this zero-mean carrier produced a
    # coherent alternating three-dimensional wake.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1_raw = vdp_drive - omega^2 * q1

    # Separate predictable carrier-synchronous response from slow course
    # response.  Across the four sampled direct-uniform traces, these two
    # normalized phase coordinates explain most raw short-window yaw and
    # relative-crossflow variation.  Clamping makes the projection a local
    # carrier model rather than an extrapolating disturbance command.
    phase_limit = params.phase_coordinate_limit
    phase_angle = clamp(
        q1 / max(amp, eps(Float64)),
        -phase_limit,
        phase_limit,
    )
    phase_velocity = clamp(
        qd1 / max(omega * amp, eps(Float64)),
        -phase_limit,
        phase_limit,
    )

    # Bearing supplies route geometry.  Only phase-orthogonal crossflow and
    # yaw remain in the steering loop, so the propulsive beat cannot masquerade
    # as alternating course slip or corrective rotation.
    bearing_value = Float64(state.bearing)
    bearing = isfinite(bearing_value) ? bearing_value : 0.0
    crossflow_value = Float64(state.relative_flow_velocity_body_U[2])
    crossflow = isfinite(crossflow_value) ? crossflow_value : 0.0
    yaw_rate_value = Float64(state.turn_rate_recent)
    yaw_rate = isfinite(yaw_rate_value) ? yaw_rate_value : 0.0
    carrier_crossflow =
        params.crossflow_phase_angle_gain * phase_angle +
        params.crossflow_phase_velocity_gain * phase_velocity
    carrier_yaw_rate =
        params.yaw_phase_angle_gain * phase_angle +
        params.yaw_phase_velocity_gain * phase_velocity
    slip_residual = crossflow - carrier_crossflow
    yaw_residual = yaw_rate - carrier_yaw_rate
    turn_state =
        bearing / max(params.steering_bearing_scale, eps(Float64)) +
        params.steering_crossflow_weight * tanh(
            slip_residual /
            max(params.steering_crossflow_scale, eps(Float64)),
        ) +
        params.steering_yaw_rate_weight * tanh(
            yaw_residual /
            max(params.steering_yaw_rate_scale, eps(Float64)),
        )
    turn_command = tanh(turn_state)

    # Put sustained steering only in the posterior mean tangent.  The original
    # lagged waveform remains intact; the phase projection changes observation
    # semantics, not carrier amplitude, frequency, lag, or actuator limits.
    mean_tail_tangent = params.steering_curvature_limit * turn_command
    phase_lag_target =
        mean_tail_tangent - q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2_raw = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Smoothly respect the physical acceleration envelope while leaving hard
    # angle and velocity enforcement to the unchanged episode integrator.
    accel_limit = params.actuation_soft_limit
    a1 = accel_limit * tanh(a1_raw / accel_limit)
    a2 = accel_limit * tanh(a2_raw / accel_limit)

    return (phi_ddot=(a1, a2),)
end
