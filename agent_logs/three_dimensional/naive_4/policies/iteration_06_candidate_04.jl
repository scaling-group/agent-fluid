# Redirect-priority posterior allocation for the 3D moving-window EvE lane.
# The captured response-gated carrier is unchanged; during a redirect its mean
# bend receives acceleration headroom before the oscillatory tail contribution.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        steering_bearing_limit=pi / 2,
        steering_course_speed_floor_U=0.15,
        steering_course_angle_limit=pi / 2,
        steering_course_weight=0.55,
        steering_error_scale=0.30,
        steering_curvature_limit=12.0 * pi / 180,
        steering_wave_relief=0.65,
        steering_phase_gate_scale=0.25,
        redirect_course_reliability_speed_U=0.25,
        redirect_error_onset=0.45,
        redirect_error_width=0.15,
        redirect_error_scale=0.30,
        redirect_curvature_limit=24.0 * pi / 180,
        redirect_wave_relief=0.95,
        redirect_wave_acceleration_reserve=0.10,
        posterior_target_limit=42.0 * pi / 180,
        acceleration_limit=1800.0 * pi / 180,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Preserve the sampled carrier without moving its anterior equilibrium.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1

    raw_bearing = Float64(state.bearing)
    bearing = isfinite(raw_bearing) ? clamp(
        raw_bearing,
        -params.steering_bearing_limit,
        params.steering_bearing_limit,
    ) : 0.0

    velocity_forward = -Float64(state.velocity_body_U[1])
    velocity_lateral = Float64(state.velocity_body_U[2])
    velocity_forward = isfinite(velocity_forward) ? velocity_forward : 0.0
    velocity_lateral = isfinite(velocity_lateral) ? velocity_lateral : 0.0
    forward_speed = max(velocity_forward, 0.0)

    # Retain the evidenced, deliberately partial course correction in cruise.
    # The positive denominator also prevents release noise or reverse motion
    # from defining a steering direction.
    course_angle = atan(
        velocity_lateral,
        max(velocity_forward, params.steering_course_speed_floor_U),
    )
    course_angle = clamp(
        course_angle,
        -params.steering_course_angle_limit,
        params.steering_course_angle_limit,
    )
    cruise_error = bearing - params.steering_course_weight * course_angle
    cruise_turn = tanh(cruise_error / params.steering_error_scale)

    # Exact target-versus-course error is too beat-sensitive to steer the
    # entire rollout in the sampled evidence. Use it only to open a redirect
    # gate after reliable forward translation has developed. The gate closes
    # continuously when measured course realigns; it has no clock or stage.
    reliability_speed = params.redirect_course_reliability_speed_U
    course_reliability = forward_speed^2 /
        (forward_speed^2 + reliability_speed^2)
    response_error = bearing - course_reliability * course_angle
    redirect_gate = course_reliability * 0.5 * (1 + tanh(
        (abs(response_error) - params.redirect_error_onset) /
        params.redirect_error_width,
    ))
    redirect_turn = tanh(response_error / params.redirect_error_scale)

    mean_tail_tangent =
        (1 - redirect_gate) * params.steering_curvature_limit * cruise_turn +
        redirect_gate * params.redirect_curvature_limit * redirect_turn
    steering_turn =
        (1 - redirect_gate) * cruise_turn + redirect_gate * redirect_turn

    posterior_wave = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))

    # Keep the sampled one-sided relief in cruise. During a large-response
    # redirect, nearly remove only the lobe that opposes the requested bend;
    # the aiding lobe is never amplified and small-error propulsion is intact.
    normalized_opposition = -steering_turn * posterior_wave /
        max(amp, eps(amp))
    opposition_gate = 0.5 * (1 + tanh(
        normalized_opposition / params.steering_phase_gate_scale,
    ))
    wave_relief = params.steering_wave_relief + redirect_gate *
        (params.redirect_wave_relief - params.steering_wave_relief)
    wave_scale = 1 - wave_relief * abs(steering_turn) * opposition_gate
    phase_lag_target = clamp(
        mean_tail_tangent + wave_scale * posterior_wave,
        -params.posterior_target_limit,
        params.posterior_target_limit,
    )

    # Decompose the bounded target exactly into mean tracking plus the admitted
    # joint-state wave. As the redirect gate opens, reserve a small part of the
    # acceleration envelope for mean tracking and damping. A wave contribution
    # that unloads an over-budget mean request is retained, but a reinforcing
    # contribution is removed; no posterior lobe is ever amplified.
    mean_accel = omega^2 * (mean_tail_tangent - q2) -
        2 * params.tail_damping * omega * qd2
    wave_accel = omega^2 * (phase_lag_target - mean_tail_tangent)
    wave_reserve = clamp(
        params.redirect_wave_acceleration_reserve,
        0.0,
        1.0,
    )
    wave_soft_limit = params.acceleration_limit *
        (1 - redirect_gate * wave_reserve)
    requested_a2 = mean_accel + wave_accel
    a2 = if abs(mean_accel) < wave_soft_limit
        clamp(requested_a2, -wave_soft_limit, wave_soft_limit)
    elseif mean_accel * wave_accel >= 0
        mean_accel
    elseif mean_accel * requested_a2 < 0 &&
            abs(requested_a2) > wave_soft_limit
        -sign(mean_accel) * wave_soft_limit
    else
        requested_a2
    end

    a1 = clamp(a1, -params.acceleration_limit, params.acceleration_limit)
    a2 = clamp(a2, -params.acceleration_limit, params.acceleration_limit)

    return (phi_ddot=(a1, a2),)
end
