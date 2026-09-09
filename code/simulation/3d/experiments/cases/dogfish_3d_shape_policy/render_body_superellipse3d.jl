# Render a mid-plane vorticity movie of the superellipse FSI body (the new base)
# free-swimming, with the modeler profile + caudal fin. Frames are collected into
# a Plots Animation and written to mp4 via FFMPEG_jll (no system ffmpeg needed).
#
# Env: DOGFISH3D_RENDER_L (64), _MODE (left), _CYCLES (4), _OUTPUT, _FPS (20)

ENV["GKSwstype"] = get(ENV, "GKSwstype", "100")

case_dir = @__DIR__
include(joinpath(case_dir, "src", "Dogfish3DShapePolicyTestbed.jl"))
using .Dogfish3DShapePolicyTestbed
const T3D = Dogfish3DShapePolicyTestbed
const Base2D = Dogfish3DShapePolicyTestbed.Base2D

using Plots
using Printf
using StaticArrays
using WaterLily

const DEG = pi / 180
env_string(n, d) = (v = strip(get(ENV, n, "")); isempty(v) ? d : v)
env_int(n, d) = (v = strip(get(ENV, n, "")); isempty(v) ? d : parse(Int, v))
env_float(n, d) = (v = strip(get(ENV, n, "")); isempty(v) ? d : parse(Float64, v))

@inline function sine_gait_bend_angle(s, t, p)
    t_sim = (t - p.reference_time) * p.inv_L
    ramp = Base2D.smootherstep01(t_sim / (p.ramp_periods * p.period))
    omega = 2 * typeof(t_sim)(pi) / p.period
    phi1 = ramp * (p.bias1 + p.amp1 * sin(omega * t_sim))
    phi2 = ramp * (p.bias2 + p.amp2 * sin(omega * t_sim - p.phase_lag))
    return phi1 * Base2D.distributed_joint_step(s, p.center1, p.half_width1) +
        phi2 * Base2D.distributed_joint_step(s, p.center2, p.half_width2)
end

gait_derive(params; L::Int, T::Type=Float32) =
    (params = merge(Base2D.cast_named_tuple(params, T), (inv_L = inv(T(L)),)),
     period = Float64(Base2D.cast_named_tuple(params, T).period))

function sine_gait_design(turn_sign::Float64)
    params = (
        amp1 = Float32(20.0 * DEG), amp2 = Float32(26.0 * DEG),
        bias1 = Float32(turn_sign * 9.0 * DEG), bias2 = Float32(turn_sign * 9.0 * DEG),
        phase_lag = Float32(85.0 * DEG), period = 1.1f0, ramp_periods = 0.6f0,
        center1 = Float32(1 / 3), center2 = Float32(2 / 3),
        half_width1 = Float32(1 / 8), half_width2 = Float32(1 / 8),
        reference_time = 0.0f0, inv_L = 1.0f0,
    )
    return (
        version = "dogfish3d.superellipse_render.v1",
        morphology = (schema = NamedTuple(), params = NamedTuple(), generator = (s, p) -> 0f0),
        motion = (schema = NamedTuple(), params = params,
                  generator = sine_gait_bend_angle, derive = gait_derive),
        experiments = [(id = "superellipse_render_3d", morphology = NamedTuple(), motion = NamedTuple())],
    )
end

turn_sign_for_mode(m) = m == "straight" ? 0.0 : m == "left" ? -1.0 : m == "right" ? 1.0 :
    error("bad mode $m")

# Top-view body outline in world coords (drawn with the NEW W profile).
function world_outline(generator, params, profile, Lf, raw_t, state)
    spine_map = Base2D.SpineMotionMap(generator, params, Lf)
    outline = Base2D.spine_outline_points(spine_map, profile, raw_t; samples=96)
    local_center = T3D.deformed_body_centroid_3d(generator, params, profile, Lf, Float32(raw_t))
    to_world = point -> begin
        shifted = SVector(Float32(point[1]), Float32(point[2])) - local_center
        state.center + Base2D.rotate_to_world_frame(shifted, state.theta)
    end
    return [to_world(p) for p in outline.closed]
end

