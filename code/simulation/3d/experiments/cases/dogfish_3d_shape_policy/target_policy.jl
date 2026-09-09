function target_policy_params()
    return (
        # State-dependent propulsion seed matched to the verified L32 reserve
        # gait (approximately 10°/13° with 85° phase lag).  No clock time,
        # grid resolution, or fixed cylinder coordinate enters the policy.
        control_period=1.1,
        oscillator_amplitude=10.0 * pi / 180,
        oscillator_mu=0.35,
        tail_amplitude_ratio=1.3,
        tail_phase_lag=85.0 * pi / 180,
        tail_damping=0.8,
        steer_gain=0.4,
        tail_steer_gain=0.5,
        lateral_velocity_gain=0.2,
        heading_rate_gain=0.1,
        bearing_rate_gain=0.05,
        wake_crossflow_gain=0.05,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # State-only reflex oscillator: the phase is encoded in (q1, qd1), not time.
    # The seed is intentionally strong enough to create visible self-propulsion;
    # target steering can be improved by evolution on top of this drive.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1

    # Reconstruct a phase-lagged target from the oscillator state.  For an
    # approximately sinusoidal q1 this is A2/A1*sin(phase-lag), but remains a
    # pure state-feedback law rather than a prescribed replay.
    phase_lag_target = params.tail_amplitude_ratio * (
        cos(params.tail_phase_lag) * q1 -
        sin(params.tail_phase_lag) * qd1 / max(omega, eps(omega))
    )
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    # Steering starts deliberately weak because the 2D iter11 replay proved
    # over-aggressive in 3D.  The EvE lane may adapt these normalized gains.
    bearing = clamp(Float64(state.bearing), -1.0, 1.0)
    steer = params.steer_gain * bearing -
        params.lateral_velocity_gain * Float64(state.velocity_body_U[2]) -
        params.heading_rate_gain * Float64(state.heading_rate) -
        params.bearing_rate_gain * Float64(state.bearing_rate) -
        params.wake_crossflow_gain * Float64(state.wake_crossflow_velocity_U)

    return (
        phi_ddot=(
            a1 + steer,
            a2 + params.tail_steer_gain * steer,
        ),
    )
end
