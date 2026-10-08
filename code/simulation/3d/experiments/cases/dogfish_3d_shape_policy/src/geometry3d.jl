const DEFAULT_DOGFISH_HEIGHT_SCALE = 1.0f0

baseline_height_scale(::Type{T}=Float32) where {T} = T(DEFAULT_DOGFISH_HEIGHT_SCALE)

# 3D snout adaptation of the WaterLily Shark.jl (Squalus acanthias) lateral
# half-widths: ONLY the nose sample is raised 0.02 -> 0.03 so the swept 3D
# snout reads as a smooth rounded taper instead of a thin nose-ball. Every
# other sample is the official profile, so the 2D top-view outline is
# essentially unchanged and the 2D case is left completely untouched.
const DOGFISH3D_WIDTH_SAMPLES = (0.03f0, 0.07f0, 0.06f0, 0.048f0, 0.03f0, 0.019f0, 0.01f0)
dogfish3d_thickness_profile(::Type{T}=Float32) where {T} =
    Base2D.DogfishThicknessProfile(Tuple(T(v) for v in DOGFISH3D_WIDTH_SAMPLES))

# Dorsoventral height-to-width ratio ρ(s)=h(s)/w(s) for the spiny dogfish
# (Squalus acanthias). Biology: a slender, near-cylindrical trunk (Squalidae
# "rounded or oval", ρ slightly >1 from the dorsal musculature/spine) and a
# dorsoventrally flattened head/snout (ρ<1). The lateral half-width w(s) is the
# WaterLily Shark.jl profile; this adds the z dimension the 2D source lacked.
const DOGFISH_RHO_HEAD = 0.75f0   # flattened head (width > height)
const DOGFISH_RHO_MAX = 1.05f0    # near-circular trunk, faintly tall-oval
const DOGFISH_RHO_SIGMA = 0.18f0  # head→trunk transition scale

@inline function height_ratio(s::T) where {T}
    sc = clamp(s, zero(T), one(T))
    return T(DOGFISH_RHO_MAX) -
        (T(DOGFISH_RHO_MAX) - T(DOGFISH_RHO_HEAD)) * exp(-(sc / T(DOGFISH_RHO_SIGMA))^2)
end

# Elliptical-section dogfish body swept on the bendable spine: straight fish
# along +x, lateral half-width Lf*w(s), dorsoventral half-height
# Lf*height_scale*ρ(s)*w(s). With ρ(s)≠1 (or height_scale≠1) the field is an
# approximate SDF (|∇d|≠1 along z); BDIM tolerates this for the mild aspect
# ratios here, and the AutoBody metric normalization absorbs first-order error.
struct Dogfish3DSDF{T, N} <: Function
    Lf::T
    thickness::Base2D.DogfishThicknessProfile{T, N}
    height_scale::T
end

function Dogfish3DSDF(Lf::T, thickness::Base2D.DogfishThicknessProfile{T, N}) where {T, N}
    return Dogfish3DSDF{T, N}(Lf, thickness, T(DEFAULT_DOGFISH_HEIGHT_SCALE))
end

@inline function (body::Dogfish3DSDF)(x, t)
    coordinate_type = typeof(x[1])
    Lf = coordinate_type(body.Lf)
    s = clamp(x[1] / Lf, zero(coordinate_type), one(coordinate_type))
    dx = x[1] - Lf * s
    dy = x[2]
    dz = x[3] / (coordinate_type(body.height_scale) * height_ratio(s))
    radius = Lf * Base2D.profile_width(body.thickness, s)
    return sqrt(dx * dx + dy * dy + dz * dz) - radius
end

function body_volume_from_profile_3d(
    profile::Base2D.DogfishThicknessProfile{T, N},
    Lf::T;
    height_scale::T=one(T),
) where {T, N}
    n_segments = 320
    ds = one(T) / T(n_segments)
    volume = zero(T)
    for index in 1:n_segments
        s = (T(index) - T(0.5)) * ds
        radius = Lf * Base2D.profile_width(profile, s)
        volume += T(pi) * height_scale * height_ratio(s) * radius * radius * Lf * ds
    end
    return volume
end

function body_centroid_x_from_profile_3d(
    profile::Base2D.DogfishThicknessProfile{T, N},
    Lf::T;
    height_scale::T=one(T),
) where {T, N}
    n_segments = 320
    ds = one(T) / T(n_segments)
    volume = zero(T)
    first_moment_x = zero(T)
    for index in 1:n_segments
        s = (T(index) - T(0.5)) * ds
        radius = Lf * Base2D.profile_width(profile, s)
        strip_volume = T(pi) * height_scale * height_ratio(s) * radius * radius * Lf * ds
        first_moment_x += strip_volume * (s * Lf)
        volume += strip_volume
    end
    return first_moment_x / volume
