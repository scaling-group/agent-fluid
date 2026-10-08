const CUDA_MODULE = Ref{Union{Module, Nothing}}(
    isdefined(@__MODULE__, :CUDA) ? getfield(@__MODULE__, :CUDA) : nothing,
)
const CUDA_IMPORT_ATTEMPTED = Ref(CUDA_MODULE[] !== nothing)
const CUDA_IMPORT_ERROR = Ref{Union{Nothing, String}}(nothing)

function gpu_runtime_hint()
    cuda_visible_devices = strip(get(ENV, "CUDA_VISIBLE_DEVICES", ""))
    if !isempty(cuda_visible_devices) && cuda_visible_devices != "-1"
        return true
    end
    haskey(ENV, "PBS_GPUFILE") && return true
    return Sys.which("nvidia-smi") !== nothing
end

function load_cuda_module()
    if CUDA_IMPORT_ATTEMPTED[]
        return CUDA_MODULE[]
    end

    CUDA_IMPORT_ATTEMPTED[] = true
    try
        @eval import CUDA
        CUDA_MODULE[] = CUDA
        CUDA_IMPORT_ERROR[] = nothing
    catch error
        CUDA_MODULE[] = nothing
        CUDA_IMPORT_ERROR[] = sprint(showerror, error)
    end
    return CUDA_MODULE[]
end

function cuda_status(; import_if_needed::Bool)
    cuda = import_if_needed ? load_cuda_module() : CUDA_MODULE[]
    cuda === nothing && return (available=false, cuda_module=nothing, error=CUDA_IMPORT_ERROR[])

    try
        return (
            available=Bool(Base.invokelatest(getproperty(cuda, :functional))),
            cuda_module=cuda,
            error=nothing,
        )
    catch error
        return (available=false, cuda_module=cuda, error=sprint(showerror, error))
    end
end

cuda_mem_type(cuda_module::Module) = getproperty(cuda_module, :CuArray)

function is_cuda_storage(x)
    cuda = CUDA_MODULE[]
    cuda === nothing && return false
    cuarray_type = cuda_mem_type(cuda)
    return x isa cuarray_type || x === cuarray_type
end

function normalize_memory_backend_name(backend)
    normalized = lowercase(strip(String(backend)))
    normalized in ("auto", "cpu", "cuda") || error(
        "Unsupported memory backend `$backend`; expected one of auto, cpu, cuda.",
    )
    return normalized
end

function resolve_memory_backend(; backend="auto", mem=nothing)
    if mem !== nothing
        status = cuda_status(import_if_needed=false)
        return (
            name=is_cuda_storage(mem) ? "cuda" : "cpu",
            mem=mem,
            cuda_available=status.available,
        )
    end

    normalized = normalize_memory_backend_name(backend)
    if normalized == "cpu"
        return (name="cpu", mem=Array, cuda_available=false)
    end

    if normalized == "auto" && !gpu_runtime_hint()
        return (name="cpu", mem=Array, cuda_available=false)
    end

    status = cuda_status(import_if_needed=true)
    if normalized == "cuda"
        status.available || error(
            "DOGFISH_MEMORY_BACKEND=cuda requested, but CUDA is not available. " *
            something(status.error, "No CUDA device detected."),
        )
        return (name="cuda", mem=cuda_mem_type(status.cuda_module), cuda_available=true)
    end
    if status.available
        return (name="cuda", mem=cuda_mem_type(status.cuda_module), cuda_available=true)
    end
    return (name="cpu", mem=Array, cuda_available=false)
end

function validate_schema_entry(name::Symbol, entry)
    issues = String[]
    hasproperty(entry, :lower) || push!(issues, "`$name` schema entry missing lower")
    hasproperty(entry, :upper) || push!(issues, "`$name` schema entry missing upper")
    isempty(issues) || return issues

    lower = Float64(entry.lower)
    upper = Float64(entry.upper)
    isfinite(lower) || push!(issues, "`$name` lower must be finite")
    isfinite(upper) || push!(issues, "`$name` upper must be finite")
    lower < upper || push!(issues, "`$name` lower must be less than upper")
    return issues
