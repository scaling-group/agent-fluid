function parse_string_list(value)
    value isa AbstractVector && return [strip(string(item)) for item in value if !isempty(strip(string(item)))]
    return [strip(item) for item in split(string(value), ",") if !isempty(strip(item))]
end

function configured_string_list(config::AbstractDict, key::String, env_name::String, default::Vector{String})
    if run_config_env_present(env_name)
        return parse_string_list(get(ENV, env_name, join(default, ",")))
    end
    haskey(config, key) || return default
    return parse_string_list(config[key])
end

function normalize_vtk_fields(fields)
    aliases = Dict(
        "u" => "velocity",
        "vel" => "velocity",
        "velocity" => "velocity",
        "p" => "pressure",
        "pressure" => "pressure",
        "omega" => "vorticity",
        "vorticity" => "vorticity",
        "sdf" => "body",
        "body" => "body",
        "body_sdf" => "body",
        "all" => "all",
        "default" => "all",
    )
    normalized = String[]
    for field in fields
        key = lowercase(strip(String(field)))
        isempty(key) && continue
        haskey(aliases, key) || error("Unsupported VTK field `$field`. Use velocity, pressure, vorticity, body, or all.")
        value = aliases[key]
        if value == "all"
            append!(normalized, ("velocity", "pressure", "vorticity", "body"))
        else
            push!(normalized, value)
        end
    end
    isempty(normalized) && append!(normalized, ("velocity", "pressure", "vorticity", "body"))
    return unique(normalized)
end

mutable struct FreeSwimVtkStream
    vtk_dir::String
    collection_name::String
    frame_entries::Vector{Tuple{Float64, String}}
    fields::Vector{String}
    latest_path::String
    manifest_path::String
    flush_collection::Bool
    compress::Bool
    count::Int
end

function start_free_swim_vtk_stream(
    output_root::AbstractString;
    collection_name::AbstractString="free_swim_flow",
    fields=("velocity", "pressure", "vorticity", "body"),
    flush_collection::Bool=true,
    compress::Bool=true,
)
    vtk_dir = abspath(joinpath(output_root, "vtk"))
    mkpath(vtk_dir)
    normalized_fields = normalize_vtk_fields(fields)
    manifest_path = joinpath(vtk_dir, "frames.csv")
    open(manifest_path, "w") do io
        println(io, "frame_index,sim_time,cycles,frame_path,center_x,center_y,heading")
    end
    return FreeSwimVtkStream(
        vtk_dir,
        String(collection_name),
        Tuple{Float64, String}[],
        normalized_fields,
        joinpath(vtk_dir, "latest_frame.json"),
        manifest_path,
        flush_collection,
        compress,
        0,
    )
end

function vtk_collection_path(stream::FreeSwimVtkStream)
    return joinpath(stream.vtk_dir, string(stream.collection_name, ".pvd"))
end

function components_first(a::AbstractArray{T, N}) where {T, N}
    return permutedims(a, (N, ntuple(identity, N - 1)...))
end

function waterlily_vtk_axis(n::Integer)
    return range(-0.5f0; step=1.0f0, length=n)
end

function vtk_vorticity_field!(sim)
    WaterLily.@inside sim.flow.σ[I] = WaterLily.curl(3, I, sim.flow.u) * sim.L / sim.U
    return Array(sim.flow.σ)
end

function vtk_body_sdf_field!(sim)
    WaterLily.measure_sdf!(sim.flow.σ, sim.body, WaterLily.time(sim.flow); fastd²=0f0)
    return Array(sim.flow.σ)
end

function atomic_write_json(path::AbstractString, payload)
    tmp_path = string(path, ".tmp")
    open(tmp_path, "w") do io
        JSON.print(io, payload, 2)
        println(io)
    end
    mv(tmp_path, path; force=true)
    return path
end

function xml_escape(value::AbstractString)
    return replace(
        value,
        "&" => "&amp;",
        "\"" => "&quot;",
        "'" => "&apos;",
        "<" => "&lt;",
        ">" => "&gt;",
    )
end

