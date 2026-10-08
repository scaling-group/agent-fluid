const ROLLOUT_JOB_SCHEMA_VERSION = "dogfish.rollout.v1"
const ROLLOUT_RESULT_SCHEMA_VERSION = "dogfish.rollout_result.v1"
const ROLLOUT_BUNDLE_SCHEMA_VERSION = "dogfish.rollout_bundle.v1"

function field_or(value, name::Symbol, default)
    return hasproperty(value, name) ? getproperty(value, name) : default
end

function namedtuple_from_json(value)
    if value isa AbstractDict
        entries = collect(value)
        names = Tuple(Symbol(String(key)) for (key, _) in entries)
        values = Tuple(namedtuple_from_json(item) for (_, item) in entries)
        return NamedTuple{names}(values)
    elseif value isa AbstractVector
        return [namedtuple_from_json(item) for item in value]
    else
        return value
    end
end

function write_json_file(path::AbstractString, payload)
    open(path, "w") do io
        JSON.print(io, jsonable(payload), 2)
    end
end

function normalized_fidelity(fidelity)
    fidelity = fidelity isa Dict ? namedtuple_from_json(fidelity) : fidelity
    fidelity isa NamedTuple || error("rollout job fidelity must be a NamedTuple")
    return (
        grid_L = Int(field_or(fidelity, :grid_L, 64)),
        Re = Float32(field_or(fidelity, :Re, 2000.0)),
        n_warmup_cycles = Float32(field_or(fidelity, :n_warmup_cycles, 2.0)),
        n_eval_cycles = Float32(field_or(fidelity, :n_eval_cycles, 2.0)),
        samples_per_cycle = Int(field_or(fidelity, :samples_per_cycle, 24)),
        backend = String(field_or(fidelity, :backend, "auto")),
        render_tier = String(field_or(fidelity, :render_tier, "none")),
    )
end

function rollout_fidelity_from_env()
    return (
        grid_L = env_int("DOGFISH_EVAL_L", 64),
        Re = env_float32("DOGFISH_RE", 2000.0f0),
        n_warmup_cycles = env_float32("DOGFISH_WARMUP_CYCLES", 2.0f0),
        n_eval_cycles = env_float32("DOGFISH_EVAL_CYCLES", 2.0f0),
        samples_per_cycle = env_int("DOGFISH_SAMPLES_PER_CYCLE", 24),
        backend = env_string("DOGFISH_MEMORY_BACKEND", "auto"),
        render_tier = env_string("DOGFISH_RENDER_TIER", "none"),
    )
end

function sanitize_identifier(value)
    text = replace(String(value), r"[^A-Za-z0-9_.-]+" => "_")
    return isempty(text) ? "unknown" : text
end

function fidelity_id(fidelity)
    f = normalized_fidelity(fidelity)
    return join(
        [
            "L$(f.grid_L)",
            "Re$(round(Float64(f.Re), digits=1))",
            "warm$(round(Float64(f.n_warmup_cycles), digits=3))",
            "eval$(round(Float64(f.n_eval_cycles), digits=3))",
            "spc$(f.samples_per_cycle)",
            f.backend,
            f.render_tier,
        ],
        "_",
    ) |> sanitize_identifier
end

function lineage_id(design)
    lineage = hasproperty(design, :lineage) ? design.lineage : NamedTuple()
    body = hasproperty(lineage, :body_regime) ? String(lineage.body_regime) : "unknown_body"
    motion = hasproperty(lineage, :motion_regime) ? String(lineage.motion_regime) : "unknown_motion"
    return sanitize_identifier(body * "__" * motion)
end

function artifact_plan_from_env()
    return (
        write_score_files = true,
        write_rollout_result = true,
        render = env_bool("DOGFISH_RENDER_EXPERIMENTS", false),
    )
end