end

function cast_named_tuple(params::NamedTuple, ::Type{T}) where {T}
    names = keys(params)
    values = map(name -> T(getproperty(params, name)), names)
    return NamedTuple{names}(values)
end

function design_experiments(design)
    if hasproperty(design, :experiments)
        return design.experiments
    end
    # Backward compatibility for older candidate_policy()-only lanes.
    return [
        (
            id="parameter_set_$(lpad(string(index), 3, '0'))",
            morphology=NamedTuple(),
            motion=params,
            assay=default_assay(),
        ) for (index, params) in enumerate(policy_experiments(design))
    ]
end

function validate_design_spec(design)
    issues = String[]
    hasproperty(design, :version) || push!(issues, "design spec missing version")
    hasproperty(design, :lineage) || push!(issues, "design spec missing lineage")
    hasproperty(design, :morphology) || push!(issues, "design spec missing morphology")
    hasproperty(design, :motion) || push!(issues, "design spec missing motion")
    hasproperty(design, :experiments) || push!(issues, "design spec missing experiments")
    isempty(issues) || return issues

    morphology = design.morphology
    motion = design.motion
    hasproperty(morphology, :schema) || push!(issues, "morphology spec missing schema")
    hasproperty(morphology, :params) || push!(issues, "morphology spec missing params")
    hasproperty(morphology, :generator) || push!(issues, "morphology spec missing generator")
    hasproperty(motion, :schema) || push!(issues, "motion spec missing schema")
    hasproperty(motion, :params) || push!(issues, "motion spec missing params")
    hasproperty(motion, :generator) || push!(issues, "motion spec missing generator")
    hasproperty(motion, :derive) || push!(issues, "motion spec missing derive")
    isempty(issues) || return issues

    morphology.schema isa NamedTuple || push!(issues, "morphology schema must be a NamedTuple")
    morphology.params isa NamedTuple || push!(issues, "morphology params must be a NamedTuple")
    morphology.generator isa Function || push!(issues, "morphology generator must be callable")
    motion.schema isa NamedTuple || push!(issues, "motion schema must be a NamedTuple")
    motion.params isa NamedTuple || push!(issues, "motion params must be a NamedTuple")
    motion.generator isa Function || push!(issues, "motion generator must be callable")
    motion.derive isa Function || push!(issues, "motion derive must be callable")
    isempty(issues) || return issues

    for (label, schema, params) in (
        ("morphology", morphology.schema, morphology.params),
        ("motion", motion.schema, motion.params),
    )
        schema_keys = Set(keys(schema))
        param_keys = Set(keys(params))
        for name in keys(schema)
            append!(issues, validate_schema_entry(name, getproperty(schema, name)))
        end
        for name in schema_keys
            name in param_keys || push!(issues, "$label params missing `$name`")
        end
        for name in param_keys
            name in schema_keys || push!(issues, "$label params has undeclared `$name`")
        end
        for name in intersect(schema_keys, param_keys)
            value = Float64(getproperty(params, name))
            entry = getproperty(schema, name)
            lower = Float64(entry.lower)
            upper = Float64(entry.upper)
            isfinite(value) || push!(issues, "$label params `$name` must be finite")
            lower <= value <= upper ||
                push!(issues, "$label params `$name`=$(value) outside [$lower, $upper]")
        end
    end

    experiments = collect(design.experiments)
    isempty(experiments) && push!(issues, "design experiments must not be empty")
    for (index, experiment) in enumerate(experiments)
        experiment isa NamedTuple || begin
            push!(issues, "experiment $index must be a NamedTuple")
            continue
        end
        hasproperty(experiment, :id) || push!(issues, "experiment $index missing id")
        hasproperty(experiment, :morphology) || push!(issues, "experiment $index missing morphology")
        hasproperty(experiment, :motion) || push!(issues, "experiment $index missing motion")
        if hasproperty(experiment, :id)
            id = String(experiment.id)
            isempty(strip(id)) && push!(issues, "experiment $index id must not be empty")
        end
        if hasproperty(experiment, :morphology) && !(experiment.morphology isa NamedTuple)
            push!(issues, "experiment $index morphology must be a NamedTuple")
        end
        if hasproperty(experiment, :motion) && !(experiment.motion isa NamedTuple)
            push!(issues, "experiment $index motion must be a NamedTuple")
        end
        if hasproperty(experiment, :assay)
            append!(issues, validate_assay_definition(index, experiment.assay))
        end
    end
    return issues
