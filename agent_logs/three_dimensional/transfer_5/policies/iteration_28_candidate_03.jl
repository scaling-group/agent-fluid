# Phase-2 candidate: retain the captured split-observer C-bend carrier and
# relieve only redundant terminal correction when the fluid already brakes yaw.
# Assigned split-baseline policy SHA256:
# e8dd4f34950bd011ceb6edb01df5d936d40aed672c0dc8e8b22d328238fb5b35
# The new mechanism has no clock or route state. Signed instantaneous yaw--
# moment power gates only the existing phase-selected anterior residual.
# Continuous target-course authority, posterior amplitude and lag, cadence,
# and component-wise smooth command projection remain unchanged.

function target_policy_params(; L::Int=64)
    return (
        version="dogfish_3d_target_v40_passive_yaw_brake_arbitration",
        L=Float64(L),
        drive_period=0.55,
        control_period=0.55,
        drive_amplitude=28.0 * pi / 180,
        drive_mu=0.35,
        drive_tail_lag_gain=0.80,
        drive_tail_damping=0.65,
        far_drive_frequency_gain=0.114,
        far_drive_turn_relief=0.36,
        progress_drive_frequency_gain=0.034,
        progress_closing_speed_scale=0.16,
        bearing_gain=3.2,
        vector_angle_gain=2.4,
        target_lateral_velocity_gain=0.20,
        bearing_trend_gain=0.70,
        bearing_trend_scale=0.110,
        turn_rate_target_gain=0.75,
        turn_rate_feedback_gain=1.25,
        turn_rate_request_scale=1.80,
        turn_rate_scale=0.22,
        negative_turn_request_gain=0.78,
        curvature_request_scale=2.20,
        negative_turn_curvature_gain=-10.5 * pi / 180,
        positive_turn_curvature_gain=-3.6 * pi / 180,
        approach_distance_L=2.10,
        approach_min_gain=0.36,
        positive_approach_min_gain=0.66,
        centerline_bearing_band=0.105,
        centerline_vector_band=0.120,
        centerline_min_turn_gain=0.31,
        sweep_bearing_band=0.35,
        sweep_rate_scale=0.12,
        sweep_damping_gain=0.45,
        positive_recovery_gain=0.64,
        positive_recovery_scale=0.24,
        positive_recovery_rate_scale=0.22,
        centerline_rate_brake_gain=0.43,
        centerline_rate_brake_scale=0.24,
        centerline_rate_brake_bearing_band=0.30,
        centerline_rate_brake_lateral_band=0.26,
        recovery_tail_curvature_gain=-5.1 * pi / 180,
        recovery_tail_curvature_scale=0.70,
        turn_request_limit=6.0,
        head_turn_share=0.70,
        tail_turn_share=1.00,
        halfcycle_tail_bias=0.25,
        halfcycle_velocity_gain=0.20,
        tail_tangent_scale=34.0 * pi / 180,
        body_angular_damping_gain=0.0,
        redirect_bearing_start=12.0 * pi / 180,
        redirect_bearing_full=35.0 * pi / 180,
        redirect_head_curvature_gain=8.0 * pi / 180,
        redirect_tail_tangent_gain=18.0 * pi / 180,
        redirect_drive_relief=0.40,
        redirect_lag_relief=0.65,
        redirect_response_floor=0.72,
        redirect_response_scale=0.90,
        terminal_yaw_brake_start_L=3.00,
        terminal_yaw_brake_full_L=0.75,
        carrier_heading_gain=0.50,
        carrier_tail_rate_gain=0.17,
        terminal_yaw_excess_scale=0.45,
        terminal_course_speed_scale_U=0.30,
        terminal_cross_track_speed_scale_U=0.25,
        terminal_course_carrier_gain=0.80,
        terminal_brake_head_curvature_gain=4.0 * pi / 180,
        terminal_brake_tail_tangent_gain=10.0 * pi / 180,
        terminal_anterior_halfcycle_curvature_gain=4.0 * pi / 180,
        terminal_passive_yaw_power_scale=0.008,
        terminal_passive_brake_counter_floor=0.50,
        command_accel_limit=1800.0 * pi / 180,
        command_projection_order=4.0,
    )
