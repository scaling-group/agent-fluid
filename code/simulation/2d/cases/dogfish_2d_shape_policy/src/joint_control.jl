@inline function smootherstep01(z)
    zc = clamp(z, zero(z), one(z))
    return zc * zc * zc * (zc * (zc * typeof(zc)(6) - typeof(zc)(15)) + typeof(zc)(10))
end

@inline function smootherstep01_derivative(z)
    zero(z) < z < one(z) || return zero(z)
    return typeof(z)(30) * z * z * (z - one(z)) * (z - one(z))
end

@inline function distributed_joint_step(s, center, half_width)
    T = typeof(s)
    z = (s - T(center - half_width)) / T(2 * half_width)
    return smootherstep01(z)
end

@inline function distributed_joint_step_derivative(s, center, half_width)
    T = typeof(s)
    z = (s - T(center - half_width)) / T(2 * half_width)
    return smootherstep01_derivative(z) / T(2 * half_width)
end

@inline function two_joint_bend_angle(s, t, p)
    return p.phi1 * distributed_joint_step(s, p.center1, p.half_width1) +
        p.phi2 * distributed_joint_step(s, p.center2, p.half_width2)
end

@inline function two_joint_bend_angle_with_rates(s, t, p)
    dt_sim = (t - p.reference_time) * p.inv_L
    phi1 = p.phi1 + p.phi_dot1 * dt_sim
    phi2 = p.phi2 + p.phi_dot2 * dt_sim
    return phi1 * distributed_joint_step(s, p.center1, p.half_width1) +
        phi2 * distributed_joint_step(s, p.center2, p.half_width2)
end

@inline function two_joint_bend_density(s, t, p)
    return p.phi1 * distributed_joint_step_derivative(s, p.center1, p.half_width1) +
        p.phi2 * distributed_joint_step_derivative(s, p.center2, p.half_width2)
end

function two_joint_bend_params(;
    T::Type=Float32,
    phi1=0,
    phi2=0,
    center1=1 / 3,
    center2=2 / 3,
    half_width1=1 / 8,
    half_width2=1 / 8,
)
    return (
        phi1=T(phi1),
        phi2=T(phi2),
        phi_dot1=zero(T),
        phi_dot2=zero(T),
        center1=T(center1),
        center2=T(center2),
        half_width1=T(half_width1),
        half_width2=T(half_width2),
        reference_time=zero(T),
        inv_L=one(T),
    )
end

function merge_two_joint_angles(params, phi1, phi2)
    T = typeof(params.phi1)
    return merge(params, (phi1=T(phi1), phi2=T(phi2)))
end

function merge_two_joint_state(params, joint; reference_time=0, L=1)
    T = typeof(params.phi1)
    return merge(
        params,
        (
            phi1=T(joint.phi1),
            phi2=T(joint.phi2),
            phi_dot1=T(joint.phi_dot1),
            phi_dot2=T(joint.phi_dot2),
            reference_time=T(reference_time),
            inv_L=inv(T(L)),
        ),
    )
end
