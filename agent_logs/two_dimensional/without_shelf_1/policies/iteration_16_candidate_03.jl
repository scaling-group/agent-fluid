function target_policy_params()
    return (
        control_period=0.90,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        steering_bias_limit=11.0 * pi / 180,
        bearing_scale=25.0 * pi / 180,
        turn_rate_scale=0.35,
        turn_rate_damping=0.70,
        steering_opposition_boost=0.50,
        wake_crossflow_scale=0.30,
        wake_crossflow_rejection_gain=0.20,
        steering_fade_distance_L=0.75,
        steering_fade_width_L=0.75,
        acceleration_command_limit=1650.0 * pi / 180,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Preserve the complete sampled upstream-capable propulsion gait. Its
    # phase remains encoded in joint state rather than elapsed time.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    raw_a1 = vdp_drive - omega^2 * q1

    # Restore the strongest sampled static-bias and direct-body-rate anchor.
    # Reject a bounded fraction of the measured local body-frame crossflow,
    # whose large oscillatory component accompanies the unresolved upper hook.
    crossflow_command = tanh(
        state.wake_crossflow_velocity_U /
            max(params.wake_crossflow_scale, eps(params.wake_crossflow_scale)),
    )
    steering_command = tanh(state.bearing / params.bearing_scale) -
        params.turn_rate_damping * tanh(
            state.heading_rate / params.turn_rate_scale,
        ) -
        params.wake_crossflow_rejection_gain * crossflow_command
    bounded_steering_command = clamp(steering_command, -1.0, 1.0)

    # Fade inside the final body length, where bearing is poorly conditioned
    # and first-crossing capture will terminate anyway.
    fade_coordinate = clamp(
        (state.distance_L - params.steering_fade_distance_L) /
            max(params.steering_fade_width_L, eps(params.steering_fade_width_L)),
        0.0,
        1.0,
    )
    steering_fade = fade_coordinate^2 * (3 - 2 * fade_coordinate)

    # Preserve every phase of the evidence-best static request. Add bounded
    # authority only when the posterior target remaining after that request
    # still opposes the steering direction, so the extra term uses measured
    # phase headroom instead of driving the joint farther outward. This is the
    # complement of the failed phase, distance, and lateral-motion relief.
    unsteered_q2_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    base_steering_bias = params.steering_bias_limit * steering_fade *
        bounded_steering_command
    static_q2_target = unsteered_q2_target + base_steering_bias
    posterior_phase = clamp(
        static_q2_target / max(amp, eps(amp)),
        -1.0,
        1.0,
    )
    opposing_headroom = max(
        0.0,
        -bounded_steering_command * posterior_phase,
    )
    phase_gain = 1.0 +
        params.steering_opposition_boost * opposing_headroom
    steering_bias = base_steering_bias * phase_gain

    # Steering remains posterior-only; the anterior propulsion oscillator is
    # unchanged. The sampled 0.50 phase allocation is restored at every
    # distance; crossflow rejection is the candidate's only new mechanism.
    q2_target = unsteered_q2_target + steering_bias
    raw_a2 = omega^2 * (q2_target - q2) -
        2 * params.tail_damping * omega * qd2

    limit = params.acceleration_command_limit
    return (
        phi_ddot=(
            clamp(raw_a1, -limit, limit),
            clamp(raw_a2, -limit, limit),
        ),
    )
end
