function target_policy_params()
    return (
        control_period=0.90,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.80,
        tail_damping=0.65,
        steering_bias_limit=10.0 * pi / 180,
        bearing_scale=25.0 * pi / 180,
        bearing_closing_rate_scale=0.35,
        bearing_closing_brake=0.65,
        steering_fade_distance_L=0.75,
        steering_fade_width_L=0.75,
        acceleration_command_limit=1650.0 * pi / 180,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Preserve the strongest sampled upstream gait and keep its oscillator
    # centered at zero; target feedback belongs only in the posterior tangent.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    raw_a1 = vdp_drive - omega^2 * q1

    # Additive rate terms either reinforced saturation or removed upstream
    # authority in the sampled rollouts. Use rate only as a sign-preserving
    # brake: it can weaken a turn whose bearing is already closing, but it can
    # never strengthen an opening-bearing turn or reverse geometric steering.
    bearing_rate = clamp(
        state.bearing_window_rate,
        -params.bearing_closing_rate_scale,
        params.bearing_closing_rate_scale,
    )
    closing_rate_fraction = state.bearing * bearing_rate < 0.0 ?
        tanh(abs(bearing_rate) / params.bearing_closing_rate_scale) : 0.0
    steering_brake = 1.0 -
        params.bearing_closing_brake * closing_rate_fraction
    fade_coordinate = clamp(
        (state.distance_L - params.steering_fade_distance_L) /
            max(params.steering_fade_width_L, eps(params.steering_fade_width_L)),
        0.0,
        1.0,
    )
    steering_fade = fade_coordinate^2 * (3 - 2 * fade_coordinate)
    steering_bias = params.steering_bias_limit * steering_fade * steering_brake *
        tanh(state.bearing / params.bearing_scale)

    # Preserve the traveling bend while steering only the cumulative posterior
    # tangent; moving this feedback into the anterior oscillator was unstable.
    tail_tangent_target = steering_bias -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    q2_target = tail_tangent_target - q1
    raw_a2 = omega^2 * (q2_target - q2) -
        2 * params.tail_damping * omega * qd2

    limit = params.acceleration_command_limit
    return (
        phi_ddot=(
            clamp(raw_a1, -limit, limit),
            clamp(raw_a2, -limit, limit),
        ),
    )
end
