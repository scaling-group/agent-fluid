# State-phased posterior half-cycle steering around the naive traveling-bend
# carrier. Phase remains entirely in observed joint state; target feedback is
# normalized and body-relative.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        steering_bearing_scale=0.28,
        steering_lookahead_T=0.10,
        steering_bearing_rate_limit=1.0,
        half_cycle_asymmetry=0.45,
        tail_target_limit=42.0 * pi / 180,
        command_acceleration_limit=1800.0 * pi / 180,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

    # Preserve the evidenced carrier: steering never recenters joint 1.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1_raw = vdp_drive - omega^2 * q1

    bearing_raw = Float64(state.bearing)
    bearing = isfinite(bearing_raw) ? clamp(bearing_raw, -1.0, 1.0) : 0.0
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
    predicted_bearing = clamp(
        bearing + params.steering_lookahead_T * bearing_rate,
        -1.0,
        1.0,
    )
    turn_command = tanh(
        predicted_bearing /
        max(params.steering_bearing_scale, eps(Float64)),
    )

    # A positive command strengthens the negative posterior half-cycle and
    # weakens the positive one; a centerline crossing reverses that choice.
    # Unlike a static mean offset, the steering authority vanishes with the
    # carrier and therefore cannot replace propulsion with a frozen bend.
    carrier_tail_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    asymmetry = params.half_cycle_asymmetry * turn_command
    steered_tail_target = carrier_tail_target -
        asymmetry * abs(carrier_tail_target)
    tail_target = clamp(
        steered_tail_target,
        -params.tail_target_limit,
        params.tail_target_limit,
    )
    a2_raw = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    accel_limit = params.command_acceleration_limit
    return (
        phi_ddot=(
            clamp(a1_raw, -accel_limit, accel_limit),
            clamp(a2_raw, -accel_limit, accel_limit),
        ),
    )
end
