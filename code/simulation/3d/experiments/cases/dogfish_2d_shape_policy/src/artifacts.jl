function env_string(name::String, default::String)
    value = strip(get(ENV, name, ""))
    return isempty(value) ? default : value
end

function env_int(name::String, default::Int)
    value = strip(get(ENV, name, ""))
    return isempty(value) ? default : parse(Int, value)
end

function env_float32(name::String, default::Float32)
    value = strip(get(ENV, name, ""))
    return isempty(value) ? default : parse(Float32, value)
end

function env_bool(name::String, default::Bool)
    value = lowercase(strip(get(ENV, name, "")))
    isempty(value) && return default
    value in ("1", "true", "yes", "on") && return true
    value in ("0", "false", "no", "off") && return false
    error("Unsupported boolean env value for $name: `$value`")
end

function write_parameter_block(io, name::AbstractString, params)
    println(io, "$name:")
    for key in keys(params)
        value = getproperty(params, key)
        if value isa Real
            println(io, "  $(key): $(Float64(value))")
        else
            println(io, "  $(key): $(jsonable(value))")
        end
    end
end

function jsonable(value)
    value === nothing && return nothing
    if value isa NamedTuple
        return Dict(String(key) => jsonable(getproperty(value, key)) for key in keys(value))
    elseif value isa AbstractDict
        return Dict(String(key) => jsonable(item) for (key, item) in value)
    elseif value isa AbstractVector
        return [jsonable(item) for item in value]
    elseif value isa Tuple
        return [jsonable(item) for item in value]
    elseif value isa Symbol
        return String(value)
    elseif value isa AbstractFloat
        return isfinite(value) ? Float64(value) : string(value)
    elseif value isa Integer || value isa Bool || value isa AbstractString
        return value
    else
        return string(value)
    end
end

function scalar_text(value)
    value === nothing && return "null"
    return string(value)
end

function raw_metrics_dict(result)
    return jsonable(result.raw_metrics)
end

function has_trajectory_artifact(result)
    return hasproperty(result.raw_metrics, :trajectory)
end

function write_trajectory_artifact(log_root::AbstractString, result)
    has_trajectory_artifact(result) || return nothing
    path = joinpath(log_root, "trajectory.json")
    open(path, "w") do io
        JSON.print(io, Dict(
            "schema_version" => "dogfish.trajectory_1d.v0",
            "experiment_id" => result.experiment_id,
            "assay" => jsonable(result.assay),
            "validity" => jsonable(result.validity),
            "trajectory" => jsonable(result.raw_metrics.trajectory),
        ), 2)
    end
    return "trajectory.json"
end

function score_dict(result)
    return Dict(
        "score_schema_version" => SCORE_SCHEMA_VERSION,
        "score" => result.score,
        "selection_score" => result.selection_score,
        "assay_local_score" => result.assay_local_score,
        "assay_local_score_name" => result.assay_local_score_name,
        "raw_metrics" => raw_metrics_dict(result),
        "validity" => jsonable(result.validity),
        "CT_prop" => result.CT_prop,
        "Cx_drag" => result.Cx_drag,
        "rms_lateral_force" => result.rms_lateral_force,
        "mean_lateral_force" => result.mean_lateral_force,
        "CP" => result.CP,
        "eta" => result.eta,
        "period" => result.period,
        "samples" => result.samples,
        "grid_L" => result.grid_L,
        "Re" => result.Re,
        "memory_backend" => result.memory_backend,
        "cuda_available" => result.cuda_available,
    )
end