end

# Yaw (z-axis) inertia of the swept body at neutral buoyancy. Each elliptical
# section contributes its own in-plane second moment (radius^2 / 4 term) plus
# the parallel-axis term about the volume centroid.
function body_inertia_from_profile_3d(
    profile::Base2D.DogfishThicknessProfile{T, N},
    Lf::T;
    density::T=one(T),
    height_scale::T=one(T),
) where {T, N}
    n_segments = 320
    ds = one(T) / T(n_segments)
    centroid_x = body_centroid_x_from_profile_3d(profile, Lf; height_scale)
    inertia = zero(T)
    for index in 1:n_segments
        s = (T(index) - T(0.5)) * ds
        radius = Lf * Base2D.profile_width(profile, s)
        strip_volume = T(pi) * height_scale * height_ratio(s) * radius * radius * Lf * ds
        x_offset = s * Lf - centroid_x
        inertia += density * strip_volume * (x_offset * x_offset + radius * radius / T(4))
    end
    return inertia
end

# Slender-body added-mass model for the 3D swept body:
#   - sway (lateral): per-length 2D section added mass rho * pi * (h*r)^2,
#     integrated along the spine;
#   - yaw: same density weighted by the squared centroid offset;
#   - surge (forward): prolate-spheroid-like fraction of displaced mass.
function free_swim_added_mass_properties_3d(
    profile::Base2D.DogfishThicknessProfile{T, N},
    Lf::T;
    density::T=one(T),
    height_scale::T=one(T),
    forward_coefficient::T=T(0.1),
    translational_scale::T=one(T),
    rotational_scale::T=one(T),
) where {T, N}
    n_segments = 320
    ds = one(T) / T(n_segments)
    centroid_x = body_centroid_x_from_profile_3d(profile, Lf; height_scale)
    volume = zero(T)
    lateral_integral = zero(T)
    yaw_integral = zero(T)
    for index in 1:n_segments
        s = (T(index) - T(0.5)) * ds
        radius = Lf * Base2D.profile_width(profile, s)
        section = T(pi) * (height_scale * height_ratio(s))^2 * radius * radius * Lf * ds
        volume += T(pi) * height_scale * height_ratio(s) * radius * radius * Lf * ds
        x_offset = s * Lf - centroid_x
        lateral_integral += section
        yaw_integral += section * x_offset * x_offset
    end
    added_forward = translational_scale * forward_coefficient * density * volume
    added_lateral = translational_scale * density * lateral_integral
    added_inertia = rotational_scale * density * yaw_integral
    return (
        model="slender_body_of_revolution",
        forward=added_forward,
        lateral=added_lateral,
        inertia=added_inertia,
        translational_scale=translational_scale,
        rotational_scale=rotational_scale,
        forward_coefficient=forward_coefficient,
        height_scale=height_scale,
        reference_volume=volume,
    )
end

# Volume-weighted centroid of the deformed body in the spine reference frame.
# The spine deforms only in the (x, y) plane, so the centroid stays at z = 0
# and the planar bookkeeping from the 2D case carries over unchanged.
function deformed_body_centroid_3d(
    generator,
    params,
    profile::Base2D.DogfishThicknessProfile{T, N},
    Lf::T,
    t::T;
    height_scale::T=one(T),
) where {T, N}
    n_segments = 96
    ds = one(T) / T(n_segments)
    spine_map = Base2D.SpineMotionMap(generator, params, Lf)
    volume = zero(T)
    first_moment = SVector(zero(T), zero(T))

    for index in 1:n_segments
        s = (T(index) - T(0.5)) * ds
        radius = Lf * Base2D.profile_width(profile, s)
        strip_volume = T(pi) * height_scale * height_ratio(s) * radius * radius * Lf * ds
        centerline = Base2D.spine_centerline(spine_map, s, t)
        first_moment += strip_volume * centerline
        volume += strip_volume
    end

    return first_moment / volume
end

function deformed_body_centroid_velocity_3d(
    generator,
    params,
    profile,
    Lf::T,
    t::T,
    dt::T;
    height_scale::T=one(T),
) where {T}
    dt_safe = max(abs(dt), sqrt(eps(T)) * Lf)
    c_forward = deformed_body_centroid_3d(generator, params, profile, Lf, t + dt_safe; height_scale)
    c_backward = deformed_body_centroid_3d(generator, params, profile, Lf, t - dt_safe; height_scale)
    return (c_forward - c_backward) / (T(2) * dt_safe)
end
