# Full-angle carrier with a target-gated posterior reactive rudder and
# translation-alignment terminal steering relief.

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
        rudder_distance_start_L=8.0,
        rudder_distance_full_L=5.5,
        rudder_error_start=0.35,
        rudder_error_full=0.90,
        rudder_lateral_scale_L=0.25,
        posterior_rudder_limit=16.0 * pi / 180,
        alignment_distance_start_L=1.5,
        alignment_distance_full_L=1.0,
        translation_alignment_start=0.50,
        translation_alignment_full=0.0,
        rudder_alignment_relief=0.20,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

    # Preserve the evidenced slip-aware anterior center. Folded bearing is a
    # stable reflection-equivariant left/right signal while the target is in
    # front; target-side lateral motion unloads the requested bend.
    bearing = Float64(state.bearing)
    lateral_velocity = Float64(state.velocity_body_U[2])
    route_error = bearing -
        params.lateral_velocity_feedback * lateral_velocity
    turn_request = tanh(route_error / params.steering_bearing_scale)

    # The head points along negative body x. Full angle prevents a target
    # passed abeam or behind from looking aligned, while the lateral component
    # supplies a continuous turn sign across the rear-axis branch.
    target_forward = -Float64(state.target_body_L[1])
    target_lateral = Float64(state.target_body_L[2])
    target_error = atan(target_lateral, target_forward)
    geometric_turn = tanh(
        target_lateral / params.rudder_lateral_scale_L,
    )

    redirect_progress = clamp(
        (abs(target_error) - params.redirect_error_start) /
            max(
                params.redirect_error_full -
                    params.redirect_error_start,
                eps(params.redirect_error_full),
            ),
        0.0,
        1.0,
    )
    redirect_gate = redirect_progress^2 * (3 - 2 * redirect_progress)

    # Retain the sampled anterior-only curvature center and large-error
    # half-cycle residual. Oscillator phase comes only from joint state.
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

    # Preserve the inherited phase-selective posterior carrier: more of the
    # target-side stroke and less of its cancelling return at large error.
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

    # The completed same-sign C-bend produced the wrong mean yaw. Use its
    # measured response to select the opposite posterior load sign. Distance
    # and error gates recruit the rudder before abeam, then remove it smoothly
    # on alignment without suppressing the traveling carrier.
    distance_progress = clamp(
        (params.rudder_distance_start_L - Float64(state.distance_L)) /
            max(
                params.rudder_distance_start_L -
                    params.rudder_distance_full_L,
                eps(params.rudder_distance_start_L),
            ),
        0.0,
        1.0,
    )
    distance_gate = distance_progress^2 * (3 - 2 * distance_progress)
    rudder_error_progress = clamp(
        (abs(target_error) - params.rudder_error_start) /
            max(
                params.rudder_error_full - params.rudder_error_start,
                eps(params.rudder_error_full),
            ),
        0.0,
        1.0,
    )
    rudder_error_gate =
        rudder_error_progress^2 * (3 - 2 * rudder_error_progress)

    # The inherited one-step head-distance response is beat-sensitive. Replace
    # it with center translation projected onto the instantaneous target unit
    # vector. This dimensionless alignment distinguishes useful approach from
    # increasingly transverse motion without changing the rhythmic carrier.
    body_x_velocity = Float64(state.velocity_body_U[1])
    translation_speed = hypot(body_x_velocity, lateral_velocity)
    target_vector_norm = hypot(target_forward, target_lateral)
    translation_alignment = clamp(
        (
            -target_forward * body_x_velocity +
                target_lateral * lateral_velocity
        ) / max(
            translation_speed * target_vector_norm,
            eps(target_vector_norm),
        ),
        -1.0,
        1.0,
    )
    alignment_progress = clamp(
        (params.translation_alignment_start - translation_alignment) /
            max(
                params.translation_alignment_start -
                    params.translation_alignment_full,
                eps(params.translation_alignment_start),
            ),
        0.0,
        1.0,
    )
    alignment_gate =
        alignment_progress^2 * (3 - 2 * alignment_progress)
    alignment_distance_progress = clamp(
        (
            params.alignment_distance_start_L -
                Float64(state.distance_L)
        ) /
            max(
                params.alignment_distance_start_L -
                    params.alignment_distance_full_L,
                eps(params.alignment_distance_start_L),
            ),
        0.0,
        1.0,
    )
    alignment_distance_gate = alignment_distance_progress^2 *
        (3 - 2 * alignment_distance_progress)
    rudder_authority = 1 - params.rudder_alignment_relief *
        alignment_distance_gate * alignment_gate
    posterior_rudder = -params.posterior_rudder_limit *
        rudder_authority * distance_gate * rudder_error_gate *
        geometric_turn

    lagged_carrier = -carrier_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    phase_lag_target = tail_carrier_scale * lagged_carrier +
        posterior_rudder
    a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
