# Phase-demodulated 3D redirect controller. The transferred 2D carrier is
# retained, while steering uses only normalized body-frame target geometry and
# observed joint state. No clock, world coordinate, route, or case identity is
# used.

function target_policy_params(; L::Int=64)
    return (
        version="dogfish_3d_phase_demodulated_redirect_v1",
        L=Float64(L),
        drive_period=0.55,
        control_period=0.55,
        drive_amplitude=28.0 * pi / 180,
        drive_mu=0.35,
        drive_tail_lag_gain=0.80,
        drive_tail_damping=0.65,
        far_drive_frequency_gain=0.114,
        progress_drive_frequency_gain=0.034,
        progress_closing_speed_scale=0.16,
        phase_heading_q1_gain=0.50,
        phase_heading_q2_gain=0.14,
        phase_heading_limit=0.40,
        bearing_gain=3.2,
        vector_angle_gain=2.4,
        turn_request_scale=2.20,
        turn_curvature_gain=9.0 * pi / 180,
        redirect_error_scale=0.70,
        redirect_frequency_relief=0.35,
        approach_distance_L=2.10,
        approach_min_turn_gain=0.55,
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

function drive_module(state, params, mean_tail_tangent=0.0, drive_frequency_scale=1.0)
    omega =
        (2 * pi / params.drive_period) *
        max(_safe(drive_frequency_scale, 1.0), 0.50)
    amp = params.drive_amplitude
    q1 = _safe(state.phi[1], 0.0)
    q2 = _safe(state.phi[2], 0.0)
    qd1 = _safe(state.phi_dot[1], 0.0)
    qd2 = _safe(state.phi_dot[2], 0.0)

    # State-feedback drive: phase comes from joint state, not from a hidden clock.
    vdp_drive = params.drive_mu * (1 - (q1 / amp)^2) * qd1
    head_accel = vdp_drive - omega^2 * q1

    # The posterior joint retains the transferred traveling-bend lag. Steering
    # changes only the bounded mean tail tangent, preserving the carrier.
    tail_target =
        _safe(mean_tail_tangent, 0.0) - q1 -
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
        mean_tail_tangent=mean_tail_tangent,
    )
end

function guidance_module(state, params)
    distance_L = max(_safe(state.distance_L, 1.0), 1.0e-6)
    target_x = _safe(state.target_body_L[1], -distance_L)
    target_y = _safe(state.target_body_L[2], 0.0)

    # The body yaws within every tail beat. Joint phase provides a state-only
    # estimate of that fast component, so target geometry is rotated into an
    # approximate beat-mean frame before steering. The estimate is bounded so
    # unusual joint states cannot manufacture a large target error.
    q1 = _safe(state.phi[1], 0.0)
    q2 = _safe(state.phi[2], 0.0)
    phase_heading = clamp(
        params.phase_heading_q1_gain * q1 + params.phase_heading_q2_gain * q2,
        -params.phase_heading_limit,
        params.phase_heading_limit,
    )
    phase_cos = cos(phase_heading)
    phase_sin = sin(phase_heading)
    mean_target_x = phase_cos * target_x + phase_sin * target_y
    mean_target_y = -phase_sin * target_x + phase_cos * target_y

    scale = max(distance_L, 0.25)
    forward_component = -mean_target_x / scale
    lateral_component = mean_target_y / scale
    vector_angle = atan(lateral_component, max(forward_component, 0.15))
    vector_angle = clamp(vector_angle, -1.25, 1.25)
    bearing = atan(mean_target_y, max(abs(mean_target_x), 0.25))
    bearing = _clamp_unit(bearing)
    closing_speed = hasproperty(state, :window_closing_speed_L) ?
        _safe(state.window_closing_speed_L, 0.0) :
        _safe(state.closing_speed_L, 0.0)
    closing_deficit =
        0.5 * (1 - tanh(closing_speed / max(params.progress_closing_speed_scale, 1.0e-6)))
    approach = _clamp01(distance_L / max(params.approach_distance_L, 1.0e-6))
    approach_gain =
        params.approach_min_turn_gain +
        (1 - params.approach_min_turn_gain) * approach
    geometric_request = approach_gain * (
        params.bearing_gain * bearing +
        params.vector_angle_gain * vector_angle
    )
    turn_command = tanh(
        geometric_request / max(params.turn_request_scale, 1.0e-6),
    )
    redirect_error = max(abs(bearing), abs(vector_angle))
    redirect_load = _clamp01(
        redirect_error / max(params.redirect_error_scale, 1.0e-6),
    )

    # The inherited 3D trace associates positive mean tail tangent with the
    # wrong-way positive heading drift. Reverse that measured mapping here.
    mean_tail_tangent = -params.turn_curvature_gain * turn_command
    return (
        turn_command=turn_command,
        geometric_request=geometric_request,
        bearing=bearing,
        vector_angle=vector_angle,
        phase_heading=phase_heading,
        forward_component=forward_component,
        lateral_component=lateral_component,
        distance_L=distance_L,
        approach_gain=approach_gain,
        far_drive_gate=approach,
        drive_progress_boost=closing_deficit,
        closing_speed_L=closing_speed,
        redirect_load=redirect_load,
        mean_tail_tangent=mean_tail_tangent,
    )
end

function target_policy(state, params)
    guidance = guidance_module(state, params)
    cadence_gain =
        params.far_drive_frequency_gain +
        params.progress_drive_frequency_gain * guidance.drive_progress_boost
    cruise_frequency_scale =
        1.0 +
        cadence_gain *
        guidance.far_drive_gate
    redirect_frequency_scale =
        1.0 - params.redirect_frequency_relief * guidance.redirect_load
    drive_frequency_scale = max(
        cruise_frequency_scale * redirect_frequency_scale,
        0.60,
    )
    drive = drive_module(
        state,
        params,
        guidance.mean_tail_tangent,
        drive_frequency_scale,
    )
    return (
        phi_ddot=(
            drive.head_accel,
            drive.tail_accel,
        ),
    )
end
