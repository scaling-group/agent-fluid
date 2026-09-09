# Target-behind C-turn recovery around the evidenced response-selected brake.
# Oscillation phase remains entirely in measured joint state.

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
        approach_distance_scale=3.2,
        approach_distance_power=8.0,
        lateral_direction_threshold=0.60,
        lateral_direction_scale=0.15,
        wrong_way_yaw_threshold=0.75,
        wrong_way_yaw_scale=0.25,
        posterior_brake_floor=0.35,
        target_behind_threshold=-0.08,
        target_behind_transition=0.08,
        recovery_lateral_scale=0.40,
        maximum_recovery_curvature=8.0 * pi / 180,
        recovery_damping_ratio=0.18,
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

    # Preserve the evidenced cruise curvature and its measured-yaw damping.
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
    cruise_mean_curvature = params.maximum_mean_curvature *
        tanh(steering_error / params.curvature_error_scale)

    # Full body-frame geometry retains the ahead/behind distinction hidden by
    # the acute cruise bearing. Once the target is behind, its lateral fraction
    # supplies the reflection-equivariant C-turn direction.
    target_x = Float64(state.target_body_L[1])
    target_y = Float64(state.target_body_L[2])
    distance = max(Float64(state.distance_L), eps(Float64))
    direction_error = atan(target_y, -target_x)
    forward_fraction = clamp(-target_x / distance, -1.0, 1.0)
    lateral_fraction = clamp(target_y / distance, -1.0, 1.0)
    target_behind_weight = 0.5 * (1 + tanh(
        (params.target_behind_threshold - forward_fraction) /
            params.target_behind_transition,
    ))
    recovery_direction = tanh(
        lateral_fraction / params.recovery_lateral_scale,
    )
    recovery_curvature = params.maximum_recovery_curvature *
        target_behind_weight * recovery_direction
    maximum_total_curvature = params.maximum_mean_curvature +
        params.maximum_recovery_curvature
    mean_curvature = clamp(
        cruise_mean_curvature + recovery_curvature,
        -maximum_total_curvature,
        maximum_total_curvature,
    )

    # The target-ahead carrier is unchanged. Target-behind recovery both moves
    # its equilibrium into a bounded C-bend and dissipates the measured rhythm;
    # geometric recovery continuously restores the propulsive oscillator.
    centered_q1 = q1 - mean_curvature
    vdp_drive = params.oscillator_mu *
        (1 - (centered_q1 / amp)^2) * qd1
    recovery_damping = 2 * params.recovery_damping_ratio * omega *
        target_behind_weight * qd1
    raw_a1 = vdp_drive - omega^2 * centered_q1 - recovery_damping

    # Gross misalignment attenuates posterior thrust without removing its mean
    # steering curvature. Alignment continuously restores the full lagged wave.
    normalized_bearing = bearing / params.alignment_bearing_scale
    posterior_wave_authority = params.posterior_wave_floor +
        (1 - params.posterior_wave_floor) / (1 + normalized_bearing^2)

    # During approach, weaken only the posterior wave half-cycle whose measured
    # yaw grows the signed full-direction error. Corrective yaw retains the
    # unmodified wave, so the evidenced inbound mechanism remains intact.
    direction_sign = tanh(
        direction_error / params.curvature_error_scale,
    )
    lateral_weight = 0.5 * (1 + tanh(
        (abs(direction_error) - params.lateral_direction_threshold) /
            params.lateral_direction_scale,
    ))
    wrong_way_yaw = max(direction_sign * heading_rate, 0.0)
    wrong_way_weight = 0.5 * (1 + tanh(
        (wrong_way_yaw - params.wrong_way_yaw_threshold) /
            params.wrong_way_yaw_scale,
    ))
    approach_weight = 1 / (1 +
        (distance / params.approach_distance_scale)^params.approach_distance_power)
    brake_weight = approach_weight * lateral_weight * wrong_way_weight
    propulsion_scale = 1 -
        (1 - params.posterior_brake_floor) * brake_weight

    # During recovery both joints share the same-sign mean to form a C-bend.
    # The posterior lag follows the damped measured anterior state; bringing
    # the target ahead releases the bend and restores the original wave.
    tail_mean = params.tail_curvature_share * mean_curvature
    posterior_wave = -centered_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    phase_lag_target = tail_mean +
        propulsion_scale * posterior_wave_authority * posterior_wave
    raw_a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Keep deterministic reserve below the 1800 deg/T^2 episode hard limit.
    a1 = clamp(raw_a1, -params.command_limit, params.command_limit)
    a2 = clamp(raw_a2, -params.command_limit, params.command_limit)

    return (phi_ddot=(a1, a2),)
end
