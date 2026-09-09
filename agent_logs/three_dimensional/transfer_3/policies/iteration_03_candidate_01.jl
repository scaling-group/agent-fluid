# Phase-2 candidate: a coherent joint-state traveling bend with bounded
# response-led posterior curvature from normalized target geometry.

function target_policy_params()
    return (
        version="dogfish3d_response_led_traveling_bend_v3",
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.80,
        tail_damping=0.65,
        los_forward_floor=0.25,
        bearing_scale=0.35,
        bearing_response_lead_time=0.10,
        bearing_rate_limit=1.20,
        mean_tail_curvature_limit=4.0 * pi / 180,
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

    # The adapter's trend window is much shorter than one tail beat. Use it
    # only as a capped response lead: improving alignment releases curvature
    # and may begin countersteer before LOS crosses zero, while an adverse
    # trend modestly strengthens the route correction. It is not treated as a
    # beat-averaged yaw-rate measurement.
    bearing_rate = hasproperty(state, :bearing_window_rate) ?
        _finite_or(state.bearing_window_rate, 0.0) :
        _finite_or(state.bearing_rate, 0.0)
    bounded_bearing_rate = clamp(
        bearing_rate,
        -params.bearing_rate_limit,
        params.bearing_rate_limit,
    )
    effective_los_error =
        los_error + params.bearing_response_lead_time * bounded_bearing_rate
    turn_command = tanh(
        effective_los_error / max(params.bearing_scale, 1.0e-6),
    )

    # The 3D FSI sign calibration and the opposite-polarity rollout agree:
    # positive joint bias produces negative yaw. A positive body-y target
    # therefore requires a positive mean tail tangent.
    mean_tail_curvature = params.mean_tail_curvature_limit * turn_command
    return (
        los_error=los_error,
        bearing_rate=bearing_rate,
        bounded_bearing_rate=bounded_bearing_rate,
        effective_los_error=effective_los_error,
        turn_command=turn_command,
        mean_tail_curvature=mean_tail_curvature,
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

    guidance = target_guidance(state, params)
    posterior_target =
        guidance.mean_tail_curvature - q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(Float64))
    posterior_accel =
        omega^2 * (posterior_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(anterior_accel, posterior_accel),)
end
