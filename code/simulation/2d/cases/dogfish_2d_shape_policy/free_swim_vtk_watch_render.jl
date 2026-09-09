case_dir = @__DIR__

include(joinpath(case_dir, "src", "DogfishShapePolicyTestbed.jl"))
using .DogfishShapePolicyTestbed

using JSON
using Printf

mutable struct RenderOptions
    latest_path::String
    manifest_path::String
    output_root::String
    mode::String
    poll_interval_s::Float64
    max_frames::Int
    clim::Float32
    fps::Int
    encode_mp4::Bool
    image_format::String
    scale::Int
    overlay_metrics::Bool
    trajectory_path::String
    summary_path::String
    length_scale::Float64
end

struct ManifestFrame
    frame_index::Int
    sim_time::Float64
    cycles::Float64
    frame_path::String
    center::Tuple{Float64, Float64}
    heading::Float64
end

struct VtiFields
    nx::Int
    ny::Int
    origin::Tuple{Float64, Float64}
    spacing::Tuple{Float64, Float64}
    vorticity::Vector{Float32}
    body_sdf::Vector{Float32}
end

struct TrajectorySample
    time::Float64
    center::Tuple{Float64, Float64}
    distance::Float64
    velocity::Tuple{Float64, Float64}
    force::Tuple{Float64, Float64}
    moment_z::Float64
    heading::Float64
end

struct TargetOverlay
    center::Tuple{Float64, Float64}
    radius::Float64
end

function usage()
    println(
        """
        Usage:
          julia --project=. cases/dogfish_2d_shape_policy/free_swim_vtk_watch_render.jl \\
            --latest logs/free_swim_l64_domain24x12_10cycle_gpu_vtk/vtk/latest_frame.json \\
            --watch --encode-mp4

        Modes:
          --watch             Watch frames.csv/latest_frame.json and render new frames.
          --render-existing   Render all frames currently listed in frames.csv.
          --once              Render only the latest frame.

        Options:
          --output-root DIR   Defaults to <run>/watch_render_frames.
          --manifest PATH     Defaults to frames.csv next to latest_frame.json.
          --poll-interval S   Defaults to 0.25.
          --max-frames N      Stop after N rendered frames; 0 means no explicit limit.
          --clim X            Symmetric vorticity color limit; defaults to 10.
                              Vorticity is rendered blue-white-red with zero as pure white.
          --scale N           Integer nearest-neighbor output scale; defaults to 1.
          --overlay-metrics   Draw per-frame time, pose, force, and target distance.
          --trajectory PATH   Defaults to <run>/trajectory.csv when present.
          --summary PATH      Defaults to <run>/summary.json when present.
          --length-scale L    Length scale for overlay normalization; defaults to summary L.
          --format bmp|ppm    Defaults to bmp.
          --encode-mp4        Encode rendered frames to watch_render.mp4 at the end.
          --fps N             MP4 fps; defaults to 12.
        """
    )
end

function parse_args(args)
    options = RenderOptions("", "", "", "watch", 0.25, 0, 10.0f0, 12, false, "bmp", 1, false, "", "", 0.0)
    index = 1
    while index <= length(args)
        arg = args[index]
        if arg == "--help" || arg == "-h"
            usage()
            exit(0)
        elseif arg == "--latest"
            index += 1
            options.latest_path = args[index]
        elseif arg == "--manifest"
            index += 1
            options.manifest_path = args[index]
        elseif arg == "--output-root"
            index += 1
            options.output_root = args[index]
        elseif arg == "--watch"
            options.mode = "watch"
        elseif arg == "--render-existing"
            options.mode = "render_existing"
        elseif arg == "--once"
            options.mode = "once"
        elseif arg == "--poll-interval"
            index += 1
            options.poll_interval_s = parse(Float64, args[index])
        elseif arg == "--max-frames"
            index += 1
            options.max_frames = parse(Int, args[index])
        elseif arg == "--clim"
            index += 1
            options.clim = parse(Float32, args[index])
        elseif arg == "--scale"
            index += 1
            options.scale = parse(Int, args[index])
        elseif arg == "--overlay-metrics"
            options.overlay_metrics = true
        elseif arg == "--trajectory"
            index += 1
            options.trajectory_path = args[index]
        elseif arg == "--summary"
            index += 1
            options.summary_path = args[index]
        elseif arg == "--length-scale"
            index += 1
            options.length_scale = parse(Float64, args[index])
        elseif arg == "--fps"
            index += 1
            options.fps = parse(Int, args[index])
        elseif arg == "--encode-mp4"
            options.encode_mp4 = true
        elseif arg == "--format"
            index += 1
            options.image_format = lowercase(strip(args[index]))
        else
            error("Unknown argument: $arg")
        end
        index += 1
    end

    isempty(options.latest_path) && error("--latest is required")
    options.latest_path = abspath(options.latest_path)
    run_root = dirname(dirname(options.latest_path))
    isempty(options.manifest_path) && (options.manifest_path = joinpath(dirname(options.latest_path), "frames.csv"))
    options.manifest_path = abspath(options.manifest_path)
    if isempty(options.output_root)
        options.output_root = joinpath(run_root, "watch_render_frames")
    end
    options.output_root = abspath(options.output_root)
    isempty(options.trajectory_path) && (options.trajectory_path = joinpath(run_root, "trajectory.csv"))
    isempty(options.summary_path) && (options.summary_path = joinpath(run_root, "summary.json"))
    options.trajectory_path = abspath(options.trajectory_path)
    options.summary_path = abspath(options.summary_path)
    options.scale = max(1, options.scale)
    options.image_format in ("bmp", "ppm") || error("--format must be bmp or ppm")
    return options
