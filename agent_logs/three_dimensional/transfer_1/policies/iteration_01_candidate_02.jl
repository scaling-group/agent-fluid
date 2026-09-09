# L64 3D candidate: retain the observed propulsive state-feedback wave and
# translate body-frame target bearing into one bounded posterior mean-curvature
# primitive.  No clock, world coordinate, route, or mutable phase is used.

function target_policy_params()
    return (
        version="dogfish3d_body_bearing_mean_tail_v1",
        drive_period=0.55,
        control_period=0.55,
        drive_amplitude=28.0 * pi / 180,
        drive_mu=0.35,
        drive_tail_lag_gain=0.80,
        drive_tail_damping=0.65,
        bearing_curvature_scale=0.20,
        mean_tail_curvature_limit=14.0 * pi / 180,
        far_drive_frequency_gain=0.114,
        far_drive_turn_relief=0.36,
        progress_drive_frequency_gain=0.034,
        progress_closing_speed_scale=0.16,
        approach_distance_L=2.10,
    )
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

    # State-feedback drive: phase comes from joint state, not from a hidden clock.
    vdp_drive = params.drive_mu * (1 - (q1 / amp)^2) * qd1
    head_accel = vdp_drive - omega^2 * q1

    # Posterior lag preserves the observed propulsive traveling bend.  The only
    # steering primitive is a bounded cycle-mean tail tangent whose sign follows
    # the body-frame bearing request.  The sampled 3D rollout associated a
    # positive mean tangent with increasing heading, so positive target bearing
    # is translated to a negative request in `guidance_module`.
    turn_command =
        tanh(_safe(turn_request, 0.0) / max(params.bearing_curvature_scale, 1.0e-6))
    mean_tail_tangent = params.mean_tail_curvature_limit * turn_command
    tail_target = mean_tail_tangent - q1 - params.drive_tail_lag_gain * qd1 / max(omega, eps(omega))
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
        mean_tail_tangent=mean_tail_tangent,
    )
end

function guidance_module(state, params)
    distance_L = max(_safe(state.distance_L, 1.0), 1.0e-6)
    bearing = clamp(_safe(state.bearing, 0.0), -1.25, 1.25)
    closing_speed = hasproperty(state, :window_closing_speed_L) ?
        _safe(state.window_closing_speed_L, 0.0) :
        _safe(state.closing_speed_L, 0.0)
    closing_deficit =
        0.5 * (1 - tanh(closing_speed / max(params.progress_closing_speed_scale, 1.0e-6)))
    far_drive_gate = _clamp01(distance_L / max(params.approach_distance_L, 1.0e-6))
    request = -bearing
    return (
        turn_request=request,
        bearing=bearing,
        distance_L=distance_L,
        far_drive_gate=far_drive_gate,
        drive_progress_boost=closing_deficit,
        closing_speed_L=closing_speed,
    )
end

function target_policy(state, params)
    guidance = guidance_module(state, params)
    turn_load = abs(tanh(
        guidance.turn_request / max(params.bearing_curvature_scale, 1.0e-6),
    ))
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
