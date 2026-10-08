# Target-gated posterior duty-ratio steering around an anterior
# mean-curvature carrier. Oscillator phase remains in observed joint state.

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
        duty_handoff_bearing_start=0.45,
        duty_handoff_bearing_full=0.90,
        stroke_transition_scale=0.20,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Body-frame target geometry supplies the slow route request. Target-side
    # lateral velocity unloads the bend; wrong-side slip strengthens it.
    bearing = Float64(state.bearing)
    lateral_velocity = Float64(state.velocity_body_U[2])
    route_error = bearing -
        params.lateral_velocity_feedback * lateral_velocity
    turn_request = tanh(route_error / params.steering_bearing_scale)

    # Steering moves only the anterior oscillator center. The centered
    # coordinate, rather than the full biased angle, drives the posterior wave
    # so the posterior target has no imposed static steering mean.
    curvature_center = params.curvature_bias_limit * turn_request
    carrier_q1 = q1 - curvature_center
    vdp_drive = params.oscillator_mu *
        (1 - (carrier_q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * carrier_q1

    # Large geometric bearing hands the posterior carrier from symmetric
    # propulsion to a steering duty ratio. Observed anterior rate identifies
    # gait phase: retain the full target-turning half-stroke and smoothly
    # suppress only the cancelling return stroke. Alignment restores the
    # symmetric carrier continuously, without a clock or hidden maneuver state.
    handoff_progress = clamp(
        (abs(bearing) - params.duty_handoff_bearing_start) /
            max(
                params.duty_handoff_bearing_full -
                    params.duty_handoff_bearing_start,
                eps(params.duty_handoff_bearing_full),
            ),
        0.0,
        1.0,
    )
    handoff_gate = handoff_progress^2 * (3 - 2 * handoff_progress)

    geometric_turn = tanh(bearing / params.steering_bearing_scale)
    normalized_stroke_rate = geometric_turn * qd1 /
        max(omega * amp, eps(omega * amp))
    useful_stroke_gate = 0.5 * (
        1 + tanh(
            normalized_stroke_rate / params.stroke_transition_scale,
        )
    )
    tail_carrier_scale = 1 -
        handoff_gate * (1 - useful_stroke_gate)

    lagged_carrier = -carrier_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    phase_lag_target = tail_carrier_scale * lagged_carrier
    a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
