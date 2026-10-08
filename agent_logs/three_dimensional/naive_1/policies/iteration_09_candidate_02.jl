# Rear-aware half-cycle steering with a large-error whole-body C-bend.
# Joint state supplies carrier phase; normalized target geometry controls both
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
        stroke_transition_scale=0.20,
        c_bend_error_start=1.35,
        c_bend_error_full=1.75,
        c_bend_lateral_scale_L=0.25,
        posterior_c_bend_limit=12.0 * pi / 180,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Preserve the evidenced slip-aware anterior center. Folded bearing is a
    # continuous reflection-equivariant left/right signal even when a target
    # crosses the rear body axis; target-side slip unloads the bend.
    bearing = Float64(state.bearing)
    lateral_velocity = Float64(state.velocity_body_U[2])
    route_error = bearing -
        params.lateral_velocity_feedback * lateral_velocity
    turn_request = tanh(route_error / params.steering_bearing_scale)
    geometric_turn = tanh(bearing / params.steering_bearing_scale)

    # The head points along negative body x. Full target angle distinguishes
    # genuine alignment from a target passed abeam or behind. Its magnitude
    # controls authority so the atan rear-axis branch cannot jump a command.
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

    # Keep the inherited anterior-only center and large-error half-cycle
    # residual. Steering remains outside the posterior carrier's static mean.
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

    # Retain more lagged carrier on the requested stroke and deepen relief on
    # its cancelling return. Full-angle gating prevents false release abeam.
    normalized_stroke_rate = geometric_turn * qd1 /
        max(omega * amp, eps(omega * amp))
    useful_stroke_gate = 0.5 * (
        1 + tanh(
            normalized_stroke_rate / params.stroke_transition_scale,
        )
    )
    symmetric_tail_scale = 1 -
        params.tail_carrier_relief * redirect_gate
    tail_carrier_scale = clamp(
        symmetric_tail_scale +
            params.tail_stroke_asymmetry * redirect_gate *
            (2 * useful_stroke_gate - 1),
        0.0,
        1.0,
    )

    # The inherited full-angle half-cycle maneuver retained opposite joint
    # means and nearly zero net yaw after abeam. Recruit a distinct C-bend only
    # beyond that sampled near-miss regime: the posterior target takes the
    # same sign as the anterior request, then vanishes smoothly on alignment.
    c_bend_progress = clamp(
        (abs(target_heading_error) - params.c_bend_error_start) /
            max(
                params.c_bend_error_full - params.c_bend_error_start,
                eps(params.c_bend_error_full),
            ),
        0.0,
        1.0,
    )
    c_bend_gate = c_bend_progress^2 * (3 - 2 * c_bend_progress)
    c_bend_direction = tanh(
        target_lateral / params.c_bend_lateral_scale_L,
    )
    posterior_c_bend = params.posterior_c_bend_limit *
        c_bend_gate * c_bend_direction

    lagged_carrier = -carrier_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    phase_lag_target = tail_carrier_scale * lagged_carrier +
        posterior_c_bend
    a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
