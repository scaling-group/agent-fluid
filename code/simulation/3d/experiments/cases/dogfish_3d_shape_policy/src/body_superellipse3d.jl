# Superellipse dogfish body — the clean SDF base for the 3D FSI swimmer.
#
# DESIGN CONTRACT ("可动但变形不乱"):
#   The body is defined ONCE in the straight spine-reference frame and is swept
#   onto the deforming spine by the shared FreeSwimmingSpineMap3D. That map sends
#   a world point to its closest spine station — returning (arc-length s·Lf +
#   tangent offset, signed normal offset, z). So every cross-section this SDF
#   sees is taken PERPENDICULAR to the local spine tangent, and its shape is a
#   pure function of s. The fish therefore bends/undulates while each section
#   stays rigid and normal to the spine: the body moves, the section never
#   shears. The tail is a SEPARATE SDF unioned (∪, = SetBody min) on with the
#   SAME map, so it bends with the peduncle. See free_swim3d.jl `compose_body_3d`.
#
# CROSS-SECTION: left-right symmetric, dorsoventrally ASYMMETRIC superellipse
#     |y/W(s)|^etop(s) + |z/Ztop(s)|^etop(s) = 1     (z ≥ 0, dorsal)
#     |y/W(s)|^ebot(s) + |z/Zbot(s)|^ebot(s) = 1     (z < 0, ventral)
#   W(s) is the SAME lateral half-width profile as the 2D case and is sampled
#   with the SAME `Base2D.profile_width` smoothstep, so the top-view outline is
#   bit-for-bit the 2D dogfish (work continuity). Ztop/Zbot/etop/ebot are the
#   dorsoventral profile the 2D source lacked, designed in the NURBS modeler.
#   Exponent 2 ⇒ ellipse; >2 ⇒ fuller, flatter-bellied section.
#
# This is an APPROXIMATE SDF (|∇d|≠1 off the cross-section axes), exact on the
# y- and z-axes; BDIM tolerates the mild error exactly as it does for the
# existing ellipse-of-revolution body (see geometry3d.jl).

# --- modeler-exported profiles: paste fresh tuples from the NURBS modeler here.
# All are body-length fractions sampled at s = 0, 1/6, 2/6, …, 1 (7 samples).
# Exported from the NURBS modeler (2026-06-12). Ends pinned to 0 ⇒ head/tail
# taper to a closed point. NOTE: this W has zero ends (vs the 2D profile's
# 0.02/0.01); it is the modeler design, so the top-view is close to but not
# bit-for-bit the 2D outline.
const BODY_W_SAMPLES    = (0f0, 0.0549f0, 0.0642f0, 0.0589f0, 0.0471f0, 0.0293f0, 0f0)   # lateral half-width
const BODY_ZTOP_SAMPLES = (0f0, 0.0474f0, 0.0553f0, 0.0510f0, 0.0407f0, 0.0246f0, 0f0)   # dorsal half-height
const BODY_ZBOT_SAMPLES = (0f0, 0.0326f0, 0.0401f0, 0.0376f0, 0.0297f0, 0.0176f0, 0f0)   # ventral half-height
const BODY_ETOP_SAMPLES = (2f0, 2.1458f0, 2.2667f0, 2.3406f0, 2.3583f0, 2.2885f0, 2f0)   # dorsal fullness
const BODY_EBOT_SAMPLES = (2f0, 1.9698f0, 1.9083f0, 1.8563f0, 1.8417f0, 1.8865f0, 2f0)   # ventral fullness

struct DogfishBodySDF{T, N} <: Function
    Lf::T
    w::Base2D.DogfishThicknessProfile{T, N}
    ztop::Base2D.DogfishThicknessProfile{T, N}
    zbot::Base2D.DogfishThicknessProfile{T, N}
    etop::Base2D.DogfishThicknessProfile{T, N}
    ebot::Base2D.DogfishThicknessProfile{T, N}
end

_to_profile(samples, ::Type{T}) where {T} =
    Base2D.DogfishThicknessProfile(Tuple(T(v) for v in samples))

