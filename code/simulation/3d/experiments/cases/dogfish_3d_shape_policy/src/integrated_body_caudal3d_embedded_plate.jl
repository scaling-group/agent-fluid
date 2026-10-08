# Connected body plus internal caudal plate represented as one wet SDF.
# The plate occupies s=0.75--1.00 only, shares the body motion map, has no
# separate rigid/material degree of freedom, and creates no material beyond the
# original 2D endpoint.  Component accessors exist only for auditable mass and
# partitioned added-mass calculations.

struct IntegratedEmbeddedPlateSDF{B,F} <: Function
    body::B
    plate::F
end

@inline function (geometry::IntegratedEmbeddedPlateSDF)(x, t)
    return min(geometry.body(x, t), geometry.plate(x, t))
end

function integrated_body_caudal_embedded_plate_sdf(
    module_3d,
    Lf::T;
    body_height_scale=T(1.25),
    x_start=T(0.75),
    x_end=one(T),
    upper_height=T(0.13),
    lower_height=T(0.09),
    half_thickness=T(0.012),
    min_root_half_cells=T(1.0),
) where {T}
    zero(T) <= x_start < x_end <= one(T) ||
        error("embedded plate must satisfy 0 <= x_start < x_end <= 1")
    body = module_3d.dogfish_body_sdf(
        Lf; height_scale=T(body_height_scale),
    )
    plate = module_3d.modeler_caudal_fin(
        body;
        x_start=T(x_start),
        x_end=T(x_end),
        upper_height=T(upper_height),
        lower_height=T(lower_height),
        half_thickness=T(half_thickness),
        min_root_half_cells=T(min_root_half_cells),
        min_midplane_half_cells=zero(T),
    )
    return IntegratedEmbeddedPlateSDF(body, plate)
end

integrated_embedded_plate_components(geometry::IntegratedEmbeddedPlateSDF) =
    (body=geometry.body, plate=geometry.plate)
