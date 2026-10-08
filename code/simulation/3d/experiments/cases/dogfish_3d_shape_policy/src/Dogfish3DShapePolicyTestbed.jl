module Dogfish3DShapePolicyTestbed

# Reuse the 2D testbed wholesale: spine kinematics, joint control, backend
# resolution, and the planar rigid-body update are all dimension-neutral or
# operate on the spine plane, which remains the only deforming plane in 3D.
include(joinpath(@__DIR__, "..", "..", "dogfish_2d_shape_policy", "src", "DogfishShapePolicyTestbed.jl"))

using .DogfishShapePolicyTestbed
const Base2D = DogfishShapePolicyTestbed

using JSON
using Plots
using Printf
using StaticArrays
using Statistics
using TOML
using WaterLily
using WriteVTK

include("geometry3d.jl")
include("caudal_fin3d.jl")
include("body_superellipse3d.jl")
include("free_swim3d.jl")
include("vtk_stream3d.jl")
include("multiwake_projection3d.jl")

export Dogfish3DSDF
export dogfish3d_thickness_profile
export CaudalFinSDF
export ModelerCaudalFinSDF
export caudal_fin
export modeler_caudal_fin
export combined_body_properties_3d
export DogfishBodySDF
export dogfish_body_sdf
export combined_body_properties_superellipse
export superellipse_added_mass
export body_volume_superellipse
export body_centroid_x_superellipse
export deformed_body_centroid_superellipse
export deformed_body_centroid_velocity_superellipse
export deformed_combined_centroid_superellipse
export deformed_combined_centroid_velocity_superellipse
export body_inertia_superellipse
export caudal_fin_added_mass
export baseline_height_scale
export body_volume_from_profile_3d
export body_centroid_x_from_profile_3d
export body_inertia_from_profile_3d
export free_swim_added_mass_properties_3d
export deformed_body_centroid_3d
export FreeSwimmingSpineMap3D
export build_free_swim_simulation_3d
export run_free_swim_rollout_3d
export set_free_swim_body_3d!
export write_free_swim_outputs_3d
export start_free_swim_vtk_stream_3d
export write_free_swim_vtk_frame_3d!
export close_free_swim_vtk_stream_3d!
export vtk_collection_path_3d
export DomainSpanningCylinderSDF3D
export FixedPlanarCylinderMap3D
export load_projected_multiwake_spec_3d
export validate_projected_multiwake_spec_3d
export projected_cylinder_bodies_3d
export projected_cylinder_union_3d

end
