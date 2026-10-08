# Phase-2 candidate: alignment-gated curvature redirect around a bounded,
# state-feedback traveling wave. All guidance uses normalized body-frame
# geometry; oscillator phase is encoded only by observed joint state.

function target_policy_params(; L::Int=64)
    return (
        version="dogfish_3d_alignment_gated_curvature_redirect_v1",
        # Retained only as the frozen compatibility adapter expected by the
        # evaluator; the control law below does not use cell-scaled geometry.
        L=Float64(L),
        drive_period=0.80,
        drive_amplitude=18.0 * pi / 180,
        oscillator_energy_gain=0.72,
        tail_wave_gain=1.15,
        tail_phase_lag=80.0 * pi / 180,
        tail_tracking_frequency_gain=0.92,
        tail_damping_ratio=0.42,
        bearing_weight=0.58,
        vector_angle_weight=0.42,
        turn_error_scale=0.48,
        redirect_deadband=0.10,
        redirect_full_scale=0.85,
        redirect_drive_relief=0.45,
        head_bias_limit=12.0 * pi / 180,
        tail_tangent_bias_ratio=2.10,
        acceleration_command_limit=1650.0 * pi / 180,
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

function drive_module(state, guidance, params)
    omega = 2 * pi / params.drive_period
    amplitude =
        params.drive_amplitude *
        (1 - params.redirect_drive_relief * guidance.redirect_gate)
    q1 = _safe(state.phi[1], 0.0)
    q2 = _safe(state.phi[2], 0.0)
    qd1 = _safe(state.phi_dot[1], 0.0)
    qd2 = _safe(state.phi_dot[2], 0.0)

    # A radial energy error sustains the observed-state oscillator without a
    # clock. Centering it on head_bias turns the entire carrier rather than
    # adding a small steering acceleration against the carrier.
    centered_q1 = q1 - guidance.head_bias
    phase_velocity = qd1 / max(omega, eps(omega))
    radius_squared =
        (centered_q1 / max(amplitude, 1.0e-6))^2 +
        (phase_velocity / max(amplitude, 1.0e-6))^2
    energy_drive =
        params.oscillator_energy_gain * omega * (1 - radius_squared) * qd1
    head_accel = -omega^2 * centered_q1 + energy_drive

    # The posterior absolute tangent carries a phase-lagged, amplified wave.
    # Its mean bias is in the same direction as the head bias; converting that
    # absolute tangent to joint-2 angle creates coordinated C-curvature.
    tail_wave = params.tail_wave_gain * (
        cos(params.tail_phase_lag) * centered_q1 -
        sin(params.tail_phase_lag) * phase_velocity
    )
    tail_target = guidance.tail_tangent_bias + tail_wave - q1
    tail_omega = params.tail_tracking_frequency_gain * omega
    tail_accel =
        tail_omega^2 * (tail_target - q2) -
        2 * params.tail_damping_ratio * tail_omega * qd2
    return (
        head_accel=head_accel,
        tail_accel=tail_accel,
        omega=omega,
        amplitude=amplitude,
        q1=q1,
        q2=q2,
        qd1=qd1,
        qd2=qd2,
        radius_squared=radius_squared,
        tail_target=tail_target,
    )
end

function guidance_module(state, params)
    distance_L = max(_safe(state.distance_L, 1.0), 1.0e-6)
    target_x_L = _safe(state.target_body_L[1], -distance_L)
    target_y_L = _safe(state.target_body_L[2], 0.0)
    forward_component = -target_x_L / distance_L
    lateral_component = target_y_L / distance_L
    vector_angle = atan(lateral_component, max(forward_component, 0.15))
    vector_angle = clamp(vector_angle, -1.25, 1.25)
    bearing = _clamp_unit(_safe(state.bearing, 0.0))
    turn_error =
        params.bearing_weight * bearing +
        params.vector_angle_weight * vector_angle
    turn_command = tanh(turn_error / max(params.turn_error_scale, 1.0e-6))
    redirect_gate = _clamp01(
        (abs(turn_error) - params.redirect_deadband) /
        max(params.redirect_full_scale - params.redirect_deadband, 1.0e-6),
    )

    # Positive lateral target geometry requires negative body curvature under
    # this model's joint/body convention. Both mean bends share that sign.
    head_bias = -params.head_bias_limit * turn_command
    tail_tangent_bias = params.tail_tangent_bias_ratio * head_bias
    return (
        turn_error=turn_error,
        turn_command=turn_command,
        redirect_gate=redirect_gate,
        head_bias=head_bias,
        tail_tangent_bias=tail_tangent_bias,
        bearing=bearing,
        vector_angle=vector_angle,
        forward_component=forward_component,
        lateral_component=lateral_component,
        distance_L=distance_L,
    )
end

function target_policy(state, params)
    guidance = guidance_module(state, params)
    drive = drive_module(state, guidance, params)
    limit = params.acceleration_command_limit
    return (
        phi_ddot=(
            clamp(drive.head_accel, -limit, limit),
            clamp(drive.tail_accel, -limit, limit),
        ),
    )
end