end
@inline function _clamp_unit(value)
    return clamp(value, -1.0, 1.0)
end

@inline function _clamp01(value)
    return clamp(value, 0.0, 1.0)
end

@inline function _safe(value, fallback)
    parsed = Float64(value)
    return isfinite(parsed) ? parsed : fallback
end

@inline function _smooth_project(value, limit, order)
    command = _safe(value, 0.0)
    command_limit = max(_safe(limit, 1.0), 1.0e-6)
    projection_order = max(_safe(order, 4.0), 2.0)
    magnitude = abs(command)
    magnitude == 0.0 && return 0.0

    # Algebraically equivalent branches avoid overflow for extreme finite
    # inputs while remaining continuous at the physical command limit.
    if magnitude <= command_limit
        ratio = magnitude / command_limit
        return command / (1.0 + ratio^projection_order)^(1.0 / projection_order)
    end
    inverse_ratio = command_limit / magnitude
    bounded_magnitude =
        command_limit / (1.0 + inverse_ratio^projection_order)^(1.0 / projection_order)
    return sign(command) * bounded_magnitude
end

function drive_module(
    state,
    params,
    turn_request=0.0,
    drive_frequency_scale=1.0,
    recovery_request=0.0,
    redirect_load=0.0,
    terminal_yaw_brake=0.0,
    terminal_yaw_counter=0.0,
)
    omega =
        (2 * pi / params.drive_period) *
        max(_safe(drive_frequency_scale, 1.0), 0.50)
    redirect = _clamp01(_safe(redirect_load, 0.0))
    yaw_brake = _clamp_unit(_safe(terminal_yaw_brake, 0.0))
    yaw_counter = _clamp_unit(_safe(terminal_yaw_counter, 0.0))
    amp = params.drive_amplitude * max(1.0 - params.redirect_drive_relief * redirect, 0.50)
    q1 = _safe(state.phi[1], 0.0)
    q2 = _safe(state.phi[2], 0.0)
    qd1 = _safe(state.phi_dot[1], 0.0)
    qd2 = _safe(state.phi_dot[2], 0.0)

    # State-feedback drive: phase comes from joint state, not from a hidden clock.
    # Large target error shifts the oscillator center into a bounded anterior
    # bend while amplitude relief leaves posture authority inside the joint
    # envelope. Alignment continuously restores the zero-mean cruise rhythm.
    turn_command = tanh(_safe(turn_request, 0.0) / max(params.curvature_request_scale, 1.0e-6))
    # The posterior-relief lineage shows that its observed tangent side is a
    # useful phase coordinate, but directly weakening or compensating the tail
    # trades away progress. Apply the excess-yaw residual to the anterior
    # oscillator center only on the supporting half-cycle. The signed product
    # is continuous through zero and bounded by the existing safe curvature
    # scale; posterior amplitude and lag remain unchanged.
    observed_tail_side = tanh(
        (q1 + q2) / max(params.tail_tangent_scale, 1.0e-6),
    )
    yaw_supporting_halfcycle = _clamp01(max(-yaw_counter * observed_tail_side, 0.0))
    terminal_anterior_counter_curvature =
        params.terminal_anterior_halfcycle_curvature_gain *
        sign(yaw_counter) *
        yaw_supporting_halfcycle
    terminal_head_target =
        params.terminal_brake_head_curvature_gain * yaw_brake +
        terminal_anterior_counter_curvature
    redirect_head_target =
        params.redirect_head_curvature_gain * turn_command * redirect +
        terminal_head_target
    q1_centered = q1 - redirect_head_target
    vdp_drive = params.drive_mu * (1 - (q1_centered / amp)^2) * qd1
    head_accel = vdp_drive - omega^2 * q1_centered

    # Posterior joint follows the anterior bend with lag during cruise. During
    # redirect, the target blends toward same-sign tail tangent and temporarily
    # reduces traveling-wave lag, forming a C-bend rather than an S-bend.
    recovery_command =
        tanh(max(_safe(recovery_request, 0.0), 0.0) / max(params.recovery_tail_curvature_scale, 1.0e-6))
    cruise_mean_tail_tangent =
        params.negative_turn_curvature_gain * min(turn_command, 0.0) +
        params.positive_turn_curvature_gain * max(turn_command, 0.0) +
        params.recovery_tail_curvature_gain * recovery_command
    redirect_tail_tangent = params.redirect_tail_tangent_gain * turn_command
    terminal_tail_tangent =
        params.terminal_brake_tail_tangent_gain * yaw_brake
    mean_tail_tangent =
        (1.0 - redirect) * cruise_mean_tail_tangent +
        redirect * redirect_tail_tangent +
        terminal_tail_tangent
    effective_tail_lag_gain =
        params.drive_tail_lag_gain * (1.0 - params.redirect_lag_relief * redirect)
    tail_target =
        mean_tail_tangent - q1 -
        effective_tail_lag_gain * qd1 / max(omega, eps(omega))
    tail_accel = omega^2 * (tail_target - q2) - 2 * params.drive_tail_damping * omega * qd2
    return (
        head_accel=head_accel,
        tail_accel=tail_accel,
        omega=omega,
        q1=q1,
        q2=q2,
        qd1=qd1,
        qd2=qd2,
        turn_command=turn_command,
        recovery_command=recovery_command,
        redirect_load=redirect,
        terminal_yaw_brake=yaw_brake,
        terminal_yaw_counter=yaw_counter,
        observed_tail_side=observed_tail_side,
        yaw_supporting_halfcycle=yaw_supporting_halfcycle,
        terminal_anterior_counter_curvature=terminal_anterior_counter_curvature,
        terminal_head_target=terminal_head_target,
        terminal_tail_tangent=terminal_tail_tangent,
        redirect_head_target=redirect_head_target,
        mean_tail_tangent=mean_tail_tangent,
        effective_tail_lag_gain=effective_tail_lag_gain,
    )
