# Target-supported carrier-residual yaw feedback on the captured intercept
# carrier. Cruise yaw opposition keeps full authority; closing approach
# feedback removes only the part not supported by current target bearing.

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
        yaw_carrier_position_gain=0.03,
        yaw_carrier_velocity_gain=-0.43,
        yaw_residual_scale=0.025,
        yaw_response_speed_onset_U=0.25,
        yaw_response_speed_width_U=0.15,
        yaw_redirect_curvature_limit=4.0 * pi / 180,
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
        capture_corridor_miss_limit_L=0.55,
        capture_corridor_width_L=0.15,
        posterior_target_limit=42.0 * pi / 180,
        joint_velocity_limit=260.0 * pi / 180,
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

@inline function _project_velocity_limit_acceleration(
    acceleration,
    velocity,
    velocity_limit,
)
    limit = max(abs(velocity_limit), eps(Float64))
    normalized_velocity = velocity / limit
    outward_at_limit = abs(normalized_velocity) >= 1 &&
        acceleration * normalized_velocity > 0
    return outward_at_limit ? zero(acceleration) : acceleration
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

    velocity_forward = -Float64(state.velocity_body_U[1])
    velocity_lateral = Float64(state.velocity_body_U[2])
    velocity_forward = isfinite(velocity_forward) ? velocity_forward : 0.0
    velocity_lateral = isfinite(velocity_lateral) ? velocity_lateral : 0.0
    forward_speed = max(velocity_forward, 0.0)

    # Enter approach mode only when proximity and target-aligned translation
    # agree. A nearby fish that is sliding away retains the full carrier.
    target_body_x = Float64(state.target_body_L[1])
    target_body_y = Float64(state.target_body_L[2])
    target_valid = isfinite(target_body_x) && isfinite(target_body_y)
    target_distance = target_valid ? hypot(target_body_x, target_body_y) : Inf
    target_closing_speed = target_valid && target_distance > eps(Float64) ?
        (-target_body_x * velocity_forward +
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

    # The target/velocity cross product gives a normalized, reflection-even
    # closest-miss distance for the local straight course.
    course_speed = hypot(velocity_forward, velocity_lateral)
    target_forward = -target_body_x
    predicted_miss_distance = target_valid &&
        course_speed > params.steering_course_speed_floor_U &&
        target_closing_speed > 0 ?
        abs(target_forward * velocity_lateral -
            target_body_y * velocity_forward) / course_speed : Inf
    corridor_width = max(
        params.capture_corridor_width_L,
        eps(Float64),
    )
    capture_corridor_coordinate = clamp(
        (params.capture_corridor_miss_limit_L - predicted_miss_distance) /
            corridor_width,
        0.0,
        1.0,
    )
    capture_corridor_signal = capture_corridor_coordinate^2 *
        (3 - 2 * capture_corridor_coordinate)

    # Preserve the anterior equilibrium and far-field carrier. The approach
    # damping is applied below, after the redirect response is observable.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1

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

    # Most beat-scale response error in the sampled captures is a repeatable
    # function of the carrier state. Remove only a conservative, normalized,
    # reflection-odd fraction before selecting high-authority redirect duty.
    # Raw course error remains the bend direction and cruise fallback.
    carrier_response =
        params.carrier_response_position_gain * q1 / max(amp, eps(amp)) +
        params.carrier_response_velocity_gain * qd1 /
            max(omega * amp, eps(omega * amp))
    residual_fraction = clamp(
        params.carrier_response_residual_fraction,
        0.0,
        1.0,
    )
    response_error = raw_response_error -
        residual_fraction * carrier_response

    # Proximity lowers the fixed cruise onset only while closing, retaining
    # mean curvature until the measured and predicted response realign.
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

    # Course reliability prevents a corridor decision at startup. The signal
    # below affects only anterior damping; all steering remains on the
    # evaluated response-conditioned path.
    capture_corridor_gate = clamp(
        approach_gate * course_reliability * capture_corridor_signal,
        0.0,
        1.0,
    )
    redirect_turn = tanh(
        raw_response_error / params.redirect_error_scale,
    )

    # Raw yaw is dominated by the locomotor carrier in the sampled trace.
    # Predict that reflection-odd component from normalized anterior joint
    # phase, then expose only the residual as a steering-response signal.
    normalized_q1 = q1 / max(amp, eps(amp))
    normalized_qd1 = qd1 / max(omega * amp, eps(omega * amp))
    carrier_yaw_response =
        params.yaw_carrier_position_gain * normalized_q1 +
        params.yaw_carrier_velocity_gain * normalized_qd1
    raw_heading_rate = Float64(state.heading_rate)
    normalized_heading_rate = isfinite(raw_heading_rate) ?
        raw_heading_rate / max(omega, eps(omega)) : carrier_yaw_response
    yaw_response_residual = normalized_heading_rate - carrier_yaw_response

    # Add bend only when the non-carrier yaw points against the requested
    # redirect. Aiding residual yaw receives exactly zero extra authority.
    yaw_opposition_coordinate = clamp(
        -redirect_turn * yaw_response_residual /
            max(params.yaw_residual_scale, eps(Float64)),
        0.0,
        1.0,
    )
    yaw_opposition_gate = yaw_opposition_coordinate^2 *
        (3 - 2 * yaw_opposition_coordinate)
    yaw_speed_coordinate = clamp(
        (forward_speed - params.yaw_response_speed_onset_U) /
            max(params.yaw_response_speed_width_U, eps(Float64)),
        0.0,
        1.0,
    )
    yaw_speed_gate = yaw_speed_coordinate^2 *
        (3 - 2 * yaw_speed_coordinate)

    # Preserve the sampled yaw-residual correction through cruise. During a
    # closing approach, raw response error can remain large because of
    # beat-scale course slip even when target bearing is nearly zero. Bound
    # only this supplemental curvature by the fraction of redirect magnitude
    # supported by target geometry; the base steering paths remain unchanged.
    target_bearing_support = clamp(
        abs(bearing) / max(abs(raw_response_error), eps(Float64)),
        0.0,
        1.0,
    )
    target_bearing_support = target_bearing_support^2 *
        (3 - 2 * target_bearing_support)
    approach_yaw_support = 1 - approach_gate *
        (1 - target_bearing_support)
    yaw_redirect_gate = raw_redirect_gate * yaw_speed_gate *
        yaw_opposition_gate * approach_yaw_support
    yaw_redirect_curvature = yaw_redirect_gate *
        params.yaw_redirect_curvature_limit * redirect_turn

    # Proximity settles the gait only after the observed course response has
    # aligned. When the measured course also intersects the capture corridor,
    # release residual anterior braking without changing posterior relief or
    # target-directed curvature.
    redirect_duty = clamp(max(raw_redirect_gate, redirect_gate), 0.0, 1.0)
    approach_settle_gate = approach_gate * (1 - redirect_duty)
    approach_drive_gate = approach_settle_gate * (1 - capture_corridor_gate)
    approach_damping = 2 * params.approach_anterior_damping *
        approach_drive_gate * omega * qd1
    a1 = vdp_drive - omega^2 * q1 - approach_damping

    mean_tail_tangent =
        (1 - redirect_gate) * params.steering_curvature_limit * cruise_turn +
        redirect_gate * params.redirect_curvature_limit * redirect_turn +
        yaw_redirect_curvature
    steering_turn =
        (1 - redirect_gate) * cruise_turn + redirect_gate * redirect_turn
    raw_mean_tail_tangent =
        (1 - raw_redirect_gate) * params.steering_curvature_limit * cruise_turn +
        raw_redirect_gate * params.redirect_curvature_limit * redirect_turn +
        yaw_redirect_curvature
    raw_steering_turn =
        (1 - raw_redirect_gate) * cruise_turn +
        raw_redirect_gate * redirect_turn

    posterior_wave_nominal = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    approach_wave_scale = 1 - approach_settle_gate *
        (1 - params.approach_wave_floor)
    posterior_wave = approach_wave_scale * posterior_wave_nominal

    # Keep the sampled one-sided relief in cruise. During a large-response
    # redirect, nearly remove only the lobe that opposes the requested bend.
    # Approach relief scales the wave, not mean curvature, so the course
    # correction above retains a directional actuation channel.
    normalized_opposition = -steering_turn * posterior_wave /
        max(amp, eps(amp))
    opposition_gate = 0.5 * (1 + tanh(
        normalized_opposition / params.steering_phase_gate_scale,
    ))
    # Preserve wave relief and acceleration headroom on the evaluated raw
    # demand; only mean-route allocation is selected by the phase residual.
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

    # The residual branch is relief-only on the current state: retain the raw
    # evaluated command whenever phase subtraction would require more
    # instantaneous posterior acceleration.
    raw_mean_accel = omega^2 * (raw_mean_tail_tangent - q2) -
        2 * params.tail_damping * omega * qd2
    raw_wave_accel = omega^2 *
        (raw_phase_lag_target - raw_mean_tail_tangent)
    raw_a2 = _mean_first_posterior_acceleration(
        raw_mean_accel,
        raw_wave_accel,
        wave_soft_limit,
    )
    a2 = abs(residual_a2) <= abs(raw_a2) ? residual_a2 : raw_a2

    a1 = clamp(a1, -params.acceleration_limit, params.acceleration_limit)
    a2 = clamp(a2, -params.acceleration_limit, params.acceleration_limit)

    # The episode integrator cannot increase speed past this boundary. Remove
    # only the same-sign acceleration component that would be clipped; inward
    # commands and all feasible carrier/redirect actions pass through exactly.
    a1 = _project_velocity_limit_acceleration(
        a1,
        qd1,
        params.joint_velocity_limit,
    )
    a2 = _project_velocity_limit_acceleration(
        a2,
        qd2,
        params.joint_velocity_limit,
    )

    return (phi_ddot=(a1, a2),)
end