end

function read_le_u64(bytes::Vector{UInt8}, position::Int)
    value = UInt64(0)
    for offset in 0:7
        value |= UInt64(bytes[position + offset]) << (8 * offset)
    end
    return value
end

function read_le_u32(value::Integer)
    return UInt8[
        value & 0xff,
        (value >> 8) & 0xff,
        (value >> 16) & 0xff,
        (value >> 24) & 0xff,
    ]
end

function read_le_u16(value::Integer)
    return UInt8[value & 0xff, (value >> 8) & 0xff]
end

function parse_extent(header::AbstractString)
    matched = match(r"WholeExtent=\"(-?\d+) (-?\d+) (-?\d+) (-?\d+) (-?\d+) (-?\d+)\"", header)
    matched === nothing && error("VTI WholeExtent not found")
    values = parse.(Int, matched.captures)
    nx = values[2] - values[1] + 1
    ny = values[4] - values[3] + 1
    return nx, ny
end

function parse_origin_spacing(header::AbstractString)
    origin_match = match(r"Origin=\"([^\"]+)\"", header)
    spacing_match = match(r"Spacing=\"([^\"]+)\"", header)
    origin_values = origin_match === nothing ? [0.0, 0.0, 0.0] : parse.(Float64, split(origin_match.captures[1]))
    spacing_values = spacing_match === nothing ? [1.0, 1.0, 1.0] : parse.(Float64, split(spacing_match.captures[1]))
    return (origin_values[1], origin_values[2]), (spacing_values[1], spacing_values[2])
end

function parse_data_offsets(header::AbstractString)
    offsets = Dict{String, Int}()
    pattern = r"<DataArray[^>]*Name=\"([^\"]+)\"[^>]*offset=\"(\d+)\""
    for matched in eachmatch(pattern, header)
        offsets[matched.captures[1]] = parse(Int, matched.captures[2])
    end
    return offsets
end

function read_float32_block(bytes::Vector{UInt8}, data_start::Int, offset::Int)
    block_start = data_start + offset
    byte_count = Int(read_le_u64(bytes, block_start))
    payload_start = block_start + 8
    payload_end = payload_start + byte_count - 1
    values = Vector{Float32}(undef, byte_count ÷ sizeof(Float32))
    read!(IOBuffer(@view bytes[payload_start:payload_end]), values)
    return values
end

function read_vti_fields(path::AbstractString)
    bytes = read(path)
    appended_tag = findfirst(Vector{UInt8}("<AppendedData"), bytes)
    appended_tag === nothing && error("VTI AppendedData section not found: $path")
    marker = findnext(==(UInt8('_')), bytes, last(appended_tag) + 1)
    marker === nothing && error("VTI appended-data marker not found: $path")
    header = String(bytes[1:marker - 1])
    occursin("compressor=", header) && error("Compressed VTI is not supported by the lightweight watcher: $path")
    nx, ny = parse_extent(header)
    origin, spacing = parse_origin_spacing(header)
    offsets = parse_data_offsets(header)
    haskey(offsets, "Vorticity") || error("VTI missing Vorticity field: $path")
    haskey(offsets, "BodySDF") || error("VTI missing BodySDF field: $path")
    data_start = marker + 1
    vorticity = read_float32_block(bytes, data_start, offsets["Vorticity"])
    body_sdf = read_float32_block(bytes, data_start, offsets["BodySDF"])
    expected = nx * ny
    length(vorticity) == expected || error("Vorticity length $(length(vorticity)) != $expected")
    length(body_sdf) == expected || error("BodySDF length $(length(body_sdf)) != $expected")
    return VtiFields(nx, ny, origin, spacing, vorticity, body_sdf)
end

