function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        max_turn_curvature=12.0 * pi / 180,
        bearing_scale=20.0 * pi / 180,
        aligned_anterior_fraction=0.48,
        strong_turn_anterior_fraction=0.35,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # A body-frame target error sets a bounded mean curvature. Positive bearing
    # receives positive bend bias, which follows the measured FSI sign convention
    # (positive bias produces negative yaw) for the headward coordinate frame.
    bearing = clamp(Float64(state.bearing), -pi / 2, pi / 2)
    turn_fraction = tanh(
        bearing / max(params.bearing_scale, eps(params.bearing_scale)),
    )
    turn_curvature = params.max_turn_curvature * turn_fraction

    # Preserve more anterior excursion during a large redirect by moving a
    # bounded share of the same total curvature toward the posterior joint.
    # As bearing aligns, smoothly return toward the successful balanced split.
    steer_demand = abs(turn_fraction)
    aligned_fraction = clamp(params.aligned_anterior_fraction, 0.0, 1.0)
    strong_turn_fraction = clamp(params.strong_turn_anterior_fraction, 0.0, 1.0)
    anterior_fraction = aligned_fraction +
        steer_demand * (strong_turn_fraction - aligned_fraction)
    q1_center = anterior_fraction * turn_curvature
    q2_center = (1 - anterior_fraction) * turn_curvature

    # Preserve the seed's state-only reflex oscillator, but center the traveling
    # bend on the requested curvature instead of remaining target-blind.
    q1_wave = q1 - q1_center
    vdp_drive = params.oscillator_mu * (1 - (q1_wave / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1_wave

    # Tail follows the first joint with a velocity-dependent lag, producing a
    # smooth traveling bend around the posterior share of the curvature bias.
    phase_lag_target = q2_center - q1_wave -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (
        phi_ddot=(
            a1,
            a2,
        ),
    )
end
