# Caudal fin for the 3D dogfish (path B: separate thin-tall surface unioned to
# the body of revolution via WaterLily's `∪`/SetBody). The fin lives in the
# same spine reference frame as the body, so it shares the motion map and bends
# /sweeps with the peduncle — which is where undulatory thrust comes from.
#
# Shape: a FAN tail in the (x, z) plane — thin in y (lateral), with vertical
# half-height H(x) growing smoothly from ~0 at the peduncle (x_start) to its
# maximum at the trailing edge (x_end), so the leading edge tapers into the
# body (no seam) and the trailing edge is the tall span that generates thrust.
# The axis stays straight along x (no rake/sweep yet); a crescent/forked tail
# is a later refinement. See docs/caudal_fin_analysis_2026-06-10.md.

struct CaudalFinSDF{T} <: Function
    Lf::T
    x_start::T        # fraction of body length, leading edge at the peduncle
    x_end::T          # fraction, trailing edge (may exceed 1 = past the body)
    height::T         # fraction, trailing-edge vertical half-height (max span/2)
    half_thickness::T # fraction, lateral half-thickness (BDIM-clamped)
end

# Modeler-faithful heterocercal caudal foil. This is the ruled quadrilateral
# exported by nurbs_body_modeler.html: the upper and lower tips have independent
# heights/axial stations and the lateral thickness tapers toward every edge.
struct ModelerCaudalFinSDF{T} <: Function
    Lf::T
    x_start::T
    x_upper_tip::T
    x_lower_tip::T
    root_upper::T
    root_lower::T
    upper_height::T
    lower_height::T
    root_half_thickness::T
    minimum_midplane_half_thickness::T
end

@inline _cross2(ax, az, bx, bz) = ax * bz - az * bx

@inline function _modeler_edge_distance(ax, az, bx, bz, px, pz)
    T = typeof(px)
    ex, ez = bx - ax, bz - az
    return _cross2(ex, ez, px - ax, pz - az) / max(sqrt(ex^2 + ez^2), eps(T))
end

@inline function _modeler_surface_coordinates(fin::ModelerCaudalFinSDF{T}, u, v) where {T}
    one_u = one(T) - u
    one_v = one(T) - v
    root_z = one_u * fin.root_upper - u * fin.root_lower
    tip_x = one_u * fin.x_upper_tip + u * fin.x_lower_tip
    tip_z = one_u * fin.upper_height - u * fin.lower_height
    x = one_v * fin.x_start + v * tip_x
    z = one_v * root_z + v * tip_z
    return x, z
end

@inline function _modeler_surface_jacobian(fin::ModelerCaudalFinSDF{T}, u, v) where {T}
    root_dz_du = -(fin.root_upper + fin.root_lower)
    tip_dx_du = fin.x_lower_tip - fin.x_upper_tip
    tip_dz_du = -(fin.upper_height + fin.lower_height)
    root_z = (one(T) - u) * fin.root_upper - u * fin.root_lower
    tip_x = (one(T) - u) * fin.x_upper_tip + u * fin.x_lower_tip
    tip_z = (one(T) - u) * fin.upper_height - u * fin.lower_height
    dx_du = v * tip_dx_du
    dz_du = (one(T) - v) * root_dz_du + v * tip_dz_du
    dx_dv = tip_x - fin.x_start
    dz_dv = tip_z - root_z
    return dx_du, dz_du, dx_dv, dz_dv
end

@inline function _modeler_uv(fin::ModelerCaudalFinSDF{T}, px, pz) where {T}
    root_span = max(fin.root_upper + fin.root_lower, eps(T))
    u = clamp((fin.root_upper - pz) / root_span, zero(T), one(T))
    tip_x = (one(T) - u) * fin.x_upper_tip + u * fin.x_lower_tip
    v = clamp((px - fin.x_start) / max(tip_x - fin.x_start, eps(T)), zero(T), one(T))
    # Four fixed Newton steps keep this allocation-free and CUDA-compatible.
    for _ in 1:4
        sx, sz = _modeler_surface_coordinates(fin, u, v)
        dx_du, dz_du, dx_dv, dz_dv = _modeler_surface_jacobian(fin, u, v)
        rx = sx - px
        rz = sz - pz
        det = _cross2(dx_du, dz_du, dx_dv, dz_dv)
        if abs(det) > eps(T)
            delta_u = _cross2(rx, rz, dx_dv, dz_dv) / det
            delta_v = _cross2(dx_du, dz_du, rx, rz) / det
            u = clamp(u - delta_u, -T(0.25), T(1.25))
            v = clamp(v - delta_v, -T(0.25), T(1.25))
        end
    end
    return clamp(u, zero(T), one(T)), clamp(v, zero(T), one(T))
