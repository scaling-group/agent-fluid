# Speed-reliable course alignment for the 3D moving-window EvE lane. Joint
# state retains propulsive phase; normalized forward speed fades steering from
# body bearing at release to actual target-versus-course error while swimming.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        steering_bearing_limit=pi / 2,
        steering_course_reliability_speed_U=0.15,
        steering_course_angle_limit=pi / 2,
        steering_error_scale=0.30,
        steering_curvature_limit=12.0 * pi / 180,
        posterior_target_limit=42.0 * pi / 180,
        acceleration_limit=1800.0 * pi / 180,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Preserve the evidenced carrier without moving its equilibrium.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1

    raw_bearing = Float64(state.bearing)
    bearing = isfinite(raw_bearing) ? clamp(
        raw_bearing,
        -params.steering_bearing_limit,
        params.steering_bearing_limit,
    ) : 0.0

    velocity_forward = -Float64(state.velocity_body_U[1])
    velocity_lateral = Float64(state.velocity_body_U[2])
    velocity_forward = isfinite(velocity_forward) ? velocity_forward : 0.0
    velocity_lateral = isfinite(velocity_lateral) ? velocity_lateral : 0.0

    # The fish swims toward negative body x. Course direction is meaningful
    # only after positive forward motion develops, so use a smooth reliability
    # weight rather than feeding release noise or reverse motion into steering.
    forward_speed = max(velocity_forward, 0.0)
    reliability_speed = params.steering_course_reliability_speed_U
    course_reliability = forward_speed^2 /
        (forward_speed^2 + reliability_speed^2)
    course_angle = atan(
        velocity_lateral,
        forward_speed,
    )
    course_angle = clamp(
        course_angle,
        -params.steering_course_angle_limit,
        params.steering_course_angle_limit,
    )
    # This continuously equals bearing at release and tends to the true
    # line-of-sight-minus-course angle during established forward swimming.
    course_error = bearing - course_reliability * course_angle
    turn_command = tanh(course_error / params.steering_error_scale)
    mean_tail_tangent = params.steering_curvature_limit * turn_command

    # Keep steering posterior-only: sampled shared anterior bias quenched the
    # carrier, while posterior bias retained the coherent alternating wake.
    posterior_wave = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    phase_lag_target = clamp(
        mean_tail_tangent + posterior_wave,
        -params.posterior_target_limit,
        params.posterior_target_limit,
    )
    a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    a1 = clamp(a1, -params.acceleration_limit, params.acceleration_limit)
    a2 = clamp(a2, -params.acceleration_limit, params.acceleration_limit)

    return (phi_ddot=(a1, a2),)
end
