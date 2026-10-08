# Half-cycle steering with approach-conditioned whole-body C-bend recovery.
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
        approach_distance_start=6.0,
        approach_distance_full=4.0,
        approach_error_start=0.65,
        approach_error_full=1.15,
        c_bend_lateral_scale_L=0.25,
        posterior_c_bend_limit=12.0 * pi / 180,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

    # Preserve the evidenced slip-aware anterior center. Folded bearing stays
    # continuous as the target passes abeam; target-side slip unloads the bend.
    bearing = Float64(state.bearing)
    lateral_velocity = Float64(state.velocity_body_U[2])
    route_error = bearing -
        params.lateral_velocity_feedback * lateral_velocity
    turn_request = tanh(route_error / params.steering_bearing_scale)
    geometric_turn = tanh(bearing / params.steering_bearing_scale)

    # The head points along negative body x. Full angle distinguishes genuine
    # alignment from a target passed abeam or behind. Only its magnitude gates
    # authority, avoiding an atan branch jump in the turn direction.
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

    # Retain the live anterior oscillator and phase-selected acceleration
    # residual; the failed one-sided envelope is not carried forward.
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

    # Preserve posterior half-cycle redistribution: retain more lagged carrier
    # on the requested stroke and deepen relief on its cancelling return.
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

    # The evaluated angle-only C-bend created useful yaw but began at the
    # closest miss. Add a middle-approach branch using normalized distance and
    # moderate full error; retain the original high-error branch so recovery
    # does not disappear when distance rises after a miss.
    c_bend_progress = clamp(
        (abs(target_heading_error) - params.c_bend_error_start) /
            max(
                params.c_bend_error_full - params.c_bend_error_start,
                eps(params.c_bend_error_full),
            ),
        0.0,
        1.0,
    )
    high_error_gate =
        c_bend_progress^2 * (3 - 2 * c_bend_progress)

    distance_progress = clamp(
        (params.approach_distance_start - Float64(state.distance_L)) /
            max(
                params.approach_distance_start -
                    params.approach_distance_full,
                eps(params.approach_distance_start),
            ),
        0.0,
        1.0,
    )
    distance_gate =
        distance_progress^2 * (3 - 2 * distance_progress)
    approach_error_progress = clamp(
        (abs(target_heading_error) - params.approach_error_start) /
            max(
                params.approach_error_full -
                    params.approach_error_start,
                eps(params.approach_error_full),
            ),
        0.0,
        1.0,
    )
    approach_error_gate = approach_error_progress^2 *
        (3 - 2 * approach_error_progress)
    approach_gate = distance_gate * approach_error_gate

    # Smooth union: either a developing near miss or persistent large error
    # can recruit the same bounded whole-body shape.
    c_bend_gate = 1 - (1 - high_error_gate) * (1 - approach_gate)
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
