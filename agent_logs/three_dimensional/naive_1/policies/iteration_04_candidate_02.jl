# State-feedback traveling-bend carrier with proprioceptively demodulated
# cruise rectification and an error-gated whole-body curvature redirect.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        steering_bearing_scale=0.25,
        lateral_velocity_feedback=1.2,
        proprioceptive_bearing_compensation=0.35,
        rectified_acceleration_limit=10.0,
        phase_velocity_limit=1.0,
        redirect_bearing_start=0.20,
        redirect_bearing_full=0.55,
        redirect_curvature_limit=7.0 * pi / 180,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # The sampled traces show a repeatable bearing ripple anticorrelated with
    # anterior bend. Remove that proprioceptive carrier component without a
    # clock or stored route, then let target-side lateral motion unload the
    # request and wrong-side slip strengthen it.
    bearing = Float64(state.bearing)
    lateral_velocity = Float64(state.velocity_body_U[2])
    course_bearing = bearing +
        params.proprioceptive_bearing_compensation * q1
    route_error = course_bearing -
        params.lateral_velocity_feedback * lateral_velocity
    turn_request = tanh(route_error / params.steering_bearing_scale)

    # Large persistent geometric error, rather than a lateral-velocity spike,
    # transfers authority from cruise rectification to a common curvature
    # center. Smoothstep keeps this state-only mode change continuous.
    redirect_progress = clamp(
        (abs(course_bearing) - params.redirect_bearing_start) /
            max(
                params.redirect_bearing_full - params.redirect_bearing_start,
                eps(params.redirect_bearing_full),
            ),
        0.0,
        1.0,
    )
    redirect_gate = redirect_progress^2 * (3 - 2 * redirect_progress)
    curvature_center = params.redirect_curvature_limit *
        redirect_gate * turn_request
    centered_q1 = q1 - curvature_center

    # Preserve the inherited self-excited anterior carrier around the bounded
    # redirect center. Near the route, phase-speed rectification retains the
    # strong parent's propulsive benefit; during a redirect it fades out so it
    # cannot compete for the already saturated joint-rate envelope.
    vdp_drive = params.oscillator_mu *
        (1 - (centered_q1 / amp)^2) * qd1
    phase_speed = clamp(
        abs(qd1) / max(omega * amp, eps(omega * amp)),
        0.0,
        params.phase_velocity_limit,
    )
    cruise_rectification = params.rectified_acceleration_limit *
        turn_request * phase_speed * (1 - redirect_gate)
    a1 = vdp_drive - omega^2 * centered_q1 + cruise_rectification

    # Recenter the posterior traveling-wave target on the same bend. Relative
    # to that center it keeps the inherited sign reversal, velocity lag, and
    # damping, so redirection does not become an in-phase standing wiggle.
    phase_lag_target = curvature_center - centered_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
