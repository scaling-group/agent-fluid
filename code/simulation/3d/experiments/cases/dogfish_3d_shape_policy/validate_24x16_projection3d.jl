# Dry construction gate for the accepted 24L x 16L 2D case and its strict
# 24L x 16L x 2L 3D projection. No WaterLily Simulation is created.

case_dir = @__DIR__
repo_root = normpath(joinpath(case_dir, "..", ".."))

include(joinpath(case_dir, "src", "Dogfish3DShapePolicyTestbed.jl"))
using .Dogfish3DShapePolicyTestbed
using JSON
using SHA
using StaticArrays
using TOML

sha256_file(path) = bytes2hex(sha256(read(path)))

config_path = get(
    ENV,
    "DOGFISH3D_PROJECTED_MULTIWAKE_CONFIG",
    joinpath(
        case_dir,
        "configs",
        "free_swim_multiwake_target_secondrow_capture0p75_24x16_l32_3d.toml",
    ),
)
source_path = joinpath(
    repo_root,
    "cases",
    "dogfish_2d_shape_policy",
    "configs",
    "free_swim_multiwake_target_secondrow_capture0p75_l64.toml",
)

spec = load_projected_multiwake_spec_3d(config_path)
validate_projected_multiwake_spec_3d(spec)
source = TOML.parsefile(source_path)
source_free_swim = source["free_swim"]
source_episode = source["free_swim_multiwake_target_episode"]

@assert spec.source_case ==
    "cases/dogfish_2d_shape_policy/configs/free_swim_multiwake_target_secondrow_capture0p75_l64.toml"
@assert spec.source_case_sha256 == sha256_file(source_path)
@assert source_free_swim["L"] == 64
@assert spec.L == 32
@assert spec.backend == source_free_swim["backend"]
@assert spec.Re == source_free_swim["Re"]
@assert spec.domain_scale_L == (24.0, 16.0, 2.0)
@assert spec.domain_scale_L[1:2] == (
    source_episode["domain_scale_x"],
    source_episode["domain_scale_y"],
)
@assert spec.initial_center_L[1:2] == (
    source_episode["initial_center_x_L"],
    source_episode["initial_center_y_L"],
)
@assert spec.initial_heading_deg == source_episode["initial_heading_deg"]
@assert spec.target_L[1:2] == (
    source_episode["target_x_L"],
    source_episode["target_y_L"],
)
@assert spec.success_radius_L == source_episode["success_radius_L"] == 0.75
@assert [center[1] for center in spec.cylinder_centers_L] ==
    source_episode["cylinder_centers_x_L"]
@assert [center[2] for center in spec.cylinder_centers_L] ==
    source_episode["cylinder_centers_y_L"]
@assert spec.cylinder_diameters_L == source_episode["cylinder_diameters_L"]
@assert spec.flow_velocity_L[1] == source_episode["flow_speed"]
@assert spec.flow_seed == source_episode["flow_seed"]
@assert spec.prewarm_horizon == source_episode["prewarm_horizon"]
@assert spec.rollout_horizon == source_episode["horizon"]
@assert spec.phi_limit_deg == source_episode["phi_limit_deg"]
@assert spec.phi_dot_limit_deg == source_episode["phi_dot_limit_deg"]
@assert spec.phi_ddot_limit_deg == source_episode["phi_ddot_limit_deg"]
@assert spec.target_L[1] -
    maximum(center[1] for center in spec.cylinder_centers_L) == 3.0

bodies = projected_cylinder_bodies_3d(spec)
@assert length(bodies) == 4
probe_sdf = DomainSpanningCylinderSDF3D(
    Float32(0.5 * first(spec.cylinder_diameters_L) * spec.L),
)
@assert probe_sdf(SVector(0.0f0, 0.0f0, -100.0f0), 0.0f0) < 0
@assert probe_sdf(SVector(Float32(spec.L), 0.0f0, 100.0f0), 0.0f0) > 0

resolved = Dict(
    "status" => "ok",
    "simulation_created" => false,
    "projection_contract" => "strict_xy_plus_locked_z",
    "source_case" => spec.source_case,
    "source_case_sha256" => spec.source_case_sha256,
    "L" => spec.L,
    "source_2d_L" => source_free_swim["L"],
    "resolution_contract" => "3d_L32_from_2d_L64",
    "domain_scale_L" => collect(spec.domain_scale_L),
    "domain_dims" => [768, 512, 64],
    "cell_count" => 25_165_824,
    "z_plane_L" => spec.target_L[3],
    "initial_center_L" => collect(spec.initial_center_L),
    "target_L" => collect(spec.target_L),
    "success_radius_L" => spec.success_radius_L,
    "cylinder_centers_L" => [collect(center) for center in spec.cylinder_centers_L],
    "cylinder_diameters_L" => spec.cylinder_diameters_L,
    "cylinder_span_mode" => spec.cylinder_span_mode,
    "flow_velocity_L" => collect(spec.flow_velocity_L),
    "locked_dofs" => collect(spec.locked_dofs),
    "actuator_limits_deg" => [
        spec.phi_limit_deg,
        spec.phi_dot_limit_deg,
        spec.phi_ddot_limit_deg,
    ],
)
JSON.print(stdout, resolved, 2)
println()
