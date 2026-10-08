# Phase-gated half-cycle steering around the naive state-feedback gait.
# The carrier remains clock-free and the anterior oscillator stays uncentered.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        steering_bearing_scale=0.30,
        steering_yaw_lead_time=0.25,
        steering_yaw_rate_limit=3.0,
        half_cycle_gain=0.35,
        half_cycle_phase_scale=8.0 * pi / 180,
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

    # Preserve the released anterior joint state: recentering it removed the
    # carrier's initial oscillation energy in both sampled failures.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1_raw = vdp_drive - omega^2 * q1

    # Positive posterior bias produced the required negative-yaw response in
    # the sampled tail-only comparator.  Recent yaw supplies phase lead: yaw
    # already developing in the requested direction releases steering before
    # the geometric error has crossed deeply through zero.
    bearing_value = Float64(state.bearing)
    bearing = isfinite(bearing_value) ? clamp(bearing_value, -1.4, 1.4) : 0.0
    yaw_value = Float64(state.turn_rate_recent)
    yaw_rate = isfinite(yaw_value) ? clamp(
        yaw_value,
        -params.steering_yaw_rate_limit,
        params.steering_yaw_rate_limit,
    ) : 0.0
    predicted_bearing = bearing + params.steering_yaw_lead_time * yaw_rate
    turn_command = tanh(
        predicted_bearing /
        max(params.steering_bearing_scale, eps(Float64)),
    )

    # The base target is reconstructed from joint state, so no external clock
    # enters the gait.  Beat-side gating strengthens the requested posterior
    # half-cycle and weakens the other one; it becomes exactly neutral at the
    # base-target crossing instead of holding a static tail curvature.
    base_tail_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    beat_side = tanh(
        base_tail_target /
        max(params.half_cycle_phase_scale, eps(Float64)),
    )
    tail_amplitude_scale = 1 +
        params.half_cycle_gain * turn_command * beat_side
    phase_lag_target = tail_amplitude_scale * base_tail_target
    a2_raw = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Smoothly respect the physical acceleration envelope while leaving hard
    # angle and velocity enforcement to the unchanged episode integrator.
    accel_limit = params.actuation_soft_limit
    a1 = accel_limit * tanh(a1_raw / accel_limit)
    a2 = accel_limit * tanh(a2_raw / accel_limit)

    return (phi_ddot=(a1, a2),)
end
