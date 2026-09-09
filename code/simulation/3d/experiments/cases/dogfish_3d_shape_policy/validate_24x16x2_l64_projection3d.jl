# Dry construction gate for the 24L x 16L x 2L, L64 strict-3D EvE case.
# No WaterLily Simulation is created.

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
        "free_swim_multiwake_target_secondrow_u010_reference24x16x2_l64_3d.toml",
    ),
)
source_path = joinpath(
    repo_root,
    "cases",
    "dogfish_2d_shape_policy",
    "configs",
    "free_swim_multiwake_target_secondrow_capture0p75_l64.toml",
)
policy_path = joinpath(case_dir, "candidate_target_policy_naive_carrier_2dstyle.jl")

spec = load_projected_multiwake_spec_3d(config_path)
validate_projected_multiwake_spec_3d(spec)
source = TOML.parsefile(source_path)
source_episode = source["free_swim_multiwake_target_episode"]

@assert spec.source_case_sha256 == sha256_file(source_path)
@assert spec.L == 64
@assert spec.domain_scale_L == (24.0, 16.0, 2.0)
@assert spec.initial_center_L == (21.0, 14.0, 1.0)
@assert spec.initial_heading_deg == 29.0
@assert spec.target_L == (9.0, 9.5, 1.0)
@assert spec.success_radius_L == source_episode["success_radius_L"] == 0.75
@assert [center[1] for center in spec.cylinder_centers_L] ==
    source_episode["cylinder_centers_x_L"]
@assert [center[2] for center in spec.cylinder_centers_L] ==
    source_episode["cylinder_centers_y_L"]
@assert spec.cylinder_diameters_L == source_episode["cylinder_diameters_L"]
@assert spec.flow_velocity_L == (0.10, 0.0, 0.0)
@assert spec.flow_seed == source_episode["flow_seed"]
@assert spec.prewarm_horizon == 200.0
@assert spec.rollout_horizon == 300.0
@assert spec.locked_dofs == ("heave", "roll", "pitch")

candidate = Module(:Dogfish3DL64Candidate)
Base.include(candidate, policy_path)
params = getfield(candidate, :target_policy_params)()
state = (
    elapsed_T=0.4,
    phi=(8pi / 180, -8pi / 180),
    phi_dot=(0.0, 0.0),
    bearing=0.25,
    velocity_body_U=(0.0, 0.0),
    moment_z_L2=0.0,
)
action = getfield(candidate, :target_policy)(state, params)
@assert length(action.phi_ddot) == 2
@assert all(isfinite, Float64.(action.phi_ddot))

resolved = Dict(
    "status" => "ok",
    "simulation_created" => false,
    "projection_contract" => "strict_xy_plus_locked_z",
    "source_case_sha256" => spec.source_case_sha256,
    "runtime_resolution" => spec.L,
    "domain_scale_L" => collect(spec.domain_scale_L),
    "domain_dims" => [1536, 1024, 128],
    "cell_count" => 201_326_592,
    "initial_center_L" => collect(spec.initial_center_L),
    "initial_heading_deg" => spec.initial_heading_deg,
    "target_L" => collect(spec.target_L),
    "success_radius_L" => spec.success_radius_L,
    "cylinder_count" => length(spec.cylinder_centers_L),
    "flow_velocity_L" => collect(spec.flow_velocity_L),
    "free_dofs" => ["surge_x", "sway_y", "yaw_z"],
    "locked_dofs" => collect(spec.locked_dofs),
    "policy_sha256" => sha256_file(policy_path),
    "candidate_contract_passed" => true,
)
JSON.print(stdout, resolved, 2)
println()