function parse_manifest(path::AbstractString)
    isfile(path) || return ManifestFrame[]
    lines = readlines(path)
    length(lines) <= 1 && return ManifestFrame[]
    frames = ManifestFrame[]
    for line in Iterators.drop(lines, 1)
        isempty(strip(line)) && continue
        columns = split(line, ",")
        length(columns) >= 7 || continue
        push!(
            frames,
            ManifestFrame(
                parse(Int, columns[1]),
                parse(Float64, columns[2]),
                parse(Float64, columns[3]),
                String(columns[4]),
                (parse(Float64, columns[5]), parse(Float64, columns[6])),
                parse(Float64, columns[7]),
            ),
        )
    end
    return frames
end

function latest_frame_as_manifest(path::AbstractString)
    meta = JSON.parsefile(path)
    center = meta["center"]
    return ManifestFrame(
        Int(meta["frame_index"]),
        Float64(meta["sim_time"]),
        Float64(meta["cycles"]),
        String(meta["frame_path"]),
        (Float64(center[1]), Float64(center[2])),
        Float64(meta["heading"]),
    )
end

function parse_float_cell(value::AbstractString)
    stripped = strip(value)
    isempty(stripped) && return NaN
    return parse(Float64, stripped)
end

function parse_trajectory_samples(path::AbstractString)
    isfile(path) || return TrajectorySample[]
    lines = readlines(path)
    length(lines) <= 1 && return TrajectorySample[]
    header = split(lines[1], ",")
    column = Dict(strip(name) => index for (index, name) in pairs(header))
    required = (
        "time",
        "center_x",
        "center_y",
        "distance",
        "velocity_x",
        "velocity_y",
        "force_x",
        "force_y",
        "moment_z",
        "heading",
    )
    all(name -> haskey(column, name), required) || return TrajectorySample[]

    samples = TrajectorySample[]
    for line in Iterators.drop(lines, 1)
        isempty(strip(line)) && continue
        values = split(line, ",")
        length(values) >= length(header) || continue
        getvalue(name) = parse_float_cell(values[column[name]])
        push!(
            samples,
            TrajectorySample(
                getvalue("time"),
                (getvalue("center_x"), getvalue("center_y")),
                getvalue("distance"),
                (getvalue("velocity_x"), getvalue("velocity_y")),
                (getvalue("force_x"), getvalue("force_y")),
                getvalue("moment_z"),
                getvalue("heading"),
            ),
        )
    end
    return samples
end

function load_length_scale(options::RenderOptions)
    options.length_scale > 0 && return options.length_scale
    isfile(options.summary_path) || return 1.0
    try
        summary = JSON.parsefile(options.summary_path)
        return Float64(get(summary, "L", 1.0))
    catch error
        @warn "Could not read render summary length scale" path = options.summary_path exception = (error, catch_backtrace())
    end
    return 1.0
end

function load_target_overlay(options::RenderOptions)
    isfile(options.summary_path) || return nothing
    try
        summary = JSON.parsefile(options.summary_path)
        target = get(summary, "target", nothing)
        if !(
            target isa AbstractVector &&
            length(target) >= 2 &&
            target[1] isa Real &&
            target[2] isa Real
        )
            return nothing
        end
        center = (Float64(target[1]), Float64(target[2]))
        radius_value = get(summary, "success_radius", 0.0)
        radius = radius_value isa Real ? max(0.0, Float64(radius_value)) : 0.0
        all(isfinite, center) || return nothing
        isfinite(radius) || return nothing
        return TargetOverlay(center, radius)
    catch error
        @warn "Could not read target marker metadata" path = options.summary_path exception = (error, catch_backtrace())
    end
    return nothing
end

function target_overlay_payload(target_overlay)
    target_overlay === nothing && return nothing
    return Dict("center" => collect(target_overlay.center), "success_radius" => target_overlay.radius)
end

function nearest_sample(samples::Vector{TrajectorySample}, frame::ManifestFrame, length_scale::Float64)
    isempty(samples) && return nothing
    best = samples[1]
    best_score = Inf
    center_norm = max(length_scale, 1.0)
    for sample in samples
        time_score = abs(sample.time - frame.sim_time)
        center_score = hypot(sample.center[1] - frame.center[1], sample.center[2] - frame.center[2]) / center_norm
        score = time_score + 1.0e-3 * center_score
        if score < best_score
            best = sample
            best_score = score
        end
    end
    return best
end

function lerp_color(a, b, t)
    return ntuple(i -> UInt8(round(Int, (1 - t) * a[i] + t * b[i])), 3)
end

function vorticity_color(value::Float32, clim::Float32)
    limit = max(abs(clim), eps(Float32))
    t = clamp(value / limit, -1f0, 1f0)
    white = (255, 255, 255)
    blue = (33, 102, 172)
    red = (178, 24, 43)
    if t < 0f0
        return lerp_color(white, blue, Float64(-t))
    end
    return lerp_color(white, red, Float64(t))
