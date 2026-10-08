# Rear-aware whole-body steering with curvature-phase posterior power-stroke
# selection. Joint state supplies phase; normalized target geometry controls
# maneuver recruitment and release.

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
        redirect_error_start=0.45,
        redirect_error_full=0.90,
        redirect_acceleration_limit=16.0,
        phase_velocity_limit=1.0,
        tail_carrier_relief=0.65,
        tail_stroke_asymmetry=0.30,
        curvature_transition_scale=0.25,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

    # Folded bearing is a continuous reflection-equivariant left/right
    # signal. Target-side lateral motion unloads the anterior center while
    # wrong-side slip strengthens it.
    bearing = Float64(state.bearing)
    lateral_velocity = Float64(state.velocity_body_U[2])
    route_error = bearing -
        params.lateral_velocity_feedback * lateral_velocity
    turn_request = tanh(route_error / params.steering_bearing_scale)
    geometric_turn = tanh(bearing / params.steering_bearing_scale)

    # This body's head points along negative body x. Full target angle keeps
    # authority active after the target passes abeam; its magnitude alone
    # gates the maneuver so the atan branch on the rear axis cannot flip the
    # requested turn sign.
    target_forward = -Float64(state.target_body_L[1])
    target_lateral = Float64(state.target_body_L[2])
    target_heading_error = atan(target_lateral, target_forward)
    redirect_progress = clamp(
        (abs(target_heading_error) - params.redirect_error_start) /
            max(
                params.redirect_error_full -
                    params.redirect_error_start,
                eps(params.redirect_error_full),
            ),
        0.0,
        1.0,
    )
    redirect_gate = redirect_progress^2 * (3 - 2 * redirect_progress)

    # Preserve the evidenced anterior-only moving center and autonomous
    # traveling carrier. The bounded phase residual adds work while q1 moves
    # into the requested bend and brakes the cancelling return stroke.
    curvature_center = params.curvature_bias_limit * turn_request
    carrier_q1 = q1 - curvature_center
    vdp_drive = params.oscillator_mu *
        (1 - (carrier_q1 / amp)^2) * qd1
    phase_speed = clamp(
        abs(qd1) / max(omega * amp, eps(omega * amp)),
        0.0,
        params.phase_velocity_limit,
    )
    anterior_redirect = params.redirect_acceleration_limit *
        redirect_gate * geometric_turn * phase_speed
    a1 = vdp_drive - omega^2 * carrier_q1 + anterior_redirect

    # Select posterior power by formed body shape rather than by anterior
    # velocity. More lagged carrier is retained on the target-bent half-cycle;
    # the opposite shape is relieved. This quarter-cycle change tests whether
    # posterior force then contributes a net turn instead of cancelling over
    # the beat. Alignment restores the symmetric zero-mean traveling wave.
    target_signed_shape = geometric_turn * carrier_q1 /
        max(amp, eps(amp))
    useful_shape_gate = 0.5 * (
        1 + tanh(
            target_signed_shape / params.curvature_transition_scale,
        )
    )
    symmetric_tail_scale = 1 -
        params.tail_carrier_relief * redirect_gate
    tail_carrier_scale = clamp(
        symmetric_tail_scale +
            params.tail_stroke_asymmetry * redirect_gate *
            (2 * useful_shape_gate - 1),
        0.0,
        1.0,
    )

    lagged_carrier = -carrier_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    phase_lag_target = tail_carrier_scale * lagged_carrier
    a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
