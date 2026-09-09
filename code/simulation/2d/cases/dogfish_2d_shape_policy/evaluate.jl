case_dir = @__DIR__

include(joinpath(case_dir, "src", "DogfishShapePolicyTestbed.jl"))
using .DogfishShapePolicyTestbed

include(joinpath(case_dir, "candidate.jl"))

function main()
    log_root = get(ENV, "ESCHER_EVAL_LOG_ROOT", joinpath(pwd(), "logs", "evaluate"))
    eval_L = DogfishShapePolicyTestbed.env_int("DOGFISH_EVAL_L", 64)
    parameter_index = DogfishShapePolicyTestbed.env_int("DOGFISH_PARAMETER_INDEX", 1)
    n_warmup_cycles = DogfishShapePolicyTestbed.env_float32("DOGFISH_WARMUP_CYCLES", 2.0f0)
    n_eval_cycles = DogfishShapePolicyTestbed.env_float32("DOGFISH_EVAL_CYCLES", 2.0f0)
    samples_per_cycle = DogfishShapePolicyTestbed.env_int("DOGFISH_SAMPLES_PER_CYCLE", 24)
    requested_backend = DogfishShapePolicyTestbed.env_string("DOGFISH_MEMORY_BACKEND", "auto")

    design = normalize_candidate()
    batch = evaluate_policy_batch(
        design;
        L=eval_L,
        n_warmup_cycles,
        n_eval_cycles,
        samples_per_cycle,
        backend=requested_backend,
    )
    write_batch_score_files(log_root, batch; requested_backend)

    println("score=$(batch.aggregate.score)")
    println("best_CT_prop=$(batch.aggregate.best_CT_prop)")
    println("eta_at_best_CT=$(batch.aggregate.eta_at_best_CT)")
    println("success_count=$(batch.aggregate.success_count)")
    println("positive_fraction=$(batch.aggregate.positive_fraction)")
    println("experiment_count=$(length(batch.entries))")
    println("policy_version=$(batch.policy_version)")
    println("requested_memory_backend=$(requested_backend)")
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
