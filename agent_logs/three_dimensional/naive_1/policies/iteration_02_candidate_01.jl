# Target-aligned half-cycle steering around the state-feedback traveling-bend
# carrier. Beat phase remains reconstructed only from observed joint state.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        bearing_scale=0.35,
        heading_rate_scale=1.5,
        heading_rate_unloading=0.35,
        half_cycle_width=0.10,
        half_cycle_acceleration=8.0,
        anterior_steer_share=1.0,
        posterior_steer_share=0.8,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Van der Pol drive: oscillation phase lives in (q1, qd1), not clock time.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1

    phase_lag_target = -q1 - params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    # Positive bearing requests positive bend, which produces negative yaw in
    # this head-at-negative-x geometry. Same-direction yaw therefore unloads
    # the request. Both inputs are body-relative and smoothly bounded.
    turn_signal = Float64(state.bearing) / params.bearing_scale +
        params.heading_rate_unloading * Float64(state.heading_rate) /
        params.heading_rate_scale
    turn_command = tanh(turn_signal)

    # q1 + qd1/omega labels the bend being occupied or approached without a
    # clock. Apply steering mainly on the requested half-cycle, preserving the
    # opposite half and the zero-centered propulsive oscillator.
    phase_coordinate = q1 + qd1 / max(omega, eps(omega))
    aligned_half_cycle = 0.5 * (1 + tanh(
        turn_command * phase_coordinate / params.half_cycle_width,
    ))
    turn_residual = params.half_cycle_acceleration * turn_command *
        aligned_half_cycle

    return (
        phi_ddot=(
            a1 + params.anterior_steer_share * turn_residual,
            a2 + params.posterior_steer_share * turn_residual,
        ),
    )
end