end

function guidance_module(state, params)
    distance = max(_safe(state.distance_L * params.L, params.L), 1.0e-6)
    distance_L = distance / params.L
    scale = max(distance, 0.25 * params.L)
    # `target_body` is the target vector already rotated into the fish body frame.
    target_x = _safe(state.target_body_L[1] * params.L, -distance)
    target_y = _safe(state.target_body_L[2] * params.L, 0.0)
    velocity_x = _safe(state.velocity_body_U[1], 0.0)
    velocity_y = _safe(state.velocity_body_U[2], 0.0)
    forward_component = -target_x / scale
    lateral_component = target_y / scale
    vector_angle = atan(lateral_component, max(forward_component, 0.15))
    vector_angle = clamp(vector_angle, -1.25, 1.25)
    bearing = _clamp_unit(_safe(state.bearing, 0.0))
    bearing_trend = hasproperty(state, :bearing_window_rate) ?
        _safe(state.bearing_window_rate, 0.0) :
        _safe(state.bearing_rate, 0.0)
    closing_speed = hasproperty(state, :window_closing_speed_L) ?
        _safe(state.window_closing_speed_L, 0.0) :
        _safe(state.closing_speed_L, 0.0)
    closing_deficit =
        0.5 * (1 - tanh(closing_speed / max(params.progress_closing_speed_scale, 1.0e-6)))
    slip_y = velocity_y / params.L

    approach = _clamp01(distance_L / max(params.approach_distance_L, 1.0e-6))
    approach_gain = params.approach_min_gain + (1 - params.approach_min_gain) * approach

    geometric_request = -(
        params.bearing_gain * bearing +
        params.vector_angle_gain * vector_angle
    ) -
        params.target_lateral_velocity_gain * slip_y -
        params.bearing_trend_gain *
            tanh(bearing_trend / max(params.bearing_trend_scale, 1.0e-6))
    turn_rate = hasproperty(state, :turn_rate_recent) ?
        _safe(state.turn_rate_recent, 0.0) :
        _safe(state.heading_rate, 0.0)
    target_turn_rate =
        params.turn_rate_target_gain *
        tanh(geometric_request / max(params.turn_rate_request_scale, 1.0e-6))
    rate_error = target_turn_rate - turn_rate
    rate_correction =
        params.turn_rate_feedback_gain *
        tanh(rate_error / max(params.turn_rate_scale, 1.0e-6))
    close_gate = 1 - approach
    request = geometric_request + rate_correction

    centerline_alignment = max(
        abs(bearing) / max(params.centerline_bearing_band, 1.0e-6),
        abs(vector_angle) / max(params.centerline_vector_band, 1.0e-6),
    )
    centerline_alignment = _clamp01(centerline_alignment)
    centerline_gain =
        params.centerline_min_turn_gain +
        (1 - params.centerline_min_turn_gain) * centerline_alignment

    sweeping_to_center = bearing * bearing_trend < 0.0 ? 1.0 : 0.0
    sweep_window =
        _clamp01((params.sweep_bearing_band - abs(bearing)) / max(params.sweep_bearing_band, 1.0e-6))
    sweep_rate = tanh(abs(bearing_trend) / max(params.sweep_rate_scale, 1.0e-6))
    sweep_damping =
        params.sweep_damping_gain * close_gate * sweep_window * sweep_rate * sweeping_to_center

    request *= centerline_gain * (1 - sweep_damping)
    request = max(request, 0.0) + params.negative_turn_request_gain * min(request, 0.0)

    crossed_below = max(-bearing, 0.0) + 0.6 * max(-vector_angle, 0.0)
    negative_spin = max(-tanh(turn_rate / max(params.positive_recovery_rate_scale, 1.0e-6)), 0.0)
    positive_recovery =
        params.positive_recovery_gain *
        close_gate *
        tanh(crossed_below / max(params.positive_recovery_scale, 1.0e-6)) *
        negative_spin
    request += positive_recovery

    centerline_rate_alignment = max(
        abs(bearing) / max(params.centerline_rate_brake_bearing_band, 1.0e-6),
        abs(lateral_component) / max(params.centerline_rate_brake_lateral_band, 1.0e-6),
    )
    centerline_rate_window = 1 - _clamp01(centerline_rate_alignment)
    centerline_rate_brake =
        params.centerline_rate_brake_gain *
        close_gate *
        centerline_rate_window *
        tanh(-turn_rate / max(params.centerline_rate_brake_scale, 1.0e-6))
    request += centerline_rate_brake
    recovery_curvature_request =
        max(positive_recovery, 0.0) + max(centerline_rate_brake, 0.0)
    positive_approach_gain =
        params.positive_approach_min_gain +
        (1 - params.positive_approach_min_gain) * approach
    effective_approach_gain =
        request > 0.0 ? max(approach_gain, positive_approach_gain) : approach_gain
    request *= effective_approach_gain
    request = clamp(request, -params.turn_request_limit, params.turn_request_limit)

    redirect_error = max(abs(bearing), abs(vector_angle))
    redirect_bandwidth = max(
        params.redirect_bearing_full - params.redirect_bearing_start,
        1.0e-6,
    )
    geometry_redirect_load = _clamp01(
        (redirect_error - params.redirect_bearing_start) / redirect_bandwidth,
    )
    # Keep full posture authority until yaw follows the request, then release
    # only a bounded fraction so the propulsive carrier resumes continuously.
    positive_turn_response = max(target_turn_rate * turn_rate, 0.0)
    redirect_response_release = tanh(
        positive_turn_response / max(params.redirect_response_scale, 1.0e-6),
    )
    redirect_response_gate =
        1.0 - (1.0 - params.redirect_response_floor) * redirect_response_release
    redirect_load = geometry_redirect_load * redirect_response_gate

    # Raw heading rate and body-frame bearing are dominated by the propulsive
    # beat in the evaluated rollout. Estimate the carrier bend after removing
    # the current redirect center, then reject its angle/rate contribution from
    # route-level yaw and target demand. Keep separate course and phase rate
    # channels: the evaluated anterior-only residual preserves continuous
    # course authority, while the distributed tangent-rate residual classifies
    # only the beat-synchronous anterior correction. The route comparison also
    # excludes the fast bearing-trend term.
    instantaneous_turn_rate = _safe(state.heading_rate, turn_rate)
    anterior_joint_angle = _safe(state.phi[1], 0.0)
    anterior_joint_velocity = _safe(state.phi_dot[1], 0.0)
    redirect_turn_command =
        tanh(request / max(params.curvature_request_scale, 1.0e-6))
    estimated_redirect_head_center =
        params.redirect_head_curvature_gain *
        redirect_turn_command *
        redirect_load
    carrier_joint_angle = anterior_joint_angle - estimated_redirect_head_center
    course_carrier_rejected_turn_rate =
        instantaneous_turn_rate +
        params.carrier_heading_gain * anterior_joint_velocity
    carrier_tail_tangent_rate =
        _safe(state.phi_dot[1], 0.0) + _safe(state.phi_dot[2], 0.0)
    phase_carrier_rejected_turn_rate =
        course_carrier_rejected_turn_rate +
        params.carrier_tail_rate_gain * carrier_tail_tangent_rate
    carrier_rejected_bearing = _clamp_unit(
        bearing + params.carrier_heading_gain * carrier_joint_angle,
    )
    carrier_rejected_vector_angle = clamp(
        vector_angle + params.carrier_heading_gain * carrier_joint_angle,
        -1.25,
        1.25,
    )
    route_geometric_request = -(
        params.bearing_gain * carrier_rejected_bearing +
        params.vector_angle_gain * carrier_rejected_vector_angle
    ) - params.target_lateral_velocity_gain * slip_y
    route_target_turn_rate =
        params.turn_rate_target_gain *
        tanh(route_geometric_request / max(params.turn_rate_request_scale, 1.0e-6))

    # If residual yaw opposes the route, all of it is excess; if it agrees,
    # only the amount beyond target-derived demand is excess. Do this once per
    # observer role so carrier cancellation cannot also remove the continuous
    # target-course bend that supplied v33's stronger approach progress.
    terminal_course_yaw_excess =
        course_carrier_rejected_turn_rate * route_target_turn_rate <= 0.0 ?
        abs(course_carrier_rejected_turn_rate) :
        max(abs(course_carrier_rejected_turn_rate) - abs(route_target_turn_rate), 0.0)
    terminal_course_yaw_response = tanh(
        terminal_course_yaw_excess /
        max(params.terminal_yaw_excess_scale, 1.0e-6),
    )
    terminal_phase_yaw_excess =
        phase_carrier_rejected_turn_rate * route_target_turn_rate <= 0.0 ?
        abs(phase_carrier_rejected_turn_rate) :
        max(abs(phase_carrier_rejected_turn_rate) - abs(route_target_turn_rate), 0.0)
    terminal_phase_yaw_response = tanh(
        terminal_phase_yaw_excess /
        max(params.terminal_yaw_excess_scale, 1.0e-6),
    )
    terminal_yaw_counter =
        -sign(phase_carrier_rejected_turn_rate) *
        terminal_phase_yaw_response

    # At the sampled terminal load peaks, the measured fluid moment usually
    # opposes instantaneous yaw and is therefore already extracting rotational
    # energy. Preserve that helpful hydrodynamic brake: smoothly release only
    # the phase-selected anterior residual instead of adding another moment
    # command or weakening the continuous target-course response.
    instantaneous_moment = _safe(state.moment_z_L2, 0.0)
    dissipative_yaw_power = max(
        -instantaneous_moment * instantaneous_turn_rate,
        0.0,
    )
    passive_yaw_brake = tanh(
        dissipative_yaw_power /
        max(params.terminal_passive_yaw_power_scale, 1.0e-6),
    )
    passive_brake_counter_authority =
        1.0 -
        (1.0 - _clamp01(params.terminal_passive_brake_counter_floor)) *
        passive_yaw_brake

    # A target-relative cross product measures translation across the current
    # collision line without introducing a world-frame route. Use normalized
    # body-frame target and velocity observations, then remove the sampled
    # carrier-scale anterior phase velocity. Preserve v24's continuous course
    # bend; signed excess yaw separately selects the anterior half-cycle
    # residual in drive_module.
    target_x_L = target_x / params.L
    target_y_L = target_y / params.L
    target_norm_L = max(hypot(target_x_L, target_y_L), 1.0e-6)
    cross_track_speed_U =
        (target_x_L * velocity_y - target_y_L * velocity_x) /
        target_norm_L
    swimmer_speed_U = hypot(velocity_x, velocity_y)
    nominal_omega = 2 * pi / max(params.drive_period, 1.0e-6)
    carrier_course_speed_U =
        params.terminal_course_carrier_gain *
        anterior_joint_velocity /
        nominal_omega
    course_residual_speed_U = cross_track_speed_U - carrier_course_speed_U
    terminal_course_counter = tanh(
        course_residual_speed_U /
        max(params.terminal_cross_track_speed_scale_U, 1.0e-6),
    )
    terminal_course_speed_gate = tanh(
        swimmer_speed_U / max(params.terminal_course_speed_scale_U, 1.0e-6),
    )
    terminal_yaw_bandwidth = max(
        params.terminal_yaw_brake_start_L - params.terminal_yaw_brake_full_L,
        1.0e-6,
    )
    terminal_yaw_proximity = _clamp01(
        (params.terminal_yaw_brake_start_L - distance_L) /
        terminal_yaw_bandwidth,
    )
    terminal_yaw_brake =
        terminal_yaw_proximity *
        terminal_course_speed_gate *
        terminal_course_counter *
        terminal_course_yaw_response
    terminal_halfcycle_yaw_counter =
        terminal_yaw_proximity *
        terminal_course_speed_gate *
        terminal_yaw_counter *
        passive_brake_counter_authority
    return (
        turn_request=request,
        geometric_request=geometric_request,
        target_turn_rate=target_turn_rate,
        turn_rate=turn_rate,
        rate_correction=rate_correction,
        bearing=bearing,
        bearing_trend=bearing_trend,
        vector_angle=vector_angle,
        forward_component=forward_component,
        lateral_component=lateral_component,
        distance_L=distance_L,
        approach_gain=effective_approach_gain,
        base_approach_gain=approach_gain,
        positive_approach_gain=positive_approach_gain,
        far_drive_gate=approach,
        drive_progress_boost=closing_deficit,
        closing_speed_L=closing_speed,
        centerline_gain=centerline_gain,
        sweep_damping=sweep_damping,
        positive_recovery=positive_recovery,
        centerline_rate_brake=centerline_rate_brake,
        recovery_curvature_request=recovery_curvature_request,
        geometry_redirect_load=geometry_redirect_load,
        positive_turn_response=positive_turn_response,
        redirect_response_gate=redirect_response_gate,
        redirect_load=redirect_load,
        instantaneous_turn_rate=instantaneous_turn_rate,
        anterior_joint_angle=anterior_joint_angle,
        anterior_joint_velocity=anterior_joint_velocity,
        estimated_redirect_head_center=estimated_redirect_head_center,
        carrier_joint_angle=carrier_joint_angle,
        course_carrier_rejected_turn_rate=course_carrier_rejected_turn_rate,
        carrier_tail_tangent_rate=carrier_tail_tangent_rate,
        phase_carrier_rejected_turn_rate=phase_carrier_rejected_turn_rate,
        carrier_rejected_bearing=carrier_rejected_bearing,
        carrier_rejected_vector_angle=carrier_rejected_vector_angle,
        route_geometric_request=route_geometric_request,
        route_target_turn_rate=route_target_turn_rate,
        terminal_course_yaw_excess=terminal_course_yaw_excess,
        terminal_course_yaw_response=terminal_course_yaw_response,
        terminal_phase_yaw_excess=terminal_phase_yaw_excess,
        terminal_phase_yaw_response=terminal_phase_yaw_response,
        terminal_yaw_counter=terminal_yaw_counter,
        instantaneous_moment=instantaneous_moment,
        dissipative_yaw_power=dissipative_yaw_power,
        passive_yaw_brake=passive_yaw_brake,
        passive_brake_counter_authority=passive_brake_counter_authority,
        cross_track_speed_U=cross_track_speed_U,
        swimmer_speed_U=swimmer_speed_U,
        carrier_course_speed_U=carrier_course_speed_U,
        course_residual_speed_U=course_residual_speed_U,
        terminal_course_counter=terminal_course_counter,
        terminal_course_speed_gate=terminal_course_speed_gate,
        terminal_yaw_proximity=terminal_yaw_proximity,
        terminal_yaw_brake=terminal_yaw_brake,
        terminal_halfcycle_yaw_counter=terminal_halfcycle_yaw_counter,
    )
