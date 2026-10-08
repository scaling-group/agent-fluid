# Target-aware state-feedback gait for the 3D moving-window EvE lane.
# Oscillator phase remains encoded only in joint state; steering uses normalized
# body-frame geometry and measured rotation rather than time or world position.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        steering_bearing_scale=0.30,
        steering_yaw_rate_scale=1.0,
        steering_yaw_rate_weight=0.45,
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

    # Van der Pol drive: oscillation phase lives in (q1, qd1), not clock time.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1_raw = vdp_drive - omega^2 * q1

    # Body-frame target error creates a bounded mean tail tangent.  The recent
    # yaw term has the same curvature sign as measured rotation, so its induced
    # counter-moment damps overshoot while bearing supplies the route request.
    bearing = Float64(state.bearing)
    bearing = isfinite(bearing) ? bearing : 0.0
    yaw_rate = Float64(state.turn_rate_recent)
    yaw_rate = isfinite(yaw_rate) ? yaw_rate : 0.0
    turn_state =
        bearing / max(params.steering_bearing_scale, eps(Float64)) +
        params.steering_yaw_rate_weight *
        tanh(yaw_rate / max(params.steering_yaw_rate_scale, eps(Float64)))
    mean_tail_tangent = params.steering_curvature_limit * tanh(turn_state)

    phase_lag_target =
        mean_tail_tangent - q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2_raw =
        omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Smoothly respect the released actuator envelope instead of depending on
    # downstream hard clipping for the seed's largest raw commands.
    accel_limit = params.actuation_soft_limit
    a1 = accel_limit * tanh(a1_raw / accel_limit)
    a2 = accel_limit * tanh(a2_raw / accel_limit)

    return (phi_ddot=(a1, a2),)
end
