# Differential-curvature turn-rate servo for the 3D moving-window EvE lane.
# Propulsive phase remains entirely in joint state.  Normalized body-frame
# bearing sets a desired turn rate, and measured turn response releases the
# bend instead of holding a saturated static curvature through alignment.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        bearing_scale=0.30,
        target_turn_rate_limit=0.50,
        turn_rate_limit=2.0,
        turn_rate_error_scale=0.60,
        head_bias_limit=4.0 * pi / 180,
        tail_bias_limit=10.0 * pi / 180,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # In the measured 3D sign convention, positive target bearing requires
    # negative body turn rate.  Closing a rate loop makes a large error request
    # a redirect, then removes or reverses the request once the body responds.
    bearing = Float64(state.bearing)
    target_turn_rate = -params.target_turn_rate_limit * tanh(
        bearing / max(params.bearing_scale, eps(params.bearing_scale)),
    )
    turn_rate = clamp(
        Float64(state.turn_rate_recent),
        -params.turn_rate_limit,
        params.turn_rate_limit,
    )
    turn_request = tanh(
        (turn_rate - target_turn_rate) /
        max(params.turn_rate_error_scale, eps(params.turn_rate_error_scale)),
    )

    # Sampled rollouts give opposite yaw signs for anterior and posterior mean
    # offsets.  Distribute one bounded request with those measured signs: the
    # smaller anterior offset supplies prompt authority while the larger
    # posterior offset retains the seed's thrust-producing traveling bend.
    head_bias = -params.head_bias_limit * turn_request
    tail_bias = params.tail_bias_limit * turn_request

    centered_q1 = q1 - head_bias
    vdp_drive = params.oscillator_mu * (1 - (centered_q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * centered_q1

    phase_lag_target = tail_bias - centered_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
