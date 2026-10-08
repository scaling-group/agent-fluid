# Distance-conditioned approach hold around the strongest sampled body-frame
# lateral-slip controller. Joint-state phase remains the only carrier phase.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        turn_curvature_limit=12.0 * pi / 180,
        bearing_limit=pi / 2,
        bearing_scale=0.20,
        lateral_velocity_limit=0.8,
        lateral_velocity_feedback=0.45,
        approach_distance_L=5.0,
        approach_width_L=1.0,
        approach_carrier_floor=0.55,
        approach_head_damping=0.20,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

    # A normalized-distance gate is effectively zero in the far field. Near
    # the target it smoothly trades carrier authority for the unchanged
    # steering residual without introducing clocked approach stages.
    raw_distance = Float64(state.distance_L)
    approach_width = max(params.approach_width_L, eps(Float64))
    approach_proximity = isfinite(raw_distance) ? clamp(
        0.5 + 0.5 *
            (params.approach_distance_L - max(raw_distance, 0.0)) /
            approach_width,
        0.0,
        1.0,
    ) : 0.0
    approach_gate = approach_proximity^2 * (3.0 - 2.0 * approach_proximity)
    carrier_scale = 1.0 - approach_gate *
        (1.0 - params.approach_carrier_floor)

    # Preserve the sampled Van der Pol drive away from the target. Approach
    # damping removes excess carrier energy continuously rather than stopping
    # propulsion or shifting the anterior oscillator center.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    approach_damping = approach_gate * params.approach_head_damping * omega
    a1 = vdp_drive - omega^2 * q1 - approach_damping * qd1

    raw_bearing = Float64(state.bearing)
    raw_lateral_velocity = Float64(state.velocity_body_U[2])
    bearing = isfinite(raw_bearing) ?
        clamp(raw_bearing, -params.bearing_limit, params.bearing_limit) : 0.0
    lateral_velocity = isfinite(raw_lateral_velocity) ?
        clamp(
            raw_lateral_velocity,
            -params.lateral_velocity_limit,
            params.lateral_velocity_limit,
        ) : 0.0

    # Body-frame slip anticipates cross-target drift. The mean curvature is
    # deliberately not reduced on approach, where the sampled rollout had
    # already saturated this target-relative request while passing too fast.
    steering_signal = bearing -
        params.lateral_velocity_feedback * lateral_velocity
    mean_tail_tangent = params.turn_curvature_limit * tanh(
        steering_signal / max(params.bearing_scale, eps(Float64)),
    )

    carrier_tail_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    phase_lag_target = mean_tail_tangent +
        carrier_scale * carrier_tail_target
    a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
