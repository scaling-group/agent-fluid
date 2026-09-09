# Traveling-bend propulsion with a bounded mean-curvature steering servo.
# Full-circle body-frame pursuit sets a finite common-bend equilibrium, so
# target response releases the turn without a clock, route, or latent state.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        maximum_bearing=pi / 2,
        maximum_lateral_velocity=1.0,
        steering_softness=0.35,
        lateral_velocity_gain=0.8,
        carrier_yaw_head_rate_gain=0.65,
        carrier_yaw_tail_rate_gain=0.22,
        maximum_yaw_residual=0.5,
        yaw_residual_gain=0.6,
        maximum_mean_bend=18.0 * pi / 180,
        steering_period=1.1,
        steering_damping=0.9,
        maximum_steering_acceleration=12.0,
        maximum_joint_acceleration=30.0,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Preserve the evidenced propulsive carrier and posterior traveling bend.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    carrier_a1 = vdp_drive - omega^2 * q1
    phase_lag_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    carrier_a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    fallback_bearing = isfinite(state.bearing) ? Float64(state.bearing) : 0.0
    target_x = isfinite(state.target_body_L[1]) ?
        Float64(state.target_body_L[1]) : -1.0
    target_y = isfinite(state.target_body_L[2]) ?
        Float64(state.target_body_L[2]) : 0.0
    lateral_velocity = isfinite(state.velocity_body_U[2]) ?
        Float64(state.velocity_body_U[2]) : 0.0
    heading_rate = isfinite(state.heading_rate) ?
        Float64(state.heading_rate) : 0.0

    # Body forward is -x. Unlike the adapter's restricted bearing, this angle
    # keeps fore and aft distinct after a pass. Clamping bounds steering while
    # preserving left/right reflection equivariance.
    aft_centerline = target_x > 0 &&
        abs(target_y) <= sqrt(eps(Float64)) * max(abs(target_x), 1.0)
    pursuit_bearing = if !isfinite(target_x) || !isfinite(target_y)
        fallback_bearing
    elseif aft_centerline
        fallback_bearing
    else
        atan(target_y, -target_x)
    end
    bounded_bearing = clamp(
        pursuit_bearing,
        -params.maximum_bearing,
        params.maximum_bearing,
    )
    bounded_lateral_velocity = clamp(
        lateral_velocity,
        -params.maximum_lateral_velocity,
        params.maximum_lateral_velocity,
    )

    # Remove beat-correlated yaw rate before interpreting measured yaw as a
    # directional response. This keeps the slow target request separate from
    # the carrier oscillation without relying on an external phase signal.
    carrier_phase_yaw = -params.carrier_yaw_head_rate_gain * qd1 -
        params.carrier_yaw_tail_rate_gain * qd2
    yaw_residual = clamp(
        heading_rate - carrier_phase_yaw,
        -params.maximum_yaw_residual,
        params.maximum_yaw_residual,
    )
    turn_signal = bounded_bearing -
        params.lateral_velocity_gain * bounded_lateral_velocity +
        params.yaw_residual_gain * yaw_residual
    turn_request = tanh(
        turn_signal / max(params.steering_softness, eps(Float64)),
    )

    # Turn request sets a bounded common-mode joint-angle target. Damped
    # feedback on observed mean bend gives the redirect a finite equilibrium;
    # when target error reverses, the same servo actively restores the return
    # arc instead of leaving both joints pinned on one side. Equal addition to
    # both joints leaves the carrier's differential traveling bend available.
    mean_bend = 0.5 * (q1 + q2)
    mean_bend_rate = 0.5 * (qd1 + qd2)
    desired_mean_bend = params.maximum_mean_bend * turn_request
    steering_omega = 2 * pi / params.steering_period
    raw_steering = steering_omega^2 * (desired_mean_bend - mean_bend) -
        2 * params.steering_damping * steering_omega * mean_bend_rate
    steering_limit = params.maximum_steering_acceleration
    steering_acceleration = steering_limit * tanh(
        raw_steering / max(steering_limit, eps(Float64)),
    )

    raw_a1 = carrier_a1 + steering_acceleration
    raw_a2 = carrier_a2 + steering_acceleration
    limit = params.maximum_joint_acceleration
    bounded_a1 = limit * tanh(raw_a1 / limit)
    bounded_a2 = limit * tanh(raw_a2 / limit)

    return (
        phi_ddot=(bounded_a1, bounded_a2),
    )
end
