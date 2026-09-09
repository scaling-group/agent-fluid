# Course-response burst redirect around the evidenced bounded-curvature carrier.
# Oscillation phase remains in measured joint state; steering uses only
# normalized body-frame target geometry and translational velocity.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        maximum_mean_curvature=7.0 * pi / 180,
        direction_error_scale=0.45,
        direction_limit=1.0,
        heading_rate_damping=0.18,
        heading_rate_limit=4.0,
        tail_curvature_share=0.8,
        alignment_direction_scale=0.60,
        posterior_wave_floor=0.35,
        course_speed_floor=0.10,
        course_error_scale=0.55,
        direction_activation_scale=0.65,
        course_agreement_scale=0.35,
        maximum_redirect_curvature=16.0 * pi / 180,
        maximum_wave_energy_relief=0.60,
        command_limit=28.0,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

    # The spine's forward axis is negative body x. Unlike the adapter's acute
    # bearing, this direction preserves whether the target has passed behind.
    target_x = Float64(state.target_body_L[1])
    target_y = Float64(state.target_body_L[2])
    direction_error = atan(target_y, -target_x)
    bounded_direction = clamp(
        direction_error,
        -params.direction_limit,
        params.direction_limit,
    )
    heading_rate = clamp(
        Float64(state.heading_rate),
        -params.heading_rate_limit,
        params.heading_rate_limit,
    )
    steering_error = bounded_direction -
        params.heading_rate_damping * heading_rate
    mean_curvature = params.maximum_mean_curvature *
        tanh(steering_error / params.direction_error_scale)

    # The persistent lower-boundary near miss is a course error, not a loss of
    # propulsion. Compare the measured translational course with the target ray;
    # their planar cross product has the reflection-equivariant steering sign.
    distance = max(Float64(state.distance_L), eps(Float64))
    velocity_x = Float64(state.velocity_body_U[1])
    velocity_y = Float64(state.velocity_body_U[2])
    speed = hypot(velocity_x, velocity_y)
    ray_dot_velocity =
        (target_x * velocity_x + target_y * velocity_y) / distance
    ray_cross_velocity =
        (target_x * velocity_y - target_y * velocity_x) / distance
    course_error = atan(ray_cross_velocity, ray_dot_velocity)

    # A smooth C-start-like burst is admitted only when target direction and
    # velocity course request the same turn. It releases as either error closes.
    speed_authority = speed^2 /
        (speed^2 + params.course_speed_floor^2)
    direction_authority = tanh(
        abs(direction_error) / params.direction_activation_scale,
    )^2
    course_command = tanh(course_error / params.course_error_scale)
    agreement_authority = max(
        tanh(
            direction_error * course_error /
            params.course_agreement_scale,
        ),
        0.0,
    )
    redirect_weight = speed_authority * direction_authority *
        agreement_authority * abs(course_command)
    redirect_curvature = params.maximum_redirect_curvature *
        redirect_weight * course_command
    mean_curvature += redirect_curvature

    # Reallocate oscillatory energy to the transient mean bend so stronger
    # curvature does not simply increase joint excursion or command effort.
    wave_energy = 1 -
        params.maximum_wave_energy_relief * redirect_weight
    wave_amplitude_scale = sqrt(max(wave_energy, eps(Float64)))

    # Preserve joint-state phase while moving and, only during a redirect,
    # tightening the anterior oscillator's bounded envelope.
    centered_q1 = q1 - mean_curvature
    effective_amplitude = amp * wave_amplitude_scale
    vdp_drive = params.oscillator_mu *
        (1 - (centered_q1 / effective_amplitude)^2) * qd1
    raw_a1 = vdp_drive - omega^2 * centered_q1

    # Full direction, rather than acute bearing, keeps thrust low during a
    # pass-behind redirect. Alignment continuously restores the lagged wave.
    normalized_direction =
        direction_error / params.alignment_direction_scale
    posterior_wave_authority = params.posterior_wave_floor +
        (1 - params.posterior_wave_floor) /
        (1 + normalized_direction^2)
    tail_mean = params.tail_curvature_share * mean_curvature
    posterior_wave = -centered_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    phase_lag_target = tail_mean + wave_amplitude_scale *
        posterior_wave_authority * posterior_wave
    raw_a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Keep deterministic reserve below the 1800 deg/T^2 episode hard limit.
    a1 = clamp(raw_a1, -params.command_limit, params.command_limit)
    a2 = clamp(raw_a2, -params.command_limit, params.command_limit)
    return (phi_ddot=(a1, a2),)
end
