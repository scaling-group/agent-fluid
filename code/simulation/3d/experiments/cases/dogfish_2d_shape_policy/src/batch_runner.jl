function env_batch_max_experiments(default::Int=8)
    return env_int("DOGFISH_MAX_EXPERIMENTS", default)
end

function env_batch_workers(default::Int=2)
    return max(1, env_int("DOGFISH_BATCH_WORKERS", default))
end

function env_batch_strategy(default::String="serial")
    strategy = lowercase(env_string("DOGFISH_BATCH_STRATEGY", default))
    strategy in ("serial", "threads") ||
        error("Unsupported DOGFISH_BATCH_STRATEGY `$strategy`; expected serial or threads.")
    return strategy
end

function aggregate_batch_score(entries)
    ok_entries = [entry for entry in entries if entry.status == "ok"]
    selection_entries = [entry for entry in ok_entries if entry.result.selection_eligible]
    if isempty(selection_entries)
        return (
            score=-100.0,
            selection_score=-100.0,
            selection_score_name=STEADY_CRUISE_BATCH_SELECTION_SCORE,
            selection_program_version=SELECTION_PROGRAM_VERSION,
            score_schema_version=SCORE_SCHEMA_VERSION,
            summary=isempty(ok_entries) ? "all experiments failed" :
                "no selection-core experiments completed",
            best_experiment_index=nothing,
            best_experiment_id=nothing,
            best_CT_prop=-Inf,
            eta_at_best_CT=0.0,
            success_count=0,
            positive_fraction=0.0,
            selection_count=0,
            diagnostic_count=length(ok_entries),
            ok_count=length(ok_entries),
        )
    end

    best_entry = selection_entries[argmax([entry.result.CT_prop for entry in selection_entries])]
    best_ct = Float64(best_entry.result.CT_prop)
    eta_at_best = Float64(best_entry.result.eta)
    success_count = count(entry -> entry.result.CT_prop > 0, selection_entries)
    positive_fraction = success_count / length(selection_entries)
    score = best_ct > 0 ? best_ct + 0.5 * eta_at_best : best_ct
    summary = (
        "Batch score $(round(score, digits=4)); " *
        "best_CT_prop=$(round(best_ct, digits=4)); " *
        "eta_at_best_CT=$(round(eta_at_best, digits=4)); " *
        "success_count=$(success_count)/$(length(ok_entries))"
    )

    return (
        score=score,
        selection_score=score,
        selection_score_name=STEADY_CRUISE_BATCH_SELECTION_SCORE,
        selection_program_version=SELECTION_PROGRAM_VERSION,
        score_schema_version=SCORE_SCHEMA_VERSION,
        summary=summary,
        best_experiment_index=best_entry.index,
        best_experiment_id=best_entry.id,
        best_CT_prop=best_ct,
        eta_at_best_CT=eta_at_best,
        success_count=success_count,
        positive_fraction=positive_fraction,
        selection_count=length(selection_entries),
        diagnostic_count=length(ok_entries) - length(selection_entries),
        ok_count=length(ok_entries),
    )
end

function run_policy_batch(
    design;
    max_experiments::Int=env_batch_max_experiments(),
    strategy::String=env_batch_strategy(),
    workers::Int=env_batch_workers(),
    kwargs...,
)
    issues = validate_design_spec(design)
    isempty(issues) || error("Invalid candidate design: " * join(issues, "; "))

    experiments = collect(design_experiments(design))
    length(experiments) <= max_experiments ||
        error("design defines $(length(experiments)) experiments, max_experiments=$max_experiments")

    strategy = lowercase(strategy)
    strategy in ("serial", "threads") ||
        error("Unsupported batch strategy `$strategy`; expected serial or threads.")
    entries, actual_workers = run_experiments(design, experiments; strategy, workers, kwargs...)

    aggregate = aggregate_batch_score(entries)
    return (
        schema_version="dogfish.batch.v1",
        policy_version=String(design.version),
        entries=entries,
        aggregate=aggregate,
        max_experiments=max_experiments,
        strategy=strategy,
        requested_workers=workers,
        actual_workers=actual_workers,
    )
end

evaluate_policy_batch(design; kwargs...) = run_policy_batch(design; kwargs...)

function experiment_entry(design, index::Int, experiment; kwargs...)
    assay = try
        experiment_assay(experiment)
    catch error
        invalid_assay(sprint(showerror, error))
    end
    try
        result = run_policy_experiment(design, experiment; experiment_index=index, kwargs...)
        return (
            index=index,
            id=String(experiment.id),
            design=design,
            status="ok",
            assay=assay,
            morphology=hasproperty(experiment, :morphology) ? experiment.morphology : NamedTuple(),
            motion=hasproperty(experiment, :motion) ? experiment.motion : experiment.params,
            result=result,
            error=nothing,
        )
    catch error
        return (
            index=index,
            id=hasproperty(experiment, :id) ? String(experiment.id) : string(index),
            design=design,
            status="failed",
            assay=assay,
            morphology=hasproperty(experiment, :morphology) ? experiment.morphology : NamedTuple(),
            motion=hasproperty(experiment, :motion) ? experiment.motion :
                (hasproperty(experiment, :params) ? experiment.params : NamedTuple()),
            result=nothing,
            error=sprint(showerror, error),
        )
    end
end

function run_experiments(design, experiments; strategy::String, workers::Int, kwargs...)
    if strategy == "serial" || length(experiments) <= 1
        return (
            [experiment_entry(design, index, experiment; kwargs...) for
             (index, experiment) in enumerate(experiments)],
            1,
        )
    end

    actual_workers = min(max(1, workers), Threads.nthreads(), length(experiments))
    if actual_workers <= 1
        return (
            [experiment_entry(design, index, experiment; kwargs...) for
             (index, experiment) in enumerate(experiments)],
            1,
        )
    end

    entries = Vector{Any}(undef, length(experiments))
    jobs = Channel{Int}(length(experiments))
    for index in eachindex(experiments)
        put!(jobs, index)
    end
    close(jobs)

    tasks = [
        Threads.@spawn begin
            for index in jobs
                entries[index] = experiment_entry(design, index, experiments[index]; kwargs...)
            end
        end for _ in 1:actual_workers
    ]
    foreach(fetch, tasks)
    return entries, actual_workers
end
