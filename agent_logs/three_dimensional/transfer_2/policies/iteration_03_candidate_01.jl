# L64 3D actuator-aware half-cycle steering candidate.  Preserve the
# demonstrated joint-state carrier and posterior lag, but replace persistent
# mean curvature and short-window derivative steering with a zero-cycle-mean
# asymmetry driven only by normalized body-frame target geometry.

function target_policy_params(; L::Int=64)
    return (
        version="dogfish_target_control_v21_envelope_halfcycle_steering",
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
        target_forward_floor=0.15,
        target_angle_limit=1.25,
        target_angle_scale=0.55,
        halfcycle_asymmetry_limit=0.10,
        tail_wave_amplitude_scale=1.28,
        approach_distance_L=2.10,
        approach_min_steering_gain=0.35,
        action_limit=1800.0 * pi / 180,
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

@inline function _carrier_then_steering(carrier, steering, limit)
    safe_limit = max(_safe(limit, 1.0), 1.0e-6)
    limited_carrier = clamp(_safe(carrier, 0.0), -safe_limit, safe_limit)
    return clamp(limited_carrier + _safe(steering, 0.0), -safe_limit, safe_limit)
end

function drive_module(state, guidance, params)
    omega =
        (2 * pi / params.drive_period) *
        max(_safe(guidance.drive_frequency_scale, 1.0), params.drive_frequency_min_scale)
    amp = params.drive_amplitude
    q1 = _safe(state.phi[1], 0.0)
    q2 = _safe(state.phi[2], 0.0)
    qd1 = _safe(state.phi_dot[1], 0.0)
    qd2 = _safe(state.phi_dot[2], 0.0)

    # The demonstrated carrier remains state-phased and clock-free.
    vdp_drive = params.drive_mu * (1 - (q1 / amp)^2) * qd1
    head_carrier = vdp_drive - omega^2 * q1

    # |sin|-2/pi is cycle-mean zero for a sinusoidal carrier.  Evaluating the
    # same even shape from observed joint state makes one half-cycle weaker and
    # the other stronger without a static bend or an explicit phase clock.
    head_phase = _clamp_unit(q1 / max(amp, eps(amp)))
    head_shape = abs(head_phase) - 2 / pi
    head_steering =
        omega^2 * amp * guidance.halfcycle_asymmetry * head_shape

    base_tail_target =
        -q1 - params.drive_tail_lag_gain * qd1 / max(omega, eps(omega))
    tail_amp = max(amp * params.tail_wave_amplitude_scale, eps(amp))
    tail_phase = _clamp_unit(base_tail_target / tail_amp)
    tail_shape = abs(tail_phase) - 2 / pi
    tail_carrier =
        omega^2 * (base_tail_target - q2) -
        2 * params.drive_tail_damping * omega * qd2
    tail_steering =
        omega^2 * tail_amp * guidance.halfcycle_asymmetry * tail_shape

    head_accel = _carrier_then_steering(
        head_carrier,
        head_steering,
        params.action_limit,
    )
    tail_accel = _carrier_then_steering(
        tail_carrier,
        tail_steering,
        params.action_limit,
    )
    return (
        head_accel=head_accel,
        tail_accel=tail_accel,
        omega=omega,
        head_carrier=head_carrier,
        tail_carrier=tail_carrier,
        head_steering=head_steering,
        tail_steering=tail_steering,
        head_shape=head_shape,
        tail_shape=tail_shape,
    )
end

function guidance_module(state, params)
    distance_L = max(_safe(state.distance_L, 1.0), 1.0e-6)
    scale = max(distance_L, params.target_scale_floor_L)
    target_x = _safe(state.target_body_L[1], -distance_L)
    target_y = _safe(state.target_body_L[2], 0.0)
    forward_component = -target_x / scale
    lateral_component = target_y / scale
    target_angle = atan(
        lateral_component,
        max(forward_component, params.target_forward_floor),
    )
    target_angle = clamp(
        target_angle,
        -params.target_angle_limit,
        params.target_angle_limit,
    )

    approach = _clamp01(
        distance_L / max(params.approach_distance_L, 1.0e-6),
    )
    steering_gain =
        params.approach_min_steering_gain +
        (1 - params.approach_min_steering_gain) * approach

    # The moving-window load audit establishes that positive common
    # half-cycle asymmetry produces negative yaw, the direction requested by a
    # positive body-lateral target error in this body-frame convention.
    halfcycle_asymmetry =
        params.halfcycle_asymmetry_limit *
        steering_gain *
        tanh(target_angle / max(params.target_angle_scale, 1.0e-6))

    closing_speed = hasproperty(state, :window_closing_speed_L) ?
        _safe(state.window_closing_speed_L, 0.0) :
        _safe(state.closing_speed_L, 0.0)
    closing_deficit =
        0.5 * (
            1 -
            tanh(
                closing_speed /
                max(params.progress_closing_speed_scale, 1.0e-6),
            )
        )
    turn_load =
        abs(halfcycle_asymmetry) /
        max(params.halfcycle_asymmetry_limit, 1.0e-6)
    cadence_gain =
        params.far_drive_frequency_gain +
        params.progress_drive_frequency_gain * closing_deficit
    drive_frequency_scale =
        1.0 +
        cadence_gain *
        approach *
        (1.0 - params.far_drive_turn_relief * turn_load)
    return (
        halfcycle_asymmetry=halfcycle_asymmetry,
        target_angle=target_angle,
        forward_component=forward_component,
        lateral_component=lateral_component,
        distance_L=distance_L,
        steering_gain=steering_gain,
        closing_speed_L=closing_speed,
        drive_frequency_scale=drive_frequency_scale,
    )
end
function target_policy(state, params)
    guidance = guidance_module(state, params)
    drive = drive_module(state, guidance, params)
    return (
        phi_ddot=(
            drive.head_accel,
            drive.tail_accel,
        ),
    )
end