end

function turn_actuator_module(drive, guidance, params)
    tail_tangent = drive.q1 + drive.q2
    tail_velocity = drive.qd1 + drive.qd2
    tail_side = tanh(tail_tangent / max(params.tail_tangent_scale, 1.0e-6))
    tail_motion = tanh(tail_velocity / max(params.drive_amplitude * drive.omega, 1.0e-6))

    # Steering biases the currently observed bend/velocity cycle without an
    # explicit period, keeping parameter tuning on active state-feedback terms.
    halfcycle_gate =
        1.0 +
        params.halfcycle_tail_bias * guidance.turn_request * tail_side +
        params.halfcycle_velocity_gain * guidance.turn_request * tail_motion
    halfcycle_gate = clamp(halfcycle_gate, 0.55, 1.45)
    steer = guidance.turn_request * halfcycle_gate
    return (
        head_delta=params.head_turn_share * steer,
        tail_delta=params.tail_turn_share * steer,
        halfcycle_gate=halfcycle_gate,
        steer=steer,
    )
end

function target_policy(state, params)
    guidance = guidance_module(state, params)
    turn_load = _clamp01(abs(guidance.turn_request) / max(params.turn_request_limit, 1.0e-6))
    cadence_gain =
        params.far_drive_frequency_gain +
        params.progress_drive_frequency_gain * guidance.drive_progress_boost
    drive_frequency_scale =
        1.0 +
        cadence_gain *
        guidance.far_drive_gate *
        (1.0 - params.far_drive_turn_relief * turn_load)
    drive = drive_module(
        state,
        params,
        guidance.turn_request,
        drive_frequency_scale,
        guidance.recovery_curvature_request,
        guidance.redirect_load,
        guidance.terminal_yaw_brake,
        guidance.terminal_halfcycle_yaw_counter,
    )
    turn = turn_actuator_module(drive, guidance, params)
    angular_damping =
        -params.body_angular_damping_gain * _safe(state.moment_z_L2, 0.0) / max(params.L^3, eps(Float64))
    head_command = drive.head_accel + turn.head_delta + angular_damping
    tail_command = drive.tail_accel + turn.tail_delta
    return (
        phi_ddot=(
            _smooth_project(
                head_command,
                params.command_accel_limit,
                params.command_projection_order,
            ),
            _smooth_project(
                tail_command,
                params.command_accel_limit,
                params.command_projection_order,
            ),
        ),
    )
end