end

@inline function _modeler_thickness_fraction(fin::ModelerCaudalFinSDF{T}, u, v) where {T}
    span_taper = max(zero(T), one(T) - v)^T(0.85)
    chord_position = T(2) * u - one(T)
    chord_taper = T(0.16) + T(0.84) * sqrt(max(zero(T), one(T) - chord_position^2))
    modeler_thickness = fin.root_half_thickness * span_taper * chord_taper
    # At exploratory L16 only, a sub-cell foil can disappear between sampled
    # grid points even though its continuous SDF is connected.  A narrow medial
    # web keeps one resolved cell along the chord without thickening the dorsal
    # or ventral edges.  The default is zero, so L32+ retains the modeler foil.
    medial_taper = max(zero(T), one(T) - chord_position^2)
    medial_web = fin.minimum_midplane_half_thickness * medial_taper
    return max(modeler_thickness, medial_web)
end

@inline function _modeler_planar_distance_fraction(fin::ModelerCaudalFinSDF{T}, px, pz) where {T}
    # Clockwise quadrilateral: root-top -> upper-tip -> lower-tip -> root-bottom.
    x0, z0 = fin.x_start, fin.root_upper
    x1, z1 = fin.x_upper_tip, fin.upper_height
    x2, z2 = fin.x_lower_tip, -fin.lower_height
    x3, z3 = fin.x_start, -fin.root_lower
    return max(
        _modeler_edge_distance(x0, z0, x1, z1, px, pz),
        _modeler_edge_distance(x1, z1, x2, z2, px, pz),
        _modeler_edge_distance(x2, z2, x3, z3, px, pz),
        _modeler_edge_distance(x3, z3, x0, z0, px, pz),
    )
end

@inline function (fin::ModelerCaudalFinSDF)(x, t)
    CT = typeof(x[1])
    Lf = CT(fin.Lf)
    px = x[1] / Lf
    pz = x[3] / Lf
    u, v = _modeler_uv(fin, px, pz)
    planar = Lf * _modeler_planar_distance_fraction(fin, px, pz)
    half_thickness = Lf * _modeler_thickness_fraction(fin, u, v)
    lateral = abs(x[2]) - half_thickness
    return max(planar, lateral)
end

# C2 smootherstep on [0,1].
@inline _fan_smooth(u::T) where {T} = (uc = clamp(u, zero(T), one(T));
    uc * uc * uc * (uc * (uc * T(6) - T(15)) + T(10)))

# Fan half-height as a fraction of body length at axial fraction position.
@inline function _fan_height_frac(fin::CaudalFinSDF{T}, x_frac) where {T}
    span = max(fin.x_end - fin.x_start, eps(T))
    return fin.height * _fan_smooth((x_frac - fin.x_start) / span)
end

# BDIM resolves interfaces over ε≈1 cell; a sheet thinner than ~2 cells leaks
# flow. Clamp lateral half-thickness to ≥ min_cells cells so the fin is
# watertight at any L (at L=64 the clamp barely binds).
function caudal_fin(
    Lf::T;
    x_start=0.70,
    x_end=1.02,
    height=0.12,
    half_thickness=0.012,
    min_cells=1.0,
) where {T}
    ht = max(T(half_thickness), T(min_cells) / Lf)
    return CaudalFinSDF{T}(Lf, T(x_start), T(x_end), T(height), ht)
end

@inline function (fin::CaudalFinSDF)(x, t)
    CT = typeof(x[1])
    Lf = CT(fin.Lf)
    xs = Lf * CT(fin.x_start)
    xe = Lf * CT(fin.x_end)
    H = Lf * _fan_height_frac(fin, x[1] / Lf)   # vertical half-height here
    d_z = abs(x[3]) - H                          # outside the fan in z
    d_axial = max(xs - x[1], x[1] - xe)          # outside the [xs, xe] band
    d_y = abs(x[2]) - Lf * CT(fin.half_thickness)
    return max(d_z, d_axial, d_y)                # thin fan plate
end

# --- fin contributions to the rigid mass properties (numerical integration) ---
# Cross-section area at x is (2H)(2t); integrate along the chord. All grid units.
const _FAN_QUADRATURE = 320

function caudal_fin_volume(fin::CaudalFinSDF{T}) where {T}
    span = fin.x_end - fin.x_start
    du = one(T) / T(_FAN_QUADRATURE)
    thickness = T(2) * fin.Lf * fin.half_thickness
    acc = zero(T)
    for i in 1:_FAN_QUADRATURE
        u = (T(i) - T(0.5)) * du
        x_frac = fin.x_start + u * span
        H = fin.Lf * _fan_height_frac(fin, x_frac)
        acc += T(2) * H * thickness * (fin.Lf * span * du)
    end
    return acc
