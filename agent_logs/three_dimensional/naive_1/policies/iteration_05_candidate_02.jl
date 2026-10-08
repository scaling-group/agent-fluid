# Target-signed slip unloading around an anterior mean-curvature carrier.
# Target geometry owns turn direction; gait-scale lateral velocity can only
# release an existing request, never reverse or amplify it.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        steering_bearing_scale=0.25,
        lateral_velocity_feedback=1.2,
        curvature_bias_limit=8.0 * pi / 180,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Bearing is the slow body-frame route signal. Only velocity already
    # directed toward the requested side may unload its magnitude. Opposing
    # beat-scale velocity is ignored instead of being mistaken for more route
    # error, and unloading is not allowed to flip the target-defined sign.
    bearing = Float64(state.bearing)
    lateral_velocity = Float64(state.velocity_body_U[2])
    target_side = sign(bearing)
    target_side_velocity = max(0.0, target_side * lateral_velocity)
    remaining_bearing = max(
        0.0,
        abs(bearing) -
            params.lateral_velocity_feedback * target_side_velocity,
    )
    route_error = target_side * remaining_bearing
    turn_request = tanh(route_error / params.steering_bearing_scale)

    # Preserve the strongest sampled policy's bounded anterior moving center.
    # The self-excited carrier remains the displacement about that center.
    curvature_center = params.curvature_bias_limit * turn_request
    carrier_q1 = q1 - curvature_center
    vdp_drive = params.oscillator_mu *
        (1 - (carrier_q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * carrier_q1

    # Steering does not enter the posterior mean. The tail retains only the
    # centered sign reversal, observed-state phase lag, and damping that made
    # the inherited coherent traveling wake.
    phase_lag_target = -carrier_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
