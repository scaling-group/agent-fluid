# Target-directed half-cycle steering for the 3D moving-window EvE lane.
# Propulsive phase remains in observed joint state; normalized body-frame
# target geometry selects which posterior half-cycle retains full authority.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        steering_bearing_scale=0.30,
        steering_lookahead_T=0.20,
        steering_bearing_rate_limit=1.20,
        steering_halfcycle_suppression=0.42,
        steering_phase_width=0.35,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

    # Preserve the sampled leader's anterior carrier exactly. Its phase lives
    # in (q1, qd1), not in clock time or a mutable oscillator state.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1

    # A short observed bearing projection releases and reverses steering as
    # the target line is crossed. All quantities are body-frame normalized.
    bearing_raw = Float64(state.bearing)
    bearing = isfinite(bearing_raw) ? clamp(bearing_raw, -pi / 2, pi / 2) : 0.0
    bearing_rate_raw = if hasproperty(state, :bearing_window_rate)
        Float64(state.bearing_window_rate)
    elseif hasproperty(state, :bearing_rate)
        Float64(state.bearing_rate)
    else
        0.0
    end
    bearing_rate = isfinite(bearing_rate_raw) ? clamp(
        bearing_rate_raw,
        -params.steering_bearing_rate_limit,
        params.steering_bearing_rate_limit,
    ) : 0.0
    predicted_bearing = bearing + params.steering_lookahead_T * bearing_rate
    turn_command = tanh(
        predicted_bearing / max(params.steering_bearing_scale, eps(Float64)),
    )

    # Infer posterior beat side from the same lagged joint-state target that
    # makes the traveling bend. The requested side is unchanged; the opposite
    # side is smoothly attenuated, so steering never amplifies a half-cycle
    # beyond the sampled carrier. Positive turn retains positive tail tangent,
    # matching the evidenced positive-bend -> negative-yaw convention.
    symmetric_tail_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    phase_width = max(
        params.steering_phase_width * amp,
        eps(Float64),
    )
    tail_side = tanh(symmetric_tail_target / phase_width)
    suppression = params.steering_halfcycle_suppression
    tail_scale = 1 - suppression * abs(turn_command) +
        suppression * turn_command * tail_side
    phase_lag_target = tail_scale * symmetric_tail_target
    a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
