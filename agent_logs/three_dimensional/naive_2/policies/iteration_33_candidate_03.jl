# Unified predicted-miss handoff with joint-reserve-aware redirect allocation.
# A bounded terminal residual remains rhythmic and target-relative while its
# two-joint distribution responds continuously to posterior kinematic reserve.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        maximum_navigation_error=pi / 2,
        course_speed_scale=0.25,
        steering_softness=0.35,
        cruise_half_cycle_asymmetry=0.35,
        redirect_half_cycle_asymmetry=0.65,
        course_redirect_scale=0.35,
        head_asymmetry_share=0.65,
        tail_asymmetry_share=1.0,
        terminal_distance=3.0,
        terminal_distance_width=0.5,
        maximum_terminal_mean_bend=8.0 * pi / 180,
        minimum_terminal_course_share=0.35,
        carrier_yaw_head_rate_gain=0.65,
        carrier_yaw_tail_rate_gain=0.22,
        maximum_yaw_residual=0.5,
        corrective_response_scale=0.08,
        maximum_terminal_tail_pulse=4.0 * pi / 180,
        tail_pulse_rate_scale=0.6,
        maximum_terminal_redirect_residual=0.35,
        posterior_soft_angle=38.0 * pi / 180,
        posterior_angle_width=3.0 * pi / 180,
        posterior_soft_rate=235.0 * pi / 180,
        posterior_rate_width=20.0 * pi / 180,
        maximum_prediction_horizon=4.0,
        prediction_time_width=0.75,
        prediction_speed_floor=0.25,
        prediction_miss_scale=1.0,
        maximum_joint_acceleration=30.0,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    fallback_bearing = isfinite(state.bearing) ? Float64(state.bearing) : 0.0
    target_x = isfinite(state.target_body_L[1]) ?
        Float64(state.target_body_L[1]) : -1.0
    target_y = isfinite(state.target_body_L[2]) ?
        Float64(state.target_body_L[2]) : 0.0
    velocity_x = isfinite(state.velocity_body_U[1]) ?
        Float64(state.velocity_body_U[1]) : 0.0
    velocity_y = isfinite(state.velocity_body_U[2]) ?
        Float64(state.velocity_body_U[2]) : 0.0
    distance = isfinite(state.distance_L) ?
        max(Float64(state.distance_L), 0.0) :
        params.terminal_distance + 4 * params.terminal_distance_width
    heading_rate = isfinite(state.heading_rate) ?
        Float64(state.heading_rate) : 0.0

    # Body forward is -x. Target and translational velocity share the body
    # frame, so their angular mismatch and cross-track miss reject beat-scale
    # body yaw. Exact aft-centerline geometry remains reflection-unbiased.
    target_norm = hypot(target_x, target_y)
    aft_tolerance = sqrt(eps(Float64)) * max(target_norm, 1.0)
    directly_aft = target_x > 0 && abs(target_y) <= aft_tolerance
    pursuit_error = if target_norm <= eps(Float64)
        fallback_bearing
    elseif directly_aft
        0.0
    else
        atan(target_y, -target_x)
    end
    speed = hypot(velocity_x, velocity_y)
    course_cross = target_x * velocity_y - target_y * velocity_x
    course_dot = target_x * velocity_x + target_y * velocity_y
    course_scale = target_norm * speed
    antiparallel = course_dot < 0 && abs(course_cross) <=
        sqrt(eps(Float64)) * max(course_scale, eps(Float64))
    course_error = if speed <= eps(Float64) || target_norm <= eps(Float64)
        pursuit_error
    elseif antiparallel
        pursuit_error
    else
        atan(course_cross, course_dot)
    end

    maximum_error = max(abs(params.maximum_navigation_error), eps(Float64))
    bounded_pursuit = clamp(pursuit_error, -maximum_error, maximum_error)
    bounded_course_error = clamp(course_error, -maximum_error, maximum_error)
    speed_scale = max(abs(params.course_speed_scale), eps(Float64))
    course_weight = speed^2 / (speed^2 + speed_scale^2)
    navigation_error = (1 - course_weight) * bounded_pursuit +
        course_weight * bounded_course_error
    turn_request = tanh(
        navigation_error / max(abs(params.steering_softness), eps(Float64)),
    )

    # Preserve the inherited 3L proximity handoff as a fallback. In addition,
    # predict the constant-course closest approach from normalized target and
    # velocity. A positive projection means the target is still ahead along
    # the measured course; cross/speed is its signed perpendicular miss.
    terminal_width = max(abs(params.terminal_distance_width), eps(Float64))
    distance_gate = 0.5 * (
        1 - tanh((distance - params.terminal_distance) / terminal_width)
    )
    prediction_floor = max(
        abs(params.prediction_speed_floor),
        eps(Float64),
    )
    safe_speed_squared = max(speed^2, prediction_floor^2)
    raw_time_to_closest = course_dot / safe_speed_squared
    time_to_closest = max(raw_time_to_closest, 0.0)
    time_gate = 0.5 * (
        1 - tanh(
            (time_to_closest - abs(params.maximum_prediction_horizon)) /
            max(abs(params.prediction_time_width), eps(Float64)),
        )
    )
    closing_alignment = course_scale > eps(Float64) ?
        clamp(course_dot / course_scale, 0.0, 1.0) : 0.0
    signed_predicted_miss = speed > prediction_floor ?
        course_cross / speed : 0.0
    miss_scale = max(abs(params.prediction_miss_scale), eps(Float64))
    prediction_request = tanh(signed_predicted_miss / miss_scale)
    prediction_gate = course_weight * closing_alignment * time_gate *
        abs(prediction_request)

    # Smoothly unite the ordinary near-target gate with the predictive gate.
    # The predictive request controls only the authority it recruited; current
    # target bearing remains the fallback as closing alignment disappears.
    terminal_gate = 1 - (1 - distance_gate) * (1 - prediction_gate)
    terminal_pursuit_request = tanh(
        bounded_pursuit /
        max(abs(params.steering_softness), eps(Float64)),
    )
    request_weight = distance_gate + prediction_gate
    terminal_turn_request = request_weight > eps(Float64) ? clamp(
        (
            distance_gate * terminal_pursuit_request +
            prediction_gate * prediction_request
        ) / request_weight,
        -1.0,
        1.0,
    ) : 0.0
    terminal_mean_bend = terminal_gate *
        abs(params.maximum_terminal_mean_bend) * terminal_turn_request
    minimum_course_share = clamp(
        params.minimum_terminal_course_share,
        0.0,
        1.0,
    )

    # Keep the rhythmic steering channel available until carrier-separated
    # yaw confirms a corrective terminal response. This preserves the
    # inherited handoff that improved the repeated closest pass.
    carrier_phase_yaw_rate =
        -params.carrier_yaw_head_rate_gain * qd1 -
        params.carrier_yaw_tail_rate_gain * qd2
    yaw_residual = clamp(
        heading_rate - carrier_phase_yaw_rate,
        -abs(params.maximum_yaw_residual),
        abs(params.maximum_yaw_residual),
    )
    corrective_yaw = max(-terminal_turn_request * yaw_residual, 0.0)
    corrective_response_gate = tanh(
        corrective_yaw /
        max(abs(params.corrective_response_scale), eps(Float64)),
    )

    # A transient correct-sign yaw is not enough to complete the redirect.
    # Release both rhythmic steering channels only as the remaining predicted
    # miss also becomes small. One consensus gate keeps their handoff coherent
    # without adding a coordinate, clock, or separate scalar threshold.
    geometry_ready_gate = 1 - abs(prediction_request)
    release_gate = corrective_response_gate * geometry_ready_gate
    unmet_release_gate = 1 - release_gate
    course_share = 1 - terminal_gate * release_gate *
        (1 - minimum_course_share)

    # Add a posterior-only wave-shape pulse during the force-producing
    # mid-stroke of a still-closing terminal intercept. Target sign supplies
    # direction; absolute joint speed supplies phase without a clock. The
    # correct-sign yaw releases the pulse only to the extent that predicted
    # miss is already small, avoiding handoff on a transient body response.
    normalized_head_speed = abs(qd1) /
        max(omega * amp, eps(Float64))
    midstroke_gate = tanh(
        normalized_head_speed /
        max(abs(params.tail_pulse_rate_scale), eps(Float64)),
    )
    terminal_tail_pulse = closing_alignment * terminal_gate *
        midstroke_gate * unmet_release_gate *
        abs(params.maximum_terminal_tail_pulse) * terminal_turn_request

    # Preserve the sampled cubic predicted-miss response, but allocate it by
    # observed posterior reserve rather than always burdening the tail. The
    # residual remains tail-dominant away from the soft angle/rate boundaries;
    # as either boundary is approached its complement moves smoothly to the
    # anterior rhythmic channel. Absolute joint state makes the allocation
    # reflection-neutral while the residual supplies the requested sign.
    posterior_miss_residual = terminal_gate * closing_alignment *
        abs(params.maximum_terminal_redirect_residual) * prediction_request^3
    posterior_angle_reserve = 0.5 * (
        1 - tanh(
            (abs(q2) - abs(params.posterior_soft_angle)) /
            max(abs(params.posterior_angle_width), eps(Float64)),
        )
    )
    posterior_rate_reserve = 0.5 * (
        1 - tanh(
            (abs(qd2) - abs(params.posterior_soft_rate)) /
            max(abs(params.posterior_rate_width), eps(Float64)),
        )
    )
    posterior_reserve = posterior_angle_reserve * posterior_rate_reserve
    tail_redirect_residual = posterior_reserve * posterior_miss_residual
    head_redirect_residual = params.head_asymmetry_share *
        (1 - posterior_reserve) * posterior_miss_residual

    # Center the oscillator and lagged posterior target on the slow mean bend.
    # The opposed traveling component and posterior lag remain intact around
    # that mean, preserving the evidenced propulsive wake.
    q1_centered = q1 - terminal_mean_bend
    vdp_drive = params.oscillator_mu *
        (1 - (q1_centered / amp)^2) * qd1
    carrier_a1 = vdp_drive - omega^2 * q1_centered
    phase_lag_target = 2 * terminal_mean_bend + terminal_tail_pulse - q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    carrier_a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Retain course-residual half-cycle steering, fading only the share handed
    # to persistent mean curvature. Both carrier half-cycles remain active.
    redirect_gate = tanh(
        abs(sin(bounded_course_error)) /
        max(abs(params.course_redirect_scale), eps(Float64)),
    ) * course_weight
    asymmetry_limit = params.cruise_half_cycle_asymmetry +
        redirect_gate * (
            params.redirect_half_cycle_asymmetry -
            params.cruise_half_cycle_asymmetry
        )
    asymmetry = course_share * asymmetry_limit * turn_request

    raw_a1 = carrier_a1 +
        (
            params.head_asymmetry_share * asymmetry +
            head_redirect_residual
        ) * abs(carrier_a1)
    raw_a2 = carrier_a2 +
        (
            params.tail_asymmetry_share * asymmetry +
            tail_redirect_residual
        ) * abs(carrier_a2)
    limit = abs(params.maximum_joint_acceleration)
    bounded_a1 = limit * tanh(raw_a1 / max(limit, eps(Float64)))
    bounded_a2 = limit * tanh(raw_a2 / max(limit, eps(Float64)))

    return (
        phi_ddot=(bounded_a1, bounded_a2),
    )
end
