# Target-gated anterior burst curvature with a centered, relieved posterior
# carrier. Oscillator phase remains encoded only in observed joint state.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        steering_error_scale=0.25,
        lateral_velocity_feedback=1.2,
        cruise_curvature_limit=8.0 * pi / 180,
        burst_curvature_limit=20.0 * pi / 180,
        burst_error_start=0.45,
        burst_error_full=0.90,
        burst_carrier_compression=0.50,
        tail_carrier_relief=0.65,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    cruise_amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # The head points along negative body x. The full angle distinguishes true
    # alignment from a target that has passed abeam, while normalized lateral
    # geometry supplies a continuous reflection-equivariant turn sign.
    target_forward = -Float64(state.target_body_L[1])
    target_lateral = Float64(state.target_body_L[2])
    distance = max(hypot(target_forward, target_lateral), eps(Float64))
    target_heading_error = atan(target_lateral, target_forward)
    lateral_target = target_lateral / distance
    geometric_turn = tanh(
        lateral_target / params.steering_error_scale,
    )

    burst_progress = clamp(
        (abs(target_heading_error) - params.burst_error_start) /
            max(
                params.burst_error_full - params.burst_error_start,
                eps(params.burst_error_full),
            ),
        0.0,
        1.0,
    )
    burst_gate = burst_progress^2 * (3 - 2 * burst_progress)

    # Retain the evidenced slip-aware cruise center at small target error.
    # During a large-error burst, geometry takes over from beat-scale slip and
    # shifts the anterior angle/rate envelope toward a sustained turn posture.
    bearing = Float64(state.bearing)
    lateral_velocity = Float64(state.velocity_body_U[2])
    route_error = bearing -
        params.lateral_velocity_feedback * lateral_velocity
    cruise_turn = tanh(route_error / params.steering_error_scale)
    cruise_center = params.cruise_curvature_limit * cruise_turn
    burst_center = params.burst_curvature_limit * geometric_turn
    curvature_center =
        (1 - burst_gate) * cruise_center + burst_gate * burst_center

    # Compress, rather than extinguish, the centered carrier as curvature
    # grows. At full burst the selected center plus carrier amplitude remains
    # inside the joint-angle envelope, leaving room for state feedback instead
    # of requesting a clipped phase-selective acceleration.
    carrier_scale = 1 -
        params.burst_carrier_compression * burst_gate
    carrier_amp = max(carrier_scale * cruise_amp, eps(cruise_amp))
    carrier_q1 = q1 - curvature_center
    vdp_drive = params.oscillator_mu *
        (1 - (carrier_q1 / carrier_amp)^2) * qd1
    a1 = vdp_drive - omega^2 * carrier_q1

    # Keep steering out of the posterior mean. The tail follows only the
    # centered anterior oscillation and smoothly yields during the burst; true
    # alignment restores the full lagged propulsive carrier.
    tail_carrier_scale = 1 -
        params.tail_carrier_relief * burst_gate
    lagged_carrier = -carrier_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    phase_lag_target = tail_carrier_scale * lagged_carrier
    a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
