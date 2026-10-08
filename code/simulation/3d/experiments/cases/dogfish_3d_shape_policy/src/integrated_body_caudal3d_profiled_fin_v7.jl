# One-piece dogfish body/caudal SDF for geometry-first review.
#
# Unlike the V6 body-union-plate construction, this SDF has one continuous
# family of superellipse sections over s=0--1.  The posterior lateral
# half-width W(s) keeps narrowing through the peduncle and caudal region while
# the dorsal/ventral half-heights first contract at the peduncle and then grow
# to a tall trailing section.  There is no separate fin object and no material
# beyond s=1.

struct IntegratedProfiledCaudalSDF{B,T} <: Function
    body::B
    transition_start::T
    peduncle_station::T
    peduncle_half_width::T
    trailing_half_width::T
    peduncle_ztop::T
    peduncle_zbot::T
    trailing_ztop::T
    trailing_zbot::T
    tail_etop::T
    tail_ebot::T
    minimum_posterior_half_width_cells::T
end

@inline _profiled_tail_smootherstep(u::T) where {T} = begin
    uc = clamp(u, zero(T), one(T))
    uc * uc * uc * (uc * (uc * T(6) - T(15)) + T(10))
end

function integrated_profiled_caudal_sdf(
    body::B;
    transition_start=0.68,
    peduncle_station=0.76,
    peduncle_half_width=0.018,
    trailing_half_width=0.012,
    peduncle_ztop=0.018,
    peduncle_zbot=0.013,
    trailing_ztop=0.13,
    trailing_zbot=0.09,
    tail_etop=2.2,
    tail_ebot=2.0,
    minimum_posterior_half_width_cells=1.0,
) where {B}
    T = typeof(body.Lf)
    ts = T(transition_start)
    ps = T(peduncle_station)
    zero(T) < ts < ps < one(T) ||
        error("profiled caudal requires 0 < transition_start < peduncle_station < 1")
    values = T.((
        peduncle_half_width,
        trailing_half_width,
        peduncle_ztop,
        peduncle_zbot,
        trailing_ztop,
        trailing_zbot,
        tail_etop,
        tail_ebot,
    ))
    all(>(zero(T)), values) || error("all profiled-caudal dimensions must be positive")
    values[2] <= values[1] ||
        error("trailing lateral half-width must not exceed the peduncle half-width")
    minimum_cells = T(minimum_posterior_half_width_cells)
    minimum_cells >= zero(T) ||
        error("minimum posterior half-width in cells must be non-negative")
    return IntegratedProfiledCaudalSDF(
        body,
        ts,
        ps,
        values...,
        minimum_cells,
    )
end

@inline function profiled_caudal_section(geometry::IntegratedProfiledCaudalSDF, s)
    body = geometry.body
    T = typeof(s)
    W0 = T(Base2D.profile_width(body.w, s))
    Zt0 = T(Base2D.profile_width(body.ztop, s))
    Zb0 = T(Base2D.profile_width(body.zbot, s))
    et0 = T(Base2D.profile_width(body.etop, s))
    eb0 = T(Base2D.profile_width(body.ebot, s))
    if s <= geometry.transition_start
        return (W=W0, Ztop=Zt0, Zbot=Zb0, etop=et0, ebot=eb0)
    elseif s < geometry.peduncle_station
        u = _profiled_tail_smootherstep(
            (s - geometry.transition_start) /
            (geometry.peduncle_station - geometry.transition_start),
        )
        return (
            W=(one(T) - u) * W0 + u * T(geometry.peduncle_half_width),
            Ztop=(one(T) - u) * Zt0 + u * T(geometry.peduncle_ztop),
            Zbot=(one(T) - u) * Zb0 + u * T(geometry.peduncle_zbot),
            etop=(one(T) - u) * et0 + u * T(geometry.tail_etop),
            ebot=(one(T) - u) * eb0 + u * T(geometry.tail_ebot),
        )
    end
    u = _profiled_tail_smootherstep(
        (s - geometry.peduncle_station) / (one(T) - geometry.peduncle_station),
    )
    return (
        W=(one(T) - u) * T(geometry.peduncle_half_width) +
            u * T(geometry.trailing_half_width),
        Ztop=(one(T) - u) * T(geometry.peduncle_ztop) +
            u * T(geometry.trailing_ztop),
        Zbot=(one(T) - u) * T(geometry.peduncle_zbot) +
            u * T(geometry.trailing_zbot),
        etop=T(geometry.tail_etop),
        ebot=T(geometry.tail_ebot),
    )
end

@inline function profiled_caudal_half_widths(
    geometry::IntegratedProfiledCaudalSDF,
    s,
)
    physical = profiled_caudal_section(geometry, s).W
    Lf = typeof(s)(geometry.body.Lf)
    numerical = s >= geometry.transition_start ?
        max(physical, typeof(s)(geometry.minimum_posterior_half_width_cells) / Lf) :
        physical
    return (physical=physical, numerical=numerical)
end