function dogfish_body_sdf(
    Lf::T;
    height_scale=one(T),
    w_samples=BODY_W_SAMPLES,
    ztop_samples=BODY_ZTOP_SAMPLES,
    zbot_samples=BODY_ZBOT_SAMPLES,
    etop_samples=BODY_ETOP_SAMPLES,
    ebot_samples=BODY_EBOT_SAMPLES,
) where {T}
    typed_height_scale = T(height_scale)
    typed_height_scale > zero(T) || error("body height_scale must be positive")
    scaled_ztop = Tuple(typed_height_scale * T(value) for value in ztop_samples)
    scaled_zbot = Tuple(typed_height_scale * T(value) for value in zbot_samples)
    return DogfishBodySDF(
        Lf,
        _to_profile(w_samples, T),
        _to_profile(scaled_ztop, T),
        _to_profile(scaled_zbot, T),
        _to_profile(etop_samples, T),
        _to_profile(ebot_samples, T),
    )
end

# Evaluated in the straight reference frame produced by FreeSwimmingSpineMap3D:
#   x[1] = arc length along the spine, x[2] = signed lateral (normal) offset,
#   x[3] = dorsoventral z (z-plane already removed).
@inline function (body::DogfishBodySDF)(x, t)
    CT = typeof(x[1])
    Lf = CT(body.Lf)
    s = clamp(x[1] / Lf, zero(CT), one(CT))
    axial = max(-x[1], x[1] - Lf)                       # axial slab SDF, <0 inside [0, Lf]
    tiny = CT(1f-4) * Lf
    W = max(Lf * Base2D.profile_width(body.w, s), tiny)
    y = x[2]
    z = x[3]
    dorsal = z >= zero(CT)
    Z = max(Lf * Base2D.profile_width(dorsal ? body.ztop : body.zbot, s), tiny)
    e = CT(Base2D.profile_width(dorsal ? body.etop : body.ebot, s))
    radial = sqrt(y * y + z * z)
    cross = if radial < tiny
        -min(W, Z)                                      # on the axis: nearest wall
    else
        cphi = y / radial
        sphi = z / radial
        inv_t = (abs(cphi) / W)^e + (abs(sphi) / Z)^e   # = (1/t)^e along this ray
        radial - inv_t^(-one(CT) / e)                   # ρ − boundary radius
    end
    # Rounded extrude: section ∩ axial slab, rounded where they meet (the profile
    # tapers to ~0 at head/tail, so the ends close to smooth points).
    return min(max(cross, axial), zero(CT)) +
        sqrt(max(cross, zero(CT))^2 + max(axial, zero(CT))^2)
end

# ----------------------------------------------------------------------------
# Rigid mass properties (computed once per rollout). The cross-section is the
# same superellipse the SDF traces; we get its area and the lateral second
# moment Q_yy = ∫ y² dA exactly from the sampled boundary polygon (Green's
# theorem), then integrate along the spine. y-centroid is 0 by symmetry, so
# Q_yy about the axis equals Q_yy about the section centroid.
# ----------------------------------------------------------------------------
@inline function _superellipse_section(W, Zt, Zb, et, eb; n::Int=128)
    area = 0.0
    qyy = 0.0
    y_prev = W                                          # θ = 0 ⇒ (W, 0)
    z_prev = 0.0
    @inbounds for k in 1:n
        theta = 2.0 * pi * k / n
        c = cos(theta)
        sθ = sin(theta)
        dorsal = sθ >= 0.0
        Zk = dorsal ? Zt : Zb
        ek = dorsal ? et : eb
        y = W * sign(c) * abs(c)^(2.0 / ek)
        z = Zk * sign(sθ) * abs(sθ)^(2.0 / ek)
        crs = y_prev * z - y * z_prev
        area += crs
        qyy += crs * (y_prev * y_prev + y_prev * y + y * y)
        y_prev = y
        z_prev = z
    end
    return (area = abs(area) / 2, qyy = abs(qyy) / 12)
end

function _superellipse_profiles(body::DogfishBodySDF, s)
    Lf = Float64(body.Lf)
    return (
        W = Lf * Float64(Base2D.profile_width(body.w, s)),
        Zt = Lf * Float64(Base2D.profile_width(body.ztop, s)),
        Zb = Lf * Float64(Base2D.profile_width(body.zbot, s)),
        et = Float64(Base2D.profile_width(body.etop, s)),
        eb = Float64(Base2D.profile_width(body.ebot, s)),
    )
end

