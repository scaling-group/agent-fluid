# Minimal 3D propulsion carrier with the successful 2D seed's naive steering.
# No startup ramp, route, wake adapter, history, predictor, or learned model.

function target_policy_params()
    return (
        control_period=1.10,
        carrier_amplitude1=20.0 * pi / 180,
        carrier_amplitude2=26.0 * pi / 180,
        phase_lag=85.0 * pi / 180,
        tracking_bandwidth_ratio=1.5,
        tracking_damping_ratio=1.0,
        steer_gain=6.0,
        tail_steer_gain=0.8,
        lateral_velocity_gain=0.00390625,
        turn_damping=0.0,
    )
end

function target_policy(state, params)
    elapsed_T = hasproperty(state, :elapsed_T) ? Float64(state.elapsed_T) : 0.0
    omega = 2.0 * pi / params.control_period
    phase1 = omega * elapsed_T
    phase2 = phase1 - params.phase_lag

    target1 = params.carrier_amplitude1 * sin(phase1)
    target2 = params.carrier_amplitude2 * sin(phase2)
    target_velocity1 = params.carrier_amplitude1 * omega * cos(phase1)
    target_velocity2 = params.carrier_amplitude2 * omega * cos(phase2)
    target_acceleration1 = -omega^2 * target1
    target_acceleration2 = -omega^2 * target2

    tracking_omega = params.tracking_bandwidth_ratio * omega
    damping = 2.0 * params.tracking_damping_ratio * tracking_omega
    stiffness = tracking_omega^2
    a1 = target_acceleration1 +
        stiffness * (target1 - Float64(state.phi[1])) +
        damping * (target_velocity1 - Float64(state.phi_dot[1]))
    a2 = target_acceleration2 +
        stiffness * (target2 - Float64(state.phi[2])) +
        damping * (target_velocity2 - Float64(state.phi_dot[2]))

    bearing = clamp(Float64(state.bearing), -1.0, 1.0)
    steer = params.steer_gain * bearing -
        params.lateral_velocity_gain * Float64(state.velocity_body_U[2]) -
        params.turn_damping * Float64(state.moment_z_L2)

    return (
        phi_ddot=(
            a1 + steer,
            a2 + params.tail_steer_gain * steer,
        ),
    )
end
