# Continuous body-to-caudal thin-web geometries.
#
# Unlike the earlier resolution-safe integrated bodies, these variants let the
# posterior Y thickness taper below one L32 cell, matching the already proven
# modeler caudal surface.  The thin lifting web is still part of one sampled
# cross-section profile on s in [0,1]; there is no unioned appendage and no
# material beyond the 2-D endpoint.

const THIN_WEB_WIDTH_SAMPLES = (
    0f0, 0.02745f0, 0.0549f0, 0.05955f0, 0.0642f0,
    0.06155f0, 0.0589f0, 0.053f0, 0.0471f0,
    0.03125f0, 0.020f0, 0.010f0, 0.004f0,
)

const THIN_WEB_BASE_ETOP = (
    2f0, 2.0729f0, 2.1458f0, 2.20625f0, 2.2667f0,
    2.30365f0, 2.3406f0, 2.34945f0, 2.3583f0,
)
const THIN_WEB_BASE_EBOT = (
    2f0, 1.9849f0, 1.9698f0, 1.93905f0, 1.9083f0,
    1.8823f0, 1.8563f0, 1.849f0, 1.8417f0,
)
const THIN_WEB_DORSAL_FRACTION = (
    0.60f0, 0.60f0, 0.60f0, 0.60f0, 0.60f0,
    0.60f0, 0.60f0, 0.60f0, 0.60f0,
    0.58f0, 0.56f0, 0.55f0, 0.55f0,
)

function thin_web_total_heights(::Type{T}, variant::Symbol) where {T}
    variant == :thin_elliptic && return T.((
        0.0, 0.050, 0.100, 0.109625, 0.11925,
        0.130, 0.140, 0.160, 0.170,
        0.150, 0.170, 0.200, 0.200,
    ))
    variant == :thin_boxy && return T.((
        0.0, 0.050, 0.100, 0.109625, 0.11925,
        0.130, 0.140, 0.160, 0.170,
        0.170, 0.200, 0.220, 0.200,
    ))
    variant == :thin_tuna_boxy && return T.((
        0.0, 0.108, 0.216, 0.23679, 0.25758,
        0.2484, 0.23922, 0.21465, 0.19008,
        0.170, 0.200, 0.250, 0.220,
    ))
    error("thin-web variant must be thin_elliptic, thin_boxy or thin_tuna_boxy")
end

function thin_web_exponents(::Type{T}, variant::Symbol) where {T}
    tail = variant == :thin_elliptic ?
        T.((2.2, 2.4, 2.6, 2.6)) : T.((3.0, 4.5, 6.0, 6.0))
    return (
        etop=(T.(THIN_WEB_BASE_ETOP)..., tail...),
        ebot=(T.(THIN_WEB_BASE_EBOT)..., tail...),
    )
end

function integrated_body_caudal_thin_web_sdf(
    module_3d,
    Lf::T;
    variant::Symbol=:thin_boxy,
) where {T}
    total = thin_web_total_heights(T, variant)
    exponents = thin_web_exponents(T, variant)
    width = T.(THIN_WEB_WIDTH_SAMPLES)
    dorsal = T.(THIN_WEB_DORSAL_FRACTION)
    ztop = Tuple(dorsal[index] * total[index] for index in eachindex(total))
    zbot = Tuple((one(T) - dorsal[index]) * total[index] for index in eachindex(total))
    all(width[index + 1] < width[index] for index in 9:length(width)-1) ||
        error("thin-web posterior Y half-width must decrease strictly")
    return module_3d.DogfishBodySDF(
        Lf,
        module_3d._to_profile(width, T),
        module_3d._to_profile(ztop, T),
        module_3d._to_profile(zbot, T),
        module_3d._to_profile(exponents.etop, T),
        module_3d._to_profile(exponents.ebot, T),
    )
end