function body_volume_superellipse(body::DogfishBodySDF{T, N}; n_axial::Int=320) where {T, N}
    Lf = Float64(body.Lf)
    ds = 1.0 / n_axial
    volume = 0.0
    for i in 1:n_axial
        s = (i - 0.5) * ds
        p = _superellipse_profiles(body, s)
        volume += _superellipse_section(p.W, p.Zt, p.Zb, p.et, p.eb).area * Lf * ds
    end
    return T(volume)
end

function body_centroid_x_superellipse(body::DogfishBodySDF{T, N}; n_axial::Int=320) where {T, N}
    Lf = Float64(body.Lf)
    ds = 1.0 / n_axial
    volume = 0.0
    moment = 0.0
    for i in 1:n_axial
        s = (i - 0.5) * ds
        p = _superellipse_profiles(body, s)
        strip = _superellipse_section(p.W, p.Zt, p.Zb, p.et, p.eb).area * Lf * ds
        volume += strip
        moment += strip * (s * Lf)
    end
    return T(volume > 0 ? moment / volume : 0.5 * Lf)
end

# Volume-weight the *deformed* spine using the same modeler superellipse
# sections as DogfishBodySDF.  This is the correct moving material reference
# for a freely swimming superellipse body; geometry3d.jl's legacy centroid
# intentionally remains available for the older elliptic body.
function deformed_body_centroid_superellipse(
    generator,
    params,
    body::DogfishBodySDF{T, N},
    Lf::T,
    t::T;
    n_axial::Int=96,
) where {T, N}
    ds = one(T) / T(n_axial)
    spine = Base2D.SpineMotionMap(generator, params, Lf)
    volume = zero(T)
    first_moment = SVector(zero(T), zero(T))
    @inbounds for index in 1:n_axial
        s = (T(index) - T(0.5)) * ds
        p = _superellipse_profiles(body, s)
        section = _superellipse_section(p.W, p.Zt, p.Zb, p.et, p.eb)
        strip_volume = T(section.area) * Lf * ds
        first_moment += strip_volume * Base2D.spine_centerline(spine, s, t)
        volume += strip_volume
    end
    return first_moment / volume
end

function deformed_body_centroid_velocity_superellipse(
    generator,
    params,
    body::DogfishBodySDF{T, N},
    Lf::T,
    t::T,
    dt::T;
    n_axial::Int=96,
) where {T, N}
    dt_safe = max(abs(dt), sqrt(eps(T)) * Lf)
    forward = deformed_body_centroid_superellipse(
        generator, params, body, Lf, t + dt_safe; n_axial,
    )
    backward = deformed_body_centroid_superellipse(
        generator, params, body, Lf, t - dt_safe; n_axial,
    )
    return (forward - backward) / (T(2) * dt_safe)
end

function body_inertia_superellipse(
    body::DogfishBodySDF{T, N};
    density::T=one(T),
    n_axial::Int=320,
    reference_x=nothing,
) where {T, N}
    Lf = Float64(body.Lf)
    ds = 1.0 / n_axial
    cx = reference_x === nothing ?
        Float64(body_centroid_x_superellipse(body; n_axial)) :
        Float64(reference_x)
    inertia = 0.0
    for i in 1:n_axial
        s = (i - 0.5) * ds
        p = _superellipse_profiles(body, s)
        sec = _superellipse_section(p.W, p.Zt, p.Zb, p.et, p.eb)
        x_off = s * Lf - cx
        inertia += Float64(density) * (sec.area * x_off * x_off + sec.qyy) * Lf * ds
    end
    return T(inertia)
end

