# Bounded body-frame homing wrapped around the naive joint-state oscillator.
# Positive joint bias produces negative yaw in this fish, so positive body-frame
# bearing maps to positive mean curvature and measured negative yaw releases it.

function target_policy_params()
    return (
        control_period=0.75,
        oscillator_amplitude=20.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.75,
        bearing_scale=0.25,
        bearing_rate_scale=0.50,
        bearing_rate_damping=0.20,
        heading_rate_scale=1.0,
        heading_rate_damping=0.35,
        lateral_velocity_scale=0.25,
        lateral_velocity_damping=0.25,
        curvature_limit=10.0 * pi / 180,
        tail_curvature_share=1.0,
        command_limit=28.0,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # All steering observations are normalized and body-relative.  The slow
    # bearing request is opposed by measured target sweep, yaw, and lateral
    # slip so that an established turn is released continuously.
    bearing = clamp(Float64(state.bearing), -pi / 2, pi / 2)
    bearing_rate = hasproperty(state, :bearing_window_rate) ?
        Float64(state.bearing_window_rate) :
        (hasproperty(state, :bearing_rate) ? Float64(state.bearing_rate) : 0.0)
    heading_rate = hasproperty(state, :heading_rate) ? Float64(state.heading_rate) : 0.0
    lateral_velocity = Float64(state.velocity_body_U[2])
    turn_signal =
        bearing / params.bearing_scale -
        params.bearing_rate_damping * tanh(bearing_rate / params.bearing_rate_scale) +
        params.heading_rate_damping * tanh(heading_rate / params.heading_rate_scale) -
        params.lateral_velocity_damping *
        tanh(lateral_velocity / params.lateral_velocity_scale)
    curvature = params.curvature_limit * tanh(turn_signal)

    # The oscillator phase remains entirely in observed joint state.  Moving
    # its equilibrium adds mean curvature without replacing the traveling bend.
    centered_q1 = q1 - curvature
    vdp_drive = params.oscillator_mu * (1 - (centered_q1 / amp)^2) * qd1
    raw_a1 = vdp_drive - omega^2 * centered_q1

    phase_lag_target =
        params.tail_curvature_share * curvature - centered_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    raw_a2 =
        omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Leave deterministic reserve below the 1800 deg/T^2 episode hard limit.
    a1 = clamp(raw_a1, -params.command_limit, params.command_limit)
    a2 = clamp(raw_a2, -params.command_limit, params.command_limit)

    return (phi_ddot=(a1, a2),)
end