function write_single_score_files(log_root::AbstractString, result; media=nothing, requested_backend="auto")
    mkpath(log_root)
    trajectory_path = write_trajectory_artifact(log_root, result)
    summary = (
        "Score $(round(result.score, digits=4)); " *
        "CT_prop=$(round(result.CT_prop, digits=4)); " *
        "Cx_drag=$(round(result.Cx_drag, digits=4)); " *
        "CP=$(round(result.CP, digits=4)); " *
        "eta=$(round(result.eta, digits=4)); " *
        "policy=$(result.policy_version); " *
        "backend=$(result.memory_backend)"
    )

    open(joinpath(log_root, "score.yaml"), "w") do io
        println(io, "score_schema_version: " * repr(SCORE_SCHEMA_VERSION))
        println(io, "score: $(result.score)")
        println(io, "selection_eligible: $(result.selection_eligible)")
        println(io, "selection_score: $(scalar_text(result.selection_score))")
        println(io, "assay_local_score: $(result.assay_local_score)")
        println(io, "assay_local_score_name: " * repr(result.assay_local_score_name))
        println(io, "summary: " * repr(summary))
        println(io, "CT_prop: $(result.CT_prop)")
        println(io, "Cx_drag: $(result.Cx_drag)")
        println(io, "rms_lateral_force: $(result.rms_lateral_force)")
        println(io, "mean_lateral_force: $(result.mean_lateral_force)")
        println(io, "CP: $(result.CP)")
        println(io, "eta: $(result.eta)")
        println(io, "period: $(result.period)")
        println(io, "samples: $(result.samples)")
        println(io, "grid_L: $(result.grid_L)")
        println(io, "Re: $(result.Re)")
        println(io, "policy_version: " * repr(result.policy_version))
        println(io, "parameter_index: $(result.parameter_index)")
        println(io, "experiment_id: " * repr(result.experiment_id))
        println(io, "assay_family: " * repr(String(result.assay.family)))
        println(io, "assay_version: " * repr(result.assay.version))
        println(io, "assay_purpose: " * repr(String(result.assay.purpose)))
        println(io, "assay_capability_axis: " * repr(String(result.assay.capability_axis)))
        println(io, "validity_assumption_domain: " * repr(String(result.validity.assumption_domain)))
        println(io, "validity_admissible: $(result.validity.admissible)")
        println(io, "memory_backend: " * repr(result.memory_backend))
        println(io, "requested_memory_backend: " * repr(requested_backend))
        println(io, "cuda_available: $(result.cuda_available)")
        if media !== nothing
            println(io, "debug_gif: " * repr(media.gif_path))
            println(io, "debug_png: " * repr(media.png_path))
            println(io, "render_manifest: " * repr(media.manifest_path))
            println(io, "frame_01: " * repr(media.frame_01_path))
            println(io, "frame_02: " * repr(media.frame_02_path))
            println(io, "frame_03: " * repr(media.frame_03_path))
            println(io, "frame_04: " * repr(media.frame_04_path))
        end
        if trajectory_path !== nothing
            println(io, "trajectory: " * repr(trajectory_path))
        end
        write_parameter_block(io, "morphology_parameters", result.morphology_parameters)
        write_parameter_block(io, "parameter_set", result.parameter_set)
        write_parameter_block(io, "assembled_parameters", result.assembled_parameters)
    end

    open(joinpath(log_root, "metrics.txt"), "w") do io
        println(io, summary)
        println(io, "score_schema_version=$(SCORE_SCHEMA_VERSION)")
        println(io, "selection_eligible=$(result.selection_eligible)")
        println(io, "selection_score=$(scalar_text(result.selection_score))")
        println(io, "assay_local_score=$(result.assay_local_score)")
        println(io, "assay_local_score_name=$(result.assay_local_score_name)")
        println(io, "policy_version=$(result.policy_version)")
        println(io, "parameter_index=$(result.parameter_index)")
        println(io, "experiment_id=$(result.experiment_id)")
        println(io, "assay_family=$(result.assay.family)")
        println(io, "assay_version=$(result.assay.version)")
        println(io, "assay_purpose=$(result.assay.purpose)")
        println(io, "assay_capability_axis=$(result.assay.capability_axis)")
        println(io, "validity_assumption_domain=$(result.validity.assumption_domain)")
        println(io, "validity_admissible=$(result.validity.admissible)")
        println(io, "requested_memory_backend=$(requested_backend)")
        println(io, "memory_backend=$(result.memory_backend)")
        println(io, "cuda_available=$(result.cuda_available)")
        if media !== nothing
            println(io, "debug_gif=$(media.gif_path)")
            println(io, "debug_png=$(media.png_path)")
            println(io, "render_manifest=$(media.manifest_path)")
            println(io, "frame_01=$(media.frame_01_path)")
            println(io, "frame_02=$(media.frame_02_path)")
            println(io, "frame_03=$(media.frame_03_path)")
            println(io, "frame_04=$(media.frame_04_path)")
        end
        if trajectory_path !== nothing
            println(io, "trajectory=$(trajectory_path)")
        end
    end
