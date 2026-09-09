struct CandidateMotionMap{T, F, P} <: Function
    generator::F
    params::P
    Lf::T
end

struct SpineMotionMap{T, F, P} <: Function
    generator::F
    params::P
    Lf::T
end

const SPINE_ARC_QUADRATURE_STEPS = 32
const SPINE_PROJECTION_ITERATIONS = 6

@inline function normalized_exp(s, beta)
    abs(beta) < 1f-6 && return s
    return expm1(beta * s) / expm1(beta)
end

@inline function (map::CandidateMotionMap)(x, t)
    coordinate_type = typeof(x[1])
    Lf = coordinate_type(map.Lf)
    xc = x .- Lf
    s = clamp(xc[1] / Lf, zero(coordinate_type), one(coordinate_type))
    dy_unit = map.generator(s, t, map.params)
    dy = Lf * dy_unit
    return xc - SVector(zero(dy), dy)
end

@inline function spine_angle(map::SpineMotionMap, s, t)
    return map.generator(s, t, map.params)
end

@inline function spine_tangent(map::SpineMotionMap, s, t)
    theta = spine_angle(map, s, t)
    return SVector(cos(theta), sin(theta))
end

@inline function spine_normal(map::SpineMotionMap, s, t)
    tangent = spine_tangent(map, s, t)
    return SVector(-tangent[2], tangent[1])
end

@inline function spine_centerline(map::SpineMotionMap, s, t)
    scalar_type = typeof(s)
    s_clamped = clamp(s, zero(scalar_type), one(scalar_type))
    ds = s_clamped / scalar_type(SPINE_ARC_QUADRATURE_STEPS)
    x_accum = zero(s_clamped)
    y_accum = zero(s_clamped)

    for index in 1:SPINE_ARC_QUADRATURE_STEPS
        sample_s = (scalar_type(index) - scalar_type(0.5)) * ds
        tangent = spine_tangent(map, sample_s, t)
        x_accum += tangent[1] * ds
        y_accum += tangent[2] * ds
    end

    Lf = scalar_type(map.Lf)
    return Lf * SVector(x_accum, y_accum)
end

@inline function closest_spine_reference_coordinate(map::SpineMotionMap, q, t)
    coordinate_type = typeof(q[1])
    Lf = coordinate_type(map.Lf)
    s = clamp(q[1] / Lf, zero(coordinate_type), one(coordinate_type))

    for _ in 1:SPINE_PROJECTION_ITERATIONS
        center = spine_centerline(map, s, t)
        tangent = spine_tangent(map, s, t)
        tangent_offset = sum((q - center) .* tangent)
        s = clamp(s + tangent_offset / Lf, zero(coordinate_type), one(coordinate_type))
    end

    center = spine_centerline(map, s, t)
    delta = q - center
    tangent = spine_tangent(map, s, t)
    normal = SVector(-tangent[2], tangent[1])
    tangent_offset = sum(delta .* tangent)
    normal_offset = sum(delta .* normal)
    return SVector(s * Lf + tangent_offset, normal_offset)
end

@inline function (map::SpineMotionMap)(x, t)
    coordinate_type = typeof(x[1])
    Lf = coordinate_type(map.Lf)
    q = x - SVector(Lf, Lf)
    return closest_spine_reference_coordinate(map, q, t)
end

function spine_outline_points(
    map::SpineMotionMap,
    profile::DogfishThicknessProfile{T, N},
    t;
    samples::Int=128,
) where {T, N}
    upper = Vector{SVector{2, Float64}}(undef, samples + 1)
    lower = Vector{SVector{2, Float64}}(undef, samples + 1)
    coordinate_type = typeof(map.Lf)
    typed_t = coordinate_type(t)

    for index in 0:samples
        s = coordinate_type(index) / coordinate_type(samples)
        center = spine_centerline(map, s, typed_t)
        normal = spine_normal(map, s, typed_t)
        half_width = coordinate_type(map.Lf) * profile_width(profile, s)
        upper[index + 1] = SVector(Float64(center[1] + half_width * normal[1]), Float64(center[2] + half_width * normal[2]))
        lower[index + 1] = SVector(Float64(center[1] - half_width * normal[1]), Float64(center[2] - half_width * normal[2]))
    end

    return (
        upper=upper,
        lower=lower,
        closed=vcat(upper, reverse(lower)),
    )
end
