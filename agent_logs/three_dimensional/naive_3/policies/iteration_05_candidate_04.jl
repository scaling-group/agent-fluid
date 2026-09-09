# Joint-phase-compensated direction tracking around the evidenced bounded-
# curvature carrier. Oscillation phase remains entirely in measured state.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        maximum_mean_curvature=7.0 * pi / 180,
        direction_error_scale=0.45,
        direction_limit=1.0,
        joint_yaw_rate_coupling=0.65,
        compensated_yaw_rate_damping=0.18,
        compensated_yaw_rate_limit=4.0,
        tail_curvature_share=0.8,
        alignment_direction_scale=0.60,
        posterior_wave_floor=0.35,
        command_limit=28.0,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

    # The spine's forward axis is negative body x. This full direction keeps
    # target-ahead and target-behind geometry distinct.
    target_x = Float64(state.target_body_L[1])
    target_y = Float64(state.target_body_L[2])
    direction_error = atan(target_y, -target_x)
    bounded_direction = clamp(
        direction_error,
        -params.direction_limit,
        params.direction_limit,
    )

    # Measured yaw is dominated by a repeatable component opposite anterior
    # joint rate. Remove that state-phased component before damping the slow
    # navigation bend, so feedback does not reverse on alternating half-cycles.
    compensated_yaw_rate = clamp(
        Float64(state.heading_rate) +
            params.joint_yaw_rate_coupling * qd1,
        -params.compensated_yaw_rate_limit,
        params.compensated_yaw_rate_limit,
    )
    steering_error = bounded_direction -
        params.compensated_yaw_rate_damping * compensated_yaw_rate
    mean_curvature = params.maximum_mean_curvature *
        tanh(steering_error / params.direction_error_scale)

    # Preserve the sampled anterior state-feedback carrier and move only its
    # equilibrium. No clock, world coordinate, route, or case identity enters.
    centered_q1 = q1 - mean_curvature
    vdp_drive = params.oscillator_mu *
        (1 - (centered_q1 / amp)^2) * qd1
    raw_a1 = vdp_drive - omega^2 * centered_q1

    # Full direction keeps posterior thrust low through a pass-behind redirect
    # while retaining the mean tail curvature and the traveling-bend scaffold.
    normalized_direction =
        direction_error / params.alignment_direction_scale
    posterior_wave_authority = params.posterior_wave_floor +
        (1 - params.posterior_wave_floor) /
        (1 + normalized_direction^2)
    tail_mean = params.tail_curvature_share * mean_curvature
    posterior_wave = -centered_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    phase_lag_target = tail_mean +
        posterior_wave_authority * posterior_wave
    raw_a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Keep deterministic reserve below the 1800 deg/T^2 episode hard limit.
    a1 = clamp(raw_a1, -params.command_limit, params.command_limit)
    a2 = clamp(raw_a2, -params.command_limit, params.command_limit)

    return (phi_ddot=(a1, a2),)
end
