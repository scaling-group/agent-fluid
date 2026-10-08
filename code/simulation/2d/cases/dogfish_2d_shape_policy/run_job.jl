case_dir = @__DIR__

include(joinpath(case_dir, "src", "DogfishShapePolicyTestbed.jl"))
using .DogfishShapePolicyTestbed
using JSON

include(joinpath(case_dir, "candidate.jl"))

function load_rollout_job(path::AbstractString)
    return DogfishShapePolicyTestbed.namedtuple_from_json(JSON.parsefile(path))
end

function main()
    output_root = get(ENV, "DOGFISH_JOB_OUTPUT_ROOT", joinpath(pwd(), "logs", "rollout_job"))
    run_id = DogfishShapePolicyTestbed.env_string("DOGFISH_JOB_RUN_ID", "local")
    experiment_index = DogfishShapePolicyTestbed.env_int("DOGFISH_EXPERIMENT_INDEX", 1)
    seed = DogfishShapePolicyTestbed.env_int("DOGFISH_JOB_SEED", 0)
    candidate_hash = DogfishShapePolicyTestbed.env_string("DOGFISH_CANDIDATE_HASH", "unknown")
    repo_commit = DogfishShapePolicyTestbed.env_string("DOGFISH_REPO_COMMIT", "unknown")

    design = normalize_candidate()
    fidelity = DogfishShapePolicyTestbed.rollout_fidelity_from_env()
    artifact_plan = DogfishShapePolicyTestbed.artifact_plan_from_env()
    job_path = strip(get(ENV, "DOGFISH_ROLLOUT_JOB", ""))

    if !isempty(job_path)
        result = DogfishShapePolicyTestbed.run_rollout_job(
            design,
            load_rollout_job(job_path);
            output_root,
        )
        println("status=$(result["status"])")
        println("variant_id=$(result["job"]["variant_id"])")
        println("assay_family=$(result["job"]["assay"]["family"])")
        println("result=$(joinpath(output_root, "rollout_result.json"))")
        return
    end

    if DogfishShapePolicyTestbed.env_bool("DOGFISH_ROLLOUT_BUNDLE", false)
        jobs = DogfishShapePolicyTestbed.rollout_jobs_from_design(
            design;
            run_id,
            fidelity,
            seed,
            candidate_hash,
            repo_commit,
            artifact_plan,
        )
        manifest = DogfishShapePolicyTestbed.run_rollout_job_bundle(design, jobs; output_root)
        println("status=ok")
        println("job_count=$(manifest["job_count"])")
        println("bundle_manifest=$(joinpath(output_root, "job_bundle_manifest.json"))")
        return
    end

    experiments = collect(DogfishShapePolicyTestbed.design_experiments(design))
    1 <= experiment_index <= length(experiments) ||
        error("DOGFISH_EXPERIMENT_INDEX $experiment_index outside 1:$(length(experiments))")
    job = DogfishShapePolicyTestbed.rollout_job_from_experiment(
        design,
        experiments[experiment_index];
        run_id,
        variant_index=experiment_index,
        fidelity,
        seed,
        candidate_hash,
        repo_commit,
        artifact_plan,
    )
    result = DogfishShapePolicyTestbed.run_rollout_job(design, job; output_root)
    println("status=$(result["status"])")
    println("variant_id=$(result["job"]["variant_id"])")
    println("assay_family=$(result["job"]["assay"]["family"])")
    println("result=$(joinpath(output_root, "rollout_result.json"))")
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
