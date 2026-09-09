function target_policy_params()
    return (
        control_period=0.68,
        oscillator_amplitude=22.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.65,
        tail_damping=0.75,
        bearing_scale=0.35,
        heading_response_horizon=6.0,
        heading_response_limit=0.35,
        approach_distance_scale=2.0,
        approach_course_damping=0.30,
        half_cycle_asymmetry=0.45,
        posterior_asymmetry_share=0.55,
        aligned_posterior_emphasis=0.10,
        progress_posterior_emphasis=0.05,
        body_speed_floor=0.05,
        course_trend_horizon=6.0,
        course_consistency_modulation=0.35,
        course_rate_reference_ratio=1.25,
        yaw_moment_scale=1.0,
        minimum_steering_fraction=0.20,
        minimum_rate_steering_fraction=0.55,
        acceleration_soft_limit=29.0,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Preserve the initialized zero-centered traveling bend. Unlike a steering
    # equilibrium, this oscillator does not subtract the release bend before
    # it can generate upstream propulsion.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    symmetric_a1 = vdp_drive - omega^2 * q1

    # Predict the remaining body-frame error after the observed turn response.
    # Far from the target this retains the established response horizon. Near
    # capture, do not project the current turn beyond the distance/body-speed
    # time-to-target; the fallbacks preserve the compact-state contract.
    bearing = clamp(Float64(state.bearing), -pi / 2, pi / 2)
    heading_rate = hasproperty(state, :heading_rate) ?
        Float64(getproperty(state, :heading_rate)) : 0.0
    velocity_body = hasproperty(state, :velocity_body_U) ?
        getproperty(state, :velocity_body_U) : (0.0, 0.0)
    velocity_body_x = Float64(velocity_body[1])
    velocity_body_y = Float64(velocity_body[2])
    body_speed = hypot(velocity_body_x, velocity_body_y)
    has_distance = hasproperty(state, :distance_L)
    distance_L = has_distance ?
        max(Float64(getproperty(state, :distance_L)), 0.0) : Inf
    heading_response_horizon = if has_distance
        min(
            params.heading_response_horizon,
            distance_L / max(body_speed, params.body_speed_floor),
        )
    else
        params.heading_response_horizon
    end
    heading_response = clamp(
        heading_response_horizon * heading_rate,
        -params.heading_response_limit,
        params.heading_response_limit,
    )

    # During approach, bearing alone can look aligned while lateral momentum
    # already carries the fish across the line of sight. Compare the observed
    # body-course angle with target bearing and damp only that mismatch. The
    # smooth distance gate preserves the established far/middle wake route;
    # speed confidence prevents a noisy direction estimate near zero motion.
    body_course = atan(
        velocity_body_y,
        max(abs(velocity_body_x), params.body_speed_floor),
    )
    course_mismatch = clamp(body_course - bearing, -pi / 2, pi / 2)
    course_confidence = body_speed^2 /
        (body_speed^2 + params.body_speed_floor^2)
    approach_ratio = distance_L /
        max(params.approach_distance_scale, eps(Float64))
    approach_gate = 1 / (1 + approach_ratio^4)
    predicted_bearing = bearing - heading_response -
        params.approach_course_damping * approach_gate *
        course_confidence * course_mismatch
    route_turn = tanh(
        predicted_bearing / max(params.bearing_scale, eps(Float64)),
    )

    # Large normalized yaw moment means the wake/body interaction is already
    # turning the fish. Reduce only the target-steering residual, retaining a
    # small authority floor and leaving the propulsive wave intact.
    yaw_load_ratio = abs(Float64(state.moment_z_L2)) /
        max(params.yaw_moment_scale, eps(Float64))
    steering_gate = params.minimum_steering_fraction +
        (1 - params.minimum_steering_fraction) /
        (1 + yaw_load_ratio * yaw_load_ratio)
    turn_fraction = steering_gate * route_turn

    # Both joints contact their rate envelope in the matched successful
    # rollouts. Preserve the propulsive accelerations, but smoothly withdraw
    # optional half-cycle steering from each joint as its oscillator-normalized
    # rate loses headroom. Independent gates avoid penalizing a joint that can
    # still contribute, and the floor retains target authority.
    rate_reference = params.course_rate_reference_ratio * omega * amp
    steering_rate_usage1 = abs(qd1) / max(rate_reference, eps(Float64))
    steering_rate_usage2 = abs(qd2) / max(rate_reference, eps(Float64))
    rate_steering_gate1 = params.minimum_rate_steering_fraction +
        (1 - params.minimum_rate_steering_fraction) /
        (1 + steering_rate_usage1^4)
    rate_steering_gate2 = params.minimum_rate_steering_fraction +
        (1 - params.minimum_rate_steering_fraction) /
        (1 + steering_rate_usage2^4)
    steering_a1 = params.half_cycle_asymmetry * turn_fraction *
        abs(symmetric_a1)
    asymmetric_a1 = symmetric_a1 + rate_steering_gate1 * steering_a1

    # Preserve the lagged traveling bend while using modest extra posterior
    # motion when the predicted body-frame route is aligned. Admit a second,
    # smaller envelope only when recent observed motion actually closes target
    # distance. Normalizing by body speed makes this a bounded progress ratio
    # rather than a dimensional closing-speed threshold.
    route_alignment = 1 /
        (1 + (predicted_bearing / max(params.bearing_scale, eps(Float64)))^2)
    closing_speed = hasproperty(state, :window_closing_speed_L) ?
        Float64(getproperty(state, :window_closing_speed_L)) :
        (hasproperty(state, :closing_speed_L) ?
            Float64(getproperty(state, :closing_speed_L)) : 0.0)
    closure_efficiency = clamp(
        max(closing_speed, 0.0) / max(body_speed, params.body_speed_floor),
        0.0,
        1.0,
    )

    # Scalar range closure can accompany an off-course pass. Preserve negative
    # course feedback, which suppresses optional posterior drive, but require
    # both actuator headroom and low yaw load before positive course convergence
    # earns more tail motion. The base traveling wave is never gated here.
    bearing_window_rate = hasproperty(state, :bearing_window_rate) ?
        Float64(getproperty(state, :bearing_window_rate)) :
        (hasproperty(state, :bearing_rate) ?
            Float64(getproperty(state, :bearing_rate)) : 0.0)
    normalized_course_trend = params.course_trend_horizon *
        bearing * bearing_window_rate /
        max(params.bearing_scale^2, eps(Float64))
    course_direction = tanh(-normalized_course_trend)
    joint_rate_usage = max(abs(qd1), abs(qd2)) /
        max(rate_reference, eps(Float64))
    course_headroom_gate = 1 / (1 + joint_rate_usage^4)
    positive_course_gate = course_headroom_gate * steering_gate
    conditioned_course = min(course_direction, 0.0) +
        positive_course_gate * max(course_direction, 0.0)
    course_consistency_scale = 1 +
        params.course_consistency_modulation * conditioned_course
    posterior_wave_scale = 1 + route_alignment * (
        params.aligned_posterior_emphasis +
        params.progress_posterior_emphasis * closure_efficiency *
        course_consistency_scale
    )
    tail_target = posterior_wave_scale * (
        -q1 - params.tail_lag_gain * qd1 / max(omega, eps(omega))
    )
    symmetric_a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2
    # A smaller share of the same half-cycle residual avoids cancelling the
    # requested turn through an equal anti-phase bias. Apply its own rate
    # headroom rather than coupling posterior authority to the anterior rate.
    steering_a2 = params.posterior_asymmetry_share *
        params.half_cycle_asymmetry * turn_fraction * abs(symmetric_a2)
    asymmetric_a2 = symmetric_a2 + rate_steering_gate2 * steering_a2

    # Smooth candidate-owned limiting avoids a persistent hard-clipped command.
    limit = params.acceleration_soft_limit
    a1 = limit * tanh(asymmetric_a1 / limit)
    a2 = limit * tanh(asymmetric_a2 / limit)

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
