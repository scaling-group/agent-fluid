function target_policy_params()
    return (
        control_period=1.0,
        oscillator_amplitude=12.0 * pi / 180,
        oscillator_mu=0.5,
        tail_lag_gain=0.55,
        tail_damping=0.75,
        steer_gain=2.8,
        steering_limit=12.0 * pi / 180,
        tail_steer_gain=0.35,
        lateral_velocity_gain=0.7,
        turn_damping=0.8,
        moment_damping=0.2,
    )
end

@inline function finite_state_scalar(state, name, default=0.0)
    hasproperty(state, name) || return default
    value = Float64(getproperty(state, name))
    return isfinite(value) ? value : default
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    bearing = finite_state_scalar(state, :bearing)
    lateral_velocity = 0.0
    if hasproperty(state, :velocity_body_U)
        velocity_body = state.velocity_body_U
        lateral_velocity = length(velocity_body) >= 2 && isfinite(velocity_body[2]) ?
            Float64(velocity_body[2]) : 0.0
    end
    recent_turn_rate = finite_state_scalar(state, :turn_rate_recent)
    normalized_moment = finite_state_scalar(state, :moment_z_L2)

    # Target bearing supplies a bounded mean curvature. Lateral motion, turn
    # rate, and moment oppose a one-way pivot without introducing a clock,
    # world coordinate, or case-specific route.
    steering_signal =
        params.steer_gain * bearing -
        params.lateral_velocity_gain * lateral_velocity +
        params.turn_damping * recent_turn_rate +
        params.moment_damping * normalized_moment
    steering_bias = params.steering_limit * tanh(steering_signal)

    # Preserve the seed's state-encoded phase, but oscillate around the
    # steering center at a frequency that does not require persistent clipping.
    gait_q1 = q1 - steering_bias
    vdp_drive = params.oscillator_mu * (1 - (gait_q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * gait_q1

    # The tail follows only the oscillatory component and receives a smaller
    # share of the steering bias, retaining a traveling bend during turns.
    phase_lag_target =
        -gait_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega)) +
        params.tail_steer_gain * steering_bias
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
