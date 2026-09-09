# State-feedback traveling bend with trend-led half-cycle steering.
# Joint state carries phase; normalized body-frame target geometry and its
# measured short-window trend brake centerline sweeps without a clock, static
# curvature, or world-frame route.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        maximum_bearing=pi / 2,
        maximum_bearing_window_rate=1.5,
        bearing_rate_lead=0.12,
        steering_softness=0.35,
        maximum_half_cycle_asymmetry=0.35,
        head_asymmetry_share=0.65,
        tail_asymmetry_share=1.0,
        maximum_joint_acceleration=30.0,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Preserve the common seed's joint-state oscillator and posterior lag as
    # the propulsive carrier evidenced by the coherent alternating wake.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    carrier_a1 = vdp_drive - omega^2 * q1
    phase_lag_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    carrier_a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Positive bearing requests the turn side calibrated by the sampled shared
    # acceleration-asymmetry rollout. The bounded short-window bearing trend is
    # a lead term: a sweep toward centerline releases and then brakes the turn,
    # while a growing error restores authority. This addresses the sampled
    # centerline overshoot without using instantaneous beat-scale yaw.
    bearing = isfinite(state.bearing) ? Float64(state.bearing) : 0.0
    bearing_window_rate = isfinite(state.bearing_window_rate) ?
        Float64(state.bearing_window_rate) : 0.0
    bounded_bearing = clamp(
        bearing,
        -params.maximum_bearing,
        params.maximum_bearing,
    )
    rate_scale = max(params.maximum_bearing_window_rate, eps(Float64))
    bounded_bearing_rate = rate_scale * tanh(bearing_window_rate / rate_scale)
    turn_signal = bounded_bearing +
        params.bearing_rate_lead * bounded_bearing_rate
    turn_request = tanh(
        turn_signal / max(params.steering_softness, eps(Float64)),
    )
    asymmetry = params.maximum_half_cycle_asymmetry * turn_request

    # Adding signed |carrier acceleration| strengthens the requested
    # half-cycle and weakens its opposite without imposing a static joint
    # equilibrium. Posterior emphasis retains a traveling rather than standing
    # bend. Smooth action saturation stays inside the physical envelope without
    # replacing beat structure with repeated downstream hard clipping.
    raw_a1 = carrier_a1 +
        params.head_asymmetry_share * asymmetry * abs(carrier_a1)
    raw_a2 = carrier_a2 +
        params.tail_asymmetry_share * asymmetry * abs(carrier_a2)
    limit = params.maximum_joint_acceleration
    bounded_a1 = limit * tanh(raw_a1 / limit)
    bounded_a2 = limit * tanh(raw_a2 / limit)

    return (
        phi_ddot=(bounded_a1, bounded_a2),
    )
end