end

function morphology_width_for_label(params, name::Symbol, fallback_index::Int)
    if hasproperty(params, name)
        return Float64(getproperty(params, name))
    end
    if hasproperty(params, :width_samples)
        samples = params.width_samples
        if 1 <= fallback_index <= length(samples)
            return Float64(samples[fallback_index])
        end
    end
    return NaN
end

function format_overlay(entry, result; label::String)
    trunk_width = morphology_width_for_label(result.morphology_parameters, :trunk_width, 2)
    tail_width = morphology_width_for_label(result.morphology_parameters, :tail_width, 7)
    title = "Dogfish 2D Vorticity | " * label * " | score=" * string(round(result.score, digits=3))
    details = (
        "id=" * entry.id *
        "   body=" * string(round(trunk_width, digits=3)) *
        "   tail=" * string(round(tail_width, digits=3)) *
        "   CT=" * string(round(result.CT_prop, digits=3)) *
        "   CP=" * string(round(result.CP, digits=3)) *
        "   eta=" * string(round(result.eta, digits=3))
    )
    return title, details
end

function sanitize_float(value; digits=3)
    rounded = round(Float64(value), digits=digits)
    return replace(string(rounded), "." => "p")
end

relative_output_path(path::AbstractString, output_root::AbstractString) = relpath(path, output_root)

function render_basename(entry, result)
    trunk_width = morphology_width_for_label(result.morphology_parameters, :trunk_width, 2)
    tail_width = morphology_width_for_label(result.morphology_parameters, :tail_width, 7)
    return join(
        [
            "dogfish2d",
            entry.id,
            "body" * sanitize_float(trunk_width),
            "tail" * sanitize_float(tail_width),
            "score" * sanitize_float(result.score),
        ],
        "_",
    )
end

function vorticity_field(sim)
    @inside sim.flow.σ[I] = WaterLily.curl(3, I, sim.flow.u) * sim.L / sim.U
    return Array(sim.flow.σ)'
end

function tail_vortex_signal(omega_field)
    tail_col_start = max(1, Int(floor(size(omega_field, 2) * 0.55)))
    return maximum(abs.(view(omega_field, :, tail_col_start:size(omega_field, 2))))
end

function frame_snapshot(frame_index::Int, simulation_time::Real, cycle_fraction::Real, omega_field)
    return (
        frame_index=frame_index,
        simulation_time=Float64(simulation_time),
        cycle_fraction=Float64(cycle_fraction),
        peak_abs_vorticity=maximum(abs.(omega_field)),
        tail_vortex_signal=tail_vortex_signal(omega_field),
        omega=omega_field,
    )
end

function first_unique_frame_index(candidate_indices::Vector{Int}, used::Set{Int}, n_frames::Int)
    for idx in candidate_indices
        clamped = clamp(idx, 1, n_frames)
        if clamped ∉ used
            push!(used, clamped)
            return clamped
        end
    end
    for idx in 1:n_frames
        if idx ∉ used
            push!(used, idx)
            return idx
        end
    end
    return n_frames
end

function select_canonical_frame_indices(snapshots)
    n_frames = length(snapshots)
    used = Set{Int}()
    startup_idx = first_unique_frame_index([1], used, n_frames)
    mid_guess = clamp(round(Int, n_frames * 0.4), 1, n_frames)
    mid_idx = first_unique_frame_index([mid_guess, mid_guess + 1, mid_guess - 1], used, n_frames)
    tail_rank = sortperm([snapshot.tail_vortex_signal for snapshot in snapshots], rev=true)
    tail_idx = first_unique_frame_index(collect(tail_rank), used, n_frames)
    final_idx = first_unique_frame_index([n_frames], used, n_frames)
    return [
        (slot="frame_01", kind="startup", index=startup_idx, reason="first rendered frame after warmup"),
        (slot="frame_02", kind="mid_wake", index=mid_idx, reason="fixed representative mid-cycle wake frame"),
        (slot="frame_03", kind="tail_vortex_peak", index=tail_idx, reason="frame with the strongest tail-region vortex signal"),
        (slot="frame_04", kind="final", index=final_idx, reason="final rendered frame"),
    ]
