# Phase-separated propulsion with route-conditioned pump reallocation.
# Gait phase and route error come only from normalized body-frame state.

function target_policy_params()
    return (
        control_period=0.90,
        oscillator_amplitude=18.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        bearing_limit=1.0,
        bearing_scale=0.35,
        course_error_limit=1.0,
        course_error_scale=0.50,
        course_speed_scale=0.20,
        phase_velocity_scale=0.60,
        phase_pump_acceleration=6.0,
        max_pump_allocation=0.85,
        steering_angle_soft_limit=36.0 * pi / 180,
        headroom_exponent=4.0,
        acceleration_limit=30.0,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

    # Retain the sampled traveling-bend scaffold. The joint-state phase pump
    # preserves the useful long-range carrier without an external clock.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    carrier_a1 = vdp_drive - omega^2 * q1
    phase_velocity = tanh(
        qd1 /
        (max(omega * amp, eps(Float64)) * params.phase_velocity_scale),
    )
    # Select the turn side from slow route geometry, not gait-contaminated
    # instantaneous yaw. At low speed bearing supplies a defined request. Once
    # translation is observable, the normalized velocity/target cross product
    # reports which side of the target the measured course will pass.
    bearing = clamp(
        Float64(state.bearing),
        -params.bearing_limit,
        params.bearing_limit,
    )
    target_x = Float64(state.target_body_L[1])
    target_y = Float64(state.target_body_L[2])
    velocity_x = Float64(state.velocity_body_U[1])
    velocity_y = Float64(state.velocity_body_U[2])
    target_distance = hypot(target_x, target_y)
    speed = hypot(velocity_x, velocity_y)
    course_error = clamp(
        (velocity_x * target_y - velocity_y * target_x) /
        max(speed * target_distance, eps(Float64)),
        -params.course_error_limit,
        params.course_error_limit,
    )
    speed_scale2 = params.course_speed_scale^2
    course_weight = speed^2 / (speed^2 + speed_scale2)

    # The sampled response-gated parent is the only policy that lowered the
    # high-y corridor: its effective selector has the same sign as bearing and
    # the opposite sign from course error. Preserve that measured allocation.
    bearing_side = tanh(bearing / params.bearing_scale)
    course_side = -tanh(course_error / params.course_error_scale)
    turn_side = clamp(
        (1 - course_weight) * bearing_side +
        course_weight * course_side,
        -1.0,
        1.0,
    )
    # Allocate the existing phase-pump effort to the turn-useful half-cycle.
    # The normalization holds the stronger half-cycle at the symmetric-pump
    # magnitude while continuously suppressing the opposite side. This makes
    # route authority compete for existing effort instead of adding to an
    # already clipped carrier.
    allocation = params.max_pump_allocation * abs(turn_side)
    phase_pump = params.phase_pump_acceleration * phase_velocity * (
        1 + params.max_pump_allocation * turn_side * phase_velocity
    ) / (1 + allocation)

    # Fade allocated energy before the anterior hard limit. The restoring
    # carrier remains active so this gate cannot latch at the soft boundary.
    angle_ratio = abs(q1) / params.steering_angle_soft_limit
    angle_headroom = clamp(
        1 - angle_ratio^params.headroom_exponent,
        0.0,
        1.0,
    )
    a1 = carrier_a1 + angle_headroom * phase_pump

    # Preserve the posterior state-feedback lag that generated the coherent
    # three-dimensional wake in the strongest sampled rollout.
    tail_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(Float64))
    a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    limit = params.acceleration_limit
    return (
        phi_ddot=(
            clamp(a1, -limit, limit),
            clamp(a2, -limit, limit),
        ),
    )
end
