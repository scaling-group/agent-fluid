# Headroom-aware steering allocation around the evidenced alignment-gated
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
        steering_sign_scale=1.0 * pi / 180,
        allocation_softness=0.5,
        anterior_steering_floor=0.15,
        posterior_reallocation_gain=1.0,
        alignment_bearing_scale=0.60,
        posterior_wave_floor=0.35,
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

    # Estimate the current zero-mean carrier demand before adding steering.
    # Its signed headroom is reflection-invariant: target, joint state, and
    # carrier acceleration all reverse together under a lateral reflection.
    carrier_vdp = params.oscillator_mu *
        (1 - (q1 / amp)^2) * qd1
    carrier_a1 = carrier_vdp - omega^2 * q1
    steering_direction = tanh(
        mean_curvature / params.steering_sign_scale,
    )
    directional_headroom = max(
        params.command_limit - steering_direction * carrier_a1,
        0.0,
    )
    requested_steering_accel = omega^2 * abs(mean_curvature)
    headroom_fraction = clamp(
        directional_headroom /
            (requested_steering_accel + params.allocation_softness),
        0.0,
        1.0,
    )
    anterior_steering_share = params.anterior_steering_floor +
        (1 - params.anterior_steering_floor) * headroom_fraction
    anterior_mean = anterior_steering_share * mean_curvature
    unallocated_mean = mean_curvature - anterior_mean

    # Keep the sampled anterior state-feedback carrier, but ask only for the
    # portion of mean bend that fits its directional command reserve.
    centered_q1 = q1 - anterior_mean
    vdp_drive = params.oscillator_mu *
        (1 - (centered_q1 / amp)^2) * qd1
    raw_a1 = vdp_drive - omega^2 * centered_q1

    # Gross misalignment attenuates posterior thrust without removing its mean
    # steering curvature. Alignment continuously restores the full lagged wave.
    normalized_bearing = bearing / params.alignment_bearing_scale
    posterior_wave_authority = params.posterior_wave_floor +
        (1 - params.posterior_wave_floor) / (1 + normalized_bearing^2)
    # Route the unallocated mean bend to the less-saturated posterior joint.
    # The traveling wave, alignment gate, and total signed steering request
    # remain intact; only their instantaneous actuator allocation changes.
    tail_mean = params.tail_curvature_share * mean_curvature +
        params.posterior_reallocation_gain * unallocated_mean
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
