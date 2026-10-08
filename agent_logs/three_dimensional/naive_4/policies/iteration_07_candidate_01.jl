# Response-gated posterior redirect with a closing-gated terminal joint hold.
# The captured transit controller is unchanged outside the target neighborhood;
# positive approach progress continuously releases excess drive near capture.

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
        approach_distance_L=1.20,
        approach_distance_width_L=0.15,
        approach_closing_speed_onset_L_per_T=0.20,
        approach_closing_speed_width_L_per_T=0.10,
        approach_hold_frequency=2.5,
        approach_hold_damping=0.9,
        approach_steering_retention=1.0,
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
    transit_a1 = vdp_drive - omega^2 * q1

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
    transit_a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    # A first-crossing capture does not require carrying the saturated beat all
    # the way through the target. Blend into a slower damped hold only inside
    # the approach neighborhood and only while distance is decreasing. If
    # closing progress is lost, this gate releases the captured transit law.
    raw_distance = Float64(state.distance_L)
    distance = isfinite(raw_distance) ? max(raw_distance, 0.0) : Inf
    raw_closing_speed = Float64(state.closing_speed_L)
    closing_speed = isfinite(raw_closing_speed) ? raw_closing_speed : 0.0
    distance_width = max(params.approach_distance_width_L, eps(Float64))
    closing_width = max(
        params.approach_closing_speed_width_L_per_T,
        eps(Float64),
    )
    distance_gate = 0.5 * (1 + tanh(
        (params.approach_distance_L - distance) / distance_width,
    ))
    closing_gate = 0.5 * (1 + tanh(
        (closing_speed - params.approach_closing_speed_onset_L_per_T) /
        closing_width,
    ))
    approach_gate = distance_gate * closing_gate

    hold_omega = params.approach_hold_frequency
    hold_damping = 2 * params.approach_hold_damping * hold_omega
    steering_retention = clamp(params.approach_steering_retention, 0.0, 1.0)
    posterior_hold_target = steering_retention * mean_tail_tangent
    hold_a1 = -hold_omega^2 * q1 - hold_damping * qd1
    hold_a2 = hold_omega^2 * (posterior_hold_target - q2) -
        hold_damping * qd2
    a1 = (1 - approach_gate) * transit_a1 + approach_gate * hold_a1
    a2 = (1 - approach_gate) * transit_a2 + approach_gate * hold_a2

    a1 = clamp(a1, -params.acceleration_limit, params.acceleration_limit)
    a2 = clamp(a2, -params.acceleration_limit, params.acceleration_limit)

    return (phi_ddot=(a1, a2),)
end
