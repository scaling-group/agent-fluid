function target_policy_params()
    return (
        control_period=0.68,
        oscillator_amplitude=22.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.65,
        tail_damping=0.75,
        bearing_scale=0.35,
        bearing_rate_horizon_far=0.35,
        bearing_rate_horizon_near=1.25,
        bearing_rate_offset_limit=20.0 * pi / 180,
        approach_onset_distance_L=4.0,
        approach_full_distance_L=1.0,
        half_cycle_asymmetry=0.45,
        posterior_asymmetry_share=0.55,
        acceleration_soft_limit=29.0,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Preserve the evaluated zero-centered traveling bend: moving its
    # equilibrium erased startup propulsion in both anterior and tail-only
    # mean-curvature variants.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    symmetric_a1 = vdp_drive - omega^2 * q1

    # Use the measured body-frame line-of-sight trend rather than body turn
    # rate as a proxy. Lengthen only the prediction horizon near the target so
    # a closing turn releases earlier in the tight approach, while a growing
    # miss receives more authority. Smoothstep avoids a discrete control mode.
    bearing = clamp(Float64(state.bearing), -pi / 2, pi / 2)
    distance_L = max(0.0, Float64(state.distance_L))
    approach_span = max(
        params.approach_onset_distance_L - params.approach_full_distance_L,
        eps(Float64),
    )
    approach_raw = clamp(
        (params.approach_onset_distance_L - distance_L) / approach_span,
        0.0,
        1.0,
    )
    approach = approach_raw^2 * (3 - 2 * approach_raw)
    rate_horizon = params.bearing_rate_horizon_far + approach *
        (params.bearing_rate_horizon_near - params.bearing_rate_horizon_far)
    bearing_rate_offset = clamp(
        rate_horizon * Float64(state.bearing_window_rate),
        -params.bearing_rate_offset_limit,
        params.bearing_rate_offset_limit,
    )
    predicted_bearing = clamp(bearing + bearing_rate_offset, -pi / 2, pi / 2)
    turn_fraction = tanh(predicted_bearing / params.bearing_scale)

    # Retain the evidenced distributed acceleration half-cycle asymmetry. It
    # biases the rhythmic response without subtracting the initialized bend or
    # adding a static steering center.
    asymmetric_a1 = symmetric_a1 +
        params.half_cycle_asymmetry * turn_fraction * abs(symmetric_a1)

    tail_target = -q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(Float64))
    symmetric_a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2
    asymmetric_a2 = symmetric_a2 + params.posterior_asymmetry_share *
        params.half_cycle_asymmetry * turn_fraction * abs(symmetric_a2)

    # Stay below the episode's harder acceleration clip without introducing
    # persistent bang-bang control.
    limit = params.acceleration_soft_limit
    a1 = limit * tanh(asymmetric_a1 / limit)
    a2 = limit * tanh(asymmetric_a2 / limit)

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