function write_pvd_file_atomic(path::AbstractString, entries; compress::Bool=true)
    tmp_path = string(path, ".tmp")
    open(tmp_path, "w") do io
        println(io, "<?xml version=\"1.0\"?>")
        if compress
            println(io, "<VTKFile type=\"Collection\" version=\"1.0\" byte_order=\"LittleEndian\" compressor=\"vtkZLibDataCompressor\">")
        else
            println(io, "<VTKFile type=\"Collection\" version=\"1.0\" byte_order=\"LittleEndian\">")
        end
        println(io, "  <Collection>")
        for (time_value, frame_path) in entries
            frame_file = xml_escape(relpath(frame_path, dirname(path)))
            println(
                io,
                "    <DataSet timestep=\"",
                @sprintf("%.9g", time_value),
                "\" part=\"0\" file=\"",
                frame_file,
                "\"/>",
            )
        end
        println(io, "  </Collection>")
        println(io, "</VTKFile>")
    end
    mv(tmp_path, path; force=true)
    return path
end

function write_free_swim_vtk_frame!(
    stream::FreeSwimVtkStream,
    sim,
    center,
    heading;
    period::Real,
)
    stream.count += 1
    frame_index = stream.count
    frame_stem = @sprintf("%s_%06d", stream.collection_name, frame_index)
    vtk_path_stem = joinpath(stream.vtk_dir, frame_stem)
    vtk = vtk_grid(
        vtk_path_stem,
        waterlily_vtk_axis(size(sim.flow.p, 1)),
        waterlily_vtk_axis(size(sim.flow.p, 2));
        compress=stream.compress,
    )
    for field in stream.fields
        if field == "velocity"
            vtk["Velocity"] = components_first(Array(sim.flow.u))
        elseif field == "pressure"
            vtk["Pressure"] = Array(sim.flow.p)
        elseif field == "vorticity"
            vtk["Vorticity"] = vtk_vorticity_field!(sim)
        elseif field == "body"
            vtk["BodySDF"] = vtk_body_sdf_field!(sim)
        end
    end
    vtk_save(vtk)
    frame_path = abspath(String(vtk.path))
    sim_time_value = Float64(sim_time(sim))
    cycles = sim_time_value / Float64(period)
    push!(stream.frame_entries, (sim_time_value, frame_path))
    stream.flush_collection && write_pvd_file_atomic(
        vtk_collection_path(stream),
        stream.frame_entries;
        compress=stream.compress,
    )

    open(stream.manifest_path, "a") do io
        println(
            io,
            join(
                (
                    frame_index,
                    sim_time_value,
                    cycles,
                    frame_path,
                    Float64(center[1]),
                    Float64(center[2]),
                    Float64(heading),
                ),
                ",",
            ),
        )
    end
    atomic_write_json(
        stream.latest_path,
        Dict(
            "schema_version" => "dogfish.free_swim_vtk_frame.v1",
            "status" => "ready",
            "frame_index" => frame_index,
            "sim_time" => sim_time_value,
            "cycles" => cycles,
            "frame_path" => frame_path,
            "pvd_path" => vtk_collection_path(stream),
            "fields" => stream.fields,
            "compress" => stream.compress,
            "center" => [Float64(center[1]), Float64(center[2])],
            "heading" => Float64(heading),
        ),
    )
    return frame_path
end

function close_free_swim_vtk_stream!(stream::FreeSwimVtkStream; status::AbstractString="complete")
    write_pvd_file_atomic(vtk_collection_path(stream), stream.frame_entries; compress=stream.compress)
    atomic_write_json(
        joinpath(stream.vtk_dir, "stream_status.json"),
        Dict(
            "schema_version" => "dogfish.free_swim_vtk_stream.v1",
            "status" => status,
            "frames" => stream.count,
            "pvd_path" => vtk_collection_path(stream),
            "latest_frame_path" => stream.latest_path,
            "manifest_path" => stream.manifest_path,
            "fields" => stream.fields,
            "compress" => stream.compress,
        ),
    )
    return vtk_collection_path(stream)
end
