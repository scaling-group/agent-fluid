# Speed-reliable exact-course steering with one-sided posterior wave relief.
# Joint state retains propulsive phase; steering never amplifies a tail lobe.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        steering_bearing_limit=pi / 2,
        steering_course_reliability_speed_U=0.15,
        steering_course_error_limit=pi / 2,
        steering_error_scale=0.30,
        steering_curvature_limit=12.0 * pi / 180,
        steering_wave_relief=0.65,
        steering_phase_gate_scale=0.25,
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

    velocity_x = Float64(state.velocity_body_U[1])
    velocity_y = Float64(state.velocity_body_U[2])
    velocity_x = isfinite(velocity_x) ? velocity_x : 0.0
    velocity_y = isfinite(velocity_y) ? velocity_y : 0.0

    # The fish swims toward negative body x. Fade from geometric bearing to
    # inertial course error only after positive forward motion is established.
    forward_speed = max(-velocity_x, 0.0)
    reliability_speed = max(
        params.steering_course_reliability_speed_U,
        eps(params.steering_course_reliability_speed_U),
    )
    course_reliability = forward_speed^2 /
        (forward_speed^2 + reliability_speed^2)

    target_x = Float64(state.target_body_L[1])
    target_y = Float64(state.target_body_L[2])
    target_valid = isfinite(target_x) && isfinite(target_y) &&
        hypot(target_x, target_y) > eps(Float64)
    speed = hypot(velocity_x, velocity_y)

    # Signed angle from velocity to target remains valid when the target is
    # nearly lateral. Its negative is the evidenced posterior turn convention.
    course_to_target = if target_valid && speed > eps(Float64)
        clamp(
            atan(
                velocity_x * target_y - velocity_y * target_x,
                velocity_x * target_x + velocity_y * target_y,
            ),
            -params.steering_course_error_limit,
            params.steering_course_error_limit,
        )
    else
        0.0
    end
    turn_signal = (1 - course_reliability) * bearing -
        course_reliability * course_to_target
    turn_command = tanh(turn_signal / params.steering_error_scale)
    mean_tail_tangent = params.steering_curvature_limit * turn_command

    posterior_wave = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))

    # Relieve only the wave lobe opposing the requested bend. Reflection flips
    # command and wave together, while an aiding lobe is never amplified.
    normalized_opposition = -turn_command * posterior_wave /
        max(amp, eps(amp))
    opposition_gate = 0.5 * (1 + tanh(
        normalized_opposition / params.steering_phase_gate_scale,
    ))
    wave_scale = 1 - params.steering_wave_relief *
        abs(turn_command) * opposition_gate
    phase_lag_target = clamp(
        mean_tail_tangent + wave_scale * posterior_wave,
        -params.posterior_target_limit,
        params.posterior_target_limit,
    )
    a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    a1 = clamp(a1, -params.acceleration_limit, params.acceleration_limit)
    a2 = clamp(a2, -params.acceleration_limit, params.acceleration_limit)

    return (phi_ddot=(a1, a2),)
end
