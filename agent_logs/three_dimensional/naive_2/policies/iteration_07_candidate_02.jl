# State-feedback traveling bend with course-responsive approach redirects.
# Joint state carries propulsive phase; normalized target-versus-velocity
# direction keeps a redirect active until translation, not just posture, turns.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        maximum_bearing=pi / 2,
        maximum_lateral_velocity=1.0,
        steering_softness=0.35,
        lateral_velocity_gain=0.8,
        course_error_gain=0.65,
        course_speed_scale=0.25,
        carrier_yaw_head_rate_gain=0.65,
        carrier_yaw_tail_rate_gain=0.22,
        maximum_yaw_residual=0.5,
        yaw_residual_gain=0.6,
        cruise_half_cycle_asymmetry=0.35,
        redirect_half_cycle_asymmetry=0.65,
        wrong_side_slip_scale=0.08,
        head_asymmetry_share=0.65,
        tail_asymmetry_share=1.0,
        approach_distance=6.0,
        approach_distance_width=1.0,
        approach_angle_scale=0.5,
        minimum_carrier_scale=0.35,
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

    # Preserve the common seed's evidenced propulsive carrier and posterior
    # lag; steering changes neither its frequency nor its amplitude target.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    carrier_a1 = vdp_drive - omega^2 * q1
    phase_lag_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    carrier_a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    fallback_bearing = isfinite(state.bearing) ? Float64(state.bearing) : 0.0
    target_x = isfinite(state.target_body_L[1]) ?
        Float64(state.target_body_L[1]) : -1.0
    target_y = isfinite(state.target_body_L[2]) ?
        Float64(state.target_body_L[2]) : 0.0
    distance = isfinite(state.distance_L) ?
        max(Float64(state.distance_L), 0.0) :
        params.approach_distance + 4 * params.approach_distance_width
    lateral_velocity = isfinite(state.velocity_body_U[2]) ?
        Float64(state.velocity_body_U[2]) : 0.0
    forward_velocity = isfinite(state.velocity_body_U[1]) ?
        Float64(state.velocity_body_U[1]) : 0.0
    heading_rate = isfinite(state.heading_rate) ?
        Float64(state.heading_rate) : 0.0
    # The adapter's restricted bearing folds fore and aft target directions
    # together.  Use the normalized target vector to retain that distinction:
    # body forward is -x, so this is the full-circle pursuit angle.  Clamping
    # keeps turn authority bounded while preserving reflection equivariance.
    pursuit_bearing = isfinite(target_x) && isfinite(target_y) ?
        atan(target_y, -target_x) : fallback_bearing
    bounded_bearing = clamp(
        pursuit_bearing,
        -params.maximum_bearing,
        params.maximum_bearing,
    )
    bounded_lateral_velocity = clamp(
        lateral_velocity,
        -params.maximum_lateral_velocity,
        params.maximum_lateral_velocity,
    )

    # Body bearing can align for part of a beat while inertial momentum still
    # carries the fish across the target line. Compare target and translational
    # course in the same forward-is-minus-x body convention. The speed gate
    # makes the angle irrelevant at startup and during a true near-stop.
    course_angle = atan(lateral_velocity, -forward_velocity)
    raw_course_error = atan(
        sin(pursuit_bearing - course_angle),
        cos(pursuit_bearing - course_angle),
    )
    bounded_course_error = clamp(
        raw_course_error,
        -params.maximum_bearing,
        params.maximum_bearing,
    )
    course_speed = hypot(forward_velocity, lateral_velocity)
    course_response = tanh(
        course_speed / max(params.course_speed_scale, eps(Float64)),
    )
    distance_width = max(params.approach_distance_width, eps(Float64))
    approach_proximity = 0.5 * (
        1 - tanh((distance - params.approach_distance) / distance_width)
    )
    course_blend = approach_proximity * course_response

    # The sampled yaw rate is mostly a repeatable function of joint phase.
    # Remove that carrier-correlated component before interpreting yaw as a
    # directional response. Correct-sign residual yaw then releases the turn;
    # wrong-sign residual yaw reinforces it without damping the propulsive beat.
    carrier_phase_yaw = -params.carrier_yaw_head_rate_gain * qd1 -
        params.carrier_yaw_tail_rate_gain * qd2
    yaw_residual = clamp(
        heading_rate - carrier_phase_yaw,
        -params.maximum_yaw_residual,
        params.maximum_yaw_residual,
    )
    # Preserve the sampled lateral-velocity response in the far field. In the
    # approach, replace it continuously with a scale-free course-angle error.
    lateral_response = -(1 - course_blend) *
        params.lateral_velocity_gain * bounded_lateral_velocity +
        course_blend * params.course_error_gain * bounded_course_error
    turn_signal = bounded_bearing + lateral_response +
        params.yaw_residual_gain * yaw_residual
    turn_request = tanh(
        turn_signal / max(params.steering_softness, eps(Float64)),
    )

    # Opposite-signed target bearing and lateral response indicate motion away
    # from the requested side. Gate the evidenced stronger redirect smoothly;
    # authority remains below one so both propulsive half-cycles survive.
    wrong_side_slip = max(
        -bounded_bearing * bounded_lateral_velocity,
        0.0,
    )
    slip_redirect_gate = tanh(
        wrong_side_slip / max(params.wrong_side_slip_scale, eps(Float64)),
    )
    course_misalignment = tanh(
        abs(bounded_course_error) /
        max(params.approach_angle_scale, eps(Float64)),
    )
    redirect_gate = max(
        slip_redirect_gate,
        approach_proximity * course_response * course_misalignment,
    )
    asymmetry_limit = params.cruise_half_cycle_asymmetry +
        redirect_gate * (
            params.redirect_half_cycle_asymmetry -
            params.cruise_half_cycle_asymmetry
    )
    asymmetry = asymmetry_limit * turn_request

    # Reduce only symmetric carrier drive during a near redirect. A recovered
    # bearing no longer releases the burst while the observed course is still
    # crossing the target line; both directional responses must settle before
    # the evidenced cruise carrier is fully restored.
    bearing_misalignment = tanh(
        abs(bounded_bearing) /
        max(params.approach_angle_scale, eps(Float64)),
    )
    approach_misalignment = max(
        bearing_misalignment,
        course_response * course_misalignment,
    )
    approach_redirect = approach_proximity * approach_misalignment
    carrier_scale = 1 -
        (1 - params.minimum_carrier_scale) * approach_redirect

    # Signed absolute carrier acceleration strengthens the requested
    # half-cycle without imposing a fixed joint equilibrium. Posterior
    # emphasis retains the traveling bend, and smooth saturation stays inside
    # the actuator envelope before any downstream clipping.
    raw_a1 = carrier_scale * carrier_a1 +
        params.head_asymmetry_share * asymmetry * abs(carrier_a1)
    raw_a2 = carrier_scale * carrier_a2 +
        params.tail_asymmetry_share * asymmetry * abs(carrier_a2)
    limit = params.maximum_joint_acceleration
    bounded_a1 = limit * tanh(raw_a1 / limit)
    bounded_a2 = limit * tanh(raw_a2 / limit)

    return (
        phi_ddot=(bounded_a1, bounded_a2),
    )
end