end

function pixel_offset(width::Int, x::Int, y::Int)
    return ((y - 1) * width + (x - 1)) * 3 + 1
end

function set_pixel!(rgb::Vector{UInt8}, width::Int, height::Int, x::Int, y::Int, color)
    1 <= x <= width || return nothing
    1 <= y <= height || return nothing
    offset = pixel_offset(width, x, y)
    rgb[offset] = color[1]
    rgb[offset + 1] = color[2]
    rgb[offset + 2] = color[3]
    return nothing
end

function draw_disk!(rgb, width, height, x0, y0, radius, color)
    r2 = radius * radius
    for y in (y0 - radius):(y0 + radius), x in (x0 - radius):(x0 + radius)
        (x - x0)^2 + (y - y0)^2 <= r2 && set_pixel!(rgb, width, height, x, y, color)
    end
    return nothing
end

function draw_ring!(rgb, width, height, x0, y0, radius, thickness, color)
    outer_radius = max(1, radius)
    inner_radius = max(0, outer_radius - max(1, thickness))
    outer2 = outer_radius * outer_radius
    inner2 = inner_radius * inner_radius
    for y in (y0 - outer_radius):(y0 + outer_radius), x in (x0 - outer_radius):(x0 + outer_radius)
        distance2 = (x - x0)^2 + (y - y0)^2
        inner2 <= distance2 <= outer2 && set_pixel!(rgb, width, height, x, y, color)
    end
    return nothing
end

function draw_line!(rgb, width, height, x0, y0, x1, y1, color)
    dx = abs(x1 - x0)
    sx = x0 < x1 ? 1 : -1
    dy = -abs(y1 - y0)
    sy = y0 < y1 ? 1 : -1
    err = dx + dy
    x, y = x0, y0
    while true
        set_pixel!(rgb, width, height, x, y, color)
        x == x1 && y == y1 && break
        e2 = 2 * err
        if e2 >= dy
            err += dy
            x += sx
        end
        if e2 <= dx
            err += dx
            y += sy
        end
    end
    return nothing
end

function blend_rect!(rgb, width, height, x0, y0, x1, y1, color, alpha::Float64)
    min_x = clamp(min(x0, x1), 1, width)
    max_x = clamp(max(x0, x1), 1, width)
    min_y = clamp(min(y0, y1), 1, height)
    max_y = clamp(max(y0, y1), 1, height)
    @inbounds for y in min_y:max_y, x in min_x:max_x
        offset = pixel_offset(width, x, y)
        rgb[offset] = UInt8(round(Int, (1 - alpha) * rgb[offset] + alpha * color[1]))
        rgb[offset + 1] = UInt8(round(Int, (1 - alpha) * rgb[offset + 1] + alpha * color[2]))
        rgb[offset + 2] = UInt8(round(Int, (1 - alpha) * rgb[offset + 2] + alpha * color[3]))
    end
    return nothing
end

