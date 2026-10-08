# Whole-body half-cycle steering with a near-target one-sided oscillator
# envelope. All scheduling uses normalized body-frame observations.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        steering_error_scale=0.25,
        lateral_velocity_feedback=1.2,
        curvature_bias_limit=8.0 * pi / 180,
        redirect_error_start=0.45,
        redirect_error_full=0.90,
        redirect_acceleration_limit=16.0,
        phase_velocity_limit=1.0,
        tail_carrier_relief=0.65,
        tail_stroke_asymmetry=0.30,
        stroke_transition_scale=0.20,
        envelope_distance_start=5.0,
        envelope_distance_full=3.5,
        envelope_shift_limit=8.0 * pi / 180,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    base_amplitude = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

    # The head points along negative body x. The full signed angle preserves
    # the axial sign, so passing a target abeam is not false alignment.
    target_forward = -Float64(state.target_body_L[1])
    target_lateral = Float64(state.target_body_L[2])
    target_error = atan(target_lateral, target_forward)
    geometric_turn = tanh(target_error / params.steering_error_scale)

    # Target-side lateral velocity unloads the cruise center; wrong-side slip
    # strengthens it. Geometry alone sets the maneuver direction.
    lateral_velocity = Float64(state.velocity_body_U[2])
    route_error = target_error -
        params.lateral_velocity_feedback * lateral_velocity
    turn_request = tanh(route_error / params.steering_error_scale)

    redirect_progress = clamp(
        (abs(target_error) - params.redirect_error_start) /
            max(
                params.redirect_error_full - params.redirect_error_start,
                eps(params.redirect_error_full),
            ),
        0.0,
        1.0,
    )
    redirect_gate = redirect_progress^2 * (3 - 2 * redirect_progress)

    # Reshape the oscillator only in the evidenced near-miss region. Shifting
    # its center and shrinking its amplitude by the same angle preserves the
    # target-side excursion while removing part of the cancelling excursion.
    distance_progress = clamp(
        (params.envelope_distance_start - Float64(state.distance_L)) /
            max(
                params.envelope_distance_start -
                    params.envelope_distance_full,
                eps(params.envelope_distance_start),
            ),
        0.0,
        1.0,
    )
    proximity_gate =
        distance_progress^2 * (3 - 2 * distance_progress)
    envelope_gate = redirect_gate * proximity_gate
    envelope_shift = params.envelope_shift_limit * envelope_gate

    curvature_center =
        params.curvature_bias_limit * turn_request +
        envelope_shift * geometric_turn
    carrier_q1 = q1 - curvature_center
    active_amplitude = max(
        base_amplitude - envelope_shift,
        eps(base_amplitude),
    )

    # Keep the state-feedback oscillator alive throughout the maneuver. As the
    # one-sided envelope takes over, retire the already saturated acceleration
    # residual rather than stacking more authority on it.
    vdp_drive = params.oscillator_mu *
        (1 - (carrier_q1 / active_amplitude)^2) * qd1
    phase_speed = clamp(
        abs(qd1) / max(omega * base_amplitude, eps(omega * base_amplitude)),
        0.0,
        params.phase_velocity_limit,
    )
    anterior_redirect = params.redirect_acceleration_limit *
        redirect_gate * (1 - envelope_gate) *
        geometric_turn * phase_speed
    a1 = vdp_drive - omega^2 * carrier_q1 + anterior_redirect

    # Preserve the sampled posterior half-cycle redistribution without the
    # failed terminal trial's extra unloading. Joint rate remains the only
    # oscillator-phase signal, and the lagged carrier retains zero static mean.
    normalized_stroke_rate = geometric_turn * qd1 /
        max(omega * base_amplitude, eps(omega * base_amplitude))
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

    lagged_carrier = -carrier_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    phase_lag_target = tail_carrier_scale * lagged_carrier
    a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
