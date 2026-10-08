# Predictive posterior-wave headroom on the captured carrier-phase-residual
# redirect. Joint-state feedback unloads only outward wave acceleration near
# the speed envelope while preserving mean target-directed curvature.

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
        carrier_response_position_gain=-0.16,
        carrier_response_velocity_gain=0.60,
        carrier_response_residual_fraction=0.25,
        redirect_curvature_limit=24.0 * pi / 180,
        redirect_wave_relief=0.95,
        redirect_wave_acceleration_reserve=0.10,
        approach_start_distance_L=1.75,
        approach_full_distance_L=0.80,
        approach_closing_onset_U=0.55,
        approach_closing_width_U=0.20,
        approach_anterior_damping=0.22,
        approach_wave_floor=0.70,
        approach_redirect_error_onset=0.18,
        posterior_target_limit=42.0 * pi / 180,
        posterior_velocity_limit=260.0 * pi / 180,
        posterior_velocity_headroom_onset=0.95,
        acceleration_limit=1800.0 * pi / 180,
    )
end

@inline function _mean_first_posterior_acceleration(
    mean_accel,
    wave_accel,
    wave_soft_limit,
)
    requested = mean_accel + wave_accel
    if abs(mean_accel) < wave_soft_limit
        return clamp(requested, -wave_soft_limit, wave_soft_limit)
    elseif mean_accel * wave_accel >= 0
        return mean_accel
    elseif mean_accel * requested < 0 && abs(requested) > wave_soft_limit
        return -sign(mean_accel) * wave_soft_limit
    end
    return requested
end

