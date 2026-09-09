# Strict top-down continuation of a planar multi-cylinder wake into the 3D
# locked-DOF dogfish testbed. The cylinders span the complete z domain so their
# x-y signed distance is exactly the source 2D circle SDF at every z.

struct DomainSpanningCylinderSDF3D{T} <: Function
    radius::T
end

@inline function (body::DomainSpanningCylinderSDF3D)(x, t)
    T = typeof(x[1])
    return sqrt(abs2(x[1]) + abs2(x[2])) - T(body.radius)
end

struct FixedPlanarCylinderMap3D{T} <: Function
    center::SVector{2, T}
end

@inline function (map::FixedPlanarCylinderMap3D)(x, t)
    T = typeof(x[1])
    return SVector(
        x[1] - T(map.center[1]),
        x[2] - T(map.center[2]),
        x[3],
    )
end

function required_projection_value(section, key)
    haskey(section, key) || error("missing projected-multiwake key: $key")
    return section[key]
end

function load_projected_multiwake_spec_3d(path::AbstractString)
    config = TOML.parsefile(path)
    get(config, "schema_version", "") == "dogfish.projected_multiwake_3d.v1" ||
        error("unsupported projected multiwake schema")
    free_swim = required_projection_value(config, "free_swim")
    section = required_projection_value(config, "projected_multiwake_3d")

    centers_x_L = Float64.(required_projection_value(section, "cylinder_centers_x_L"))
    centers_y_L = Float64.(required_projection_value(section, "cylinder_centers_y_L"))
    diameters_L = Float64.(required_projection_value(section, "cylinder_diameters_L"))
    length(centers_x_L) == length(centers_y_L) == length(diameters_L) ||
        error("cylinder x/y/diameter arrays must have equal lengths")
    all(>(0.0), diameters_L) || error("all projected cylinder diameters must be positive")

    domain_scale_L = (
        Float64(required_projection_value(section, "domain_scale_x_L")),
        Float64(required_projection_value(section, "domain_scale_y_L")),
        Float64(required_projection_value(section, "domain_scale_z_L")),
    )
    z_plane_fraction = Float64(required_projection_value(section, "z_plane_fraction"))
    initial_center_L = (
        Float64(required_projection_value(section, "initial_center_x_L")),
        Float64(required_projection_value(section, "initial_center_y_L")),
        z_plane_fraction * domain_scale_L[3],
    )
    target_L = (
        Float64(required_projection_value(section, "target_x_L")),
        Float64(required_projection_value(section, "target_y_L")),
        z_plane_fraction * domain_scale_L[3],
    )
    cylinder_centers_L = [
        SVector{2, Float64}(x_L, y_L)
        for (x_L, y_L) in zip(centers_x_L, centers_y_L)
    ]

    return (
        schema_version=String(config["schema_version"]),
        source_case=String(required_projection_value(section, "source_case")),
        source_case_sha256=String(required_projection_value(section, "source_case_sha256")),
        reference_3d_commit=String(required_projection_value(section, "reference_3d_commit")),
        L=Int(required_projection_value(free_swim, "L")),
        backend=String(required_projection_value(free_swim, "backend")),
        Re=Float64(required_projection_value(free_swim, "Re")),
        domain_scale_L=domain_scale_L,
        z_plane_fraction=z_plane_fraction,
        initial_center_L=initial_center_L,
        initial_heading_deg=Float64(required_projection_value(section, "initial_heading_deg")),
        target_L=target_L,
        capture_metric=String(required_projection_value(section, "capture_metric")),
        success_radius_L=Float64(required_projection_value(section, "success_radius_L")),
        cylinder_centers_L=cylinder_centers_L,
        cylinder_diameters_L=diameters_L,
        cylinder_span_mode=String(required_projection_value(section, "cylinder_span_mode")),
        flow_velocity_L=Tuple(Float64.(required_projection_value(section, "flow_velocity_L"))),
        flow_seed=Int(required_projection_value(section, "flow_seed")),
        prewarm_horizon=Float64(required_projection_value(section, "prewarm_horizon")),
        rollout_horizon=Float64(required_projection_value(section, "rollout_horizon")),
        height_scale=Float64(required_projection_value(section, "height_scale")),
        caudal_fin=Bool(required_projection_value(section, "caudal_fin")),
        locked_dofs=Tuple(String.(required_projection_value(section, "locked_dofs"))),
        phi_limit_deg=Float64(required_projection_value(section, "phi_limit_deg")),
        phi_dot_limit_deg=Float64(required_projection_value(section, "phi_dot_limit_deg")),
        phi_ddot_limit_deg=Float64(required_projection_value(section, "phi_ddot_limit_deg")),
    )
end

function validate_projected_multiwake_spec_3d(spec)
    spec.L > 0 || error("L must be positive")
    all(>(0.0), spec.domain_scale_L) || error("all 3D domain scales must be positive")
    spec.z_plane_fraction == 0.5 ||
        error("strict top-down continuation requires the z=mid-plane")
    if isempty(spec.cylinder_centers_L)
        spec.cylinder_span_mode == "none" ||
            error("zero-cylinder capability cases require cylinder_span_mode=none")
    else
        spec.cylinder_span_mode == "domain_spanning" ||
            error("projected wake cases require domain-spanning cylinders")
    end
    spec.capture_metric == "planar_xy" ||
        error("locked-DOF continuation requires planar_xy capture")
    spec.flow_velocity_L[2] == 0.0 && spec.flow_velocity_L[3] == 0.0 ||
        error("strict continuation requires x-directed inflow")
    Set(spec.locked_dofs) == Set(("heave", "roll", "pitch")) ||
        error("strict continuation locks heave, roll, and pitch")
    spec.initial_center_L[3] == spec.target_L[3] ||
        error("fish and target must share the z mid-plane")
    all(>(0.0), spec.cylinder_diameters_L) ||
        error("all projected cylinder diameters must be positive")
    return true
end

function projected_cylinder_bodies_3d(spec; T::Type=Float32)
    validate_projected_multiwake_spec_3d(spec)
    Lf = T(spec.L)
    return [
        AutoBody(
            DomainSpanningCylinderSDF3D(T(0.5 * diameter_L) * Lf),
            FixedPlanarCylinderMap3D(
                SVector(T(center_L[1]) * Lf, T(center_L[2]) * Lf),
            ),
        )
        for (center_L, diameter_L) in
            zip(spec.cylinder_centers_L, spec.cylinder_diameters_L)
    ]
end

function projected_cylinder_union_3d(spec; T::Type=Float32)
    bodies = projected_cylinder_bodies_3d(spec; T)
    return isempty(bodies) ? WaterLily.NoBody() : reduce(∪, bodies)
end