function rollout_job_from_experiment(
    design,
    experiment;
    run_id::AbstractString="local",
    variant_index::Int=1,
    fidelity=rollout_fidelity_from_env(),
    seed::Int=0,
    candidate_hash::AbstractString="unknown",
    repo_commit::AbstractString="unknown",
    artifact_plan=artifact_plan_from_env(),
)
    assay = experiment_assay(experiment)
    normalized_fid = normalized_fidelity(fidelity)
    variant_id = hasproperty(experiment, :id) ?
        String(experiment.id) : "experiment_$(lpad(string(variant_index), 3, '0'))"
    return (
        schema_version = ROLLOUT_JOB_SCHEMA_VERSION,
        run_id = String(run_id),
        lineage_id = lineage_id(design),
        variant_id = variant_id,
        variant_index = variant_index,
        assay_id = sanitize_identifier(String(assay.family) * "." * assay.version),
        fidelity_id = fidelity_id(normalized_fid),
        seed = seed,
        candidate_hash = String(candidate_hash),
        repo_commit = String(repo_commit),
        morphology = hasproperty(experiment, :morphology) ? experiment.morphology : NamedTuple(),
        motion = hasproperty(experiment, :motion) ? experiment.motion :
            (hasproperty(experiment, :params) ? experiment.params : NamedTuple()),
        assay = assay,
        fidelity = normalized_fid,
        artifact_plan = artifact_plan,
    )
end

function rollout_jobs_from_design(
    design;
    run_id::AbstractString="local",
    fidelity=rollout_fidelity_from_env(),
    seed::Int=0,
    candidate_hash::AbstractString="unknown",
    repo_commit::AbstractString="unknown",
    artifact_plan=artifact_plan_from_env(),
)
    return [
        rollout_job_from_experiment(
            design,
            experiment;
            run_id,
            variant_index=index,
            fidelity,
            seed,
            candidate_hash,
            repo_commit,
            artifact_plan,
        ) for (index, experiment) in enumerate(collect(design_experiments(design)))
    ]
end

function normalize_rollout_job(raw_job)
    job = raw_job isa AbstractDict ? namedtuple_from_json(raw_job) : raw_job
    job isa NamedTuple || error("rollout job must be a NamedTuple or JSON object")
    hasproperty(job, :variant_id) || error("rollout job missing variant_id")
    hasproperty(job, :morphology) || error("rollout job missing morphology")
    hasproperty(job, :motion) || error("rollout job missing motion")
    hasproperty(job, :assay) || error("rollout job missing assay")
    hasproperty(job, :fidelity) || error("rollout job missing fidelity")

    fidelity = normalized_fidelity(job.fidelity)
    assay = normalize_assay(job.assay)
    return (
        schema_version = String(field_or(job, :schema_version, ROLLOUT_JOB_SCHEMA_VERSION)),
        run_id = String(field_or(job, :run_id, "local")),
        lineage_id = String(field_or(job, :lineage_id, "unknown")),
        variant_id = String(job.variant_id),
        variant_index = Int(field_or(job, :variant_index, 1)),
        assay_id = String(field_or(job, :assay_id, sanitize_identifier(String(assay.family) * "." * assay.version))),
        fidelity_id = String(field_or(job, :fidelity_id, fidelity_id(fidelity))),
        seed = Int(field_or(job, :seed, 0)),
        candidate_hash = String(field_or(job, :candidate_hash, "unknown")),
        repo_commit = String(field_or(job, :repo_commit, "unknown")),
        morphology = job.morphology,
        motion = job.motion,
        assay = assay,
        fidelity = fidelity,
        artifact_plan = field_or(job, :artifact_plan, artifact_plan_from_env()),
    )
end

function experiment_from_rollout_job(job)
    return (
        id = job.variant_id,
        morphology = job.morphology,
        motion = job.motion,
        assay = job.assay,
    )
end

