# Energy-regulated target-side half-cycle steering on a traveling bend.
# Oscillator phase and reserve come only from joint state; steering uses the
# normalized body-frame target vector, never a clock or world-frame route.

function target_policy_params()
    return (
        control_period=0.90,
        oscillator_amplitude=18.0 * pi / 180,
        oscillator_energy_gain=1.4,
        tail_lag_gain=0.8,
        tail_damping=0.70,
        target_distance_floor_L=0.25,
        target_lateral_scale=0.30,
        half_cycle_velocity_scale=0.60,
        half_cycle_acceleration=8.0,
        steering_energy_soft=1.15,
        steering_energy_hard=2.00,
        acceleration_limit=30.0,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

    # Regulate the joint-state phase orbit instead of allowing a persistent
    # steering impulse to pump the anterior joint into its hard limits.
    phase_position = q1 / amp
    phase_speed = qd1 / max(omega * amp, eps(omega))
    oscillator_energy = phase_position^2 + phase_speed^2
    energy_drive = params.oscillator_energy_gain *
        (1 - oscillator_energy) * qd1
    carrier_a1 = energy_drive - omega^2 * q1

    # Body-frame lateral target error has a stable route meaning whereas the
    # sampled instantaneous yaw rate is dominated by within-beat rotation.
    # Positive lateral error requests negative yaw for this body convention.
    distance_L = max(
        Float64(state.distance_L),
        params.target_distance_floor_L,
    )
    lateral_target = clamp(
        Float64(state.target_body_L[2]) / distance_L,
        -1.0,
        1.0,
    )
    turn_side = -tanh(lateral_target / params.target_lateral_scale)

    # Strengthen only the requested half-stroke. Fade that residual before
    # joint-state energy reaches the region associated with envelope contact;
    # the radial carrier feedback then dissipates excess energy.
    steering_authority = clamp(
        (params.steering_energy_hard - oscillator_energy) /
        (params.steering_energy_hard - params.steering_energy_soft),
        0.0,
        1.0,
    )
    phase_velocity = tanh(
        qd1 /
        (max(omega * amp, eps(omega)) * params.half_cycle_velocity_scale),
    )
    half_cycle_drive = 0.5 * params.half_cycle_acceleration *
        steering_authority *
        (turn_side + abs(turn_side) * phase_velocity)
    a1 = carrier_a1 + half_cycle_drive

    # Preserve the evidenced posterior lag and emphasis as the propulsive
    # traveling-bend scaffold while the anterior half-cycle carries steering.
    tail_target = -q1 - params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    limit = params.acceleration_limit
    return (
        phi_ddot=(
            clamp(a1, -limit, limit),
            clamp(a2, -limit, limit),
        ),
    )
end
