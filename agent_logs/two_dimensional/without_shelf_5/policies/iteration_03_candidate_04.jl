function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        bearing_limit=pi / 2,
        steering_gain=1.9,
        steering_angle_limit=12.0 * pi / 180,
        anterior_steering_fraction=0.4,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Body-frame bearing supplies a bounded curvature center without prescribing
    # a global route. The joint state still carries the propulsion phase.
    bounded_bearing = clamp(state.bearing, -params.bearing_limit, params.bearing_limit)
    steering_angle = params.steering_angle_limit * tanh(params.steering_gain * bounded_bearing)
    q1_center = params.anterior_steering_fraction * steering_angle

    centered_q1 = q1 - q1_center
    vdp_drive = params.oscillator_mu * (1 - (centered_q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * centered_q1

    # Center the total posterior tangent on the same steering command while the
    # velocity term retains the seed's smooth traveling-bend phase lag.
    phase_lag_target = steering_angle - q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
