# Target-relative mean-curvature steering with state-phase half-cycle authority.
# Phase remains entirely in measured joint state; no clock, route, or world
# coordinate enters the policy.

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
        half_cycle_gain=2.5,
        command_limit=30.0,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Slow target error requests average body curvature; yaw-rate feedback
    # releases the request once the body is already rotating toward the target.
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
    turn_request = tanh(steering_error / params.curvature_error_scale)
    mean_curvature = params.maximum_mean_curvature * turn_request

    # Center the carrier on the evidenced low-authority mean bend.  The
    # oscillator phase remains encoded by measured joint state.
    centered_q1 = q1 - mean_curvature
    vdp_drive = params.oscillator_mu *
        (1 - (centered_q1 / amp)^2) * qd1

    # Strengthen only the half-cycle moving toward the requested bend.  The
    # product is reflection-equivariant and fades quadratically near zero turn
    # request, preserving the carrier on the target centerline.
    aligned_speed = max(turn_request * qd1, 0.0)
    half_cycle_boost = params.half_cycle_gain * turn_request * aligned_speed
    raw_a1 = vdp_drive - omega^2 * centered_q1 + half_cycle_boost

    # Preserve the seed's posterior lag while distributing the same slow bend
    # across the tail; the anterior asymmetry propagates through this target.
    tail_mean = params.tail_curvature_share * mean_curvature
    phase_lag_target = tail_mean - centered_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    raw_a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Reserve acceleration authority below the episode's 1800 deg/T^2 bound.
    a1 = clamp(raw_a1, -params.command_limit, params.command_limit)
    a2 = clamp(raw_a2, -params.command_limit, params.command_limit)

    return (phi_ddot=(a1, a2),)
end