@inline function _posterior_wave_with_velocity_headroom(
    wave_accel,
    posterior_velocity,
    velocity_limit,
    headroom_onset,
)
    limit = max(abs(velocity_limit), eps(Float64))
    onset = clamp(headroom_onset, 0.0, 1.0)
    speed_fraction = abs(posterior_velocity) / limit
    headroom = clamp(
        (1 - speed_fraction) / max(1 - onset, eps(Float64)),
        0.0,
        1.0,
    )
    headroom = headroom^2 * (3 - 2 * headroom)
    pushes_outward = wave_accel * posterior_velocity > 0
    return pushes_outward ? headroom * wave_accel : wave_accel
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    raw_bearing = Float64(state.bearing)
    bearing = isfinite(raw_bearing) ? clamp(
        raw_bearing,
        -params.steering_bearing_limit,
        params.steering_bearing_limit,
    ) : 0.0

    velocity_body_x = Float64(state.velocity_body_U[1])
    velocity_lateral = Float64(state.velocity_body_U[2])
    velocity_body_x = isfinite(velocity_body_x) ? velocity_body_x : 0.0
    velocity_lateral = isfinite(velocity_lateral) ? velocity_lateral : 0.0
    velocity_forward = -velocity_body_x
    forward_speed = max(velocity_forward, 0.0)

    # Approach authority requires both proximity and measured target-aligned
    # closing. A nearby fish that is sliding away recovers the full cruise law.
    target_body_x = Float64(state.target_body_L[1])
    target_body_y = Float64(state.target_body_L[2])
    target_valid = isfinite(target_body_x) && isfinite(target_body_y)
    target_distance = target_valid ? hypot(target_body_x, target_body_y) : Inf
    target_closing_speed = target_valid && target_distance > eps(Float64) ?
        (target_body_x * velocity_body_x +
         target_body_y * velocity_lateral) / target_distance : 0.0
    approach_span = max(
        params.approach_start_distance_L - params.approach_full_distance_L,
        eps(params.approach_start_distance_L),
    )
    approach_proximity = clamp(
        (params.approach_start_distance_L - target_distance) / approach_span,
        0.0,
        1.0,
    )
    approach_proximity = approach_proximity^2 * (3 - 2 * approach_proximity)
    approach_closing_gate = 0.5 * (1 + tanh(
        (target_closing_speed - params.approach_closing_onset_U) /
        max(params.approach_closing_width_U, eps(Float64)),
    ))
    approach_gate = approach_proximity * approach_closing_gate

    # Preserve the anterior equilibrium and far-field carrier. During reliable
    # closing, bounded joint-velocity damping removes excess rhythmic drive.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    approach_damping = 2 * params.approach_anterior_damping *
        approach_gate * omega * qd1
    a1 = vdp_drive - omega^2 * q1 - approach_damping

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
    raw_response_error = bearing - course_reliability * course_angle

    # Most beat-scale response-error variance is a repeatable function of the
    # carrier state rather than a persistent route change. Remove only a
    # conservative fraction before opening the strong redirect. These
    # coordinates are normalized and odd under lateral reflection. Cruise
    # steering still uses the raw course observation as an evidenced fallback.
    carrier_response =
        params.carrier_response_position_gain * q1 / max(amp, eps(amp)) +
        params.carrier_response_velocity_gain * qd1 /
            max(omega * amp, eps(omega * amp))
    residual_fraction = clamp(
        params.carrier_response_residual_fraction,
        0.0,
        1.0,
    )
    response_error = raw_response_error - residual_fraction * carrier_response

    # Proximity lowers the fixed cruise onset only while closing, retaining
    # mean curvature until the measured response error actually falls.
    approach_redirect_onset = clamp(
        params.approach_redirect_error_onset,
        0.0,
        params.redirect_error_onset,
    )
    effective_redirect_onset = params.redirect_error_onset + approach_gate *
        (approach_redirect_onset - params.redirect_error_onset)
    raw_redirect_gate = course_reliability * 0.5 * (1 + tanh(
        (abs(raw_response_error) - effective_redirect_onset) /
        params.redirect_error_width,
    ))
    redirect_gate = course_reliability * 0.5 * (1 + tanh(
        (abs(response_error) - effective_redirect_onset) /
        params.redirect_error_width,
    ))
    # Residualization selects high-authority duty; the evaluated raw response
    # retains the direction and magnitude of the bend once that gate is open.
    redirect_turn = tanh(raw_response_error / params.redirect_error_scale)

    mean_tail_tangent =
        (1 - redirect_gate) * params.steering_curvature_limit * cruise_turn +
        redirect_gate * params.redirect_curvature_limit * redirect_turn
    steering_turn =
        (1 - redirect_gate) * cruise_turn + redirect_gate * redirect_turn
    raw_mean_tail_tangent =
        (1 - raw_redirect_gate) * params.steering_curvature_limit * cruise_turn +
        raw_redirect_gate * params.redirect_curvature_limit * redirect_turn
    raw_steering_turn =
        (1 - raw_redirect_gate) * cruise_turn +
        raw_redirect_gate * redirect_turn

    posterior_wave_nominal = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    approach_wave_scale = 1 - approach_gate *
        (1 - params.approach_wave_floor)
    posterior_wave = approach_wave_scale * posterior_wave_nominal

    # Keep the sampled one-sided relief in cruise. During a large-response
    # redirect, nearly remove only the lobe that opposes the requested bend;
    # the aiding lobe is never amplified and small-error propulsion is intact.
    normalized_opposition = -steering_turn * posterior_wave /
        max(amp, eps(amp))
    opposition_gate = 0.5 * (1 + tanh(
        normalized_opposition / params.steering_phase_gate_scale,
    ))
    # Preserve the evaluated wave relief and acceleration headroom on the raw
    # beat-scale demand. Only the mean route allocation is residual-gated.
    wave_relief = params.steering_wave_relief + raw_redirect_gate *
        (params.redirect_wave_relief - params.steering_wave_relief)
    wave_scale = 1 - wave_relief * abs(steering_turn) * opposition_gate
    phase_lag_target = clamp(
        mean_tail_tangent + wave_scale * posterior_wave,
        -params.posterior_target_limit,
        params.posterior_target_limit,
    )
    raw_normalized_opposition = -raw_steering_turn * posterior_wave /
        max(amp, eps(amp))
    raw_opposition_gate = 0.5 * (1 + tanh(
        raw_normalized_opposition / params.steering_phase_gate_scale,
    ))
    raw_wave_scale = 1 - wave_relief * abs(raw_steering_turn) *
        raw_opposition_gate
    raw_phase_lag_target = clamp(
        raw_mean_tail_tangent + raw_wave_scale * posterior_wave,
        -params.posterior_target_limit,
        params.posterior_target_limit,
    )

    # Allocate the bounded posterior acceleration by control role. Reserve
    # redirect-dependent headroom for mean-bend tracking, retain wave action
    # that fits or unloads the mean request, and never amplify a wave lobe.
    mean_accel = omega^2 * (mean_tail_tangent - q2) -
        2 * params.tail_damping * omega * qd2
    wave_accel = omega^2 * (phase_lag_target - mean_tail_tangent)
    wave_accel = _posterior_wave_with_velocity_headroom(
        wave_accel,
        qd2,
        params.posterior_velocity_limit,
        params.posterior_velocity_headroom_onset,
    )
    wave_reserve = clamp(
        params.redirect_wave_acceleration_reserve,
        0.0,
        1.0,
    )
    wave_soft_limit = params.acceleration_limit *
        (1 - raw_redirect_gate * wave_reserve)
    residual_a2 = _mean_first_posterior_acceleration(
        mean_accel,
        wave_accel,
        wave_soft_limit,
    )

    # The phase residual is relief-only on the inherited state: retain the raw
    # evaluated command whenever changing the route gate would require more
    # instantaneous posterior acceleration.
    raw_mean_accel = omega^2 * (raw_mean_tail_tangent - q2) -
        2 * params.tail_damping * omega * qd2
    raw_wave_accel = omega^2 *
        (raw_phase_lag_target - raw_mean_tail_tangent)
    raw_wave_accel = _posterior_wave_with_velocity_headroom(
        raw_wave_accel,
        qd2,
        params.posterior_velocity_limit,
        params.posterior_velocity_headroom_onset,
    )
    raw_a2 = _mean_first_posterior_acceleration(
        raw_mean_accel,
        raw_wave_accel,
        wave_soft_limit,
    )
    a2 = abs(residual_a2) <= abs(raw_a2) ? residual_a2 : raw_a2

    a1 = clamp(a1, -params.acceleration_limit, params.acceleration_limit)
    a2 = clamp(a2, -params.acceleration_limit, params.acceleration_limit)

    return (phi_ddot=(a1, a2),)
end