function glyph_rows(ch::Char)
    ch == '0' && return ("01110", "10001", "10011", "10101", "11001", "10001", "01110")
    ch == '1' && return ("00100", "01100", "00100", "00100", "00100", "00100", "01110")
    ch == '2' && return ("01110", "10001", "00001", "00010", "00100", "01000", "11111")
    ch == '3' && return ("11110", "00001", "00001", "01110", "00001", "00001", "11110")
    ch == '4' && return ("00010", "00110", "01010", "10010", "11111", "00010", "00010")
    ch == '5' && return ("11111", "10000", "10000", "11110", "00001", "00001", "11110")
    ch == '6' && return ("01110", "10000", "10000", "11110", "10001", "10001", "01110")
    ch == '7' && return ("11111", "00001", "00010", "00100", "01000", "01000", "01000")
    ch == '8' && return ("01110", "10001", "10001", "01110", "10001", "10001", "01110")
    ch == '9' && return ("01110", "10001", "10001", "01111", "00001", "00001", "01110")
    ch == 'A' && return ("01110", "10001", "10001", "11111", "10001", "10001", "10001")
    ch == 'B' && return ("11110", "10001", "10001", "11110", "10001", "10001", "11110")
    ch == 'C' && return ("01110", "10001", "10000", "10000", "10000", "10001", "01110")
    ch == 'D' && return ("11110", "10001", "10001", "10001", "10001", "10001", "11110")
    ch == 'E' && return ("11111", "10000", "10000", "11110", "10000", "10000", "11111")
    ch == 'F' && return ("11111", "10000", "10000", "11110", "10000", "10000", "10000")
    ch == 'G' && return ("01110", "10001", "10000", "10111", "10001", "10001", "01110")
    ch == 'H' && return ("10001", "10001", "10001", "11111", "10001", "10001", "10001")
    ch == 'I' && return ("01110", "00100", "00100", "00100", "00100", "00100", "01110")
    ch == 'J' && return ("00111", "00010", "00010", "00010", "10010", "10010", "01100")
    ch == 'K' && return ("10001", "10010", "10100", "11000", "10100", "10010", "10001")
    ch == 'L' && return ("10000", "10000", "10000", "10000", "10000", "10000", "11111")
    ch == 'M' && return ("10001", "11011", "10101", "10101", "10001", "10001", "10001")
    ch == 'N' && return ("10001", "11001", "10101", "10011", "10001", "10001", "10001")
    ch == 'O' && return ("01110", "10001", "10001", "10001", "10001", "10001", "01110")
    ch == 'P' && return ("11110", "10001", "10001", "11110", "10000", "10000", "10000")
    ch == 'Q' && return ("01110", "10001", "10001", "10001", "10101", "10010", "01101")
    ch == 'R' && return ("11110", "10001", "10001", "11110", "10100", "10010", "10001")
    ch == 'S' && return ("01111", "10000", "10000", "01110", "00001", "00001", "11110")
    ch == 'T' && return ("11111", "00100", "00100", "00100", "00100", "00100", "00100")
    ch == 'U' && return ("10001", "10001", "10001", "10001", "10001", "10001", "01110")
    ch == 'V' && return ("10001", "10001", "10001", "10001", "10001", "01010", "00100")
    ch == 'W' && return ("10001", "10001", "10001", "10101", "10101", "10101", "01010")
    ch == 'X' && return ("10001", "10001", "01010", "00100", "01010", "10001", "10001")
    ch == 'Y' && return ("10001", "10001", "01010", "00100", "00100", "00100", "00100")
    ch == 'Z' && return ("11111", "00001", "00010", "00100", "01000", "10000", "11111")
    ch == '-' && return ("00000", "00000", "00000", "11111", "00000", "00000", "00000")
    ch == '+' && return ("00000", "00100", "00100", "11111", "00100", "00100", "00000")
    ch == '=' && return ("00000", "11111", "00000", "00000", "11111", "00000", "00000")
    ch == '.' && return ("00000", "00000", "00000", "00000", "00000", "01100", "01100")
    ch == ',' && return ("00000", "00000", "00000", "00000", "00000", "01100", "01000")
    ch == '(' && return ("00010", "00100", "01000", "01000", "01000", "00100", "00010")
    ch == ')' && return ("01000", "00100", "00010", "00010", "00010", "00100", "01000")
    ch == '|' && return ("00100", "00100", "00100", "00100", "00100", "00100", "00100")
    ch == ':' && return ("00000", "01100", "01100", "00000", "01100", "01100", "00000")
    ch == '/' && return ("00001", "00010", "00010", "00100", "01000", "01000", "10000")
    ch == ' ' && return ("00000", "00000", "00000", "00000", "00000", "00000", "00000")
    return ("11111", "00001", "00010", "00100", "00100", "00000", "00100")
end

function draw_char!(rgb, width, height, x0, y0, ch::Char, scale::Int, color)
    rows = glyph_rows(ch)
    for (row_index, row) in pairs(rows), col_index in 1:lastindex(row)
        row[col_index] == '1' || continue
        px = x0 + (col_index - 1) * scale
        py = y0 + (row_index - 1) * scale
        for y in py:(py + scale - 1), x in px:(px + scale - 1)
            set_pixel!(rgb, width, height, x, y, color)
        end
    end
    return nothing
end

function draw_text!(rgb, width, height, x0, y0, text::AbstractString, scale::Int, color)
    cursor = x0
    for ch in uppercase(text)
        draw_char!(rgb, width, height, cursor, y0, ch, scale, color)
        cursor += 6 * scale
    end
    return nothing
end

function metric_text_lines(frame::ManifestFrame, sample, length_scale::Float64)
    L = max(length_scale, eps(Float64))
    center = frame.center
    heading = frame.heading
    force = sample === nothing ? (NaN, NaN) : sample.force
    distance = sample === nothing ? NaN : sample.distance
    return [
        @sprintf("T=%.3f | C=(%.3f,%.3f)L | TH=%.3f RAD", frame.sim_time, center[1] / L, center[2] / L, heading),
        @sprintf("F=(%.3E,%.3E) | D=%.3fL", force[1], force[2], distance / L),
    ]
end

