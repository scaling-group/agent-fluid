# Slip-aware anterior mean-curvature steering with a bearing-gated posterior
# carrier relief. Oscillator phase remains encoded only in observed joint state.

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
        tail_relief_bearing_start=0.45,
        tail_relief_bearing_full=0.90,
        tail_carrier_relief=0.65,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Positive bearing requests the positive bend side, which produces
    # negative yaw for this head-at-negative-x body convention. Positive
    # body-frame lateral motion is already target-side motion, so it unloads
    # that request; wrong-side slip strengthens the correction.
    bearing = Float64(state.bearing)
    lateral_velocity = Float64(state.velocity_body_U[2])
    route_error = bearing -
        params.lateral_velocity_feedback * lateral_velocity
    turn_request = tanh(route_error / params.steering_bearing_scale)

    # Preserve the strongest sampled policy's anterior-only moving center. The
    # oscillatory coordinate, rather than the full biased angle, drives the
    # posterior wave so steering does not create an opposite tail mean.
    curvature_center = params.curvature_bias_limit * turn_request
    carrier_q1 = q1 - curvature_center
    vdp_drive = params.oscillator_mu *
        (1 - (carrier_q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * carrier_q1

    # Large geometric bearing marks the sampled miss regime. Smoothly reduce
    # posterior thrust there so the bounded anterior curvature can redirect
    # the body. Falling bearing restores the full carrier without a clock or a
    # hidden maneuver stage.
    relief_progress = clamp(
        (abs(bearing) - params.tail_relief_bearing_start) /
            max(
                params.tail_relief_bearing_full -
                    params.tail_relief_bearing_start,
                eps(params.tail_relief_bearing_full),
            ),
        0.0,
        1.0,
    )
    relief_gate = relief_progress^2 * (3 - 2 * relief_progress)
    tail_carrier_scale = 1 - params.tail_carrier_relief * relief_gate

    lagged_carrier = -carrier_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    phase_lag_target = tail_carrier_scale * lagged_carrier
    a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
