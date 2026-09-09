# Response-gated posterior-curvature steering for the 3D moving-window lane.
# Target geometry selects one turn direction; correctly signed body response
# can release that bend but beat-scale yaw cannot reverse it.  Propulsive phase
# remains entirely in joint state, with no clock, route, or mutable state.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        bearing_scale=0.30,
        turn_rate_limit=2.0,
        response_release_rate=0.45,
        tail_curvature_limit=10.0 * pi / 180,
        acceleration_soft_limit=1800.0 * pi / 180,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Positive posterior curvature produced negative yaw in both sampled
    # posterior-only rollouts, so bearing owns the steering sign.  A positive
    # correcting_rate means the body already turns toward alignment.  Its gate
    # can only release curvature; high-frequency yaw cannot invert the route
    # request as it did in the inherited turn-rate servo.
    bearing_request = tanh(
        Float64(state.bearing) /
        max(params.bearing_scale, eps(params.bearing_scale)),
    )
    turn_rate = clamp(
        Float64(state.turn_rate_recent),
        -params.turn_rate_limit,
        params.turn_rate_limit,
    )
    correcting_rate = max(0.0, -bearing_request * turn_rate)
    response_gate = inv(
        1.0 + correcting_rate /
        max(params.response_release_rate, eps(params.response_release_rate)),
    )
    tail_bias = params.tail_curvature_limit * bearing_request * response_gate

    # Preserve the target-blind carrier at the anterior joint and add only a
    # posterior mean bend around its thrust-producing traveling-wave target.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    raw_a1 = vdp_drive - omega^2 * q1
    phase_lag_target = tail_bias - q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    raw_a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    # The sampled parent relied on the downstream hard acceleration clip on
    # nearly every row.  A smooth policy-owned envelope preserves sign and
    # finite phase authority without emitting persistent bang-bang requests.
    accel_limit = max(
        params.acceleration_soft_limit,
        eps(params.acceleration_soft_limit),
    )
    a1 = accel_limit * tanh(raw_a1 / accel_limit)
    a2 = accel_limit * tanh(raw_a2 / accel_limit)

    return (phi_ddot=(a1, a2),)
end
