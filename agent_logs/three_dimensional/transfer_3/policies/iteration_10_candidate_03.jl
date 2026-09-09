# Phase-2 candidate: distribute a geometry-gated mean-curvature redirect
# across both joints while retaining the coherent state-feedback carrier.

function target_policy_params()
    return (
        version="dogfish3d_distributed_geometry_redirect_v1",
        control_period=0.55,
        oscillator_amplitude=28.0 * pi / 180,
        oscillator_mu=0.35,
        tail_lag_gain=0.80,
        tail_damping=0.65,
        los_forward_floor=0.25,
        redirect_bearing_scale=0.35,
        total_mean_curvature_limit=10.0 * pi / 180,
        anterior_curvature_share=0.55,
    )
end

@inline function _finite_or(value, fallback)
    parsed = Float64(value)
    return isfinite(parsed) ? parsed : fallback
end

function target_guidance(state, params)
    distance = max(_finite_or(state.distance_L, 1.0), 1.0e-6)
    target_x = _finite_or(state.target_body_L[1], -distance)
    target_y = _finite_or(state.target_body_L[2], 0.0)
    target_norm = max(hypot(target_x, target_y), 1.0e-6)

    # Material body -x is forward. The normalized body-frame bearing is
    # reflection-equivariant and remains defined when the target is abeam or
    # behind. Alignment itself continuously releases the redirect.
    target_forward = -target_x / target_norm
    target_lateral = target_y / target_norm
    bearing = atan(
        target_lateral,
        max(target_forward, params.los_forward_floor),
    )
    turn_request = -tanh(
        bearing / max(params.redirect_bearing_scale, 1.0e-6),
    )
    total_mean_curvature =
        params.total_mean_curvature_limit * turn_request

    # Move a fixed share of the slow mean bend into the anterior oscillator;
    # the posterior joint supplies the remainder around its lagged wave.
    anterior_mean_curvature =
        params.anterior_curvature_share * total_mean_curvature
    posterior_mean_curvature =
        total_mean_curvature - anterior_mean_curvature

    return (
        bearing=bearing,
        turn_request=turn_request,
        total_mean_curvature=total_mean_curvature,
        anterior_mean_curvature=anterior_mean_curvature,
        posterior_mean_curvature=posterior_mean_curvature,
    )
end

function target_policy(state, params)
    omega = 2 * pi / params.control_period
    amplitude = params.oscillator_amplitude
    q1 = _finite_or(state.phi[1], 0.0)
    q2 = _finite_or(state.phi[2], 0.0)
    qd1 = _finite_or(state.phi_dot[1], 0.0)
    qd2 = _finite_or(state.phi_dot[2], 0.0)

    guidance = target_guidance(state, params)

    # Center the same self-sustaining oscillator on the slow anterior share;
    # no external phase or clock is introduced.
    anterior_wave = q1 - guidance.anterior_mean_curvature
    vdp_drive =
        params.oscillator_mu *
        (1 - (anterior_wave / amplitude)^2) * qd1
    anterior_accel = vdp_drive - omega^2 * anterior_wave

    # Track a traveling bend about the remaining posterior mean. Written this
    # way, the sum of the two joint means equals total_mean_curvature.
    posterior_target =
        guidance.posterior_mean_curvature - anterior_wave -
        params.tail_lag_gain * qd1 / max(omega, eps(Float64))
    posterior_accel =
        omega^2 * (posterior_target - q2) -
        2 * params.tail_damping * omega * qd2

    return (phi_ddot=(anterior_accel, posterior_accel),)
end