function draw_metrics_overlay!(rgb, width, height, lines; text_scale::Int=2)
    isempty(lines) && return nothing
    pad = 5 * text_scale
    line_height = 9 * text_scale
    text_width = maximum(length(line) for line in lines) * 6 * text_scale
    box_width = min(width, text_width + 2 * pad)
    box_height = min(height, length(lines) * line_height + 2 * pad)
    x0 = width - box_width + 1
    y0 = height - box_height + 1
    x1 = width
    y1 = height
    blend_rect!(rgb, width, height, x0, y0, x1, y1, (245, 249, 247), 0.86)
    draw_line!(rgb, width, height, x0, y0, x1, y0, (60, 72, 72))
    draw_line!(rgb, width, height, x0, y0, x0, y1, (60, 72, 72))
    y = y0 + pad
    for line in lines
        draw_text!(rgb, width, height, x0 + pad, y, line, text_scale, (5, 8, 8))
        y += line_height
    end
    return nothing
end

function scale_rgb_nearest(rgb::Vector{UInt8}, width::Int, height::Int, scale::Int)
    scale <= 1 && return rgb, width, height
    out_width = width * scale
    out_height = height * scale
    out = Vector{UInt8}(undef, out_width * out_height * 3)
    @inbounds for y in 1:height, x in 1:width
        source = pixel_offset(width, x, y)
        for yy in ((y - 1) * scale + 1):(y * scale), xx in ((x - 1) * scale + 1):(x * scale)
            target = pixel_offset(out_width, xx, yy)
            out[target] = rgb[source]
            out[target + 1] = rgb[source + 1]
            out[target + 2] = rgb[source + 2]
        end
    end
    return out, out_width, out_height
end

function grid_to_pixel(fields::VtiFields, center)
    x = round(Int, (center[1] - fields.origin[1]) / fields.spacing[1]) + 1
    source_y = round(Int, (center[2] - fields.origin[2]) / fields.spacing[2]) + 1
    y = fields.ny - source_y + 1
    return x, y
end

function draw_target_marker!(rgb, width, height, fields::VtiFields, target_overlay)
    target_overlay === nothing && return nothing
    x, y = grid_to_pixel(fields, target_overlay.center)
    pixel_size = max(eps(Float64), min(abs(fields.spacing[1]), abs(fields.spacing[2])))
    radius = max(7, round(Int, target_overlay.radius / pixel_size))
    half_cross = max(8, min(14, radius ÷ 3))
    white = (255, 255, 255)
    green = (0, 150, 55)
    draw_ring!(rgb, width, height, x, y, radius + 2, 6, white)
    draw_ring!(rgb, width, height, x, y, radius, 3, green)
    for offset in -2:2
        draw_line!(rgb, width, height, x - half_cross, y + offset, x + half_cross, y + offset, white)
        draw_line!(rgb, width, height, x + offset, y - half_cross, x + offset, y + half_cross, white)
    end
    for offset in -1:1
        draw_line!(rgb, width, height, x - half_cross, y + offset, x + half_cross, y + offset, green)
        draw_line!(rgb, width, height, x + offset, y - half_cross, x + offset, y + half_cross, green)
    end
    draw_disk!(rgb, width, height, x, y, 4, white)
    draw_disk!(rgb, width, height, x, y, 2, green)
    return nothing
end

function render_rgb(fields::VtiFields, frame::ManifestFrame, trajectory, clim::Float32, target_overlay)
    width, height = fields.nx, fields.ny
    rgb = Vector{UInt8}(undef, width * height * 3)
    @inbounds for image_y in 1:height
        source_y = height - image_y + 1
        row_base = (source_y - 1) * width
        for x in 1:width
            color = vorticity_color(fields.vorticity[row_base + x], clim)
            offset = pixel_offset(width, x, image_y)
            rgb[offset] = color[1]
            rgb[offset + 1] = color[2]
            rgb[offset + 2] = color[3]
        end
    end

    black = (5, 8, 8)
    center_x, center_image_y = grid_to_pixel(fields, frame.center)
    center_source_y = height - center_image_y + 1
    body_radius_x = max(32, round(Int, 0.08 * width))
    body_radius_y = max(16, round(Int, 0.08 * height))
    min_x = max(1, center_x - body_radius_x)
    max_x = min(width, center_x + body_radius_x)
    min_y = max(1, center_source_y - body_radius_y)
    max_y = min(height, center_source_y + body_radius_y)
    @inbounds for sy in min_y:min(max_y, height - 1), sx in min_x:min(max_x, width - 1)
        idx = (sy - 1) * width + sx
        v = fields.body_sdf[idx]
        right = fields.body_sdf[idx + 1]
        up = fields.body_sdf[idx + width]
        if (v <= 0f0) != (right <= 0f0) || (v <= 0f0) != (up <= 0f0)
            image_y = height - sy + 1
            set_pixel!(rgb, width, height, sx, image_y, black)
        end
    end

    orange = (255, 166, 0)
    white = (255, 255, 255)
    if !isempty(trajectory)
        last_x, last_y = grid_to_pixel(fields, trajectory[1].center)
        for point in Iterators.drop(trajectory, 1)
            x, y = grid_to_pixel(fields, point.center)
            draw_line!(rgb, width, height, last_x, last_y, x, y, orange)
            last_x, last_y = x, y
        end
        initial_x, initial_y = grid_to_pixel(fields, trajectory[1].center)
        draw_disk!(rgb, width, height, initial_x, initial_y, 3, white)
        draw_disk!(rgb, width, height, initial_x, initial_y, 2, orange)
    end
    current_x, current_y = grid_to_pixel(fields, frame.center)
    draw_disk!(rgb, width, height, current_x, current_y, 3, black)
    draw_disk!(rgb, width, height, current_x, current_y, 2, orange)
    draw_target_marker!(rgb, width, height, fields, target_overlay)
    return rgb
