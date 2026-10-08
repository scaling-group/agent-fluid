# State-feedback traveling-bend carrier with slip-damped anterior stroke
# allocation. Oscillator phase remains encoded only in observed joint state.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        steering_bearing_scale=0.25,
        lateral_velocity_feedback=1.2,
        steering_acceleration_limit=10.0,
        phase_velocity_limit=1.0,
        joint_acceleration_budget=1800.0 * pi / 180,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Preserve the zero-centered Van der Pol carrier and infer beat phase from
    # joint state rather than a clock.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    anterior_carrier = vdp_drive - omega^2 * q1

    # Body-frame lateral motion toward the requested side unloads steering;
    # wrong-side slip strengthens it. The smooth bound remains reflection
    # equivariant and introduces no route or world-frame direction.
    bearing = Float64(state.bearing)
    lateral_velocity = Float64(state.velocity_body_U[2])
    route_error = bearing -
        params.lateral_velocity_feedback * lateral_velocity
    turn_request = tanh(route_error / params.steering_bearing_scale)

    # Allocate the bounded steering residual before the carrier reaches the
    # acceleration envelope. This preserves the requested stroke while
    # genuinely shortening the opposing stroke instead of losing that brake
    # to downstream clipping. Steering vanishes at observed reversals.
    phase_speed = clamp(
        abs(qd1) / max(omega * amp, eps(omega * amp)),
        0.0,
        params.phase_velocity_limit,
    )
    steering = params.steering_acceleration_limit *
        turn_request * phase_speed
    carrier_headroom = max(
        params.joint_acceleration_budget - abs(steering),
        0.0,
    )
    a1 = clamp(
        anterior_carrier,
        -carrier_headroom,
        carrier_headroom,
    ) + steering

    # Keep the inherited posterior lag unsteered so this rollout isolates the
    # anterior headroom-allocation mechanism.
    phase_lag_target = -q1 - params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
