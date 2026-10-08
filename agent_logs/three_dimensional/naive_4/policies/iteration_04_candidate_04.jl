# Target-versus-course steering with turn-priority posterior allocation.
# Propulsive phase remains in joint state; large observed course error reserves
# posterior angle authority for curvature and restores the wave on alignment.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        steering_bearing_limit=pi / 2,
        steering_course_speed_floor_U=0.15,
        steering_course_angle_limit=pi / 2,
        steering_course_weight=0.55,
        steering_error_scale=0.30,
        steering_curvature_limit=20.0 * pi / 180,
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

    # The fish swims toward negative body x. The positive speed floor makes
    # course feedback vanish continuously at release and remain bounded if a
    # beat briefly produces reverse motion.
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

    # Keep steering posterior-only: sampled shared anterior bias quenched the
    # carrier, while posterior bias retained the coherent alternating wake.
    # Allocate the joint-angle envelope around the requested mean rather than
    # adding a full wave and clipping only its outer extreme. This makes large
    # observed course error a continuous redirect mode; alignment returns all
    # posterior authority to the traveling wave.
    posterior_wave = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    posterior_wave_budget = max(
        params.posterior_target_limit - abs(mean_tail_tangent),
        0.0,
    )
    allocated_posterior_wave = clamp(
        posterior_wave,
        -posterior_wave_budget,
        posterior_wave_budget,
    )
    phase_lag_target = mean_tail_tangent + allocated_posterior_wave
    a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    a1 = clamp(a1, -params.acceleration_limit, params.acceleration_limit)
    a2 = clamp(a2, -params.acceleration_limit, params.acceleration_limit)

    return (phi_ddot=(a1, a2),)
end
