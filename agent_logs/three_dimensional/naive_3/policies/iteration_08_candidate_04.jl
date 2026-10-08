# Slip-triggered anterior half-cycle steering around the demonstrated
# bearing/slip traveling carrier. Beat phase remains in observed joint state.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        turn_curvature_limit=12.0 * pi / 180,
        full_bearing_limit=pi,
        bearing_scale=0.20,
        lateral_velocity_limit=0.8,
        lateral_velocity_feedback=0.45,
        asymmetry_error_on=0.22,
        asymmetry_error_width=0.30,
        head_phase_width=0.20,
        requested_halfcycle_accel_floor=0.35,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

    # The scalar adapter bearing folds the rear half-plane through abs(x).
    # Normalized body-frame geometry preserves the full target quadrant around
    # the head-facing body -x axis.
    target_x = Float64(state.target_body_L[1])
    target_y = Float64(state.target_body_L[2])
    raw_folded_bearing = Float64(state.bearing)
    fallback_bearing = isfinite(raw_folded_bearing) ?
        raw_folded_bearing : 0.0
    raw_full_bearing = isfinite(target_x) && isfinite(target_y) ?
        atan(target_y, -target_x) : fallback_bearing
    full_bearing = clamp(
        raw_full_bearing,
        -params.full_bearing_limit,
        params.full_bearing_limit,
    )

    raw_lateral_velocity = Float64(state.velocity_body_U[2])
    lateral_velocity = isfinite(raw_lateral_velocity) ?
        clamp(
            raw_lateral_velocity,
            -params.lateral_velocity_limit,
            params.lateral_velocity_limit,
        ) : 0.0

    # Body-frame slip exposes the centerline-crossing error before bearing
    # alone grows large. Retain the evidenced posterior mean-curvature map.
    steering_signal = full_bearing -
        params.lateral_velocity_feedback * lateral_velocity
    turn_request = tanh(
        steering_signal / max(params.bearing_scale, eps(Float64)),
    )
    mean_tail_tangent = params.turn_curvature_limit * turn_request

    # Recruit the anterior joint without moving its equilibrium. Under a
    # material request, slow only the half-cycle whose bend has the requested
    # sign. The counter-half-cycle remains the demonstrated carrier and the
    # selected half-cycle retains a nonzero acceleration floor. This creates a
    # bounded duty asymmetry rather than a static C-bend or a larger peak.
    asymmetry_fraction = clamp(
        (abs(steering_signal) - params.asymmetry_error_on) /
        max(params.asymmetry_error_width, eps(Float64)),
        0.0,
        1.0,
    )
    asymmetry_gate = asymmetry_fraction^2 *
        (3.0 - 2.0 * asymmetry_fraction)
    head_side = tanh(
        q1 / max(params.head_phase_width * amp, eps(Float64)),
    )
    requested_side = max(0.0, turn_request * head_side)
    head_accel_scale = 1.0 - asymmetry_gate *
        (1.0 - params.requested_halfcycle_accel_floor) * requested_side

    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    carrier_head_accel = vdp_drive - omega^2 * q1
    a1 = head_accel_scale * carrier_head_accel

    carrier_tail_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    tail_target = mean_tail_tangent + carrier_tail_target
    a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
