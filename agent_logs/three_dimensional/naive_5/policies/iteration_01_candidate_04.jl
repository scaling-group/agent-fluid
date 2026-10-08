# Target-bearing mean-curvature candidate for the 3D moving-window lane.
# Oscillation phase remains encoded only in observed joint state; the target
# affects a bounded posterior mean bend rather than a world-frame route.

function target_policy_params()
    return (
        control_period=0.90,
        oscillator_amplitude=18.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        bearing_gain=3.0,
        bearing_limit=1.25,
        heading_rate_gain=1.5,
        heading_rate_ratio_limit=0.5,
        tail_curvature_limit=8.0 * pi / 180,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Preserve the seed's state-feedback carrier, at a cadence and scale that
    # leave acceleration authority for steering.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1

    # A positive joint bias produces negative yaw for this FSI geometry.  The
    # body-frame bearing uses that sign directly.  Yaw rate is normalized by
    # gait frequency and fed back with the opposite effect of an established
    # target-directed turn, preventing a static curvature command from curling
    # into the upper-boundary exit seen in the parent rollout.
    bearing = clamp(
        Float64(state.bearing),
        -params.bearing_limit,
        params.bearing_limit,
    )
    heading_rate_ratio = clamp(
        Float64(state.heading_rate) / max(omega, eps(omega)),
        -params.heading_rate_ratio_limit,
        params.heading_rate_ratio_limit,
    )
    curvature_request =
        params.bearing_gain * bearing +
        params.heading_rate_gain * heading_rate_ratio
    tail_mean_curvature = params.tail_curvature_limit * tanh(curvature_request)

    phase_lag_target =
        tail_mean_curvature -
        q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
