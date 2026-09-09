# Phase-2 candidate: target-gated posterior half-cycle steering on the
# coherent joint-state traveling bend. Joint state supplies gait phase and
# normalized body-frame geometry supplies the signed steering request.

function target_policy_params()
    return (
        version="dogfish3d_strong_carrier_halfcycle_steering_v1",
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.80,
        tail_damping=0.65,
        los_forward_floor=0.25,
        los_error_scale=0.20,
        halfcycle_asymmetry_gain=0.05,
        halfcycle_phase_scale=8.0 * pi / 180,
        halfcycle_scale_min=0.95,
        halfcycle_scale_max=1.05,
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

    # Material body -x is forward. Range normalization makes this a bounded,
    # reflection-equivariant direction error rather than a world-frame route.
    forward = -target_x / distance
    lateral = target_y / distance
    los_error = atan(lateral, max(forward, params.los_forward_floor))
    steering_request = tanh(
        los_error / max(params.los_error_scale, 1.0e-6),
    )
    return (los_error=los_error, steering_request=steering_request)
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amplitude = params.oscillator_amplitude
    q1 = _finite_or(state.phi[1], 0.0)
    q2 = _finite_or(state.phi[2], 0.0)
    qd1 = _finite_or(state.phi_dot[1], 0.0)
    qd2 = _finite_or(state.phi_dot[2], 0.0)

    # Preserve the evidenced state-feedback carrier. No clock or mutable phase
    # is needed because (q1, qd1) identifies the current gait half-cycle.
    vdp_drive = params.oscillator_mu * (1.0 - (q1 / amplitude)^2) * qd1
    anterior_accel = vdp_drive - omega^2 * q1

    # Keep the posterior lagged wave centered at zero, then create only a small
    # target-gated amplitude imbalance. Positive body-y error strengthens the
    # positive wave side and weakens the negative side; reflection reverses
    # both target request and wave side, preserving policy equivariance.
    guidance = target_guidance(state, params)
    posterior_wave =
        -q1 - params.tail_lag_gain * qd1 / max(omega, eps(Float64))
    wave_side = tanh(
        posterior_wave / max(params.halfcycle_phase_scale, 1.0e-6),
    )
    halfcycle_scale = clamp(
        1.0 +
        params.halfcycle_asymmetry_gain *
        guidance.steering_request *
        wave_side,
        params.halfcycle_scale_min,
        params.halfcycle_scale_max,
    )
    posterior_target = halfcycle_scale * posterior_wave
    posterior_accel =
        omega^2 * (posterior_target - q2) -
        2.0 * params.tail_damping * omega * qd2

    return (phi_ddot=(anterior_accel, posterior_accel),)
end