end

function caudal_fin_centroid_x(fin::CaudalFinSDF{T}) where {T}
    span = fin.x_end - fin.x_start
    du = one(T) / T(_FAN_QUADRATURE)
    area_acc = zero(T)
    moment_acc = zero(T)
    for i in 1:_FAN_QUADRATURE
        u = (T(i) - T(0.5)) * du
        x_frac = fin.x_start + u * span
        x_grid = fin.Lf * x_frac
        H = fin.Lf * _fan_height_frac(fin, x_frac)
        strip = T(2) * H * (fin.Lf * span * du)   # area weight (thickness cancels)
        area_acc += strip
        moment_acc += strip * x_grid
    end
    return area_acc > zero(T) ? moment_acc / area_acc : fin.Lf * fin.x_end
end

# Self yaw-inertia about the fin's own centroid; lateral (y) extent negligible.
function caudal_fin_self_inertia_z(fin::CaudalFinSDF{T}; density::T=one(T)) where {T}
    span = fin.x_end - fin.x_start
    du = one(T) / T(_FAN_QUADRATURE)
    thickness = T(2) * fin.Lf * fin.half_thickness
    cx = caudal_fin_centroid_x(fin)
    acc = zero(T)
    for i in 1:_FAN_QUADRATURE
        u = (T(i) - T(0.5)) * du
        x_frac = fin.x_start + u * span
        x_grid = fin.Lf * x_frac
        H = fin.Lf * _fan_height_frac(fin, x_frac)
        dm = density * T(2) * H * thickness * (fin.Lf * span * du)
        acc += dm * (x_grid - cx)^2
    end
    return acc
end

# Slender-body lateral added mass of the fan: each chordwise strip of vertical
# half-height H contributes ρ·π·H² per unit length; yaw via parallel axis.
function caudal_fin_added_mass(
    fin::CaudalFinSDF{T};
    density::T=one(T),
    centroid_x::T=caudal_fin_centroid_x(fin),
) where {T}
    span = fin.x_end - fin.x_start
    du = one(T) / T(_FAN_QUADRATURE)
    lateral = zero(T)
    inertia = zero(T)
    for i in 1:_FAN_QUADRATURE
        u = (T(i) - T(0.5)) * du
        x_frac = fin.x_start + u * span
        x_grid = fin.Lf * x_frac
        H = fin.Lf * _fan_height_frac(fin, x_frac)
        dm = density * T(pi) * H * H * (fin.Lf * span * du)
        lateral += dm
        inertia += dm * (x_grid - centroid_x)^2
    end
    return (lateral=lateral, inertia=inertia)
end

const _MODELER_FIN_QUADRATURE = 96

function caudal_fin_volume(fin::ModelerCaudalFinSDF{T}) where {T}
    du = one(T) / T(_MODELER_FIN_QUADRATURE)
    dv = du
    volume = zero(T)
    for iu in 1:_MODELER_FIN_QUADRATURE, iv in 1:_MODELER_FIN_QUADRATURE
        u = (T(iu) - T(0.5)) * du
        v = (T(iv) - T(0.5)) * dv
        dx_du, dz_du, dx_dv, dz_dv = _modeler_surface_jacobian(fin, u, v)
        jacobian = abs(_cross2(dx_du, dz_du, dx_dv, dz_dv))
        half_thickness = _modeler_thickness_fraction(fin, u, v)
        volume += T(2) * fin.Lf^3 * half_thickness * jacobian * du * dv
    end
    return volume
end

function caudal_fin_centroid_x(fin::ModelerCaudalFinSDF{T}) where {T}
    du = one(T) / T(_MODELER_FIN_QUADRATURE)
    dv = du
    volume = zero(T)
    moment = zero(T)
    for iu in 1:_MODELER_FIN_QUADRATURE, iv in 1:_MODELER_FIN_QUADRATURE
        u = (T(iu) - T(0.5)) * du
        v = (T(iv) - T(0.5)) * dv
        x_frac, _ = _modeler_surface_coordinates(fin, u, v)
        dx_du, dz_du, dx_dv, dz_dv = _modeler_surface_jacobian(fin, u, v)
        jacobian = abs(_cross2(dx_du, dz_du, dx_dv, dz_dv))
        half_thickness = _modeler_thickness_fraction(fin, u, v)
        dvolume = T(2) * fin.Lf^3 * half_thickness * jacobian * du * dv
        volume += dvolume
        moment += dvolume * fin.Lf * x_frac
    end
    return volume > zero(T) ? moment / volume : fin.Lf * fin.x_upper_tip
end