end

function manifest_frame_entry(selection, snapshot, frame_path::AbstractString)
    return Dict(
        "slot" => selection.slot,
        "path" => frame_path,
        "kind" => selection.kind,
        "frame_index" => snapshot.frame_index,
        "simulation_time" => snapshot.simulation_time,
        "cycle_fraction" => snapshot.cycle_fraction,
        "selection_reason" => selection.reason,
        "stats" => Dict(
            "peak_abs_vorticity" => snapshot.peak_abs_vorticity,
            "tail_vortex_signal" => snapshot.tail_vortex_signal,
        ),
    )
end

function plot_vorticity_field(omega_field, entry, result; label="seed", clims=(-10, 10))
    title_text, detail_text = format_overlay(entry, result; label)
    plt = contourf(
        omega_field;
        color=palette(:BuGn),
        clims=clims,
        levels=range(clims[1], clims[2], length=41),
        linewidth=0,
        aspect_ratio=:equal,
        legend=false,
        border=:none,
        ticks=nothing,
        title=title_text,
        titlefont=font(11, "sans-serif"),
        size=(1400, 560),
        top_margin=6Plots.mm,
    )
    annotate!(plt, 0.05 * size(omega_field, 2), 0.94 * size(omega_field, 1), text(detail_text, 8, :black, :left))
    return plt
end

function render_experiment_gif(
    design,
    entry;
    output_root::AbstractString,
    result,
    n_warmup_cycles::Float32=2.0f0,
    n_render_cycles::Float32=1.0f0,
    frames_per_cycle::Int=24,
    backend="cpu",
)
    mkpath(output_root)
    experiment = (id=entry.id, morphology=entry.morphology, motion=entry.motion, assay=entry.assay)
    sim, period, _, _, _ = build_simulation(
        design,
        experiment;
        L=result.grid_L,
        Re=Float32(result.Re),
        T=Float32,
        backend,
    )
    sim_step!(sim, n_warmup_cycles * period, remeasure=true)

    base = render_basename(entry, result)
    gif_path_abs = joinpath(output_root, base * ".gif")
    png_path_abs = joinpath(output_root, "frame_04.png")
    manifest_path = joinpath(output_root, "render_manifest.json")
    n_frames = max(1, Int(round(Float64(n_render_cycles * frames_per_cycle))))
    dt = period / frames_per_cycle
    t0 = sim_time(sim)
    snapshots = []
    for frame_index in 1:n_frames
        target_t = t0 + frame_index * dt
        sim_step!(sim, target_t, remeasure=true)
        push!(snapshots, frame_snapshot(frame_index, sim_time(sim), Float64(frame_index) / Float64(n_frames), vorticity_field(sim)))
    end
    selections = select_canonical_frame_indices(snapshots)
    frame_paths = Dict(selection.slot => joinpath(output_root, selection.slot * ".png") for selection in selections)
    selected_frames = []
    animation = Animation()
    for snapshot in snapshots
        plt = plot_vorticity_field(snapshot.omega, entry, result; label=entry.id)
        frame(animation, plt)
        for selection in selections
            if snapshot.frame_index == selection.index
                frame_path = frame_paths[selection.slot]
                savefig(plt, frame_path)
                push!(selected_frames, manifest_frame_entry(selection, snapshot, relative_output_path(frame_path, output_root)))
            end
        end
    end
    gif(animation, gif_path_abs; fps=12)

    manifest = Dict(
        "schema_version" => "dogfish.render_manifest.v1",
        "label" => entry.id,
        "base_name" => base,
        "gif_path" => relative_output_path(gif_path_abs, output_root),
        "png_path" => relative_output_path(png_path_abs, output_root),
        "render_config" => Dict(
            "frames_per_cycle" => frames_per_cycle,
            "n_render_cycles" => Float64(n_render_cycles),
            "n_frames_rendered" => n_frames,
            "fps" => 12,
            "grid_L" => result.grid_L,
            "Re" => result.Re,
        ),
        "score" => score_dict(result),
        "assay" => jsonable(entry.assay),
        "morphology" => jsonable(entry.morphology),
        "motion" => jsonable(entry.motion),
        "selected_frames" => sort(selected_frames; by=frame -> frame["slot"]),
    )
    open(manifest_path, "w") do io
        JSON.print(io, manifest, 2)
    end

    return (
        gif_path=relative_output_path(gif_path_abs, output_root),
        png_path=relative_output_path(png_path_abs, output_root),
        manifest_path=relative_output_path(manifest_path, output_root),
        frame_01_path=relative_output_path(frame_paths["frame_01"], output_root),
        frame_02_path=relative_output_path(frame_paths["frame_02"], output_root),
        frame_03_path=relative_output_path(frame_paths["frame_03"], output_root),
        frame_04_path=relative_output_path(frame_paths["frame_04"], output_root),
    )