function rollout_result_payload(job, status::String; result=nothing, error=nothing)
    payload = Dict(
        "schema_version" => ROLLOUT_RESULT_SCHEMA_VERSION,
        "status" => status,
        "job" => jsonable(job),
        "artifacts" => Dict(
            "rollout_job" => "rollout_job.json",
            "rollout_result" => "rollout_result.json",
            "score" => "score.yaml",
            "metrics" => "metrics.txt",
        ),
    )
    if result !== nothing
        if has_trajectory_artifact(result)
            payload["artifacts"]["trajectory"] = "trajectory.json"
        end
        payload["score"] = score_dict(result)
        payload["metrics"] = raw_metrics_dict(result)
        payload["assay"] = jsonable(result.assay)
        payload["validity"] = jsonable(result.validity)
        payload["selection_eligible"] = result.selection_eligible
        payload["selection_score"] = jsonable(result.selection_score)
        payload["assay_local_score"] = result.assay_local_score
        payload["assay_local_score_name"] = result.assay_local_score_name
    end
    if error !== nothing
        payload["failure"] = Dict("message" => String(error))
    end
    return payload
end

function write_failed_rollout_files(output_root::AbstractString, job, error_message::AbstractString)
    mkpath(output_root)
    open(joinpath(output_root, "score.yaml"), "w") do io
        println(io, "score: -100.0")
        println(io, "summary: " * repr("rollout job failed"))
        println(io, "status: failed")
        println(io, "variant_id: " * repr(job.variant_id))
        println(io, "assay_family: " * repr(String(job.assay.family)))
        println(io, "error: " * repr(error_message))
    end
    open(joinpath(output_root, "metrics.txt"), "w") do io
        println(io, "status=failed")
        println(io, "variant_id=$(job.variant_id)")
        println(io, "assay_family=$(job.assay.family)")
        println(io, "error=$(error_message)")
    end
end

function run_rollout_job(design, raw_job; output_root::AbstractString)
    job = normalize_rollout_job(raw_job)
    mkpath(output_root)
    write_json_file(joinpath(output_root, "rollout_job.json"), job)

    try
        experiment = experiment_from_rollout_job(job)
        result = run_policy_experiment(
            design,
            experiment;
            experiment_index=job.variant_index,
            L=job.fidelity.grid_L,
            Re=job.fidelity.Re,
            n_warmup_cycles=job.fidelity.n_warmup_cycles,
            n_eval_cycles=job.fidelity.n_eval_cycles,
            samples_per_cycle=job.fidelity.samples_per_cycle,
            backend=job.fidelity.backend,
        )
        if field_or(job.artifact_plan, :write_score_files, true)
            write_single_score_files(output_root, result; requested_backend=job.fidelity.backend)
        end
        payload = rollout_result_payload(job, "ok"; result)
        write_json_file(joinpath(output_root, "rollout_result.json"), payload)
        return payload
    catch error
        message = sprint(showerror, error)
        write_failed_rollout_files(output_root, job, message)
        payload = rollout_result_payload(job, "failed"; error=message)
        write_json_file(joinpath(output_root, "rollout_result.json"), payload)
        return payload
    end
end

function run_rollout_job_bundle(design, jobs; output_root::AbstractString)
    mkpath(output_root)
    entries = []
    for (index, job) in enumerate(jobs)
        job_root = joinpath(output_root, "jobs", lpad(string(index), 3, '0'))
        result = run_rollout_job(design, job; output_root=job_root)
        push!(
            entries,
            Dict(
                "index" => index,
                "variant_id" => result["job"]["variant_id"],
                "status" => result["status"],
                "path" => joinpath("jobs", lpad(string(index), 3, '0'), "rollout_result.json"),
                "assay" => result["job"]["assay"],
                "selection_eligible" => get(result, "selection_eligible", false),
                "selection_score" => get(result, "selection_score", nothing),
                "assay_local_score" => get(result, "assay_local_score", nothing),
            ),
        )
    end
    manifest = Dict(
        "schema_version" => ROLLOUT_BUNDLE_SCHEMA_VERSION,
        "job_count" => length(entries),
        "entries" => entries,
    )
    write_json_file(joinpath(output_root, "job_bundle_manifest.json"), manifest)
    return manifest
end
