# Phase-2 candidate: preserve the transferred state-feedback traveling bend,
# but translate body-frame target error into a bounded mean bend of both joints.
# This places steering in the oscillator targets rather than adding a small
# acceleration after an already clipped carrier command.

function target_policy_params(; L::Int=64)
    return (
        version="dogfish_target_control_v19_3d_mean_curvature",
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
        curvature_request_scale=2.20,
        mean_curvature_limit=8.0 * pi / 180,
        approach_distance_L=2.10,
        approach_min_gain=0.36,
        centerline_bearing_band=0.105,
        centerline_vector_band=0.120,
        centerline_min_turn_gain=0.31,
        turn_request_limit=6.0,
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

function drive_module(state, params, turn_request=0.0, drive_frequency_scale=1.0)
    omega =
        (2 * pi / params.drive_period) *
        max(_safe(drive_frequency_scale, 1.0), 0.50)
    amp = params.drive_amplitude
    q1 = _safe(state.phi[1], 0.0)
    q2 = _safe(state.phi[2], 0.0)
    qd1 = _safe(state.phi_dot[1], 0.0)
    qd2 = _safe(state.phi_dot[2], 0.0)

    # The local 3D sign calibration is counterintuitive: positive mean joint
    # curvature produces negative yaw.  Negating the desired-yaw request maps a
    # positive body-frame target bearing to the required positive mean bend.
    turn_command = tanh(_safe(turn_request, 0.0) / max(params.curvature_request_scale, 1.0e-6))
    mean_bend = -params.mean_curvature_limit * turn_command

    # Phase comes only from observed joint state.  Centering both joint cycles
    # on mean_bend creates one coherent curvature command before actuator
    # clipping, while the posterior target retains the propulsive phase lag.
    q1_centered = q1 - mean_bend
    vdp_drive = params.drive_mu * (1 - (q1_centered / amp)^2) * qd1
    head_accel = vdp_drive - omega^2 * q1_centered
    tail_target =
        mean_bend - q1_centered -
        params.drive_tail_lag_gain * qd1 / max(omega, eps(omega))
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
        mean_bend=mean_bend,
        q1_centered=q1_centered,
    )
end

function guidance_module(state, params)
    distance_L = max(_safe(state.distance_L, 1.0), 1.0e-6)
    scale = max(distance_L, 0.25)
    # `target_body_L` is normalized and already rotated into the body frame;
    # local -x is the fish's forward direction.
    target_x = _safe(state.target_body_L[1], -distance_L)
    target_y = _safe(state.target_body_L[2], 0.0)
    forward_component = -target_x / scale
    lateral_component = target_y / scale
    vector_angle = atan(lateral_component, max(forward_component, 0.15))
    vector_angle = clamp(vector_angle, -1.25, 1.25)
    bearing = _clamp_unit(_safe(state.bearing, 0.0))
    closing_speed = hasproperty(state, :window_closing_speed_L) ?
        _safe(state.window_closing_speed_L, 0.0) :
        _safe(state.closing_speed_L, 0.0)
    closing_deficit =
        0.5 * (1 - tanh(closing_speed / max(params.progress_closing_speed_scale, 1.0e-6)))
    approach = _clamp01(distance_L / max(params.approach_distance_L, 1.0e-6))
    approach_gain = params.approach_min_gain + (1 - params.approach_min_gain) * approach

    # This request has desired-yaw sign.  Keep it geometric: the available
    # short-window rates are dominated by within-beat yaw in the sampled 3D
    # trace and should not reverse the mean-curvature command.
    request = -(
        params.bearing_gain * bearing +
        params.vector_angle_gain * vector_angle
    )

    centerline_alignment = max(
        abs(bearing) / max(params.centerline_bearing_band, 1.0e-6),
        abs(vector_angle) / max(params.centerline_vector_band, 1.0e-6),
    )
    centerline_alignment = _clamp01(centerline_alignment)
    centerline_gain =
        params.centerline_min_turn_gain +
        (1 - params.centerline_min_turn_gain) * centerline_alignment

    request *= centerline_gain * approach_gain
    request = clamp(request, -params.turn_request_limit, params.turn_request_limit)
    return (
        turn_request=request,
        bearing=bearing,
        vector_angle=vector_angle,
        forward_component=forward_component,
        lateral_component=lateral_component,
        distance_L=distance_L,
        approach_gain=approach_gain,
        far_drive_gate=approach,
        drive_progress_boost=closing_deficit,
        closing_speed_L=closing_speed,
        centerline_gain=centerline_gain,
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
    )
    return (
        phi_ddot=(
            drive.head_accel,
            drive.tail_accel,
        ),
    )
end
