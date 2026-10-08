# Target-bearing mean-curvature controller around a state-feedback traveling
# bend. No clock, world-frame route, or mutable oscillator state is used.

function target_policy_params()
    return (
        control_period=0.80,
        oscillator_amplitude=20.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.75,
        bearing_limit=1.2,
        bearing_gain=3.2,
        max_curvature_bias=10.0 * pi / 180,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Persistent body-frame target error becomes bounded mean curvature. The
    # matched-kinematics turn audit establishes that positive joint bias gives
    # negative yaw, which drives a positive bearing toward zero.
    bearing = clamp(
        Float64(state.bearing),
        -params.bearing_limit,
        params.bearing_limit,
    )
    curvature_bias = params.max_curvature_bias * tanh(params.bearing_gain * bearing)

    # Run the observable-state oscillator about the requested curvature so the
    # steering bias does not replace the propulsive wave.
    q1_wave = q1 - curvature_bias
    vdp_drive = params.oscillator_mu * (1 - (q1_wave / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1_wave

    # The posterior joint receives the same mean bias while retaining the
    # seed's directional lag and posterior wave emphasis.
    phase_lag_target = curvature_bias - q1_wave -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) - 2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
