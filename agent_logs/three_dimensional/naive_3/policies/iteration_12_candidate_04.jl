# Response-gated whole-body redirect around the evidenced alignment-gated
# carrier. Oscillation phase remains entirely in measured joint state.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        maximum_mean_curvature=7.0 * pi / 180,
        curvature_error_scale=0.45,
        bearing_limit=1.0,
        heading_rate_damping=0.18,
        heading_rate_limit=4.0,
        tail_curvature_share=0.8,
        alignment_bearing_scale=0.60,
        posterior_wave_floor=0.35,
        maneuver_distance_scale=4.5,
        maneuver_distance_power=8.0,
        maneuver_direction_threshold=0.70,
        maneuver_direction_scale=0.15,
        maneuver_closing_threshold=0.45,
        maneuver_closing_scale=0.12,
        closing_speed_limit=2.0,
        maneuver_response_scale=0.75,
        maximum_maneuver_curvature=22.0 * pi / 180,
        maneuver_tail_share=0.9,
        maneuver_damping=0.9,
        maneuver_wave_floor=0.08,
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

    # Preserve the sampled cruise: acute target bearing requests restrained
    # mean curvature, and measured yaw rate continuously damps that request.
    bearing = clamp(
        Float64(state.bearing),
        -params.bearing_limit,
        params.bearing_limit,
    )
    heading_rate = clamp(
        Float64(state.heading_rate),
        -params.heading_rate_limit,
        params.heading_rate_limit,
    )
    steering_error = bearing - params.heading_rate_damping * heading_rate
    cruise_curvature = params.maximum_mean_curvature *
        tanh(steering_error / params.curvature_error_scale)

    # The adapter's acute bearing loses the ahead/behind distinction. Full
    # normalized body-frame direction is used only to identify a large lateral
    # miss; no clock, coordinate, target identity, or route enters the policy.
    target_x = Float64(state.target_body_L[1])
    target_y = Float64(state.target_body_L[2])
    # Exactly astern on the centerline has no reflection-equivariant preferred
    # turn side, so leave it to the next nonzero lateral observation.
    direction_error = abs(target_y) > eps(Float64) ?
        atan(target_y, -target_x) : 0.0
    direction_weight = 0.5 * (1 + tanh(
        (abs(direction_error) - params.maneuver_direction_threshold) /
            params.maneuver_direction_scale,
    ))
    distance = max(Float64(state.distance_L), eps(Float64))
    approach_weight = 1 / (1 +
        (distance / params.maneuver_distance_scale)^params.maneuver_distance_power)
    closing_speed = clamp(
        Float64(state.closing_speed_L),
        -params.closing_speed_limit,
        params.closing_speed_limit,
    )
    closing_deficit = 0.5 * (1 + tanh(
        (params.maneuver_closing_threshold - closing_speed) /
            params.maneuver_closing_scale,
    ))

    # Persist while target-relative direction is not correcting, and release
    # continuously once the short observation window shows the bearing moving
    # toward zero. This is a response gate, not a timed burst.
    redirect_direction = tanh(
        direction_error / params.curvature_error_scale,
    )
    bearing_trend = clamp(
        Float64(state.bearing_window_rate),
        -params.heading_rate_limit,
        params.heading_rate_limit,
    )
    corrective_bearing_rate = max(
        -redirect_direction * bearing_trend,
        0.0,
    )
    response_release = 1 / (1 +
        (corrective_bearing_rate / params.maneuver_response_scale)^2)
    maneuver_weight = approach_weight * direction_weight *
        closing_deficit * response_release

    # A large, poorly closing lateral error blends the entire carrier into a
    # same-side equilibrium bend. Unlike the completed tail-only redirects,
    # damping removes anterior beat energy while the bend is active.
    maneuver_curvature = params.maximum_maneuver_curvature *
        redirect_direction
    anterior_equilibrium = (1 - maneuver_weight) * cruise_curvature +
        maneuver_weight * maneuver_curvature
    centered_q1 = q1 - anterior_equilibrium
    vdp_drive = (1 - maneuver_weight) * params.oscillator_mu *
        (1 - (centered_q1 / amp)^2) * qd1
    maneuver_damping = 2 * params.maneuver_damping * omega *
        maneuver_weight
    raw_a1 = vdp_drive - omega^2 * centered_q1 -
        maneuver_damping * qd1

    # Cruise retains the lagged traveling wave. During the redirect, both
    # joints form the bounded bend and the posterior wave is nearly quenched;
    # geometric correction restores propulsion continuously.
    normalized_bearing = bearing / params.alignment_bearing_scale
    posterior_wave_authority = params.posterior_wave_floor +
        (1 - params.posterior_wave_floor) / (1 + normalized_bearing^2)
    tail_equilibrium =
        (1 - maneuver_weight) * params.tail_curvature_share * cruise_curvature +
        maneuver_weight * params.maneuver_tail_share * maneuver_curvature
    posterior_wave = -centered_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    posterior_wave_scale =
        (1 - maneuver_weight) * posterior_wave_authority +
        maneuver_weight * params.maneuver_wave_floor
    phase_lag_target = tail_equilibrium +
        posterior_wave_scale * posterior_wave
    tail_damping = params.tail_damping +
        maneuver_weight * params.maneuver_damping
    raw_a2 = omega^2 * (phase_lag_target - q2) -
        2 * tail_damping * omega * qd2

    # Keep deterministic reserve below the 1800 deg/T^2 episode hard limit.
    a1 = clamp(raw_a1, -params.command_limit, params.command_limit)
    a2 = clamp(raw_a2, -params.command_limit, params.command_limit)
    return (phi_ddot=(a1, a2),)
end
