function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        steering_acceleration=10.0,
        steering_bearing_scale=0.35,
        steering_rate_gain=0.20,
        steering_rate_limit=0.75,
        tail_steering_ratio=0.55,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Preserve the successful state-only traveling-bend carrier.  Oscillator
    # phase is encoded in joint state rather than prescribed by a clock.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1

    # Tail follows the first joint with a velocity-dependent lag, producing a
    # smooth traveling bend without prescribing a clocked waveform.
    phase_lag_target = -q1 - params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    # Body-frame bearing supplies the proven mean-turn request.  Its windowed
    # rate is a small response term: release the turn while target error is
    # already shrinking and reinforce it when error grows.  Early padded
    # observations and minimal contract probes safely contribute zero rate.
    bearing = Float64(state.bearing)
    bearing_rate = hasproperty(state, :bearing_window_rate) ?
        clamp(
            Float64(state.bearing_window_rate),
            -params.steering_rate_limit,
            params.steering_rate_limit,
        ) :
        0.0
    steering_error = bearing + params.steering_rate_gain * bearing_rate
    steering = params.steering_acceleration *
        tanh(steering_error / params.steering_bearing_scale)

    return (
        phi_ddot=(
            a1 + steering,
            a2 + params.tail_steering_ratio * steering,
        ),
    )
end
