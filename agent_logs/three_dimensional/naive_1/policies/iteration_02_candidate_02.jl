# Response-damped target steering around a state-feedback traveling bend.
# Phase remains encoded in joint state; no clock, route, world coordinate, or
# prescribed vortex phase is used. The shared-bias sign follows the completed
# shared-bias rollouts rather than a posterior-only steering calibration.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        steering_bias_limit=8.0 * pi / 180,
        steering_bearing_scale=0.30,
        yaw_response_weight=0.16,
        yaw_rate_scale=1.5,
        tail_bias_ratio=0.8,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Positive shared bias produced sustained positive yaw in the sampled
    # 8:6.4-degree candidate. Reverse that measured actuator sign so positive
    # body-frame bearing requests negative shared curvature. A bounded yaw
    # response releases the request as the desired negative turn develops;
    # tanh prevents beat-scale rate spikes from becoming acceleration spikes.
    bearing = clamp(Float64(state.bearing), -1.0, 1.0)
    yaw_response = tanh(
        Float64(state.turn_rate_recent) /
        max(params.yaw_rate_scale, eps(Float64)),
    )
    turn_error = bearing + params.yaw_response_weight * yaw_response
    turn_request = tanh(
        turn_error / max(params.steering_bearing_scale, eps(Float64)),
    )
    mean_bias = -params.steering_bias_limit * turn_request

    # Run the Van der Pol carrier around the requested mean curvature; its
    # phase still lives entirely in (q1, qd1).
    centered_q1 = q1 - mean_bias
    vdp_drive = params.oscillator_mu * (1 - (centered_q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * centered_q1

    # Preserve the seed's posterior lag around the compatible 8:6.4 shared
    # bias distribution that retained a coherent three-dimensional wake.
    phase_lag_target = params.tail_bias_ratio * mean_bias - centered_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
