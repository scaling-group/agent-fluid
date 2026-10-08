# State-feedback traveling bend with an always-available anterior curvature
# center and a large-error phase-selective redirect. The posterior joint keeps
# a zero-mean lagged carrier so added steering does not replace propulsion.

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
        redirect_bearing_start=0.45,
        redirect_bearing_full=0.85,
        redirect_acceleration_limit=5.0,
        phase_velocity_limit=1.0,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # Body-frame target geometry supplies the slow route request. Target-side
    # lateral motion unloads the bend; wrong-side slip strengthens it.
    bearing = Float64(state.bearing)
    lateral_velocity = Float64(state.velocity_body_U[2])
    route_error = bearing -
        params.lateral_velocity_feedback * lateral_velocity
    turn_request = tanh(route_error / params.steering_bearing_scale)

    # Retain the strongest sampled policy's bounded anterior mean center at
    # every error magnitude. In particular, do not disable this useful early
    # redirect merely because the initial bearing is modest.
    curvature_center = params.curvature_bias_limit * turn_request
    carrier_q1 = q1 - curvature_center
    vdp_drive = params.oscillator_mu *
        (1 - (carrier_q1 / amp)^2) * qd1

    # Once geometric bearing exceeds the regime handled by the static center,
    # recruit a smooth signed half-cycle residual. Observed carrier speed is
    # the only phase signal: the residual adds work on the requested stroke,
    # brakes the opposite stroke, and vanishes at each reversal.
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
    phase_speed = clamp(
        abs(qd1) / max(omega * amp, eps(omega * amp)),
        0.0,
        params.phase_velocity_limit,
    )
    redirect = params.redirect_acceleration_limit *
        redirect_gate * turn_request * phase_speed

    a1 = vdp_drive - omega^2 * carrier_q1 + redirect

    # Steering remains anterior-only. Build the posterior target from the
    # centered coordinate so it keeps a zero-mean propulsive traveling lag.
    phase_lag_target = -carrier_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
