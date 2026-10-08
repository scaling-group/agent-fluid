# Slip-aware anterior mean-curvature steering with large-bearing tail relief
# and a distinct anterior redirect reserve. Phase remains in observed state.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        steering_bearing_scale=0.25,
        lateral_velocity_feedback=1.2,
        cruise_curvature_limit=8.0 * pi / 180,
        redirect_bearing_start=0.75,
        redirect_bearing_full=1.20,
        redirect_curvature_reserve=8.0 * pi / 180,
        tail_relief_bearing_start=0.45,
        tail_relief_bearing_full=0.90,
        tail_carrier_relief=0.65,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Persistent target geometry supplies turn sign. Target-side lateral
    # motion unloads the request, while wrong-side slip reinforces it.
    bearing = Float64(state.bearing)
    lateral_velocity = Float64(state.velocity_body_U[2])
    route_error = bearing -
        params.lateral_velocity_feedback * lateral_velocity
    turn_request = tanh(route_error / params.steering_bearing_scale)

    # The cruise bend is always available. Only the sampled large-bearing miss
    # regime recruits extra anterior mean curvature; observed alignment
    # releases it without a clock, stage counter, or beat-scale yaw feedback.
    redirect_progress = clamp(
        (abs(bearing) - params.redirect_bearing_start) /
            max(
                params.redirect_bearing_full - params.redirect_bearing_start,
                eps(params.redirect_bearing_full),
            ),
        0.0,
        1.0,
    )
    redirect_gate = redirect_progress^2 * (3 - 2 * redirect_progress)
    curvature_limit = params.cruise_curvature_limit +
        params.redirect_curvature_reserve * redirect_gate
    curvature_center = curvature_limit * turn_request

    # Keep the self-excited carrier as displacement about the moving anterior
    # center. The redirect changes mean curvature, not oscillator phase.
    carrier_q1 = q1 - curvature_center
    vdp_drive = params.oscillator_mu *
        (1 - (carrier_q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * carrier_q1

    # Retain the best sample's smooth posterior-carrier relief. Steering never
    # enters the tail mean: the tail tracks only a scaled, zero-mean lagged
    # carrier and recovers full cruise amplitude as bearing falls.
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
    tail_carrier_scale = 1 - params.tail_carrier_relief * relief_gate

    lagged_carrier = -carrier_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    phase_lag_target = tail_carrier_scale * lagged_carrier
    a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
