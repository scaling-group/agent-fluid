const DEFAULT_DOGFISH_WIDTH_SAMPLES = (
    0.02f0,
    0.07f0,
    0.06f0,
    0.048f0,
    0.03f0,
    0.019f0,
    0.01f0,
)

struct DogfishThicknessProfile{T, N}
    widths::NTuple{N, T}
end

struct DogfishSDF{T, N} <: Function
    Lf::T
    thickness::DogfishThicknessProfile{T, N}
end

struct CandidateMorphologySDF{T, F, P} <: Function
    Lf::T
    generator::F
    params::P
end

function baseline_thickness_profile(::Type{T}=Float32) where {T}
    return DogfishThicknessProfile(Tuple(T(value) for value in DEFAULT_DOGFISH_WIDTH_SAMPLES))
end

function baseline_morphology_parameters(::Type{T}=Float32) where {T}
    return (
        profile = "baseline_width_samples_v0",
        width_samples = Tuple(T(value) for value in DEFAULT_DOGFISH_WIDTH_SAMPLES),
    )
end

@inline function profile_width(profile::DogfishThicknessProfile{T, N}, s::S) where {T, N, S}
    s_clamped = clamp(s, zero(S), one(S))
    scaled = s_clamped * S(N - 1)
    lower_index = clamp(floor(Int, scaled) + 1, 1, N - 1)
    alpha = scaled - S(lower_index - 1)
    smooth_alpha = alpha * alpha * (S(3) - S(2) * alpha)
    w0 = S(profile.widths[lower_index])
    w1 = S(profile.widths[lower_index + 1])
    return muladd(smooth_alpha, w1 - w0, w0)
end

@inline function (body::DogfishSDF)(x, t)
    coordinate_type = typeof(x[1])
    Lf = coordinate_type(body.Lf)
    s = clamp(x[1] / Lf, zero(coordinate_type), one(coordinate_type))
    centerline = Lf * SVector(s, zero(s))
    return sqrt(sum(abs2, x - centerline)) - Lf * profile_width(body.thickness, s)
end

@inline function (body::CandidateMorphologySDF)(x, t)
    coordinate_type = typeof(x[1])
    Lf = coordinate_type(body.Lf)
    s = clamp(x[1] / Lf, zero(coordinate_type), one(coordinate_type))
    centerline = Lf * SVector(s, zero(s))
    width = body.generator(s, body.params)
    return sqrt(sum(abs2, x - centerline)) - Lf * coordinate_type(width)
end
