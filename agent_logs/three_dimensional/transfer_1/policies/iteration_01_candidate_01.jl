# Phase-2 candidate: preserve the transferred state-feedback traveling wave,
# but replace its tail-only, sign-asymmetric steering with a reflection-
# equivariant mean-curvature command shared by the two joints. All guidance
# inputs are normalized body-frame observations; oscillator phase remains in
# joint state rather than time.

function target_policy_params(; L::Int=64)
    return (
        version="dogfish_target_control_phase2_shared_mean_curvature",
        L=Float64(L),
        control_period=0.55,
        drive_amplitude=28.0 * pi / 180,
        drive_mu=0.35,
        drive_tail_lag_gain=0.80,
        drive_tail_damping=0.65,
        minimum_drive_frequency_scale=0.50,
        far_drive_frequency_gain=0.114,
        far_drive_turn_relief=0.36,
        progress_drive_frequency_gain=0.034,
        progress_closing_speed_scale=0.16,
        approach_distance_L=2.10,
        minimum_forward_fraction=0.15,
        bearing_limit=1.25,
        bearing_scale=0.45,
        target_vector_gain=0.25,
        lateral_slip_gain=0.28,
        lateral_slip_scale=0.16,
        yaw_release_gain=0.10,
        yaw_rate_scale=0.80,
        mean_curvature_limit=18.0 * pi / 180,
        head_curvature_share=0.35,
    )
end

@inline function _clamp01(value)
    return clamp(value, 0.0, 1.0)
end

@inline function _safe(value, fallback)
    parsed = Float64(value)
    return isfinite(parsed) ? parsed : fallback
end

function guidance_module(state, params)
    distance_L = max(_safe(state.distance_L, params.approach_distance_L), 1.0e-6)
    target_x_L = _safe(state.target_body_L[1], -distance_L)
    target_y_L = _safe(state.target_body_L[2], 0.0)
    target_scale_L = max(distance_L, 0.25)
    forward_fraction = -target_x_L / target_scale_L
    lateral_fraction = target_y_L / target_scale_L
    vector_angle = atan(
        lateral_fraction,
        max(forward_fraction, params.minimum_forward_fraction),
    )
    vector_angle = clamp(vector_angle, -params.bearing_limit, params.bearing_limit)
    bearing = clamp(
        _safe(state.bearing, vector_angle),
        -params.bearing_limit,
        params.bearing_limit,
    )

    # In the inherited rollout, positive target bearing coincided with negative
    # body-frame lateral velocity and an opening target angle. Counter that
    # cross-track translation without interpreting the small local wake signal
    # as a route command.
    lateral_slip = _safe(state.velocity_body_U[2], 0.0)
    slip_correction =
        -params.lateral_slip_gain *
        tanh(lateral_slip / max(params.lateral_slip_scale, 1.0e-6))

    # Correct-sign yaw releases the bend; wrong-sign yaw reinforces it. The
    # small bounded term cannot replace the persistent target geometry.
    turn_rate = hasproperty(state, :turn_rate_recent) ?
        _safe(state.turn_rate_recent, 0.0) :
        _safe(state.heading_rate, 0.0)
    yaw_correction =
        params.yaw_release_gain *
        tanh(turn_rate / max(params.yaw_rate_scale, 1.0e-6))

    route_error =
        bearing +
        params.target_vector_gain * vector_angle +
        slip_correction +
        yaw_correction
    turn_signal = tanh(route_error / max(params.bearing_scale, 1.0e-6))

    # Positive bearing requires the negative mean bend in the observed 3D sign
    # convention. Every signed input and this output reverse under reflection.
    mean_curvature = -params.mean_curvature_limit * turn_signal

    closing_speed_L = hasproperty(state, :window_closing_speed_L) ?
        _safe(state.window_closing_speed_L, 0.0) :
        _safe(state.closing_speed_L, 0.0)
    closing_deficit =
        0.5 *
        (1 - tanh(closing_speed_L / max(params.progress_closing_speed_scale, 1.0e-6)))
    far_drive_gate =
        _clamp01(distance_L / max(params.approach_distance_L, 1.0e-6))

    return (
        distance_L=distance_L,
        bearing=bearing,
        vector_angle=vector_angle,
        lateral_slip=lateral_slip,
        turn_rate=turn_rate,
        route_error=route_error,
        turn_signal=turn_signal,
        mean_curvature=mean_curvature,
        closing_deficit=closing_deficit,
        far_drive_gate=far_drive_gate,
    )
end

function drive_module(state, params, guidance)
    turn_load = abs(guidance.turn_signal)
    cadence_gain =
        params.far_drive_frequency_gain +
        params.progress_drive_frequency_gain * guidance.closing_deficit
    drive_frequency_scale =
        1.0 +
        cadence_gain *
        guidance.far_drive_gate *
        (1.0 - params.far_drive_turn_relief * turn_load)
    omega =
        (2 * pi / params.control_period) *
        max(
            _safe(drive_frequency_scale, 1.0),
            params.minimum_drive_frequency_scale,
        )

    q1 = _safe(state.phi[1], 0.0)
    q2 = _safe(state.phi[2], 0.0)
    qd1 = _safe(state.phi_dot[1], 0.0)
    qd2 = _safe(state.phi_dot[2], 0.0)

    # Center the state-feedback oscillator on a modest anterior share of the
    # requested curvature. The posterior joint receives the larger remainder.
    head_mean = params.head_curvature_share * guidance.mean_curvature
    centered_q1 = q1 - head_mean
    vdp_drive =
        params.drive_mu *
        (1 - (centered_q1 / params.drive_amplitude)^2) *
        qd1
    head_accel = vdp_drive - omega^2 * centered_q1

    # Preserve posterior lag and total tangent curvature while shifting both
    # joint means. This retains propulsion instead of substituting a static
    # bend for the traveling wave.
    tail_target =
        guidance.mean_curvature -
        q1 -
        params.drive_tail_lag_gain * qd1 / max(omega, eps(omega))
    tail_accel =
        omega^2 * (tail_target - q2) -
        2 * params.drive_tail_damping * omega * qd2

    return (head_accel=head_accel, tail_accel=tail_accel)
end

function target_policy(state, params)
    guidance = guidance_module(state, params)
    drive = drive_module(state, params, guidance)
    return (phi_ddot=(drive.head_accel, drive.tail_accel),)
end
