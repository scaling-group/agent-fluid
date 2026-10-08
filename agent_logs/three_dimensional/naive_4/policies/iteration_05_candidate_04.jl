# Course-aligned one-sided tail relief with bearing-gated redirection reserve.
# Joint state carries propulsive phase; large off-axis target geometry shrinks
# the zero-mean carrier envelope so bounded posterior curvature can redirect it.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        redirection_bearing_onset=0.30,
        redirection_bearing_full=0.90,
        redirection_carrier_floor=0.55,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        steering_bearing_limit=pi / 2,
        steering_course_speed_floor_U=0.15,
        steering_course_angle_limit=pi / 2,
        steering_course_weight=0.55,
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
    nominal_amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    raw_bearing = Float64(state.bearing)
    bearing = isfinite(raw_bearing) ? clamp(
        raw_bearing,
        -params.steering_bearing_limit,
        params.steering_bearing_limit,
    ) : 0.0

    # Body bearing changes slowly relative to beat-scale course oscillation.
    # Preserve the full carrier in the on-axis band, but shrink its limit-cycle
    # envelope during a large redirect so mean tail curvature has headroom.
    redirection_span = max(
        params.redirection_bearing_full - params.redirection_bearing_onset,
        eps(params.redirection_bearing_full),
    )
    redirection_gate = clamp(
        (abs(bearing) - params.redirection_bearing_onset) / redirection_span,
        0.0,
        1.0,
    )
    carrier_fraction = 1 - redirection_gate *
        (1 - params.redirection_carrier_floor)
    active_amp = max(
        nominal_amp * carrier_fraction,
        eps(nominal_amp),
    )
    vdp_drive = params.oscillator_mu *
        (1 - (q1 / active_amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1

    velocity_forward = -Float64(state.velocity_body_U[1])
    velocity_lateral = Float64(state.velocity_body_U[2])
    velocity_forward = isfinite(velocity_forward) ? velocity_forward : 0.0
    velocity_lateral = isfinite(velocity_lateral) ? velocity_lateral : 0.0

    # The fish swims toward negative body x. Inertial course exposes lateral
    # overshoot before body bearing alone can correct the accumulated motion.
    course_angle = atan(
        velocity_lateral,
        max(velocity_forward, params.steering_course_speed_floor_U),
    )
    course_angle = clamp(
        course_angle,
        -params.steering_course_angle_limit,
        params.steering_course_angle_limit,
    )
    course_error = bearing - params.steering_course_weight * course_angle
    turn_command = tanh(course_error / params.steering_error_scale)
    mean_tail_tangent = params.steering_curvature_limit * turn_command

    posterior_wave = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))

    # Relieve only the posterior lobe opposed to the requested mean bend. This
    # preserves an aiding lobe without amplifying it into the actuator limit.
    normalized_opposition = -turn_command * posterior_wave /
        max(nominal_amp, eps(nominal_amp))
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
