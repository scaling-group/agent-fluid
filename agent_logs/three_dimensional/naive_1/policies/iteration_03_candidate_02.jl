# State-feedback traveling-bend carrier with small-error half-cycle steering
# and a body-frame, large-error posterior redirect. Oscillator phase remains
# encoded only in observed joint state.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        steering_acceleration_limit=12.0,
        steering_bearing_scale=0.25,
        heading_rate_lead=0.12,
        phase_velocity_limit=1.0,
        redirect_bearing_start=0.30,
        redirect_bearing_full=0.85,
        redirect_error_scale=0.30,
        redirect_heading_rate_lead=0.35,
        redirect_tail_bias_limit=8.0 * pi / 180,
        redirect_tail_carrier_relief=0.35,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Van der Pol carrier: oscillation phase lives in (q1, qd1), not clock
    # time, and its equilibrium remains centered so target feedback cannot
    # replace the beat with a static bend.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    bearing = Float64(state.bearing)
    heading_rate = Float64(state.heading_rate)

    # Positive bearing requests the positive-bend half-cycle. Correct-sign
    # negative yaw unloads that request; after an overshoot the same feedback
    # strengthens the opposite half-cycle. The acceleration residual does work
    # only while joint 1 is moving toward the requested side, creating bounded
    # amplitude asymmetry without prescribing beat phase or mean curvature.
    route_error = bearing + params.heading_rate_lead * heading_rate
    turn_request = tanh(route_error / params.steering_bearing_scale)
    phase_velocity = clamp(
        qd1 / max(omega * amp, eps(omega * amp)),
        -params.phase_velocity_limit,
        params.phase_velocity_limit,
    )
    useful_half_cycle = max(0.0, sign(turn_request) * phase_velocity)
    # Reserve the additive anterior residual for the small-error regime.  The
    # smoothstep gate depends only on observed body-frame target geometry.
    redirect_progress = clamp(
        (abs(bearing) - params.redirect_bearing_start) /
            max(
                params.redirect_bearing_full - params.redirect_bearing_start,
                eps(params.redirect_bearing_full),
            ),
        0.0,
        1.0,
    )
    redirect_gate = redirect_progress^2 * (3 - 2 * redirect_progress)
    half_cycle_steer = params.steering_acceleration_limit *
        turn_request * useful_half_cycle * (1 - redirect_gate)

    a1 = vdp_drive - omega^2 * q1 + half_cycle_steer

    # Large persistent bearing receives a bounded posterior curvature burst.
    # Correct-sign yaw cancels the rate-leaded redirect command; that restores
    # the full lagged carrier without a clocked maneuver stage.  Partial
    # carrier relief during an active burst leaves tail authority for curvature
    # instead of simply stacking more acceleration on the saturated gait.
    redirect_error = bearing +
        params.redirect_heading_rate_lead * heading_rate
    redirect_command = tanh(redirect_error / params.redirect_error_scale)
    redirect_weight = redirect_gate * abs(redirect_command)
    lagged_carrier = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    carrier_scale = 1 -
        params.redirect_tail_carrier_relief * redirect_weight
    tail_bias = params.redirect_tail_bias_limit * redirect_gate *
        redirect_command
    phase_lag_target = carrier_scale * lagged_carrier + tail_bias
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
