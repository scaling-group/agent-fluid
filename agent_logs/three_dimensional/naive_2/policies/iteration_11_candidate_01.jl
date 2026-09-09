# Response-signed interception hold on a course-residual traveling bend.
# Far-field course feedback preserves translation; a near, closing, off-course
# approach blends into curvature whose sign follows measured terminal yaw.

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
        capture_hold_distance=2.25,
        capture_hold_distance_width=0.35,
        capture_hold_closing_speed_scale=0.35,
        capture_hold_course_scale=0.45,
        maximum_capture_hold=0.70,
        capture_hold_frequency_ratio=0.40,
        capture_hold_damping=1.0,
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

    # Body forward is -x. Target and translational velocity share the body
    # frame, so their signed angular mismatch rejects instantaneous body yaw.
    # Reflection symmetry leaves the exactly aft centerline unbiased.
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

    # Hand phase-sensitive steering to a persistent target-bearing mean bend
    # only in the region where the inherited course controller began to miss.
    terminal_width = max(abs(params.terminal_distance_width), eps(Float64))
    terminal_gate = 0.5 * (
        1 - tanh((distance - params.terminal_distance) / terminal_width)
    )
    terminal_pursuit_request = tanh(
        bounded_pursuit /
        max(abs(params.steering_softness), eps(Float64)),
    )
    # Inherited quiet-hold evidence shows positive common bend produces
    # positive world yaw, opposite the response required by positive pursuit
    # error under this body's forward-is-minus-x convention.
    terminal_mean_bend = -terminal_gate *
        abs(params.maximum_terminal_mean_bend) * terminal_pursuit_request
    minimum_course_share = clamp(
        params.minimum_terminal_course_share,
        0.0,
        1.0,
    )
    course_share = 1 - terminal_gate * (1 - minimum_course_share)

    # Preserve the evidenced state-feedback carrier outside capture approach.
    # Both joint oscillations are centered on the same terminal mean while the
    # posterior target retains its opposed traveling component and lag.
    q1_centered = q1 - terminal_mean_bend
    vdp_drive = params.oscillator_mu *
        (1 - (q1_centered / amp)^2) * qd1
    carrier_a1 = vdp_drive - omega^2 * q1_centered
    phase_lag_target = 2 * terminal_mean_bend - q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    carrier_a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

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
    rhythmic_a1 = carrier_a1 +
        params.head_asymmetry_share * asymmetry * abs(carrier_a1)
    rhythmic_a2 = carrier_a2 +
        params.tail_asymmetry_share * asymmetry * abs(carrier_a2)

    # A close target does not by itself justify coasting. Recruit a damped
    # interception posture only while the measured body-frame velocity is
    # closing on the target along a misaligned course. An aligned approach or
    # an already receding fish retains the rhythmic controller.
    radial_closing_speed = target_norm > eps(Float64) ?
        course_dot / target_norm : 0.0
    hold_distance_width = max(
        abs(params.capture_hold_distance_width),
        eps(Float64),
    )
    hold_proximity = 0.5 * (
        1 - tanh(
            (distance - params.capture_hold_distance) /
            hold_distance_width,
        )
    )
    closing_gate = tanh(
        max(radial_closing_speed, 0.0) /
        max(abs(params.capture_hold_closing_speed_scale), eps(Float64)),
    )
    miss_gate = tanh(
        abs(sin(bounded_course_error)) /
        max(abs(params.capture_hold_course_scale), eps(Float64)),
    )
    hold_weight = clamp(params.maximum_capture_hold, 0.0, 1.0) *
        hold_proximity * closing_gate * miss_gate

    # The hold keeps response-signed target-directed curvature authority while
    # replacing part of the propulsive beat with a slower damped posture.
    hold_omega = omega * clamp(
        abs(params.capture_hold_frequency_ratio),
        eps(Float64),
        1.0,
    )
    hold_damping = max(abs(params.capture_hold_damping), 0.0)
    hold_a1 = hold_omega^2 * (terminal_mean_bend - q1) -
        2 * hold_damping * hold_omega * qd1
    hold_a2 = hold_omega^2 * (terminal_mean_bend - q2) -
        2 * hold_damping * hold_omega * qd2
    raw_a1 = (1 - hold_weight) * rhythmic_a1 + hold_weight * hold_a1
    raw_a2 = (1 - hold_weight) * rhythmic_a2 + hold_weight * hold_a2

    limit = abs(params.maximum_joint_acceleration)
    bounded_a1 = limit * tanh(raw_a1 / max(limit, eps(Float64)))
    bounded_a2 = limit * tanh(raw_a2 / max(limit, eps(Float64)))

    return (
        phi_ddot=(bounded_a1, bounded_a2),
    )
end
