# State-feedback propulsion with target-directed posterior half-cycle asymmetry.
# Joint state carries phase; body-frame target feedback selects the stronger
# tail half-cycle without a clock, fixed direction, or route.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        steering_asymmetry_limit=0.42,
        steering_bearing_scale=0.24,
        steering_turn_rate_lead=0.25,
        posterior_side_softness=8.0 * pi / 180,
        max_joint_acceleration=1800.0 * pi / 180,
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

    # Positive bearing asks for the tail's positive half-cycle to be stronger.
    # Recent measured turn rate leads the request so a correctly developing
    # turn releases before the body sweeps through the target bearing.
    bearing = isfinite(state.bearing) ? Float64(state.bearing) : 0.0
    turn_rate = isfinite(state.turn_rate_recent) ? Float64(state.turn_rate_recent) : 0.0
    steering_signal = bearing + params.steering_turn_rate_lead * turn_rate
    turn_request =
        tanh(steering_signal / max(params.steering_bearing_scale, eps(Float64)))

    # The lagged target itself is a state-derived beat-side signal.  Modulating
    # its magnitude retains zero crossings and posterior lag, unlike a static
    # equilibrium offset that can suppress the traveling bend.
    base_tail_target = -q1 - params.tail_lag_gain * qd1 / max(omega, eps(omega))
    beat_side = tanh(
        base_tail_target / max(params.posterior_side_softness, eps(Float64)),
    )
    tail_scale = 1 + params.steering_asymmetry_limit * turn_request * beat_side
    phase_lag_target = tail_scale * base_tail_target
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    acceleration_limit = params.max_joint_acceleration
    return (
        phi_ddot=(
            clamp(a1, -acceleration_limit, acceleration_limit),
            clamp(a2, -acceleration_limit, acceleration_limit),
        ),
    )
end
