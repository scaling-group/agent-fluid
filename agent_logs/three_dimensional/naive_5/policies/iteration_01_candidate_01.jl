# Target-bearing mean-curvature controller on a state-feedback traveling bend.
# The oscillator phase remains encoded in joint state; no clock, world route,
# or moving-window coordinate enters the policy.

function target_policy_params()
    return (
        control_period=0.85,
        oscillator_amplitude=18.0 * pi / 180,
        oscillator_mu=0.35,
        tail_amplitude_ratio=1.25,
        tail_phase_lag=0.5 * pi,
        tail_damping=0.85,
        bearing_scale=0.40,
        turn_rate_scale=1.0,
        turn_rate_damping=0.20,
        curvature_limit=14.0 * pi / 180,
        tail_curvature_share=0.90,
        acceleration_limit=24.0,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

    # Positive body-frame bearing requires negative curvature in this fish's
    # forward-axis convention. Measured turn rate releases a correct turn and
    # opposes an overshoot without introducing a hidden navigation stage.
    bearing = clamp(Float64(state.bearing), -1.0, 1.0)
    rate_feedback = params.turn_rate_damping * tanh(
        Float64(state.heading_rate) / params.turn_rate_scale,
    )
    curvature_error = -bearing - rate_feedback
    curvature_bias = params.curvature_limit * tanh(
        curvature_error / params.bearing_scale,
    )

    # Oscillate about the requested mean bend. The slower, smaller carrier is
    # chosen to keep its nominal joint speed and acceleration inside the fixed
    # envelope that clipped the sampled naive rollout.
    centered_q1 = q1 - curvature_bias
    vdp_drive = params.oscillator_mu * (1 - (centered_q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * centered_q1

    # Reconstruct a posterior-emphasized lagged target from the observed
    # oscillator state, then carry most of the mean curvature into the tail.
    phase_lag_target = params.tail_curvature_share * curvature_bias +
        params.tail_amplitude_ratio * (
            cos(params.tail_phase_lag) * centered_q1 -
            sin(params.tail_phase_lag) * qd1 / max(omega, eps(omega))
        )
    a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    limit = params.acceleration_limit
    return (phi_ddot=(clamp(a1, -limit, limit), clamp(a2, -limit, limit)),)
end
