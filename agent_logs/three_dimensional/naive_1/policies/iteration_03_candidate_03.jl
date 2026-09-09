# Geometry-held differential redirect for the 3D moving-window EvE lane.
# Propulsive phase remains entirely in joint state. The signed body-frame
# line of sight holds an asymmetric bend through beat-scale yaw and releases
# it on alignment, without a clock, short-window rate loop, or world route.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        course_error_scale=0.30,
        head_bias_limit=4.0 * pi / 180,
        tail_bias_limit=10.0 * pi / 180,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = state.phi[1]
    q2 = state.phi[2]
    qd1 = state.phi_dot[1]
    qd2 = state.phi_dot[2]

    # The fish's forward axis is negative body x. Unlike the adapter's folded
    # bearing, this signed line-of-sight angle retains whether the target has
    # moved behind the head. Positive error requires the evidenced combination
    # of negative anterior and positive posterior mean curvature.
    target_forward = -Float64(state.target_body_L[1])
    target_lateral = Float64(state.target_body_L[2])
    course_error = atan(target_lateral, target_forward)
    turn_request = tanh(
        course_error /
        max(params.course_error_scale, eps(params.course_error_scale)),
    )
    head_bias = -params.head_bias_limit * turn_request
    tail_bias = params.tail_bias_limit * turn_request

    # Preserve the seed's state-feedback oscillator while shifting its center.
    # Target geometry changes only the mean bend; (q1, qd1) retain phase.
    centered_q1 = q1 - head_bias
    vdp_drive = params.oscillator_mu * (1 - (centered_q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * centered_q1

    # Retain the thrust-producing posterior lag around the compatible,
    # opposite-sign tail bias measured in the strongest sampled rollout.
    phase_lag_target = tail_bias - centered_q1 -
        params.tail_lag_gain * qd1 / max(omega, eps(omega))
    a2 = omega^2 * (phase_lag_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
