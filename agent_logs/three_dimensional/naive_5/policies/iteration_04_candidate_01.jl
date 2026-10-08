# Bearing-gated burst redirect around a state-feedback traveling bend.
# Geometry and gait phase are observed in the body frame and joint state; no
# clock, world route, case identity, or mutable controller state is used.

function target_policy_params()
    return (
        control_period=0.90,
        oscillator_amplitude=18.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        bearing_limit=1.25,
        redirect_bearing_scale=0.25,
        redirect_deadband=0.08,
        redirect_full_bearing=0.40,
        redirect_angle=26.0 * pi / 180,
        redirect_tail_ratio=0.75,
        redirect_bandwidth_ratio=0.75,
        redirect_damping=0.90,
        acceleration_limit=30.0,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

    # Cruise is the evidenced joint-state traveling bend. The anterior
    # oscillator carries phase, and the posterior target supplies lag.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    cruise_a1 = vdp_drive - omega^2 * q1
    tail_target = -q1 - params.tail_lag_gain * qd1 / max(omega, eps(Float64))
    cruise_a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    # Positive bearing requires negative yaw in this body's convention.
    # Outside a small alignment band, smoothly enter a C-bend redirect; the
    # same observed bearing that triggers the bend also releases it as the
    # target returns toward the body axis.
    bearing = clamp(
        Float64(state.bearing),
        -params.bearing_limit,
        params.bearing_limit,
    )
    turn_side = -tanh(bearing / params.redirect_bearing_scale)
    gate_coordinate = clamp(
        (abs(bearing) - params.redirect_deadband) /
        max(
            params.redirect_full_bearing - params.redirect_deadband,
            eps(Float64),
        ),
        0.0,
        1.0,
    )
    redirect_gate = gate_coordinate^2 * (3 - 2 * gate_coordinate)

    # Same-sign joint targets create a bounded whole-body curvature instead of
    # continuously pumping one half-stroke. Damped pose tracking supplies a
    # finite redirect transient; cruise resumes continuously as the gate falls.
    redirect_target1 = params.redirect_angle * turn_side
    redirect_target2 = params.redirect_tail_ratio * redirect_target1
    redirect_omega = params.redirect_bandwidth_ratio * omega
    redirect_damping = 2 * params.redirect_damping * redirect_omega
    redirect_a1 = redirect_omega^2 * (redirect_target1 - q1) -
        redirect_damping * qd1
    redirect_a2 = redirect_omega^2 * (redirect_target2 - q2) -
        redirect_damping * qd2

    cruise_gate = 1 - redirect_gate
    a1 = cruise_gate * cruise_a1 + redirect_gate * redirect_a1
    a2 = cruise_gate * cruise_a2 + redirect_gate * redirect_a2

    limit = params.acceleration_limit
    return (
        phi_ddot=(
            clamp(a1, -limit, limit),
            clamp(a2, -limit, limit),
        ),
    )
end
