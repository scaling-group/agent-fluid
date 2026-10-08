# One-piece body/peduncle/caudal geometry for the isolated capability branch.
#
# This deliberately reuses DogfishBodySDF and its seven uniformly spaced
# DogfishThicknessProfile samples.  It therefore inherits the existing moving
# spine, deformed centroid, volume, dry inertia and analytical added-mass code.
# There is no SetBody union and no separate caudal material region.

const INTEGRATED_CAUDAL_WIDTH_SAMPLES =
    (0f0, 0.0549f0, 0.0642f0, 0.0589f0, 0.0471f0, 0.025f0, 0.016f0)
const INTEGRATED_CAUDAL_ZTOP_BODY_SAMPLES =
    (0f0, 0.0474f0, 0.0553f0, 0.0510f0, 0.0407f0, 0.022f0)
const INTEGRATED_CAUDAL_ZBOT_BODY_SAMPLES =
    (0f0, 0.0326f0, 0.0401f0, 0.0376f0, 0.0297f0, 0.016f0)
const INTEGRATED_CAUDAL_ETOP_SAMPLES =
    (2f0, 2.1458f0, 2.2667f0, 2.3406f0, 2.3583f0, 2.1f0, 2f0)
const INTEGRATED_CAUDAL_EBOT_SAMPLES =
    (2f0, 1.9698f0, 1.9083f0, 1.8563f0, 1.8417f0, 1.95f0, 2f0)

function integrated_body_caudal_sdf(
    module_3d,
    Lf::T;
    variant::Symbol=:balanced,
    body_height_scale=one(T),
    caudal_span_scale=one(T),
    peduncle_half_width=0.025,
    tail_half_width=0.016,
) where {T}
    variant in (:compact, :balanced, :strong) ||
        error("integrated caudal variant must be compact, balanced or strong")
    body_scale = T(body_height_scale)
    span_scale = T(caudal_span_scale)
    body_scale > zero(T) || error("body_height_scale must be positive")
    span_scale > zero(T) || error("caudal_span_scale must be positive")
    zero(T) < T(tail_half_width) <= T(peduncle_half_width) ||
        error("tail half-width must be positive and no larger than peduncle half-width")
    T(peduncle_half_width) < T(INTEGRATED_CAUDAL_WIDTH_SAMPLES[5]) ||
        error("peduncle half-width must remain narrower than posterior body")

    terminal_upper = variant == :compact ? T(0.095) :
        variant == :balanced ? T(0.115) : T(0.130)
    terminal_lower = variant == :compact ? T(0.065) :
        variant == :balanced ? T(0.080) : T(0.090)
    terminal_upper *= span_scale
    terminal_lower *= span_scale
    peduncle_upper = body_scale * T(INTEGRATED_CAUDAL_ZTOP_BODY_SAMPLES[end])
    peduncle_lower = body_scale * T(INTEGRATED_CAUDAL_ZBOT_BODY_SAMPLES[end])
    terminal_upper > peduncle_upper && terminal_lower > peduncle_lower ||
        error("integrated caudal terminal span must exceed the peduncle span")

    width = (
        T(INTEGRATED_CAUDAL_WIDTH_SAMPLES[1]),
        T(INTEGRATED_CAUDAL_WIDTH_SAMPLES[2]),
        T(INTEGRATED_CAUDAL_WIDTH_SAMPLES[3]),
        T(INTEGRATED_CAUDAL_WIDTH_SAMPLES[4]),
        T(INTEGRATED_CAUDAL_WIDTH_SAMPLES[5]),
        T(peduncle_half_width),
        T(tail_half_width),
    )
    ztop = (
        (body_scale * T(value) for value in INTEGRATED_CAUDAL_ZTOP_BODY_SAMPLES)...,
        terminal_upper,
    )
    zbot = (
        (body_scale * T(value) for value in INTEGRATED_CAUDAL_ZBOT_BODY_SAMPLES)...,
        terminal_lower,
    )
    return module_3d.DogfishBodySDF(
        Lf,
        module_3d._to_profile(width, T),
        module_3d._to_profile(ztop, T),
        module_3d._to_profile(zbot, T),
        module_3d._to_profile(INTEGRATED_CAUDAL_ETOP_SAMPLES, T),
        module_3d._to_profile(INTEGRATED_CAUDAL_EBOT_SAMPLES, T),
    )
end
