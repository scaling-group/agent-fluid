# Turn-demand carrier relief around the strongest sampled lateral-slip policy.
# Large body-frame redirect demand preserves mean tail curvature while smoothly
# yielding posterior wave authority; alignment restores the full carrier.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        turn_curvature_limit=12.0 * pi / 180,
        bearing_limit=pi / 2,
        bearing_scale=0.20,
        lateral_velocity_limit=0.8,
        lateral_velocity_feedback=0.45,
        turn_carrier_relief=0.50,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

    # Preserve the demonstrated zero-centered joint-state propulsion rhythm.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1

    raw_bearing = Float64(state.bearing)
    raw_lateral_velocity = Float64(state.velocity_body_U[2])
    bearing = isfinite(raw_bearing) ?
        clamp(raw_bearing, -params.bearing_limit, params.bearing_limit) : 0.0
    lateral_velocity = isfinite(raw_lateral_velocity) ?
        clamp(
            raw_lateral_velocity,
            -params.lateral_velocity_limit,
            params.lateral_velocity_limit,
        ) : 0.0

    # Retain the sampled controller's target-relative slip residual. Motion
    # across the requested side strengthens the correction before bearing alone
    # accumulates a large error.
    steering_signal = bearing -
        params.lateral_velocity_feedback * lateral_velocity
    turn_command = tanh(
        steering_signal / max(params.bearing_scale, eps(Float64)),
    )
    mean_tail_tangent = params.turn_curvature_limit * turn_command

    # Reallocate, rather than increase, posterior authority. Squared demand
    # leaves the full traveling carrier at alignment and smoothly retains at
    # least (1-relief) of it during a hard redirect. The mean bend is not
    # attenuated, so it occupies more of the available tail motion precisely
    # when the sampled trajectory showed saturated but delayed recovery.
    carrier_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    turn_demand = clamp(turn_command * turn_command, 0.0, 1.0)
    carrier_multiplier = 1.0 - params.turn_carrier_relief * turn_demand
    tail_target = mean_tail_tangent + carrier_multiplier * carrier_target
    a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
