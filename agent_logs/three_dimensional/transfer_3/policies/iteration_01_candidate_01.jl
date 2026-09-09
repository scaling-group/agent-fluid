# L64 still-water candidate: envelope-compatible traveling-bend propulsion
# with a body-frame target-to-mean-curvature reflex. Positive joint bias is
# calibrated by the 3D FSI turn sanity to produce negative yaw.

function target_policy_params()
    return (
        version="dogfish3d_mean_curvature_reflex_v1",

        # State-feedback traveling bend. These values keep the nominal joint
        # angle, rate, and acceleration below the episode envelope so the gait
        # does not depend on persistent evaluator clipping.
        drive_period=0.85,
        drive_amplitude=12.0 * pi / 180,
        drive_mu=0.35,
        posterior_lag_gain=0.80,
        posterior_damping=0.65,

        # One steering mechanism: target geometry sets mean curvature, and
        # observed target/yaw trends release or reinforce that curvature.
        bearing_gain=1.00,
        vector_angle_gain=0.85,
        bearing_trend_gain=0.18,
        bearing_trend_scale=0.18,
        yaw_rate_gain=0.65,
        yaw_rate_scale=0.45,
        curvature_request_scale=0.55,
        maximum_joint_bias=9.0 * pi / 180,

        # The design should normally remain inside this guard. It is below the
        # episode's immutable 1800 deg/T^2 acceleration limit.
        command_acceleration_limit=1700.0 * pi / 180,
    )
end

@inline function _safe(value, fallback)
    parsed = Float64(value)
    return isfinite(parsed) ? parsed : fallback
end

function steering_bias(state, params)
    distance_L = max(_safe(state.distance_L, 1.0), 1.0e-6)
    target_x_L = _safe(state.target_body_L[1], -distance_L)
    target_y_L = _safe(state.target_body_L[2], 0.0)

    # The fish's material head points along body -x. Keeping the signed
    # forward component in this angle preserves useful guidance after a pass;
    # the evaluator's bearing alone intentionally uses abs(target_x).
    geometry_scale = max(distance_L, 0.25)
    forward_component = -target_x_L / geometry_scale
    lateral_component = target_y_L / geometry_scale
    vector_angle = clamp(
        atan(lateral_component, max(forward_component, 0.15)),
        -1.35,
        1.35,
    )
    bearing = clamp(_safe(state.bearing, 0.0), -1.0, 1.0)

    bearing_trend = hasproperty(state, :bearing_window_rate) ?
        _safe(state.bearing_window_rate, 0.0) :
        _safe(state.bearing_rate, 0.0)
    yaw_rate = hasproperty(state, :turn_rate_recent) ?
        _safe(state.turn_rate_recent, 0.0) :
        _safe(state.heading_rate, 0.0)

    # In this body convention positive target y calls for negative yaw. The
    # calibrated positive joint bias supplies that negative yaw. Positive
    # bearing trend and yaw rate therefore enter with the same correcting sign.
    request =
        params.bearing_gain * bearing +
        params.vector_angle_gain * vector_angle +
        params.bearing_trend_gain *
            tanh(bearing_trend / max(params.bearing_trend_scale, 1.0e-6)) +
        params.yaw_rate_gain *
            tanh(yaw_rate / max(params.yaw_rate_scale, 1.0e-6))
    command = tanh(request / max(params.curvature_request_scale, 1.0e-6))
    return params.maximum_joint_bias * command
end

function drive_acceleration(state, params, joint_bias)
    omega = 2 * pi / params.drive_period
    amplitude = params.drive_amplitude
    q1 = _safe(state.phi[1], 0.0)
    q2 = _safe(state.phi[2], 0.0)
    qd1 = _safe(state.phi_dot[1], 0.0)
    qd2 = _safe(state.phi_dot[2], 0.0)

    # Joint 1 oscillates about the requested mean bend. The phase remains
    # encoded only in observed joint angle and rate.
    centered_q1 = q1 - joint_bias
    vdp_drive =
        params.drive_mu * (1 - (centered_q1 / amplitude)^2) * qd1
    accel1 = vdp_drive - omega^2 * centered_q1

    # Joint 2 follows a posterior-lagged wave about the same mean joint bias.
    # At equilibrium q1=q2=joint_bias; the oscillatory parts retain direction
    # and posterior phase lag instead of collapsing into a static C-bend.
    tail_target =
        2 * joint_bias - q1 -
        params.posterior_lag_gain * qd1 / max(omega, eps(omega))
    accel2 =
        omega^2 * (tail_target - q2) -
        2 * params.posterior_damping * omega * qd2
    return accel1, accel2
end

function target_policy(state, params)
    joint_bias = steering_bias(state, params)
    accel1, accel2 = drive_acceleration(state, params, joint_bias)
    limit = max(params.command_acceleration_limit, 1.0e-6)
    return (
        phi_ddot=(
            clamp(accel1, -limit, limit),
            clamp(accel2, -limit, limit),
        ),
    )
end