end

function experiment_dir_name(index::Int)
    return lpad(string(index), 3, '0')
end

function write_experiment_score_files(root::AbstractString, entry)
    exp_root = joinpath(root, "experiments", experiment_dir_name(entry.index))
    mkpath(exp_root)
    if entry.status == "ok"
        render_media = env_bool("DOGFISH_RENDER_EXPERIMENTS", true)
        media = render_media ? render_experiment_gif(
            entry.design,
            entry;
            output_root=exp_root,
            result=entry.result,
            backend=entry.result.memory_backend,
            n_warmup_cycles=env_float32("DOGFISH_RENDER_WARMUP_CYCLES", 1.0f0),
            n_render_cycles=env_float32("DOGFISH_RENDER_CYCLES", 1.0f0),
            frames_per_cycle=env_int("DOGFISH_RENDER_FRAMES_PER_CYCLE", 24),
        ) : nothing
        write_single_score_files(exp_root, entry.result; media, requested_backend=entry.result.memory_backend)
    else
        open(joinpath(exp_root, "score.yaml"), "w") do io
            println(io, "score: -100.0")
            println(io, "summary: " * repr("experiment failed"))
            println(io, "experiment_id: " * repr(entry.id))
            println(io, "assay_family: " * repr(String(entry.assay.family)))
            println(io, "assay_version: " * repr(entry.assay.version))
            println(io, "status: failed")
            println(io, "error: " * repr(entry.error))
        end
        open(joinpath(exp_root, "metrics.txt"), "w") do io
            println(io, "experiment_id=$(entry.id)")
            println(io, "assay_family=$(entry.assay.family)")
            println(io, "assay_version=$(entry.assay.version)")
            println(io, "status=failed")
            println(io, "error=$(entry.error)")
        end
    end
end

function manifest_entry(entry)
    payload = Dict(
        "index" => entry.index,
        "id" => entry.id,
        "status" => entry.status,
        "assay" => jsonable(entry.assay),
        "morphology" => jsonable(entry.morphology),
        "motion" => jsonable(entry.motion),
        "paths" => Dict(
            "score" => joinpath("experiments", experiment_dir_name(entry.index), "score.yaml"),
            "metrics" => joinpath("experiments", experiment_dir_name(entry.index), "metrics.txt"),
        ),
    )
    if entry.status == "ok"
        payload["score"] = score_dict(entry.result)
        payload["metrics"] = raw_metrics_dict(entry.result)
        payload["assay_local_score"] = entry.result.assay_local_score
        payload["assay_local_score_name"] = entry.result.assay_local_score_name
        payload["selection_eligible"] = entry.result.selection_eligible
        payload["selection_score"] = jsonable(entry.result.selection_score)
        payload["validity"] = jsonable(entry.result.validity)
        if has_trajectory_artifact(entry.result)
            payload["paths"]["trajectory"] = joinpath(
                "experiments",
                experiment_dir_name(entry.index),
                "trajectory.json",
            )
        end
    else
        payload["error"] = entry.error
    end
    return payload
