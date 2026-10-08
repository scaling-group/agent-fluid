# Response-unloaded anterior mean-curvature steering around a state-feedback
# traveling-bend carrier. Oscillator phase remains encoded in joint state.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        steering_bearing_scale=0.25,
        lateral_velocity_feedback=1.2,
        yaw_response_gain=0.35,
        yaw_rate_scale=1.0,
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

    # Body-frame target geometry supplies the slow route request. Target-side
    # lateral velocity unloads the bend, while wrong-side slip strengthens it.
    bearing = Float64(state.bearing)
    lateral_velocity = Float64(state.velocity_body_U[2])
    route_error = bearing -
        params.lateral_velocity_feedback * lateral_velocity
    bearing_turn = tanh(route_error / params.steering_bearing_scale)

    # Positive curvature produces negative yaw for this head-at-negative-x
    # convention. A bounded recent-yaw residual therefore holds full authority
    # against wrong-sign yaw and releases part of it once the requested yaw is
    # developing. Scaling by route magnitude removes the residual on course.
    yaw_response = tanh(
        Float64(state.turn_rate_recent) / params.yaw_rate_scale,
    )
    turn_request = clamp(
        bearing_turn +
            params.yaw_response_gain * abs(bearing_turn) * yaw_response,
        -1.0,
        1.0,
    )

    # Move only the anterior oscillator center. The mean bend remains ungated
    # by distance or bearing magnitude because sampled bearing-gated handoffs
    # retained the early upper-boundary exit.
    curvature_center = params.curvature_bias_limit * turn_request
    carrier_q1 = q1 - curvature_center
    vdp_drive = params.oscillator_mu *
        (1 - (carrier_q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * carrier_q1

    # Remove the anterior mean from the posterior target. Steering stays at the
    # anterior joint while the tail preserves the evidenced zero-mean lagged
    # traveling wave instead of receiving a second redirect command.
    phase_lag_target = -carrier_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
