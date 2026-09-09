# Phase-2 candidate: target-trend-led posterior half-cycle steering.
# Oscillation phase comes only from joint state. Steering uses normalized
# body-frame target geometry and its observed trend, without a clock or route.

function target_policy_params()
    return (
        version="dogfish3d_target_trend_halfcycle_v1",
        control_period=0.68,
        oscillator_amplitude=18.0 * pi / 180,
        oscillator_mu=0.35,
        posterior_lag_gain=0.80,
        posterior_damping=0.70,
        los_forward_floor=0.25,
        los_error_scale=0.20,
        bearing_rate_limit=0.60,
        response_lead_time=0.22,
        halfcycle_asymmetry_gain=0.18,
        halfcycle_phase_scale=10.0 * pi / 180,
        halfcycle_scale_min=0.82,
        halfcycle_scale_max=1.18,
        command_acceleration_limit=1750.0 * pi / 180,
        command_soft_knee_fraction=0.85,
    )
end

@inline function _finite_or(value, fallback)
    parsed = Float64(value)
    return isfinite(parsed) ? parsed : fallback
end

@inline function _bounded_rate(value, limit)
    safe_limit = max(_finite_or(limit, 1.0), 1.0e-6)
    return safe_limit * tanh(_finite_or(value, 0.0) / safe_limit)
end

@inline function _soft_envelope(value, limit, knee_fraction)
    safe_value = _finite_or(value, 0.0)
    safe_limit = max(_finite_or(limit, 1.0), 1.0e-6)
    fraction = clamp(_finite_or(knee_fraction, 0.85), 0.0, 0.99)
    knee = fraction * safe_limit
    magnitude = abs(safe_value)
    magnitude <= knee && return safe_value

    shoulder = max(safe_limit - knee, 1.0e-6)
    bounded_magnitude = knee + shoulder * tanh((magnitude - knee) / shoulder)
    return copysign(bounded_magnitude, safe_value)
end

function target_trend_guidance(state, params)
    distance = max(_finite_or(state.distance_L, 1.0), 1.0e-6)
    target_x = _finite_or(state.target_body_L[1], -distance)
    target_y = _finite_or(state.target_body_L[2], 0.0)

    # Material body -x points forward. Normalization by range makes this a
    # body-frame angular error rather than a resolution or distance command.
    forward = -target_x / distance
    lateral = target_y / distance
    los_error = atan(lateral, max(forward, params.los_forward_floor))

    # Lead only the target geometry. Unlike a raw yaw-rate residual, this term
    # releases steering while the observed line of sight is already closing.
    bearing_rate = hasproperty(state, :bearing_window_rate) ?
        _finite_or(state.bearing_window_rate, 0.0) :
        _finite_or(state.bearing_rate, 0.0)
    bounded_bearing_rate = _bounded_rate(bearing_rate, params.bearing_rate_limit)
    predicted_los_error =
        los_error + params.response_lead_time * bounded_bearing_rate

    # Positive body-y error requires negative yaw in the calibrated 3D frame.
    steering_request = -tanh(
        predicted_los_error / max(params.los_error_scale, 1.0e-6),
    )
    return (
        los_error=los_error,
        bearing_rate=bounded_bearing_rate,
        predicted_los_error=predicted_los_error,
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

    # State-feedback anterior rhythm with nominal peaks inside the angle and
    # rate envelope; no elapsed-time phase is present.
    vdp_drive = params.oscillator_mu * (1.0 - (q1 / amplitude)^2) * qd1
    anterior_raw = vdp_drive - omega^2 * q1

    # Preserve a directed posterior-lagged wave. Steering changes half-cycle
    # strength without adding static curvature that can collapse propulsion.
    guidance = target_trend_guidance(state, params)
    posterior_wave =
        -q1 - params.posterior_lag_gain * qd1 / max(omega, eps(Float64))
    wave_side = tanh(
        posterior_wave / max(params.halfcycle_phase_scale, 1.0e-6),
    )
    halfcycle_scale = clamp(
        1.0 +
        params.halfcycle_asymmetry_gain * guidance.steering_request * wave_side,
        params.halfcycle_scale_min,
        params.halfcycle_scale_max,
    )
    posterior_target = halfcycle_scale * posterior_wave
    posterior_raw =
        omega^2 * (posterior_target - q2) -
        2.0 * params.posterior_damping * omega * qd2

    limit = params.command_acceleration_limit
    knee = params.command_soft_knee_fraction
    return (
        phi_ddot=(
            _soft_envelope(anterior_raw, limit, knee),
            _soft_envelope(posterior_raw, limit, knee),
        ),
    )
end
