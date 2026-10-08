# Phase-2 candidate: preserve the transferred champion's demonstrated
# joint-state traveling wave, but replace its multi-branch steering stack with
# one polarity-calibrated body-frame target-to-mean-curvature command.

function target_policy_params(; L::Int=64)
    return (
        version="dogfish_target_control_v19_los_mean_curvature",
        L=Float64(L),
        drive_period=0.55,
        control_period=0.55,
        drive_amplitude=28.0 * pi / 180,
        drive_mu=0.35,
        drive_tail_lag_gain=0.80,
        drive_tail_damping=0.65,
        drive_frequency_min_scale=0.50,
        far_drive_frequency_gain=0.114,
        far_drive_turn_relief=0.36,
        progress_drive_frequency_gain=0.034,
        progress_closing_speed_scale=0.16,
        target_scale_floor_L=0.25,
        vector_forward_floor=0.15,
        vector_angle_limit=1.25,
        los_bearing_weight=0.45,
        los_vector_weight=0.55,
        turn_error_scale=0.32,
        turn_curvature_limit=12.0 * pi / 180,
        approach_distance_L=2.10,
        approach_min_curvature_gain=0.45,
    )
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
        max(_safe(drive_frequency_scale, 1.0), params.drive_frequency_min_scale)
    amp = params.drive_amplitude
    q1 = _safe(state.phi[1], 0.0)
    q2 = _safe(state.phi[2], 0.0)
    qd1 = _safe(state.phi_dot[1], 0.0)
    qd2 = _safe(state.phi_dot[2], 0.0)

    # State-feedback drive: phase comes from joint state, not from a hidden clock.
    vdp_drive = params.drive_mu * (1 - (q1 / amp)^2) * qd1
    head_accel = vdp_drive - omega^2 * q1

    # Posterior joint follows the anterior bend with lag.  Steering enters only
    # as a bounded mean tangent, leaving the propulsive wave interpretable.
    bounded_mean_tangent = clamp(
        _safe(mean_tail_tangent, 0.0),
        -params.turn_curvature_limit,
        params.turn_curvature_limit,
    )
    tail_target =
        bounded_mean_tangent - q1 -
        params.drive_tail_lag_gain * qd1 / max(omega, eps(omega))
    tail_accel = omega^2 * (tail_target - q2) - 2 * params.drive_tail_damping * omega * qd2
    return (
        head_accel=head_accel,
        tail_accel=tail_accel,
        omega=omega,
        mean_tail_tangent=bounded_mean_tangent,
    )
end

function guidance_module(state, params)
    distance_L = max(_safe(state.distance_L, 1.0), 1.0e-6)
    scale = max(distance_L, params.target_scale_floor_L)
    # The evaluator supplies an L-normalized target vector in the body frame.
    # Negative x is forward for this fish geometry; positive y requires the
    # negative mean tangent evidenced by the inherited 3D rollout.
    target_x = _safe(state.target_body_L[1], -distance_L)
    target_y = _safe(state.target_body_L[2], 0.0)
    forward_component = -target_x / scale
    lateral_component = target_y / scale
    vector_angle = atan(
        lateral_component,
        max(forward_component, params.vector_forward_floor),
    )
    vector_angle = clamp(
        vector_angle,
        -params.vector_angle_limit,
        params.vector_angle_limit,
    )
    bearing = clamp(_safe(state.bearing, 0.0), -params.vector_angle_limit, params.vector_angle_limit)
    route_error =
        params.los_bearing_weight * bearing +
        params.los_vector_weight * vector_angle

    approach = _clamp01(distance_L / max(params.approach_distance_L, 1.0e-6))
    curvature_gain =
        params.approach_min_curvature_gain +
        (1 - params.approach_min_curvature_gain) * approach
    mean_tail_tangent =
        -params.turn_curvature_limit *
        curvature_gain *
        tanh(route_error / max(params.turn_error_scale, 1.0e-6))

    closing_speed = hasproperty(state, :window_closing_speed_L) ?
        _safe(state.window_closing_speed_L, 0.0) :
        _safe(state.closing_speed_L, 0.0)
    closing_deficit =
        0.5 * (1 - tanh(closing_speed / max(params.progress_closing_speed_scale, 1.0e-6)))
    return (
        mean_tail_tangent=mean_tail_tangent,
        route_error=route_error,
        bearing=bearing,
        vector_angle=vector_angle,
        forward_component=forward_component,
        lateral_component=lateral_component,
        distance_L=distance_L,
        curvature_gain=curvature_gain,
        far_drive_gate=approach,
        drive_progress_boost=closing_deficit,
        closing_speed_L=closing_speed,
    )
end

function target_policy(state, params)
    guidance = guidance_module(state, params)
    turn_load = _clamp01(
        abs(guidance.mean_tail_tangent) /
        max(params.turn_curvature_limit, 1.0e-6),
    )
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