function render_frame(sim, state, raw_t, sim_t, generator, params, profile, Lf)
    σ = sim.flow.σ
    WaterLily.@inside σ[I] = WaterLily.curl(3, I, sim.flow.u) * sim.L / sim.U
    field = Array(σ)
    kz = clamp(Int(round(size(field, 3) / 2)), 2, size(field, 3) - 1)
    slice = field[2:(end - 1), 2:(end - 1), kz]
    nx, ny = size(slice)
    plt = heatmap((1:nx) .- 0.5, (1:ny) .- 0.5, permutedims(slice),
        c = :RdBu, clims = (-8, 8), aspect_ratio = :equal,
        xlims = (0, nx), ylims = (0, ny), colorbar = false,
        title = @sprintf("superellipse body · tU/L = %.2f", sim_t), dpi = 120)
    ol = world_outline(generator, params, profile, Lf, raw_t, state)
    plot!(plt, [p[1] for p in ol], [p[2] for p in ol],
        seriestype = :shape, fillalpha = 0.35, fillcolor = :gray25,
        linecolor = :black, linewidth = 1.0, label = nothing)
    return plt
end

function main()
    L = env_int("DOGFISH3D_RENDER_L", 64)
    mode = env_string("DOGFISH3D_RENDER_MODE", "left")
    n_cycles = Float32(env_float("DOGFISH3D_RENDER_CYCLES", 4.0))
    fps = env_int("DOGFISH3D_RENDER_FPS", 20)
    out = env_string("DOGFISH3D_RENDER_OUTPUT", joinpath(case_dir, "logs", "body_superellipse_render"))
    backend = env_string("DOGFISH_MEMORY_BACKEND", "auto")
    mkpath(out)

    Lf = Float32(L)
    body = dogfish_body_sdf(Lf)
    fin = caudal_fin(Lf; x_start = 0.80, x_end = 1.07, height = 0.11, half_thickness = 0.012)
    design = sine_gait_design(turn_sign_for_mode(mode))
    derived = design.motion.derive(design.motion.params; L, T = Float32)
    assembled = derived.params

    anim = Animation()
    nframes = Ref(0)
    write_vtk = env_string("DOGFISH3D_RENDER_VTK", "false") in ("1", "true", "yes", "on")
    vtk_every = max(1, env_int("DOGFISH3D_RENDER_VTK_EVERY", 2))
    vtk_fields = Tuple(strip(s) for s in split(env_string("DOGFISH3D_RENDER_VTK_FIELDS", "lambda2,body,velocity"), ",") if !isempty(strip(s)))
    vtk_stream = write_vtk ? start_free_swim_vtk_stream_3d(out; fields = vtk_fields) : nothing
    hook = (sim, state, raw_t, sim_t) -> begin
        nframes[] += 1
        plt = render_frame(sim, state, raw_t, sim_t, design.motion.generator, assembled, body.w, Lf)
        frame(anim, plt)
        if vtk_stream !== nothing && nframes[] % vtk_every == 0
            write_free_swim_vtk_frame_3d!(vtk_stream, sim, state,
                Float64(size(sim.flow.p, 3) - 2) / 2; period = derived.period)
        end
    end

    @info "rendering" L mode n_cycles
    rollout = run_free_swim_rollout_3d(
        design, design.experiments[1];
        L, T = Float32, backend, domain_scale = (8.0, 4.0, 1.5),
        initial_center_fraction = (0.62f0, 0.5f0, 0.5f0),
        n_cycles, samples_per_cycle = 24,
        caudal_fin = fin, body_sdf = body, sample_hook = hook,
    )

    mp4_path = joinpath(out, "body_superellipse_$(mode)_L$(L).mp4")
    mp4(anim, mp4_path; fps = fps)
    if vtk_stream !== nothing
        println("VTK_PVD: ", close_free_swim_vtk_stream_3d!(vtk_stream))
    end
    @printf("frames=%d  status=%s  disp=(%.3f, %.3f)L  dpsi=%.1f deg\n",
        nframes[], rollout.status,
        rollout.final_state.displacement[1] / L, rollout.final_state.displacement[2] / L,
        (rollout.trace.heading[end] - rollout.trace.heading[1]) / DEG)
    println("MP4: ", mp4_path)
    return mp4_path
end

main()