end

function write_ppm(path::AbstractString, rgb::Vector{UInt8}, width::Int, height::Int)
    open(path, "w") do io
        write(io, "P6\n$width $height\n255\n")
        write(io, rgb)
    end
    return path
end

function write_bmp(path::AbstractString, rgb::Vector{UInt8}, width::Int, height::Int)
    row_bytes = 3 * width
    padding = mod(4 - mod(row_bytes, 4), 4)
    padded_row_bytes = row_bytes + padding
    image_bytes = padded_row_bytes * height
    file_bytes = 54 + image_bytes
    open(path, "w") do io
        write(io, UInt8['B', 'M'])
        write(io, read_le_u32(file_bytes))
        write(io, read_le_u16(0))
        write(io, read_le_u16(0))
        write(io, read_le_u32(54))
        write(io, read_le_u32(40))
        write(io, read_le_u32(width))
        write(io, read_le_u32(height))
        write(io, read_le_u16(1))
        write(io, read_le_u16(24))
        write(io, read_le_u32(0))
        write(io, read_le_u32(image_bytes))
        write(io, read_le_u32(2835))
        write(io, read_le_u32(2835))
        write(io, read_le_u32(0))
        write(io, read_le_u32(0))
        pad = UInt8[0, 0, 0]
        for y in height:-1:1
            row_offset = pixel_offset(width, 1, y)
            for x in 1:width
                offset = row_offset + (x - 1) * 3
                write(io, UInt8[rgb[offset + 2], rgb[offset + 1], rgb[offset]])
            end
            padding > 0 && write(io, @view pad[1:padding])
        end
    end
    return path
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

function render_frame(
    frame::ManifestFrame,
    trajectory,
    options::RenderOptions,
    metric_samples::Vector{TrajectorySample},
    length_scale::Float64,
    target_overlay,
)
    start_s = time()
    fields = read_vti_fields(frame.frame_path)
    rgb = render_rgb(fields, frame, trajectory, options.clim, target_overlay)
    rgb, width, height = scale_rgb_nearest(rgb, fields.nx, fields.ny, options.scale)
    if options.overlay_metrics
        sample = nearest_sample(metric_samples, frame, length_scale)
        draw_metrics_overlay!(
            rgb,
            width,
            height,
            metric_text_lines(frame, sample, length_scale);
            text_scale=max(2, options.scale),
        )
    end
    mkpath(options.output_root)
    extension = options.image_format == "ppm" ? "ppm" : "bmp"
    output_path = joinpath(options.output_root, @sprintf("frame_%06d.%s", frame.frame_index, extension))
    if options.image_format == "ppm"
        write_ppm(output_path, rgb, width, height)
    else
        write_bmp(output_path, rgb, width, height)
    end
    elapsed_s = time() - start_s
    atomic_write_json(
        joinpath(options.output_root, "latest_render.json"),
        Dict(
            "schema_version" => "dogfish.free_swim_watch_render_frame.v1",
            "frame_index" => frame.frame_index,
            "sim_time" => frame.sim_time,
            "cycles" => frame.cycles,
            "source_frame_path" => frame.frame_path,
            "render_path" => output_path,
            "render_wall_s" => elapsed_s,
            "image_size" => [width, height],
            "source_image_size" => [fields.nx, fields.ny],
            "scale" => options.scale,
            "overlay_metrics" => options.overlay_metrics,
            "target_marker" => target_overlay_payload(target_overlay),
        ),
    )
    return output_path, elapsed_s
end

function encode_mp4(options::RenderOptions)
    Sys.which("ffmpeg") === nothing && return nothing
    pattern = joinpath(options.output_root, @sprintf("frame_%%06d.%s", options.image_format))
    output_path = joinpath(options.output_root, "watch_render.mp4")
    cmd = Cmd([
        "ffmpeg",
        "-y",
        "-framerate",
        string(options.fps),
        "-i",
        pattern,
        "-vf",
        "pad=ceil(iw/2)*2:ceil(ih/2)*2",
        "-c:v",
        "libx264",
        "-pix_fmt",
        "yuv420p",
        output_path,
    ])
    run(pipeline(cmd; stdout=devnull, stderr=devnull))
    return output_path
