# Target-relative turn-response tracking over the seed's traveling-bend drive.
# Phase remains in measured joint state, while body-frame bearing and recent
# yaw close the slow steering loop without time or world coordinates.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        bearing_limit=1.2,
        bearing_scale=0.45,
        desired_turn_rate_limit=0.75,
        measured_turn_rate_limit=4.0,
        turn_rate_error_scale=0.60,
        maximum_mean_curvature=7.0 * pi / 180,
        tail_curvature_share=0.8,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Positive mean curvature produces negative yaw for this body convention.
    # Track a bearing-requested yaw response: correct yaw releases curvature,
    # while excess yaw creates a counter-bend before the route is crossed.
    bearing = clamp(
        Float64(state.bearing),
        -params.bearing_limit,
        params.bearing_limit,
    )
    measured_turn_rate = clamp(
        Float64(state.turn_rate_recent),
        -params.measured_turn_rate_limit,
        params.measured_turn_rate_limit,
    )
    desired_turn_rate = -params.desired_turn_rate_limit *
        tanh(bearing / params.bearing_scale)
    turn_rate_error = desired_turn_rate - measured_turn_rate
    mean_curvature = -params.maximum_mean_curvature *
        tanh(turn_rate_error / params.turn_rate_error_scale)

    # Retain the sampled propulsive distribution: the anterior oscillator is
    # centered on the slow bend and keeps phase entirely in (q1, qd1).
    centered_q1 = q1 - mean_curvature
    vdp_drive = params.oscillator_mu *
        (1 - (centered_q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * centered_q1

    # Preserve posterior lag and the evidenced smaller posterior mean bend.
    tail_mean = params.tail_curvature_share * mean_curvature
    phase_lag_target = tail_mean - centered_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