@inline function (geometry::IntegratedProfiledCaudalSDF)(x, t)
    CT = typeof(x[1])
    Lf = CT(geometry.body.Lf)
    s = clamp(x[1] / Lf, zero(CT), one(CT))
    section = profiled_caudal_section(geometry, s)
    axial = max(-x[1], x[1] - Lf)
    tiny = CT(1f-4) * Lf
    widths = profiled_caudal_half_widths(geometry, s)
    W = max(Lf * CT(widths.numerical), tiny)
    y = x[2]
    z = x[3]
    dorsal = z >= zero(CT)
    Z = max(Lf * CT(dorsal ? section.Ztop : section.Zbot), tiny)
    exponent = CT(dorsal ? section.etop : section.ebot)
    radial = sqrt(y * y + z * z)
    cross = if radial < tiny
        -min(W, Z)
    else
        cphi = y / radial
        sphi = z / radial
        inv_t = (abs(cphi) / W)^exponent + (abs(sphi) / Z)^exponent
        radial - inv_t^(-one(CT) / exponent)
    end
    return min(max(cross, axial), zero(CT)) +
        sqrt(max(cross, zero(CT))^2 + max(axial, zero(CT))^2)
end

profiled_caudal_parameters(geometry::IntegratedProfiledCaudalSDF) = (
    topology="single continuous superellipse-section SDF",
    axial_extent=(0.0, 1.0),
    transition_start=Float64(geometry.transition_start),
    peduncle_station=Float64(geometry.peduncle_station),
    peduncle_half_width=Float64(geometry.peduncle_half_width),
    trailing_half_width=Float64(geometry.trailing_half_width),
    peduncle_ztop=Float64(geometry.peduncle_ztop),
    peduncle_zbot=Float64(geometry.peduncle_zbot),
    trailing_ztop=Float64(geometry.trailing_ztop),
    trailing_zbot=Float64(geometry.trailing_zbot),
    tail_etop=Float64(geometry.tail_etop),
    tail_ebot=Float64(geometry.tail_ebot),
    minimum_posterior_half_width_cells=Float64(
        geometry.minimum_posterior_half_width_cells,
    ),
)

@inline function _profiled_caudal_section_metrics(
    geometry::IntegratedProfiledCaudalSDF,
    s;
    resolved::Bool=true,
)
    Lf = Float64(geometry.body.Lf)
    section = profiled_caudal_section(geometry, s)
    widths = profiled_caudal_half_widths(geometry, s)
    W = Lf * Float64(resolved ? widths.numerical : widths.physical)
    Ztop = Lf * Float64(section.Ztop)
    Zbot = Lf * Float64(section.Zbot)
    return T3D._superellipse_section(
        W,
        Ztop,
        Zbot,
        Float64(section.etop),
        Float64(section.ebot),
    )
end

function profiled_caudal_volume_superellipse(
    geometry::IntegratedProfiledCaudalSDF{B,T};
    n_axial::Int=320,
    resolved::Bool=true,
) where {B,T}
    Lf = Float64(geometry.body.Lf)
    ds = 1.0 / n_axial
    volume = 0.0
    for index in 1:n_axial
        s = (index - 0.5) * ds
        section = _profiled_caudal_section_metrics(geometry, s; resolved)
        volume += section.area * Lf * ds
    end
    return T(volume)
end

function profiled_caudal_centroid_x_superellipse(
    geometry::IntegratedProfiledCaudalSDF{B,T};
    n_axial::Int=320,
    resolved::Bool=true,
) where {B,T}
    Lf = Float64(geometry.body.Lf)
    ds = 1.0 / n_axial
    volume = 0.0
    moment = 0.0
    for index in 1:n_axial
        s = (index - 0.5) * ds
        section = _profiled_caudal_section_metrics(geometry, s; resolved)
        strip = section.area * Lf * ds
        volume += strip
        moment += strip * s * Lf
    end
    return T(volume > 0 ? moment / volume : 0.5 * Lf)
end

function profiled_caudal_added_mass(
    geometry::IntegratedProfiledCaudalSDF{B,T};
    density::T=one(T),
    forward_coefficient::T=T(0.1),
    translational_scale::T=one(T),
    rotational_scale::T=one(T),
    n_axial::Int=320,
    reference_x=nothing,
    resolved_volume::Bool=true,
) where {B,T}
    Lf = Float64(geometry.body.Lf)
    ds = 1.0 / n_axial
    cx = reference_x === nothing ?
        Float64(profiled_caudal_centroid_x_superellipse(
            geometry; n_axial, resolved=resolved_volume,
        )) :
        Float64(reference_x)
    volume = Float64(profiled_caudal_volume_superellipse(
        geometry; n_axial, resolved=resolved_volume,
    ))
    lateral = 0.0
    yaw = 0.0
    for index in 1:n_axial
        s = (index - 0.5) * ds
        section = profiled_caudal_section(geometry, s)
        b = 0.5 * Lf * (Float64(section.Ztop) + Float64(section.Zbot))
        strip = pi * b * b * Lf * ds
        offset = s * Lf - cx
        lateral += strip
        yaw += strip * offset * offset
    end
    return (
        model="slender_body_profiled_caudal",
        forward=T(translational_scale) * T(forward_coefficient) * density * T(volume),
        lateral=T(translational_scale) * density * T(lateral),
        inertia=T(rotational_scale) * density * T(yaw),
        translational_scale=T(translational_scale),
        rotational_scale=T(rotational_scale),
        forward_coefficient=T(forward_coefficient),
        reference_volume=T(volume),
        resolved_volume=resolved_volume,
    )
end
