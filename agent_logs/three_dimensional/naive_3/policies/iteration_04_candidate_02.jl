# Alignment-triggered damped redirect around the evidenced bounded-curvature
# carrier. Phase remains entirely in measured joint state.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        maximum_mean_curvature=7.0 * pi / 180,
        direction_error_scale=0.45,
        direction_limit=1.0,
        heading_rate_damping=0.18,
        heading_rate_limit=4.0,
        tail_curvature_share=0.8,
        alignment_direction_scale=0.65,
        alignment_power=4.0,
        anterior_wave_floor=0.12,
        posterior_wave_floor=0.25,
        redirect_frequency_ratio=0.55,
        redirect_damping=0.90,
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

    # The spine's forward axis is negative body x. Retaining the longitudinal
    # sign prevents a pass-behind target from appearing newly aligned.
    target_x = Float64(state.target_body_L[1])
    target_y = Float64(state.target_body_L[2])
    direction_error = atan(target_y, -target_x)
    bounded_direction = clamp(
        direction_error,
        -params.direction_limit,
        params.direction_limit,
    )
    heading_rate = clamp(
        Float64(state.heading_rate),
        -params.heading_rate_limit,
        params.heading_rate_limit,
    )
    steering_error = bounded_direction -
        params.heading_rate_damping * heading_rate
    mean_curvature = params.maximum_mean_curvature *
        tanh(steering_error / params.direction_error_scale)

    # Cruise uses the evidenced state-feedback oscillator. Gross body-frame
    # misalignment continuously replaces it with a damped tracker of the same
    # bounded mean bend, shedding beat momentum without a timed control mode.
    normalized_direction =
        abs(direction_error) / params.alignment_direction_scale
    alignment_gate = 1 /
        (1 + normalized_direction^params.alignment_power)
    anterior_wave_authority = params.anterior_wave_floor +
        (1 - params.anterior_wave_floor) * alignment_gate

    centered_q1 = q1 - mean_curvature
    vdp_drive = params.oscillator_mu *
        (1 - (centered_q1 / amp)^2) * qd1
    cruise_accel = vdp_drive - omega^2 * centered_q1

    redirect_omega = params.redirect_frequency_ratio * omega
    redirect_accel = -redirect_omega^2 * centered_q1 -
        2 * params.redirect_damping * redirect_omega * qd1
    raw_a1 = anterior_wave_authority * cruise_accel +
        (1 - anterior_wave_authority) * redirect_accel

    # Posterior wave authority follows the same alignment gate but retains a
    # small traveling component around the distributed mean bend.
    posterior_wave_authority = params.posterior_wave_floor +
        (1 - params.posterior_wave_floor) * alignment_gate
    tail_mean = params.tail_curvature_share * mean_curvature
    posterior_wave = -centered_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    phase_lag_target = tail_mean +
        posterior_wave_authority * posterior_wave
    raw_a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Keep deterministic reserve below the 1800 deg/T^2 episode hard limit.
    a1 = clamp(raw_a1, -params.command_limit, params.command_limit)
    a2 = clamp(raw_a2, -params.command_limit, params.command_limit)
    return (phi_ddot=(a1, a2),)
end