end

function validate_policy_spec(policy)
    issues = String[]
    hasproperty(policy, :version) || push!(issues, "policy spec missing version")
    hasproperty(policy, :schema) || push!(issues, "policy spec missing schema")
    hasproperty(policy, :displacement) || push!(issues, "policy spec missing displacement")
    (hasproperty(policy, :experiments) || hasproperty(policy, :parameter_sets)) ||
        push!(issues, "policy spec missing experiments")
    isempty(issues) || return issues

    policy.schema isa NamedTuple || push!(issues, "policy schema must be a NamedTuple")
    experiments = policy_experiments(policy)
    applicable(iterate, experiments) || push!(issues, "policy experiments must be iterable")
    policy.displacement isa Function || push!(issues, "policy displacement must be callable")
    isempty(issues) || return issues

    schema_keys = Set(keys(policy.schema))
    (:A in schema_keys) || push!(issues, "policy schema must include A")
    (:St in schema_keys) || push!(issues, "policy schema must include St")
    for name in keys(policy.schema)
        append!(issues, validate_schema_entry(name, getproperty(policy.schema, name)))
    end

    experiments = collect(experiments)
    isempty(experiments) && push!(issues, "policy experiments must not be empty")
    for (index, experiment) in enumerate(experiments)
        exp_issues = validate_experiment_definition(index, experiment)
        append!(issues, exp_issues)
        isempty(exp_issues) || continue
        params = experiment.params
        params isa NamedTuple || begin
            push!(issues, "experiment $index params must be a NamedTuple")
            continue
        end
        param_keys = Set(keys(params))
        for name in schema_keys
            name in param_keys || push!(issues, "experiment $index params missing `$name`")
        end
        for name in param_keys
            name in schema_keys || push!(issues, "experiment $index params has undeclared `$name`")
        end
        for name in intersect(schema_keys, param_keys)
            value = Float64(getproperty(params, name))
            entry = getproperty(policy.schema, name)
            lower = Float64(entry.lower)
            upper = Float64(entry.upper)
            isfinite(value) || push!(issues, "experiment $index params `$name` must be finite")
            lower <= value <= upper ||
                push!(issues, "experiment $index params `$name`=$(value) outside [$lower, $upper]")
        end
    end

    return issues
end

function policy_experiments(policy)
    if hasproperty(policy, :experiments)
        return policy.experiments
    end
    # Backward compatibility for early candidate modules.
    return [
        (
            id="parameter_set_$(lpad(string(index), 3, '0'))",
            params=params,
        ) for (index, params) in enumerate(policy.parameter_sets)
    ]
end

function validate_experiment_definition(index::Int, experiment)
    issues = String[]
    experiment isa NamedTuple || begin
        push!(issues, "experiment $index must be a NamedTuple")
        return issues
    end
    hasproperty(experiment, :id) || push!(issues, "experiment $index missing id")
    hasproperty(experiment, :params) || push!(issues, "experiment $index missing params")
    if hasproperty(experiment, :id)
        id = String(experiment.id)
        isempty(strip(id)) && push!(issues, "experiment $index id must not be empty")
    end
    if hasproperty(experiment, :params) && !(experiment.params isa NamedTuple)
        push!(issues, "experiment $index params must be a NamedTuple")
    end
    if hasproperty(experiment, :assay)
        append!(issues, validate_assay_definition(index, experiment.assay))
    end
    return issues
