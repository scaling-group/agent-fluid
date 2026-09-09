# Wrong-side posterior counter-bend around the evidenced alignment-gated
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
        target_lateral_scale=0.20,
        opposing_lateral_speed_scale=0.25,
        maximum_posterior_counterbend=7.0 * pi / 180,
        command_limit=28.0,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Persistent target error asks for bounded average curvature. Measured yaw
    # releases the request as the body turns; all geometry is body-relative.
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
    mean_curvature = params.maximum_mean_curvature *
        tanh(steering_error / params.curvature_error_scale)

    # Preserve the sampled anterior state-feedback carrier and move only its
    # equilibrium. No clock, world coordinate, route, or case identity enters.
    centered_q1 = q1 - mean_curvature
    vdp_drive = params.oscillator_mu *
        (1 - (centered_q1 / amp)^2) * qd1
    raw_a1 = vdp_drive - omega^2 * centered_q1

    # Gross misalignment attenuates posterior thrust without removing its mean
    # steering curvature. Alignment continuously restores the full lagged wave.
    normalized_bearing = bearing / params.alignment_bearing_scale
    posterior_wave_authority = params.posterior_wave_floor +
        (1 - params.posterior_wave_floor) / (1 + normalized_bearing^2)

    # The completed same-sign posterior guard worsened the lateral miss.
    # Instead, introduce a mild S-shaped component only while rigid-body
    # translation opposes the normalized target side. This changes posterior
    # wave shape without adding anterior effort, and releases at rest or as
    # soon as lateral motion becomes corrective.
    target_y = Float64(state.target_body_L[2])
    distance = max(Float64(state.distance_L), eps(Float64))
    lateral_target_fraction = clamp(target_y / distance, -1.0, 1.0)
    target_side = tanh(
        lateral_target_fraction / params.target_lateral_scale,
    )
    lateral_velocity = Float64(state.velocity_body_U[2])
    opposing_lateral_speed = max(0.0, -target_side * lateral_velocity)
    counterbend_guard = target_side * tanh(
        opposing_lateral_speed / params.opposing_lateral_speed_scale,
    )^2
    posterior_counterbend =
        params.maximum_posterior_counterbend * counterbend_guard

    tail_mean = params.tail_curvature_share * mean_curvature -
        posterior_counterbend
    posterior_wave = -centered_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    phase_lag_target = tail_mean + posterior_wave_authority * posterior_wave
    raw_a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Keep deterministic reserve below the 1800 deg/T^2 episode hard limit.
    a1 = clamp(raw_a1, -params.command_limit, params.command_limit)
    a2 = clamp(raw_a2, -params.command_limit, params.command_limit)

    return (phi_ddot=(a1, a2),)
end
