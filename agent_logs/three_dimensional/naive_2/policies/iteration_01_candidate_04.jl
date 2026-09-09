# State-feedback traveling bend with bounded target-directed mean curvature.
# The policy uses only normalized body-frame observations and joint state.

function target_policy_params()
    return (
        control_period=1.10,
        oscillator_amplitude=10.0 * pi / 180,
        oscillator_mu=0.35,
        tail_amplitude_ratio=1.30,
        tail_phase_lag=85.0 * pi / 180,
        tail_damping=0.80,
        max_turn_bias=9.0 * pi / 180,
        bearing_gain=4.0,
        lateral_velocity_gain=1.25,
        yaw_rate_gain=0.35,
        max_joint_acceleration=24.0,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Positive bias produces negative yaw in this testbed.  Target bearing has
    # the matching sign; lateral slip releases the turn while yaw-rate feedback
    # opposes the measured body rotation through that calibrated FSI coupling.
    turn_signal = params.bearing_gain * Float64(state.bearing) -
        params.lateral_velocity_gain * Float64(state.velocity_body_U[2]) +
        params.yaw_rate_gain * Float64(state.heading_rate)
    turn_bias = params.max_turn_bias * tanh(turn_signal)

    # Oscillator phase remains encoded in joint state.  Centering the rhythm on
    # turn_bias preserves a traveling bend while adding bounded mean curvature.
    centered_q1 = q1 - turn_bias
    vdp_drive = params.oscillator_mu * (1 - (centered_q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * centered_q1

    phase_lag_target = turn_bias + params.tail_amplitude_ratio * (
        cos(params.tail_phase_lag) * centered_q1 -
        sin(params.tail_phase_lag) * qd1 / max(omega, eps(omega))
    )
    a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    limit = params.max_joint_acceleration

    return (phi_ddot=(clamp(a1, -limit, limit), clamp(a2, -limit, limit)),)
end
