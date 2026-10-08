# Full-quadrant phase-lag steering around the demonstrated bearing/slip
# traveling carrier. Beat phase remains entirely in observed joint state.

function target_policy_params()
    return (
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.8,
        tail_damping=0.65,
        turn_curvature_limit=12.0 * pi / 180,
        full_bearing_limit=pi,
        bearing_scale=0.20,
        lateral_velocity_limit=0.8,
        lateral_velocity_feedback=0.45,
        lag_modulation_bearing_on=0.25,
        lag_modulation_bearing_width=0.50,
        turn_lag_floor=0.45,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amp = params.oscillator_amplitude
    q1 = Float64(state.phi[1])
    q2 = Float64(state.phi[2])
    qd1 = Float64(state.phi_dot[1])
    qd2 = Float64(state.phi_dot[2])

    # Preserve the sampled zero-centered anterior oscillator at every target
    # distance. The controller neither shifts its center nor attenuates it.
    vdp_drive = params.oscillator_mu * (1 - (q1 / amp)^2) * qd1
    a1 = vdp_drive - omega^2 * q1

    # The scalar adapter bearing folds the rear half-plane through abs(x).
    # Normalized target geometry retains the full quadrant relative to the
    # head-facing body -x direction.
    target_x = Float64(state.target_body_L[1])
    target_y = Float64(state.target_body_L[2])
    raw_folded_bearing = Float64(state.bearing)
    fallback_bearing = isfinite(raw_folded_bearing) ?
        raw_folded_bearing : 0.0
    raw_full_bearing = isfinite(target_x) && isfinite(target_y) ?
        atan(target_y, -target_x) : fallback_bearing
    full_bearing = clamp(
        raw_full_bearing,
        -params.full_bearing_limit,
        params.full_bearing_limit,
    )

    raw_lateral_velocity = Float64(state.velocity_body_U[2])
    lateral_velocity = isfinite(raw_lateral_velocity) ?
        clamp(
            raw_lateral_velocity,
            -params.lateral_velocity_limit,
            params.lateral_velocity_limit,
        ) : 0.0

    # Retain the evidenced bounded posterior mean-curvature request. Body slip
    # strengthens the request when motion carries the fish across the target
    # line and releases it when lateral translation is already corrective.
    steering_signal = full_bearing -
        params.lateral_velocity_feedback * lateral_velocity
    turn_request = tanh(
        steering_signal / max(params.bearing_scale, eps(Float64)),
    )
    mean_tail_tangent = params.turn_curvature_limit * turn_request

    # Outside the demonstrated approach corridor, contract only the posterior
    # velocity-lag term. Depending on |bearing| and |turn_request| keeps this
    # wave-shape modulation reflection-equivariant. The -q1 carrier remains
    # fully oscillatory, while its summed curvature stays nearer the requested
    # mean through more of a high-error beat.
    lag_fraction = clamp(
        (abs(full_bearing) - params.lag_modulation_bearing_on) /
        max(params.lag_modulation_bearing_width, eps(Float64)),
        0.0,
        1.0,
    )
    lag_gate = lag_fraction^2 * (3.0 - 2.0 * lag_fraction)
    lag_blend = lag_gate * abs(turn_request)
    effective_tail_lag = params.tail_lag_gain - lag_blend *
        (params.tail_lag_gain - params.turn_lag_floor)

    tail_target = mean_tail_tangent - q1 -
        effective_tail_lag * qd1 / max(omega, eps(Float64))
    a2 = omega^2 * (tail_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(a1, a2),)
end
