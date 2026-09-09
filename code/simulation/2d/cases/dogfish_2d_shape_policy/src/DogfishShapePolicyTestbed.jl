module DogfishShapePolicyTestbed

using JSON
using Plots
using Printf
using StaticArrays
using Statistics
using TOML
using WaterLily
using WriteVTK

function should_eager_import_cuda()
    requested_backend = lowercase(strip(get(ENV, "DOGFISH_MEMORY_BACKEND", "")))
    requested_backend == "cuda" && return true

    cuda_visible_devices = strip(get(ENV, "CUDA_VISIBLE_DEVICES", ""))
    if !isempty(cuda_visible_devices) && cuda_visible_devices != "-1"
        return true
    end

    haskey(ENV, "PBS_GPUFILE") && return true
    return Sys.which("nvidia-smi") !== nothing
end

if should_eager_import_cuda()
    import CUDA
end

include("geometry.jl")
include("kinematics.jl")
include("joint_control.jl")
include("assays.jl")
include("simulation.jl")
include("performance.jl")
include("evaluation.jl")
include("artifacts.jl")
include("run_config.jl")
include("free_swim.jl")
include("vtk_stream.jl")
include("batch_runner.jl")
include("jobs.jl")

export evaluate_policy
export evaluate_policy_batch
export evaluate_design
export design_experiments
export default_assay
export experiment_assay
export normalize_assay
export raw_metrics_dict
export assay_is_selection_core
export normalized_exp
export normalize_candidate
export resolve_memory_backend
export run_policy_experiment
export run_policy_batch
export build_free_swim_simulation
export run_free_swim_rollout
export free_swim_step_body_state
export write_free_swim_outputs
export run_rollout_job
export run_rollout_job_bundle
export rollout_fidelity_from_env
export rollout_job_from_experiment
export rollout_jobs_from_design
export artifact_plan_from_env
export namedtuple_from_json
export validate_design_spec
export validate_assay_definition
export validate_policy_spec
export write_batch_score_files
export write_single_score_files
export cast_named_tuple
export distributed_joint_step
export distributed_joint_step_derivative
export two_joint_bend_angle
export two_joint_bend_angle_with_rates
export two_joint_bend_density
export two_joint_bend_params
export merge_two_joint_angles
export merge_two_joint_state
export configured_string_list
export start_free_swim_vtk_stream
export write_free_swim_vtk_frame!
export close_free_swim_vtk_stream!
export vtk_collection_path
export SCORE_SCHEMA_VERSION
export SELECTION_PROGRAM_VERSION
export ROLLOUT_JOB_SCHEMA_VERSION
export ROLLOUT_RESULT_SCHEMA_VERSION

end
