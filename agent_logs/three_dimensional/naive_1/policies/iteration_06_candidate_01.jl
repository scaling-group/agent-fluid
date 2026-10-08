# Geometry-gated C-bend redirect around a state-feedback traveling carrier.
# Large bearing trades carrier amplitude for anterior curvature; alignment
# continuously restores the zero-mean posterior traveling wave.

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
        redirect_bearing_start=0.45,
        redirect_bearing_full=1.05,
        redirect_curvature_addition=16.0 * pi / 180,
        redirect_carrier_min_scale=0.25,
        carrier_shape_limit=2.0,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Target geometry is the slow route signal. Target-side lateral motion
    # unloads the request, while wrong-side slip strengthens it.
    bearing = Float64(state.bearing)
    lateral_velocity = Float64(state.velocity_body_U[2])
    route_error = bearing -
        params.lateral_velocity_feedback * lateral_velocity
    turn_request = tanh(route_error / params.steering_bearing_scale)

    # Smoothly recruit a compact C-bend gait only after cruise curvature is
    # evidently insufficient. This is released by alignment, not by a clock.
    redirect_progress = clamp(
        (abs(bearing) - params.redirect_bearing_start) /
            max(
                params.redirect_bearing_full -
                    params.redirect_bearing_start,
                eps(params.redirect_bearing_full),
            ),
        0.0,
        1.0,
    )
    redirect_gate = redirect_progress^2 * (3 - 2 * redirect_progress)
    curvature_limit = params.curvature_bias_limit +
        params.redirect_curvature_addition * redirect_gate
    curvature_center = curvature_limit * turn_request

    # During redirect, shrink the self-excited carrier about the stronger
    # center. Limiting only the shaping coordinate avoids a damping spike while
    # the moving equilibrium is being recruited.
    carrier_scale = 1 -
        (1 - params.redirect_carrier_min_scale) * redirect_gate
    carrier_amp = max(amp * carrier_scale, eps(amp))
    carrier_q1 = q1 - curvature_center
    shaped_carrier = clamp(
        carrier_q1 / carrier_amp,
        -params.carrier_shape_limit,
        params.carrier_shape_limit,
    )
    vdp_drive = params.oscillator_mu *
        (1 - shaped_carrier^2) * qd1
    a1 = vdp_drive - omega^2 * carrier_q1

    # The posterior joint receives no steering mean. Scaling the centered
    # lagged carrier yields thrust during cruise and lets curvature dominate
    # during the large-bearing redirect.
    lagged_carrier = -carrier_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    phase_lag_target = carrier_scale * lagged_carrier
    a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