# Same NamedTuple shape as combined_body_properties_3d, folding the caudal fin in
# through the existing caudal_fin_* helpers so `fin=nothing` reproduces the
# finless body exactly.
function combined_body_properties_superellipse(
    body::DogfishBodySDF{T, N};
    density::T=one(T),
    fin::Union{Nothing, CaudalFinSDF{T}, ModelerCaudalFinSDF{T}}=nothing,
    fin_material_density::T=density,
    reference_x=nothing,
) where {T, N}
    body_volume = body_volume_superellipse(body)
    body_volume_cx = body_centroid_x_superellipse(body)
    body_mass = density * body_volume
    fin_volume = fin === nothing ? zero(T) : caudal_fin_volume(fin)
    fin_mass = fin_material_density * fin_volume
    fin_volume_cx = fin === nothing ? zero(T) : caudal_fin_centroid_x(fin)
    uniform_density_mass_cx = body_mass + fin_mass > zero(T) ?
        (body_mass * body_volume_cx + fin_mass * fin_volume_cx) / (body_mass + fin_mass) :
        body_volume_cx
    physical_mass_cx = reference_x === nothing ? uniform_density_mass_cx : T(reference_x)
    body_iz = body_inertia_superellipse(
        body;
        density,
        reference_x=physical_mass_cx,
    )

    if fin === nothing
        return (
            volume = body_volume,
            mass = body_mass,
            centroid_x = physical_mass_cx,
            physical_mass_centroid_x = physical_mass_cx,
            uniform_density_mass_centroid_x = uniform_density_mass_cx,
            body_volume_centroid_x = body_volume_cx,
            inertia_z = body_iz,
            fin_volume = zero(T),
            fin_mass = zero(T),
        )
    end

    total_mass = body_mass + fin_mass
    fin_iz = fin_material_density == zero(T) ? zero(T) :
        caudal_fin_self_inertia_z(fin; density=fin_material_density) +
        fin_mass * (fin_volume_cx - physical_mass_cx)^2

    return (
        volume = body_volume + fin_volume,
        mass = total_mass,
        centroid_x = physical_mass_cx,
        physical_mass_centroid_x = physical_mass_cx,
        uniform_density_mass_centroid_x = uniform_density_mass_cx,
        body_volume_centroid_x = body_volume_cx,
        inertia_z = body_iz + fin_iz,
        fin_volume = fin_volume,
        fin_mass = fin_mass,
    )
end

function modeler_caudal_fin(
    body::DogfishBodySDF{T};
    x_start=0.80,
    x_end=1.07,
    upper_height=0.13,
    lower_height=0.09,
    lower_tip_fraction=0.78,
    half_thickness=0.012,
    min_root_half_cells=1.0,
    min_midplane_half_cells=0.0,
) where {T}
    xs = T(x_start)
    root_upper = T(Base2D.profile_width(body.ztop, xs))
    root_lower = T(Base2D.profile_width(body.zbot, xs))
    x_upper_tip = T(x_end)
    x_lower_tip = xs + (x_upper_tip - xs) * T(lower_tip_fraction)
    root_half_thickness = max(T(half_thickness), T(min_root_half_cells) / body.Lf)
    minimum_midplane_half_thickness = T(min_midplane_half_cells) / body.Lf
    return ModelerCaudalFinSDF{T}(
        body.Lf,
        xs,
        x_upper_tip,
        x_lower_tip,
        root_upper,
        root_lower,
        T(upper_height),
        T(lower_height),
        root_half_thickness,
        minimum_midplane_half_thickness,
    )
end

# Slender-body added mass, same model and NamedTuple shape as
# free_swim_added_mass_properties_3d: each chordwise strip of vertical
# half-height b contributes ρ·π·b² to sway, with the superellipse half-height
# b ≈ (Ztop + Zbot)/2. The caudal-fin contribution is merged by the caller
# (the existing caudal_fin_added_mass path), so this is body-only.
function superellipse_added_mass(
    body::DogfishBodySDF{T, N};
    density::T=one(T),
    forward_coefficient::T=T(0.1),
    translational_scale::T=one(T),
    rotational_scale::T=one(T),
    n_axial::Int=320,
    reference_x=nothing,
) where {T, N}
    Lf = Float64(body.Lf)
    ds = 1.0 / n_axial
    cx = reference_x === nothing ?
        Float64(body_centroid_x_superellipse(body; n_axial)) :
        Float64(reference_x)
    volume = Float64(body_volume_superellipse(body; n_axial))
    lateral = 0.0
    yaw = 0.0
    for i in 1:n_axial
        s = (i - 0.5) * ds
        p = _superellipse_profiles(body, s)
        b = 0.5 * (p.Zt + p.Zb)                         # mean vertical half-height
        strip = pi * b * b * Lf * ds
        x_off = s * Lf - cx
        lateral += strip
        yaw += strip * x_off * x_off
    end
    return (
        model = "slender_body_superellipse",
        forward = T(translational_scale) * T(forward_coefficient) * density * T(volume),
        lateral = T(translational_scale) * density * T(lateral),
        inertia = T(rotational_scale) * density * T(yaw),
        translational_scale = T(translational_scale),
        rotational_scale = T(rotational_scale),
        forward_coefficient = T(forward_coefficient),
        reference_volume = T(volume),
    )
end