function caudal_fin_self_inertia_z(
    fin::ModelerCaudalFinSDF{T}; density::T=one(T),
) where {T}
    du = one(T) / T(_MODELER_FIN_QUADRATURE)
    dv = du
    centroid_x = caudal_fin_centroid_x(fin)
    inertia = zero(T)
    for iu in 1:_MODELER_FIN_QUADRATURE, iv in 1:_MODELER_FIN_QUADRATURE
        u = (T(iu) - T(0.5)) * du
        v = (T(iv) - T(0.5)) * dv
        x_frac, _ = _modeler_surface_coordinates(fin, u, v)
        dx_du, dz_du, dx_dv, dz_dv = _modeler_surface_jacobian(fin, u, v)
        jacobian = abs(_cross2(dx_du, dz_du, dx_dv, dz_dv))
        half_thickness_frac = _modeler_thickness_fraction(fin, u, v)
        dvolume = T(2) * fin.Lf^3 * half_thickness_frac * jacobian * du * dv
        x_offset = fin.Lf * x_frac - centroid_x
        half_thickness = fin.Lf * half_thickness_frac
        inertia += density * dvolume * (x_offset^2 + half_thickness^2 / T(3))
    end
    return inertia
end

@inline function _modeler_vertical_bounds(fin::ModelerCaudalFinSDF{T}, x_frac) where {T}
    top_alpha = clamp(
        (x_frac - fin.x_start) / max(fin.x_upper_tip - fin.x_start, eps(T)),
        zero(T), one(T),
    )
    top = fin.root_upper + top_alpha * (fin.upper_height - fin.root_upper)
    bottom = if x_frac <= fin.x_lower_tip
        alpha = clamp(
            (x_frac - fin.x_start) / max(fin.x_lower_tip - fin.x_start, eps(T)),
            zero(T), one(T),
        )
        -fin.root_lower + alpha * (-fin.lower_height + fin.root_lower)
    else
        alpha = clamp(
            (x_frac - fin.x_lower_tip) /
            max(fin.x_upper_tip - fin.x_lower_tip, eps(T)),
            zero(T), one(T),
        )
        -fin.lower_height + alpha * (fin.upper_height + fin.lower_height)
    end
    return bottom, top
end

function caudal_fin_added_mass(
    fin::ModelerCaudalFinSDF{T};
    density::T=one(T),
    centroid_x::T=caudal_fin_centroid_x(fin),
) where {T}
    n = _FAN_QUADRATURE
    dx_frac = (fin.x_upper_tip - fin.x_start) / T(n)
    lateral = zero(T)
    inertia = zero(T)
    for index in 1:n
        x_frac = fin.x_start + (T(index) - T(0.5)) * dx_frac
        lower, upper = _modeler_vertical_bounds(fin, x_frac)
        half_span = max(zero(T), (upper - lower) / T(2)) * fin.Lf
        dx = fin.Lf * dx_frac
        dm = density * T(pi) * half_span^2 * dx
        x_offset = fin.Lf * x_frac - centroid_x
        lateral += dm
        inertia += dm * x_offset^2
    end
    return (lateral=lateral, inertia=inertia)
end

# Combined body+fin rigid properties about the combined centroid. `fin=nothing`
# reproduces the finless numbers exactly.
function combined_body_properties_3d(
    profile::Base2D.DogfishThicknessProfile{T, N},
    Lf::T;
    density::T=one(T),
    height_scale::T=one(T),
    fin::Union{Nothing, CaudalFinSDF{T}, ModelerCaudalFinSDF{T}}=nothing,
) where {T, N}
    body_volume = body_volume_from_profile_3d(profile, Lf; height_scale)
    body_cx = body_centroid_x_from_profile_3d(profile, Lf; height_scale)
    body_iz = body_inertia_from_profile_3d(profile, Lf; density, height_scale)
    body_mass = density * body_volume

    if fin === nothing
        return (
            volume=body_volume,
            mass=body_mass,
            centroid_x=body_cx,
            inertia_z=body_iz,
            fin_volume=zero(T),
        )
    end

    fin_volume = caudal_fin_volume(fin)
    fin_mass = density * fin_volume
    fin_cx = caudal_fin_centroid_x(fin)
    total_volume = body_volume + fin_volume
    total_mass = body_mass + fin_mass
    centroid_x = (body_mass * body_cx + fin_mass * fin_cx) / total_mass

    body_iz_combined = body_iz + body_mass * (body_cx - centroid_x)^2
    fin_iz_combined =
        caudal_fin_self_inertia_z(fin; density) + fin_mass * (fin_cx - centroid_x)^2

    return (
        volume=total_volume,
        mass=total_mass,
        centroid_x=centroid_x,
        inertia_z=body_iz_combined + fin_iz_combined,
        fin_volume=fin_volume,
    )
end
