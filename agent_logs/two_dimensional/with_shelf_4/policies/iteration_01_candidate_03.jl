function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        steering_bend_limit=16.0 * pi / 180,
        steering_bearing_scale=0.35,
        tail_steering_share=0.6,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Convert body-frame target error into a smooth mean-curvature command.
    # The bounded bias redirects the inherited rhythm without a clock, route,
    # or world-frame direction.
    bearing = clamp(Float64(state.bearing), -pi / 2, pi / 2)
    mean_bend = params.steering_bend_limit *
        tanh(bearing / params.steering_bearing_scale)

    # Keep the joint-state oscillator, but center its traveling component on
    # the requested mean bend so steering has authority even at beat reversal.
    q1_wave = q1 - mean_bend
    vdp_drive = params.oscillator_mu * (1 - (q1_wave / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1_wave

    # Tail follows the first joint with a velocity-dependent lag, producing a
    # smooth traveling bend without prescribing a clocked waveform.
    phase_lag_target = params.tail_steering_share * mean_bend - q1_wave -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
