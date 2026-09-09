mutable struct PhaseProfiler
    enabled::Bool
    sync_gpu::Bool
    timings::Dict{String, Float64}
end

function phase_profiler(enabled::Bool; sync_gpu::Bool=false, phases=String[])
    timings = Dict{String, Float64}(String(phase) => 0.0 for phase in phases)
    return PhaseProfiler(enabled, sync_gpu, timings)
end

function synchronize_cuda_backend()
    cuda = CUDA_MODULE[]
    cuda === nothing && return nothing
    Base.invokelatest(getproperty(cuda, :synchronize))
    return nothing
end

function record_phase!(f, profiler::PhaseProfiler, phase::AbstractString)
    profiler.enabled || return f()
    profiler.sync_gpu && synchronize_cuda_backend()
    start_ns = time_ns()
    try
        return f()
    finally
        profiler.sync_gpu && synchronize_cuda_backend()
        elapsed_s = Float64(time_ns() - start_ns) * 1.0e-9
        phase_key = String(phase)
        profiler.timings[phase_key] = get(profiler.timings, phase_key, 0.0) + elapsed_s
    end
end

function phase_timing_summary(profiler::PhaseProfiler, wall_s::Float64)
    accounted_s = profiler.enabled ? sum(values(profiler.timings)) : 0.0
    fraction_of_wall = Dict(
        key => value / max(wall_s, eps(Float64)) for (key, value) in profiler.timings
    )
    fraction_of_accounted = Dict(
        key => value / max(accounted_s, eps(Float64)) for (key, value) in profiler.timings
    )
    return Dict(
        "enabled" => profiler.enabled,
        "gpu_synchronized" => profiler.enabled && profiler.sync_gpu,
        "timing_s" => profiler.enabled ? profiler.timings : Dict{String, Float64}(),
        "timing_accounted_s" => accounted_s,
        "timing_unaccounted_s" => profiler.enabled ? wall_s - accounted_s : nothing,
        "timing_fraction_of_wall" => profiler.enabled ? fraction_of_wall : Dict{String, Float64}(),
        "timing_fraction_of_accounted" => profiler.enabled ? fraction_of_accounted : Dict{String, Float64}(),
    )
end

function start_gpu_monitor(
    output_root::AbstractString;
    enabled::Bool,
    interval_s::Int=1,
    gpu_indices::AbstractString="",
)
    if !enabled || Sys.which("nvidia-smi") === nothing
        return (process=nothing, io=nothing, path=nothing)
    end

    mkpath(output_root)
    path = joinpath(output_root, "gpu_utilization.csv")
    io = open(path, "w")
    command = [
        "nvidia-smi",
        "--query-gpu=timestamp,index,name,utilization.gpu,utilization.memory,memory.used,memory.total,power.draw,temperature.gpu",
        "--format=csv",
        "-l",
        string(max(1, interval_s)),
    ]
    if !isempty(strip(gpu_indices))
        push!(command, "-i")
        push!(command, strip(gpu_indices))
    end
    cmd = Cmd(command)
    process = run(pipeline(cmd; stdout=io, stderr=devnull), wait=false)
    return (process=process, io=io, path=path)
end

function stop_gpu_monitor(monitor)
    monitor.process === nothing && return nothing
    try
        kill(monitor.process)
    catch
    end
    try
        wait(monitor.process)
    catch
    end
    try
        close(monitor.io)
    catch
    end
    return monitor.path
end

function parse_metric_number(value)
    matched = match(r"[-+]?\d+(?:\.\d+)?", String(value))
    matched === nothing && return nothing
    return parse(Float64, matched.match)
end

function summarize_values(values)
    isempty(values) && return nothing
    return Dict(
        "avg" => sum(values) / length(values),
        "min" => minimum(values),
        "max" => maximum(values),
    )
end

function gpu_monitor_summary(path)
    path === nothing && return nothing
    isfile(path) || return nothing

    lines = readlines(path)
    length(lines) >= 2 || return Dict("samples" => 0)
    headers = [lowercase(strip(header)) for header in split(first(lines), ",")]
    metric_names = (
        "utilization_gpu_percent",
        "utilization_memory_percent",
        "memory_used_mib",
        "memory_total_mib",
        "power_draw_w",
        "temperature_gpu_c",
    )
    metrics = Dict{String, Vector{Float64}}(
        metric_name => Float64[] for metric_name in metric_names
    )
    per_gpu = Dict{String, Dict{String, Vector{Float64}}}()
    index_column = findfirst(header -> header == "index", headers)
    column_map = Dict{String, String}()
    for (index, header) in pairs(headers)
        if occursin("utilization.gpu", header)
            column_map[string(index)] = "utilization_gpu_percent"
        elseif occursin("utilization.memory", header)
            column_map[string(index)] = "utilization_memory_percent"
        elseif occursin("memory.used", header)
            column_map[string(index)] = "memory_used_mib"
        elseif occursin("memory.total", header)
            column_map[string(index)] = "memory_total_mib"
        elseif occursin("power.draw", header)
            column_map[string(index)] = "power_draw_w"
        elseif occursin("temperature.gpu", header)
            column_map[string(index)] = "temperature_gpu_c"
        end
    end

    samples = 0
    for line in Iterators.drop(lines, 1)
        isempty(strip(line)) && continue
        samples += 1
        columns = split(line, ",")
        gpu_index = index_column === nothing || index_column > length(columns) ?
            "unknown" :
            strip(columns[index_column])
        gpu_metrics = get!(per_gpu, gpu_index) do
            Dict{String, Vector{Float64}}(metric_name => Float64[] for metric_name in metric_names)
        end
        for (index_text, metric_name) in column_map
            index = parse(Int, index_text)
            index <= length(columns) || continue
            value = parse_metric_number(columns[index])
            value === nothing && continue
            push!(metrics[metric_name], value)
            push!(gpu_metrics[metric_name], value)
        end
    end

    summary = Dict{String, Any}("samples" => samples)
    for (metric_name, values) in metrics
        summary[metric_name] = summarize_values(values)
    end
    summary["per_gpu"] = Dict(
        gpu_index => Dict(
            metric_name => summarize_values(values) for (metric_name, values) in gpu_metrics
        ) for (gpu_index, gpu_metrics) in per_gpu
    )
    return summary
end
