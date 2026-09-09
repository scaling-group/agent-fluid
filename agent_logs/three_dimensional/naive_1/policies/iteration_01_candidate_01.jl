# State-feedback traveling bend with bounded target-directed mean curvature.
# Phase remains encoded in joint state; no clock, route, or world coordinate is
# used. Positive bend bias follows the measured 3D sign convention and produces
# negative yaw when the target lies on the positive body-frame lateral side.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        steering_bias_limit=8.0 * pi / 180,
        steering_bearing_scale=0.22,
        lateral_slip_weight=0.18,
        lateral_slip_scale=0.35,
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

    # Convert normalized body-frame route error into a bounded mean bend. The
    # slip term relieves steering when lateral motion is already closing the
    # error and strengthens it when the fish is sliding away from the target.
    bearing = clamp(Float64(state.bearing), -1.0, 1.0)
    lateral_slip = tanh(
        Float64(state.velocity_body_U[2]) /
        max(params.lateral_slip_scale, eps(Float64)),
    )
    turn_error = bearing - params.lateral_slip_weight * lateral_slip
    turn_request = tanh(
        turn_error / max(params.steering_bearing_scale, eps(Float64)),
    )
    mean_bias = params.steering_bias_limit * turn_request

    # Van der Pol drive about the requested curvature: oscillation phase still
    # lives entirely in (q1, qd1), while the target only shifts its center.
    centered_q1 = q1 - mean_bias
    vdp_drive = params.oscillator_mu * (1 - (centered_q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * centered_q1

    # Preserve the seed's posterior lag and emphasis around a compatible tail
    # bias, so steering does not replace the propulsive traveling bend.
    phase_lag_target = params.tail_bias_ratio * mean_bias - centered_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
