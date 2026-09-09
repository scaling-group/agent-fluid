# Phase-2 candidate: preserve the coherent joint-state traveling bend and steer
# with a small target-gated posterior half-cycle modulation. The controller has
# no clock, route, world coordinate, or persistent mean-curvature command.

function target_policy_params()
    return (
        version="dogfish3d_geometry_gated_halfcycle_carrier_v1",
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.80,
        tail_damping=0.65,
        los_forward_floor=0.25,
        bearing_scale=0.35,
        halfcycle_asymmetry_limit=0.12,
        halfcycle_phase_fraction=0.30,
    )
end

@inline function _finite_or(value, fallback)
    parsed = Float64(value)
    return isfinite(parsed) ? parsed : fallback
end

function target_guidance(state, params)
    distance = max(_finite_or(state.distance_L, 1.0), 1.0e-6)
    target_x = _finite_or(state.target_body_L[1], -distance)
    target_y = _finite_or(state.target_body_L[2], 0.0)

    # Forward is negative body x for this fish. Both components are normalized
    # by target distance, so the command transfers across resolution and range.
    forward = -target_x / distance
    lateral = target_y / distance
    los_error = atan(lateral, max(forward, params.los_forward_floor))
    steering_request = tanh(los_error / max(params.bearing_scale, 1.0e-6))
    return (
        los_error=los_error,
        steering_request=steering_request,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amplitude = params.oscillator_amplitude
    q1 = _finite_or(state.phi[1], 0.0)
    q2 = _finite_or(state.phi[2], 0.0)
    qd1 = _finite_or(state.phi_dot[1], 0.0)
    qd2 = _finite_or(state.phi_dot[2], 0.0)

    # Preserve the parent's coherent, self-propelled state-feedback carrier.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amplitude)^2) * qd1
    anterior_accel = vdp_drive - omega^2 * q1

    # Keep the evidenced posterior phase lag unchanged at alignment. Steering
    # strengthens only the useful observed half-cycle and weakens its opposite,
    # avoiding the parent's persistent posterior offset. The sign is calibrated
    # from the sampled 3D rollout: a positive body-y target must strengthen the
    # negative posterior half-cycle to produce the required negative yaw.
    posterior_wave =
        -q1 - params.tail_lag_gain * qd1 / max(omega, eps(Float64))
    guidance = target_guidance(state, params)
    phase_scale = max(
        amplitude * params.halfcycle_phase_fraction,
        1.0e-6,
    )
    wave_side = tanh(posterior_wave / phase_scale)
    asymmetry =
        params.halfcycle_asymmetry_limit * guidance.steering_request
    posterior_scale = clamp(
        1.0 - asymmetry * wave_side,
        1.0 - params.halfcycle_asymmetry_limit,
        1.0 + params.halfcycle_asymmetry_limit,
    )
    posterior_target = posterior_scale * posterior_wave
    posterior_accel =
        omega^2 * (posterior_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(anterior_accel, posterior_accel),)
end
