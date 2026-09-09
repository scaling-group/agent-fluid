# 3D VTK output for offline rendering (ParaView / pyvista). Mirrors the 2D
# FreeSwimVtkStream but writes the full 3D grid with fields suited to 3D wake
# visualization: velocity, pressure, λ₂ vortex-core metric, and the body SDF
# (contour at 0 reconstructs the swimmer surface). Pure output path — never
# touches the solver state except the scratch field σ.

mutable struct FreeSwimVtkStream3D
    vtk_dir::String
    collection_name::String
    frame_entries::Vector{Tuple{Float64, String}}
    fields::Vector{String}
    manifest_path::String
    flush_collection::Bool
    compress::Bool
    count::Int
end

const VTK3D_DEFAULT_FIELDS = ("velocity", "pressure", "lambda2", "body")

function normalize_vtk_fields_3d(fields)
    aliases = Dict(
        "u" => "velocity",
        "velocity" => "velocity",
        "p" => "pressure",
        "pressure" => "pressure",
        "lambda2" => "lambda2",
        "l2" => "lambda2",
        "vorticity" => "vorticity_z",
        "vorticity_z" => "vorticity_z",
        "omega_z" => "vorticity_z",
        "sdf" => "body",
        "body" => "body",
        "all" => "all",
    )
    normalized = String[]
    for field in fields
        key = lowercase(strip(String(field)))
        isempty(key) && continue
        haskey(aliases, key) || error(
            "Unsupported 3D VTK field `$field`. Use velocity, pressure, lambda2, vorticity_z, body, or all.",
        )
        value = aliases[key]
        value == "all" ? append!(normalized, VTK3D_DEFAULT_FIELDS) : push!(normalized, value)
    end
    isempty(normalized) && append!(normalized, VTK3D_DEFAULT_FIELDS)
    return unique(normalized)
end

function start_free_swim_vtk_stream_3d(
    output_root::AbstractString;
    collection_name::AbstractString="flow3d",
    fields=VTK3D_DEFAULT_FIELDS,
    flush_collection::Bool=true,
    compress::Bool=true,
)
    vtk_dir = abspath(joinpath(output_root, "vtk"))
    mkpath(vtk_dir)
    manifest_path = joinpath(vtk_dir, "frames.csv")
    open(manifest_path, "w") do io
        println(io, "frame_index,sim_time,cycles,frame_path,center_x,center_y,z_plane,heading")
    end
    return FreeSwimVtkStream3D(
        vtk_dir,
        String(collection_name),
        Tuple{Float64, String}[],
        normalize_vtk_fields_3d(fields),
        manifest_path,
        flush_collection,
        compress,
        0,
    )
end

vtk_collection_path_3d(stream::FreeSwimVtkStream3D) =
    joinpath(stream.vtk_dir, string(stream.collection_name, ".pvd"))

function vtk_lambda2_field_3d!(sim)
    scale = (sim.L / sim.U)^2
    WaterLily.@inside sim.flow.σ[I] = WaterLily.λ₂(I, sim.flow.u) * scale
    return Array(sim.flow.σ)
end

function vtk_vorticity_z_field_3d!(sim)
    WaterLily.@inside sim.flow.σ[I] = WaterLily.curl(3, I, sim.flow.u) * sim.L / sim.U
    return Array(sim.flow.σ)
end

function vtk_body_sdf_field_3d!(sim)
    WaterLily.measure_sdf!(sim.flow.σ, sim.body, WaterLily.time(sim.flow); fastd²=0f0)
    return Array(sim.flow.σ)
end

function write_free_swim_vtk_frame_3d!(
    stream::FreeSwimVtkStream3D,
    sim,
    state,
    z_plane;
    period::Real,
)
    stream.count += 1
    frame_index = stream.count
    frame_stem = @sprintf("%s_%06d", stream.collection_name, frame_index)
    vtk = vtk_grid(
        joinpath(stream.vtk_dir, frame_stem),
        Base2D.waterlily_vtk_axis(size(sim.flow.p, 1)),
        Base2D.waterlily_vtk_axis(size(sim.flow.p, 2)),
        Base2D.waterlily_vtk_axis(size(sim.flow.p, 3));
        compress=stream.compress,
    )
    for field in stream.fields
        if field == "velocity"
            vtk["Velocity"] = Base2D.components_first(Array(sim.flow.u))
        elseif field == "pressure"
            vtk["Pressure"] = Array(sim.flow.p)
        elseif field == "lambda2"
            vtk["Lambda2"] = vtk_lambda2_field_3d!(sim)
        elseif field == "vorticity_z"
            vtk["VorticityZ"] = vtk_vorticity_z_field_3d!(sim)
        elseif field == "body"
            vtk["BodySDF"] = vtk_body_sdf_field_3d!(sim)
        end
    end
    vtk_save(vtk)
    frame_path = abspath(String(vtk.path))
    sim_time_value = Float64(sim_time(sim))
    push!(stream.frame_entries, (sim_time_value, frame_path))
    stream.flush_collection && Base2D.write_pvd_file_atomic(
        vtk_collection_path_3d(stream),
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
                    sim_time_value / Float64(period),
                    frame_path,
                    Float64(state.center[1]),
                    Float64(state.center[2]),
                    Float64(z_plane),
                    Float64(state.theta),
                ),
                ",",
            ),
        )
    end
    return frame_path
end

function close_free_swim_vtk_stream_3d!(stream::FreeSwimVtkStream3D)
    Base2D.write_pvd_file_atomic(
        vtk_collection_path_3d(stream),
        stream.frame_entries;
        compress=stream.compress,
    )
    return vtk_collection_path_3d(stream)
end