end

function render_frames(
    frames,
    options::RenderOptions;
    rendered=Set{Int}(),
    metric_samples=TrajectorySample[],
    length_scale=1.0,
    target_overlay=nothing,
)
    rendered_paths = String[]
    timings = Float64[]
    for (position, frame) in pairs(frames)
        frame.frame_index in rendered && continue
        isfile(frame.frame_path) || continue
        trajectory = frames[1:position]
        output_path, elapsed_s = render_frame(frame, trajectory, options, metric_samples, length_scale, target_overlay)
        push!(rendered, frame.frame_index)
        push!(rendered_paths, output_path)
        push!(timings, elapsed_s)
        println(@sprintf("rendered frame=%d cycles=%.3f wall_s=%.4f path=%s", frame.frame_index, frame.cycles, elapsed_s, output_path))
        options.max_frames > 0 && length(rendered) >= options.max_frames && break
    end
    return rendered_paths, timings
end

function write_summary(options::RenderOptions, rendered_paths, timings, wall_s, mp4_path, length_scale::Float64, target_overlay)
    summary = Dict(
        "schema_version" => "dogfish.free_swim_watch_render.v1",
        "mode" => options.mode,
        "latest_path" => options.latest_path,
        "manifest_path" => options.manifest_path,
        "output_root" => options.output_root,
        "frames" => length(rendered_paths),
        "wall_s" => wall_s,
        "render_timing_s" => timings,
        "render_avg_s" => isempty(timings) ? nothing : sum(timings) / length(timings),
        "render_max_s" => isempty(timings) ? nothing : maximum(timings),
        "render_min_s" => isempty(timings) ? nothing : minimum(timings),
        "mp4" => mp4_path,
        "image_format" => options.image_format,
        "colormap" => "blue_white_red_zero_white",
        "clim" => Float64(options.clim),
        "scale" => options.scale,
        "overlay_metrics" => options.overlay_metrics,
        "trajectory_path" => options.trajectory_path,
        "summary_path" => options.summary_path,
        "length_scale" => length_scale,
        "target_marker" => target_overlay_payload(target_overlay),
    )
    summary_path = joinpath(options.output_root, "render_summary.json")
    atomic_write_json(summary_path, summary)
    return summary_path
end

function stream_complete(latest_path::AbstractString, rendered::Set{Int})
    status_path = joinpath(dirname(latest_path), "stream_status.json")
    isfile(status_path) || return false
    status = JSON.parsefile(status_path)
    get(status, "status", "") in ("complete", "failed") || return false
    expected = Int(get(status, "frames", 0))
    return expected == 0 || length(rendered) >= expected
end

function main()
    options = parse_args(ARGS)
    mkpath(options.output_root)
    rendered = Set{Int}()
    rendered_paths = String[]
    timings = Float64[]
    wall_start = time()
    metric_samples = options.overlay_metrics ? parse_trajectory_samples(options.trajectory_path) : TrajectorySample[]
    length_scale = load_length_scale(options)

    target_overlay = load_target_overlay(options)
    if options.mode == "once"
        frame = latest_frame_as_manifest(options.latest_path)
        paths, new_timings = render_frames([frame], options; rendered, metric_samples, length_scale, target_overlay)
        append!(rendered_paths, paths)
        append!(timings, new_timings)
    elseif options.mode == "render_existing"
        frames = parse_manifest(options.manifest_path)
        paths, new_timings = render_frames(frames, options; rendered, metric_samples, length_scale, target_overlay)
        append!(rendered_paths, paths)
        append!(timings, new_timings)
    elseif options.mode == "watch"
        while true
            frames = parse_manifest(options.manifest_path)
            if isempty(frames) && isfile(options.latest_path)
                frames = [latest_frame_as_manifest(options.latest_path)]
            end
            paths, new_timings = render_frames(frames, options; rendered, metric_samples, length_scale, target_overlay)
            append!(rendered_paths, paths)
            append!(timings, new_timings)
            if options.max_frames > 0 && length(rendered) >= options.max_frames
                break
            end
            stream_complete(options.latest_path, rendered) && break
            sleep(options.poll_interval_s)
        end
    else
        error("Unsupported mode $(options.mode)")
    end

    mp4_path = options.encode_mp4 ? encode_mp4(options) : nothing
    summary_path = write_summary(options, rendered_paths, timings, time() - wall_start, mp4_path, length_scale, target_overlay)
    println("frames=$(length(rendered_paths))")
    println("output_root=$(options.output_root)")
    println("summary=$summary_path")
    println("mp4=$mp4_path")
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
