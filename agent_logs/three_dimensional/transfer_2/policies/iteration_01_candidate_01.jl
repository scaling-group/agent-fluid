# Actuator-feasible traveling bend plus one target-bearing mean-curvature
# mechanism. All task geometry is consumed in normalized body coordinates.

function target_policy_params()
    return (
        version="dogfish3d_normalized_distributed_curvature_v1",
        control_period=0.90,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.80,
        tail_damping=0.65,
        bearing_floor_L=0.25,
        bearing_scale=0.30,
        head_curvature_limit=6.0 * pi / 180,
        tail_curvature_limit=8.0 * pi / 180,
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

function guidance_module(state, params)
    distance_L = max(_safe(state.distance_L, 1.0), 1.0e-6)
    target_x_L = _safe(state.target_body_L[1], -distance_L)
    target_y_L = _safe(state.target_body_L[2], 0.0)

    # The fish's forward direction is negative body x. The absolute axial
    # denominator preserves a signed lateral request even after an overshoot.
    bearing = atan(
        target_y_L,
        max(abs(target_x_L), params.bearing_floor_L),
    )
    bearing = clamp(bearing, -0.5 * pi, 0.5 * pi)
    curvature_command = tanh(bearing / max(params.bearing_scale, 1.0e-6))
    return (
        bearing=bearing,
        curvature_command=curvature_command,
    )
end

function drive_module(state, params, curvature_command)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = _safe(state.phi[1], 0.0)
    q2 = _safe(state.phi[2], 0.0)
    qd1 = _safe(state.phi_dot[1], 0.0)
    qd2 = _safe(state.phi_dot[2], 0.0)

    command = _clamp_unit(_safe(curvature_command, 0.0))
    head_bias = params.head_curvature_limit * command
    tail_bias = params.tail_curvature_limit * command
    centered_q1 = q1 - head_bias

    # Phase lives entirely in observed joint state. Centering the oscillator on
    # a bounded bias adds steering while retaining the propulsive limit cycle.
    vdp_drive =
        params.oscillator_mu * (1 - (centered_q1 / amp)^2) * qd1
    head_accel = vdp_drive - omega^2 * centered_q1

    # Posterior lag supplies the traveling direction; its own equilibrium bias
    # distributes mean curvature without requiring a clock or memorized route.
    tail_target =
        tail_bias - centered_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    tail_accel =
        omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2
    return (
        head_accel=head_accel,
        tail_accel=tail_accel,
    )
end

function target_policy(state, params)
    guidance = guidance_module(state, params)
    drive = drive_module(
        state,
        params,
        guidance.curvature_command,
    )
    return (
        phi_ddot=(
            drive.head_accel,
            drive.tail_accel,
        ),
    )
end
