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
        lateral_offset_scale_L=1.0,
        lateral_blend_start_distance_L=3.0,
        lateral_blend_full_distance_L=1.5,
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

    # Preserve the complete sampled 0.50 far-field anchor. Only after entering
    # the newly demonstrated sub-3L region, blend its angular bearing drive
    # toward bounded body-frame lateral offset. Unlike the bearing, the latter
    # does not grow solely because fore-aft separation crosses through zero.
    bearing_drive = tanh(state.bearing / params.bearing_scale)
    lateral_offset_drive = tanh(
        state.target_body_L[2] /
            max(params.lateral_offset_scale_L, eps(params.lateral_offset_scale_L)),
    )
    lateral_blend_coordinate = clamp(
        (params.lateral_blend_start_distance_L - state.distance_L) /
            max(
                params.lateral_blend_start_distance_L -
                    params.lateral_blend_full_distance_L,
                eps(params.lateral_blend_start_distance_L),
            ),
        0.0,
        1.0,
    )
    lateral_blend = lateral_blend_coordinate^2 *
        (3 - 2 * lateral_blend_coordinate)
    geometric_drive = (1 - lateral_blend) * bearing_drive +
        lateral_blend * lateral_offset_drive
    steering_command = geometric_drive -
        params.turn_rate_damping * tanh(
            state.heading_rate / params.turn_rate_scale,
        )
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
    # unchanged. At 3L and beyond this is exactly the sampled 0.50 policy. The
    # near-target representation changes geometry, not phase gain or gait.
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