end

function write_batch_score_files(log_root::AbstractString, batch; requested_backend="auto")
    mkpath(log_root)
    for entry in batch.entries
        write_experiment_score_files(log_root, entry)
    end

    aggregate = batch.aggregate
    manifest = Dict(
        "schema_version" => batch.schema_version,
        "assay_contract_version" => ASSAY_CONTRACT_VERSION,
        "score_schema_version" => SCORE_SCHEMA_VERSION,
        "selection_program_version" => SELECTION_PROGRAM_VERSION,
        "policy_version" => batch.policy_version,
        "score_semantics" => Dict(
            "legacy_score_field" => "score",
            "legacy_score_meaning" => "selection_score",
            "selection_score_name" => STEADY_CRUISE_BATCH_SELECTION_SCORE,
            "assay_local_score_owner" => "testbed",
            "cross_assay_selection_owner" => "research_program",
        ),
        "batch" => Dict(
            "experiment_count" => length(batch.entries),
            "max_experiments" => batch.max_experiments,
            "strategy" => batch.strategy,
            "requested_workers" => batch.requested_workers,
            "actual_workers" => batch.actual_workers,
        ),
        "aggregate" => jsonable(aggregate),
        "experiments" => [manifest_entry(entry) for entry in batch.entries],
    )
    open(joinpath(log_root, "batch_manifest.json"), "w") do io
        JSON.print(io, manifest, 2)
    end

    open(joinpath(log_root, "score.yaml"), "w") do io
        println(io, "score_schema_version: " * repr(SCORE_SCHEMA_VERSION))
        println(io, "selection_program_version: " * repr(SELECTION_PROGRAM_VERSION))
        println(io, "score: $(aggregate.score)")
        println(io, "selection_score: $(aggregate.selection_score)")
        println(io, "selection_score_name: " * repr(aggregate.selection_score_name))
        println(io, "summary: " * repr(aggregate.summary))
        println(io, "policy_version: " * repr(batch.policy_version))
        println(io, "batch_manifest: " * repr("batch_manifest.json"))
        println(io, "experiment_count: $(length(batch.entries))")
        println(io, "batch_strategy: " * repr(batch.strategy))
        println(io, "batch_requested_workers: $(batch.requested_workers)")
        println(io, "batch_actual_workers: $(batch.actual_workers)")
        println(io, "best_experiment_index: $(aggregate.best_experiment_index)")
        println(io, "best_experiment_id: " * repr(aggregate.best_experiment_id))
        println(io, "best_CT_prop: $(aggregate.best_CT_prop)")
        println(io, "eta_at_best_CT: $(aggregate.eta_at_best_CT)")
        println(io, "success_count: $(aggregate.success_count)")
        println(io, "positive_fraction: $(aggregate.positive_fraction)")
        println(io, "requested_memory_backend: " * repr(requested_backend))
    end

    open(joinpath(log_root, "metrics.txt"), "w") do io
        println(io, aggregate.summary)
        println(io, "score_schema_version=$(SCORE_SCHEMA_VERSION)")
        println(io, "selection_program_version=$(SELECTION_PROGRAM_VERSION)")
        println(io, "selection_score=$(aggregate.selection_score)")
        println(io, "selection_score_name=$(aggregate.selection_score_name)")
        println(io, "policy_version=$(batch.policy_version)")
        println(io, "experiment_count=$(length(batch.entries))")
        println(io, "batch_strategy=$(batch.strategy)")
        println(io, "batch_requested_workers=$(batch.requested_workers)")
        println(io, "batch_actual_workers=$(batch.actual_workers)")
        println(io, "best_experiment_id=$(aggregate.best_experiment_id)")
        println(io, "best_CT_prop=$(aggregate.best_CT_prop)")
        println(io, "eta_at_best_CT=$(aggregate.eta_at_best_CT)")
        println(io, "success_count=$(aggregate.success_count)")
        println(io, "positive_fraction=$(aggregate.positive_fraction)")
    end
end
