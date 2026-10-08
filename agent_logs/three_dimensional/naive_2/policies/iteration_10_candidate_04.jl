# Sign-consensus posterior bend-pulse steering around the full
# crossflow-assisted traveling-wave carrier. The pulse is joint-state phased.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        steering_bearing_scale=0.30,
        steering_crossflow_scale=0.25,
        steering_crossflow_weight=0.75,
        steering_course_speed_scale=0.20,
        steering_course_error_scale=0.80,
        steering_course_error_weight=0.55,
        course_bearing_window=0.30,
        course_head_curvature_share=0.25,
        steering_yaw_rate_scale=1.0,
        steering_yaw_rate_weight=0.45,
        steering_curvature_limit=12.0 * pi / 180,
        steering_waveform_curvature_limit=6.0 * pi / 180,
        posterior_target_soft_limit=43.0 * pi / 180,
        actuation_soft_limit=1800.0 * pi / 180,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Bearing supplies route geometry. Head-relative crossflow is retained as
    # the sampled slip residual that improved both distance and survival while
    # preserving the alternating wake.
    bearing_value = Float64(state.bearing)
    bearing = isfinite(bearing_value) ? bearing_value : 0.0
    crossflow_value = Float64(state.relative_flow_velocity_body_U[2])
    crossflow = isfinite(crossflow_value) ? crossflow_value : 0.0

    # The target-to-velocity angle predicts translational route crossing. It
    # is silent near rest and smoothly concentrated near the target line, so
    # it brakes a delayed turn without replacing far-error bearing authority
    # or reacting to a fixed world direction.
    target_x_value = Float64(state.target_body_L[1])
    target_y_value = Float64(state.target_body_L[2])
    velocity_x_value = Float64(state.velocity_body_U[1])
    velocity_y_value = Float64(state.velocity_body_U[2])
    target_x = isfinite(target_x_value) ? target_x_value : 0.0
    target_y = isfinite(target_y_value) ? target_y_value : 0.0
    velocity_x = isfinite(velocity_x_value) ? velocity_x_value : 0.0
    velocity_y = isfinite(velocity_y_value) ? velocity_y_value : 0.0
    velocity_norm = hypot(velocity_x, velocity_y)
    course_cross = target_x * velocity_y - target_y * velocity_x
    course_dot = target_x * velocity_x + target_y * velocity_y
    course_error = velocity_norm > eps(Float64) ?
        clamp(atan(course_cross, course_dot), -pi / 2, pi / 2) : 0.0
    forward_speed = max(-velocity_x, 0.0)
    course_speed_gate = tanh(
        forward_speed /
        max(params.steering_course_speed_scale, eps(Float64)),
    )^2
    alignment_ratio = abs(bearing) /
        max(params.course_bearing_window, eps(Float64))
    centerline_gate = 1 / (1 + alignment_ratio^4)
    course_core = course_speed_gate * tanh(
        course_error /
        max(params.steering_course_error_scale, eps(Float64)),
    )
    course_response = centerline_gate * course_core
    course_brake =
        params.steering_course_error_weight * course_response

    # The successful course cue still acted too slowly through the tail alone.
    # Give that cue a small anterior lever without increasing total tail-end
    # curvature: recenter the carrier transiently, then let the posterior
    # relative target compensate the actual q1 below. The gate releases this
    # shift at rest, away from the target line, and as course alignment returns.
    head_redirect = params.course_head_curvature_share *
        params.steering_curvature_limit * course_response
    q1_carrier = q1 - head_redirect
    vdp_drive = params.oscillator_mu *
        (1 - (q1_carrier / amp)^2) * qd1
    a1_raw = vdp_drive - omega^2 * q1_carrier

    yaw_rate_value = Float64(state.turn_rate_recent)
    yaw_rate = isfinite(yaw_rate_value) ? yaw_rate_value : 0.0
    turn_state =
        bearing / max(params.steering_bearing_scale, eps(Float64)) +
        params.steering_crossflow_weight * tanh(
            crossflow /
            max(params.steering_crossflow_scale, eps(Float64)),
        ) +
        course_brake +
        params.steering_yaw_rate_weight * tanh(
            yaw_rate / max(params.steering_yaw_rate_scale, eps(Float64)),
        )
    mean_tail_tangent = params.steering_curvature_limit * tanh(turn_state)

    # Course-only half-cycle attenuation reduced effort but lost closest
    # approach. Add a different posterior wave-shape lever only when bearing
    # and measured translation agree on the turn direction. The product makes
    # disagreement exactly silent without a discontinuous sign decision.
    bearing_command = tanh(
        bearing / max(params.steering_bearing_scale, eps(Float64)),
    )
    directional_agreement = max(bearing_command * course_core, 0.0)
    consensus_turn = 0.5 * (bearing_command + course_core) *
        sqrt(directional_agreement)

    # Infer bend phase from q1 itself: curvature authority is zero at the
    # anterior center crossing and rises at either bend peak. This preserves
    # reflection symmetry and needs no clock or mutable oscillator state.
    normalized_head_bend = q1 / max(amp, eps(Float64))
    bend_phase_gate = clamp(normalized_head_bend^2, 0.0, 1.0)
    requested_waveform_redirect =
        params.steering_waveform_curvature_limit *
        consensus_turn * bend_phase_gate

    # Keep the full lagged carrier and baseline posterior mean. Limit only the
    # new signed pulse by the target-angle reserve in its requested direction;
    # a pulse that pulls an opposing excursion back toward center remains free
    # to act even when the other bend side has exhausted its reserve.
    base_phase_lag_target = mean_tail_tangent - q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    posterior_soft_limit = params.posterior_target_soft_limit
    redirect_reserve = requested_waveform_redirect >= 0.0 ?
        max(posterior_soft_limit - base_phase_lag_target, 0.0) :
        max(posterior_soft_limit + base_phase_lag_target, 0.0)
    waveform_redirect = redirect_reserve > eps(Float64) ?
        redirect_reserve * tanh(
            requested_waveform_redirect / redirect_reserve,
        ) : 0.0
    phase_lag_target = base_phase_lag_target + waveform_redirect
    a2_raw = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Stay smoothly inside the released acceleration envelope.
    accel_limit = params.actuation_soft_limit
    a1 = accel_limit * tanh(a1_raw / accel_limit)
    a2 = accel_limit * tanh(a2_raw / accel_limit)

    return (phi_ddot=(a1, a2),)
end
