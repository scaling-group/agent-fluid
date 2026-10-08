# Half-stroke-selective posterior authority plus a response-released anterior
# counter-yaw pulse. Oscillator phase remains encoded only in observed state.

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
        tail_relief_bearing_start=0.45,
        tail_relief_bearing_full=0.90,
        tail_carrier_relief=0.65,
        tail_stroke_asymmetry=0.30,
        stroke_transition_scale=0.20,
        counter_yaw_acceleration_limit=16.0,
        yaw_response_scale=0.80,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Positive bearing requests the positive bend side, which produces
    # negative yaw for this head-at-negative-x body convention. Target-side
    # lateral velocity unloads the bend; wrong-side slip strengthens it.
    bearing = Float64(state.bearing)
    lateral_velocity = Float64(state.velocity_body_U[2])
    route_error = bearing -
        params.lateral_velocity_feedback * lateral_velocity
    turn_request = tanh(route_error / params.steering_bearing_scale)
    geometric_turn = tanh(bearing / params.steering_bearing_scale)

    # Move only the anterior oscillator center. The oscillatory coordinate,
    # not the full biased angle, drives the posterior wave, keeping steering
    # out of the posterior mean.
    curvature_center = params.curvature_bias_limit * turn_request
    carrier_q1 = q1 - curvature_center
    vdp_drive = params.oscillator_mu *
        (1 - (carrier_q1 / amp)^2) * qd1
    base_a1 = vdp_drive - omega^2 * carrier_q1

    # Large bearing activates the evidenced posterior relief. Within that
    # regime, normalized joint rate identifies the half-stroke. Redistribute
    # the symmetric relief's mean carrier authority toward motion into the
    # requested bend and away from the cancelling return stroke. Smooth gates
    # avoid a clock, phase state, or acceleration discontinuity and restore
    # symmetric cruise on course.
    relief_progress = clamp(
        (abs(bearing) - params.tail_relief_bearing_start) /
            max(
                params.tail_relief_bearing_full -
                    params.tail_relief_bearing_start,
                eps(params.tail_relief_bearing_full),
            ),
        0.0,
        1.0,
    )
    relief_gate = relief_progress^2 * (3 - 2 * relief_progress)

    normalized_stroke_rate = turn_request * qd1 /
        max(omega * amp, eps(omega * amp))
    useful_stroke_gate = 0.5 * (
        1 + tanh(
            normalized_stroke_rate / params.stroke_transition_scale,
        )
    )
    symmetric_tail_scale = 1 -
        params.tail_carrier_relief * relief_gate
    tail_carrier_scale = clamp(
        symmetric_tail_scale +
            params.tail_stroke_asymmetry * relief_gate *
            (2 * useful_stroke_gate - 1),
        0.0,
        1.0,
    )

    # The sampled miss has large positive target bearing but large positive
    # yaw on the cancelling stroke; the desired yaw sign is opposite bearing.
    # Open a bounded pulse only while measured yaw is wrong, and make it vanish
    # at joint reversal. Correct-sign yaw releases the pulse, so feedback does
    # not move the oscillator equilibrium or suppress the correcting stroke.
    heading_rate = Float64(state.heading_rate)
    normalized_wrong_yaw = geometric_turn * heading_rate /
        max(
            params.yaw_response_scale,
            eps(params.yaw_response_scale),
        )
    wrong_yaw_gate = max(tanh(normalized_wrong_yaw), 0.0)^2
    phase_speed = clamp(
        abs(qd1) / max(omega * amp, eps(omega * amp)),
        0.0,
        1.0,
    )
    counter_yaw = params.counter_yaw_acceleration_limit *
        relief_gate * geometric_turn * wrong_yaw_gate * phase_speed
    a1 = base_a1 + counter_yaw

    lagged_carrier = -carrier_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    phase_lag_target = tail_carrier_scale * lagged_carrier
    a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