end

function parameter_with_derived_values(params::NamedTuple; L::Int, T::Type=Float32)
    typed_params = cast_named_tuple(params, T)
    U = T(1)
    Lf = T(L)
    A = T(typed_params.A)
    St = T(typed_params.St)
    omega = T(2 * pi) * St * U / (T(2) * A * Lf)
    # sim_step! uses tU/L; the body map receives raw solver time internally.
    period = T(2) * A / St
    return merge(typed_params, (omega=omega,)), Float64(period)
end

function normalize_candidate()
    if isdefined(Main, :candidate_design)
        return Main.candidate_design()
    end
    if isdefined(Main, :candidate_policy)
        policy = Main.candidate_policy()
        return (
            version = hasproperty(policy, :version) ? policy.version : "dogfish.motion_policy.compat.v1",
            lineage = (
                body_regime = :baseline_locked_body_plan,
                motion_regime = :legacy_policy_module,
                notes = "compatibility wrapper around candidate_policy()",
            ),
            morphology = (
                schema = NamedTuple(),
                params = NamedTuple(),
                generator = (s, p) -> baseline_width_generator(s),
            ),
            motion = (
                schema = policy.schema,
                params = NamedTuple(),
                generator = policy.displacement,
                derive = motion_derived_from_A_St,
            ),
            experiments = [
                (
                    id = experiment.id,
                    morphology = NamedTuple(),
                    motion = experiment.params,
                    assay = hasproperty(experiment, :assay) ?
                        normalize_assay(experiment.assay) : default_assay(),
                ) for experiment in policy_experiments(policy)
            ],
        )
    end
    error("candidate.jl must define candidate_design() or candidate_policy()")
end

@inline function baseline_width_generator(s)
    return profile_width(baseline_thickness_profile(), s)
end

function motion_derived_from_A_St(params; L::Int, T::Type=Float32)
    return parameter_with_derived_values(params; L, T)
end

function assemble_experiment(design, experiment; T::Type=Float32)
    morphology_params = merge(design.morphology.params, experiment.morphology)
    motion_params = merge(design.motion.params, experiment.motion)
    typed_morphology = cast_named_tuple(morphology_params, T)
    derived = design.motion.derive(motion_params; L=64, T=T) # placeholder overridden later
    return typed_morphology, derived
end

function assemble_experiment_for_length(design, experiment; L::Int, T::Type=Float32)
    morphology_params = merge(design.morphology.params, experiment.morphology)
    motion_params = merge(design.motion.params, experiment.motion)
    typed_morphology = cast_named_tuple(morphology_params, T)
    derived = design.motion.derive(motion_params; L, T)
    return typed_morphology, derived.params, derived.period
end

function build_simulation(
    design,
    experiment::NamedTuple;
    L::Int=64,
    Re::Float32=2000f0,
    T::Type=Float32,
    backend="auto",
    mem=nothing,
)
    resolved_backend = resolve_memory_backend(backend=backend, mem=mem)
    _, assembled_params, period = assemble_experiment_for_length(design, experiment; L, T)
    morphology_params = baseline_morphology_parameters(T)
    U = T(1)
    Lf = T(L)
    sdf = DogfishSDF(Lf, baseline_thickness_profile(T))
    map = SpineMotionMap(design.motion.generator, assembled_params, Lf)

    simulation_builder = () -> Simulation(
        (4L, 2L),
        (U, zero(T)),
        L;
        ν=U * Lf / Re,
        body=AutoBody(sdf, map),
        T,
        mem=resolved_backend.mem,
    )
    sim = resolved_backend.name == "cuda" ? Base.invokelatest(simulation_builder) : simulation_builder()
    return sim, period, morphology_params, assembled_params, resolved_backend
end
