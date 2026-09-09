# Still-water 3D response-gated curvature candidate.
#
# The joint-state oscillator and posterior lag preserve the sampled policy's
# coherent self-propulsion. Steering is deliberately one mechanism: normalized
# body-frame target angle requests a bounded yaw rate, and measured yaw response
# releases or reverses mean curvature before the fish sweeps past alignment.

function target_policy_params()
    return (
        version="dogfish3d_response_gated_curvature_v1",
        control_period=0.55,
        drive_period=0.55,
        drive_amplitude=28.0 * pi / 180,
        drive_mu=0.35,
        tail_lag_gain=0.80,
        tail_damping=0.65,
        target_angle_forward_floor=0.25,
        target_angle_limit=1.35,
        target_angle_scale=0.35,
        desired_yaw_rate_limit=0.60,
        yaw_rate_error_scale=0.45,
        mean_curvature_limit=14.0 * pi / 180,
        anterior_curvature_share=0.35,
    )
end

@inline function _safe_policy_value(value, fallback)
    parsed = Float64(value)
    return isfinite(parsed) ? parsed : fallback
end

function steering_response(state, params)
    distance_L = max(_safe_policy_value(state.distance_L, 1.0), 1.0e-6)
    target_x_L = _safe_policy_value(state.target_body_L[1], -distance_L)
    target_y_L = _safe_policy_value(state.target_body_L[2], 0.0)

    # The material fish points along negative body x. Normalize by current
    # distance so this angle is independent of grid resolution and route scale.
    forward = -target_x_L / distance_L
    lateral = target_y_L / distance_L
    target_angle = atan(
        lateral,
        max(forward, params.target_angle_forward_floor),
    )
    target_angle = clamp(
        target_angle,
        -params.target_angle_limit,
        params.target_angle_limit,
    )

    yaw_rate = hasproperty(state, :turn_rate_recent) ?
        _safe_policy_value(state.turn_rate_recent, 0.0) :
        _safe_policy_value(state.heading_rate, 0.0)
    desired_yaw_rate =
        -params.desired_yaw_rate_limit *
        tanh(target_angle / max(params.target_angle_scale, 1.0e-6))

    # The calibrated 3D FSI sign is negative: positive joint curvature produces
    # negative yaw. Hence positive (measured - desired) rate error calls for
    # positive curvature, including active braking after an overshoot.
    yaw_rate_error = yaw_rate - desired_yaw_rate
    curvature_command =
        tanh(yaw_rate_error / max(params.yaw_rate_error_scale, 1.0e-6))
    mean_curvature = params.mean_curvature_limit * curvature_command
    return (
        target_angle=target_angle,
        desired_yaw_rate=desired_yaw_rate,
        yaw_rate=yaw_rate,
        yaw_rate_error=yaw_rate_error,
        curvature_command=curvature_command,
        mean_curvature=mean_curvature,
    )
end

function target_policy(state, params)
    steering = steering_response(state, params)
    omega = 2 * pi / params.drive_period
    amplitude = params.drive_amplitude
    q1 = _safe_policy_value(state.phi[1], 0.0)
    q2 = _safe_policy_value(state.phi[2], 0.0)
    qd1 = _safe_policy_value(state.phi_dot[1], 0.0)
    qd2 = _safe_policy_value(state.phi_dot[2], 0.0)

    # Shift part of the oscillator center with the curvature request. This puts
    # braking authority on the anterior joint even when posterior tracking is
    # acceleration-limited, while joint state remains the only gait phase.
    anterior_center =
        params.anterior_curvature_share * steering.mean_curvature
    centered_q1 = q1 - anterior_center
    vdp_drive =
        params.drive_mu *
        (1 - (centered_q1 / max(amplitude, 1.0e-6))^2) *
        qd1
    head_accel = vdp_drive - omega^2 * centered_q1

    # Track a lagged posterior bend whose total mean tangent equals the bounded
    # steering curvature. The oscillatory part remains a traveling bend rather
    # than a reciprocal two-joint wiggle.
    tail_target =
        steering.mean_curvature -
        q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    tail_accel =
        omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(head_accel, tail_accel),)
end
