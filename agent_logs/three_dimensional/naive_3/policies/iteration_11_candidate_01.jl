# Full-quadrant, receding-gated burst redirect around the demonstrated
# bearing/slip traveling carrier. Every gate is instantaneous body-frame state.

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
        burst_bearing_on=0.75,
        burst_bearing_width=0.35,
        receding_speed_scale=0.25,
        burst_head_curvature=14.0 * pi / 180,
        burst_tail_curvature=8.0 * pi / 180,
        burst_carrier_floor=0.30,
        burst_head_damping=0.20,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

    # The adapter's scalar bearing folds the rear half-plane through abs(x).
    # Measure around the head-facing body -x axis so a passed target retains
    # its signed error without any world direction or route information.
    raw_target_x = Float64(state.target_body_L[1])
    raw_target_y = Float64(state.target_body_L[2])
    target_x = isfinite(raw_target_x) ? raw_target_x : -1.0
    target_y = isfinite(raw_target_y) ? raw_target_y : 0.0
    raw_full_bearing = atan(target_y, -target_x)
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
    steering_signal = full_bearing -
        params.lateral_velocity_feedback * lateral_velocity
    turn_request = tanh(
        steering_signal / max(params.bearing_scale, eps(Float64)),
    )

    # Project body velocity onto the body-frame target vector. Positive values
    # are target-closing; negative values identify the failed post-pass escape
    # without a noisy derivative, timer, or stored controller mode.
    raw_forward_velocity = Float64(state.velocity_body_U[1])
    forward_velocity = isfinite(raw_forward_velocity) ?
        raw_forward_velocity : 0.0
    target_distance = hypot(target_x, target_y)
    radial_closing = target_distance > eps(Float64) ?
        (forward_velocity * target_x + lateral_velocity * target_y) /
            target_distance : 0.0
    receding_fraction = clamp(
        -radial_closing / max(params.receding_speed_scale, eps(Float64)),
        0.0,
        1.0,
    )
    receding_gate = receding_fraction^2 *
        (3.0 - 2.0 * receding_fraction)

    # The burst is absent throughout the evidenced target-closing approach.
    # Large angular error plus receding motion recruits a bounded distributed
    # coil; restored radial closing immediately releases it back to the carrier.
    error_fraction = clamp(
        (abs(full_bearing) - params.burst_bearing_on) /
        max(params.burst_bearing_width, eps(Float64)),
        0.0,
        1.0,
    )
    error_gate = error_fraction^2 * (3.0 - 2.0 * error_fraction)
    burst_gate = error_gate * receding_gate

    head_center = params.burst_head_curvature * turn_request * burst_gate
    centered_q1 = q1 - head_center
    vdp_drive = params.oscillator_mu *
        (1 - (centered_q1 / amp)^2) * qd1
    burst_damping = 2 * params.burst_head_damping * omega *
        burst_gate * qd1
    a1 = vdp_drive - omega^2 * centered_q1 - burst_damping

    # Retain the sampled posterior mean curvature. During a receding burst,
    # add bounded same-sign tail curvature and yield most of the oscillatory
    # component to the coil; full lagged propulsion returns when closing does.
    mean_tail_tangent = params.turn_curvature_limit * turn_request
    burst_tail_tangent = params.burst_tail_curvature *
        turn_request * burst_gate
    carrier_scale = 1.0 - burst_gate *
        (1.0 - params.burst_carrier_floor)
    carrier_tail_target = -centered_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    tail_target = mean_tail_tangent + burst_tail_tangent +
        carrier_scale * carrier_tail_target
    a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
