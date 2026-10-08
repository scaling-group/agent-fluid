# Free-swimming 3D sanity: open-loop two-joint sine gait with an optional
# constant curvature bias, run as straight / left / right episodes. Confirms
# that the 3D swept body propels itself in the locked-DOF planar setting and
# that the turning response is signed correctly, while logging how strongly
# the locked DOFs (Fz, Mx, My) are excited.
#
# Env knobs:
#   DOGFISH3D_SANITY_MODES   straight,left,right (default)
#   DOGFISH3D_SANITY_L       grid cells per body length (default 16)
#   DOGFISH3D_SANITY_CYCLES  gait cycles to run (default 3)
#   DOGFISH3D_SANITY_OUTPUT  output root (default logs/free_swim3d_turn_sanity)
#   DOGFISH3D_SANITY_FRAMES  render mid-plane vorticity frames (default true)
#   DOGFISH3D_SANITY_VTK     write 3D VTK frames for offline rendering (default false)
#   DOGFISH3D_SANITY_VTK_EVERY  write VTK every Nth sample (default 2)

ENV["GKSwstype"] = get(ENV, "GKSwstype", "100")

case_dir = @__DIR__

include(joinpath(case_dir, "src", "Dogfish3DShapePolicyTestbed.jl"))
using .Dogfish3DShapePolicyTestbed
const T3D = Dogfish3DShapePolicyTestbed
const Base2D = Dogfish3DShapePolicyTestbed.Base2D

using JSON
using Plots
using Printf
using StaticArrays
using Statistics
using WaterLily

const DEG = pi / 180

function env_string(name::String, default::String)
    value = strip(get(ENV, name, ""))
    return isempty(value) ? default : value
end

function env_int(name::String, default::Int)
    value = strip(get(ENV, name, ""))
    return isempty(value) ? default : parse(Int, value)
end

function env_float(name::String, default::Float64)
    value = strip(get(ENV, name, ""))
    return isempty(value) ? default : parse(Float64, value)
end

function env_bool(name::String, default::Bool)
    value = lowercase(strip(get(ENV, name, "")))
    isempty(value) && return default
    value in ("1", "true", "yes", "on") && return true
    value in ("0", "false", "no", "off") && return false
    error("Unsupported boolean env value for $name: `$value`")
end

# Open-loop gait evaluated directly from raw solver time; fully smooth in t so
# the body velocity from AutoBody's time derivative stays well defined.
@inline function sine_gait_bend_angle(s, t, p)
    t_sim = (t - p.reference_time) * p.inv_L
    ramp_span = p.ramp_periods * p.period
    ramp = Base2D.smootherstep01(t_sim / ramp_span)
    omega = 2 * typeof(t_sim)(pi) / p.period
    phi1 = ramp * (p.bias1 + p.amp1 * sin(omega * t_sim))
    phi2 = ramp * (p.bias2 + p.amp2 * sin(omega * t_sim - p.phase_lag))
    return phi1 * Base2D.distributed_joint_step(s, p.center1, p.half_width1) +
        phi2 * Base2D.distributed_joint_step(s, p.center2, p.half_width2)
end

function gait_motion_derived_params(params; L::Int, T::Type=Float32)
    typed = Base2D.cast_named_tuple(params, T)
    typed = merge(typed, (inv_L=inv(T(L)),))
    return (params=typed, period=Float64(typed.period))
end

function sine_gait_design(;
    turn_sign::Float64,
    period::Float64,
    amp1_deg::Float64,
    amp2_deg::Float64,
    phase_lag_deg::Float64,
    bias_deg::Float64,
    ramp_periods::Float64,
)
    params = (
        amp1=Float32(amp1_deg * DEG),
        amp2=Float32(amp2_deg * DEG),
        bias1=Float32(turn_sign * bias_deg * DEG),
        bias2=Float32(turn_sign * bias_deg * DEG),
        phase_lag=Float32(phase_lag_deg * DEG),
        period=Float32(period),
        ramp_periods=Float32(ramp_periods),
        center1=Float32(1 / 3),
        center2=Float32(2 / 3),
        half_width1=Float32(1 / 8),
        half_width2=Float32(1 / 8),
        reference_time=0.0f0,
        inv_L=1.0f0,
    )
    return (
        version="dogfish3d.free_turn_sanity.v1",
        lineage=(
            body_regime=:baseline_profile_body_of_revolution,
            motion_regime=:open_loop_two_joint_sine_gait,
            notes="3D locked-DOF free-swim sanity: planar spine wave on a 3D swept body",
        ),
        morphology=(
            schema=NamedTuple(),
            params=NamedTuple(),
            generator=(s, p) -> 0f0,
        ),
        motion=(
            schema=NamedTuple(),
            params=params,
            generator=sine_gait_bend_angle,
            derive=gait_motion_derived_params,
        ),
        experiments=[
            (
                id="free_turn_sanity_3d",
                morphology=NamedTuple(),
                motion=NamedTuple(),
            ),
        ],
    )
end

# Sign maps the intended turn direction to the joint-bias sign. The mapping is
# calibrated to the FSI response, not to naive geometry: a positive joint bias
# yields a negative yaw rate here (the same wrong-sign coupling the 2D paper
# documents), so "left" (positive yaw) uses a negative bias.
function turn_sign_for_mode(mode::AbstractString)
    mode == "straight" && return 0.0
    mode == "left" && return -1.0
    mode == "right" && return 1.0
    error("Unsupported mode `$mode`; expected straight,left,right")
end

function world_outline(generator, params, profile, Lf, raw_t, state, height_scale)
    spine_map = Base2D.SpineMotionMap(generator, params, Lf)
    outline = Base2D.spine_outline_points(spine_map, profile, raw_t; samples=96)
    local_center = T3D.deformed_body_centroid_3d(
        generator, params, profile, Lf, Float32(raw_t); height_scale=Float32(height_scale),
    )
    to_world = point -> begin
        shifted = SVector(Float32(point[1]), Float32(point[2])) - local_center
        rotated = Base2D.rotate_to_world_frame(shifted, state.theta)
        state.center + rotated
    end
    return [to_world(point) for point in outline.closed]
end

function render_midplane_frame(
    sim,
    state,
    raw_t,
    sim_t,
    frame_index,
    frame_dir,
    generator,
    params,
    profile,
    Lf,
    height_scale,
)
    σ = sim.flow.σ
    WaterLily.@inside σ[I] = WaterLily.curl(3, I, sim.flow.u) * sim.L / sim.U
    field = Array(σ)
    kz = clamp(Int(round(size(field, 3) / 2)), 2, size(field, 3) - 1)
    slice = field[2:(end - 1), 2:(end - 1), kz]
    nx, ny = size(slice)
    xs = (1:nx) .- 0.5
    ys = (1:ny) .- 0.5
    plt = heatmap(
        xs,
        ys,
        permutedims(slice),
        c=:RdBu,
        clims=(-8, 8),
        aspect_ratio=:equal,
        xlims=(0, nx),
        ylims=(0, ny),
        colorbar=false,
        title=@sprintf("tU/L = %.2f", sim_t),
        dpi=110,
    )
    outline = world_outline(generator, params, profile, Lf, raw_t, state, height_scale)
    plot!(
        plt,
        [point[1] for point in outline],
        [point[2] for point in outline],
        seriestype=:shape,
        fillalpha=0.35,
        fillcolor=:gray25,
        linecolor=:black,
        linewidth=1.0,
        label=nothing,
    )
    savefig(plt, joinpath(frame_dir, @sprintf("frame_%04d.png", frame_index)))
    return nothing
end

function summarize_mode(mode, rollout)
    trace = rollout.trace
    n = length(trace.time)
    displacement = rollout.final_state.displacement
    heading_change = trace.heading[end] - trace.heading[1]
    mean_omega = n > 1 ? mean(trace.omega[2:end]) : 0.0

    # Locked-DOF excitation diagnostics (sampled instants).
    max_force_xy = maximum(map(f -> hypot(f[1], f[2]), trace.force))
    max_force_z = maximum(abs, trace.force_z)
    max_moment_z = maximum(abs, trace.moment_z)
    max_moment_x = maximum(abs, trace.locked_moment_x)
    max_moment_y = maximum(abs, trace.locked_moment_y)
    L = Float64(rollout.grid_L)
    # Normalize locked-DOF moments by a stable reference (lateral force * L),
    # not by Mz: Mz collapses toward zero for weak turns and would blow the
    # ratio up spuriously. This ratio is dimensionless and stays meaningful
    # across straight and turning modes.
    force_z_ratio = max_force_xy > 0 ? max_force_z / max_force_xy : 0.0
    moment_xy_ratio = max_force_xy > 0 ?
        max(max_moment_x, max_moment_y) / (max_force_xy * L) : 0.0

    speed_L = hypot(displacement...) / max(rollout.sim_time, eps()) / L

    return (
        mode=mode,
        status=rollout.status,
        termination=rollout.termination,
        steps=rollout.steps,
        wall_seconds=rollout.wall_seconds,
        ms_per_step=1000 * rollout.wall_seconds / max(rollout.steps, 1),
        cell_count=rollout.cell_count,
        sim_time=rollout.sim_time,
        displacement_L=(displacement[1] / L, displacement[2] / L),
        mean_speed_L=speed_L,
        heading_change_deg=heading_change / DEG,
        mean_omega=mean_omega,
        max_force_xy=max_force_xy,
        max_force_z=max_force_z,
        force_z_ratio=force_z_ratio,
        max_moment_z=max_moment_z,
        max_moment_x=max_moment_x,
        max_moment_y=max_moment_y,
        locked_moment_ratio=moment_xy_ratio,
    )
end

# Per-mode checks cover what every episode must satisfy regardless of steering:
# the rollout completes and the swimmer makes net forward (-x) progress, plus
# the locked vertical DOF stays quiet.
function check_mode(summary)
    issues = String[]
    summary.status == "ok" || push!(issues, "rollout failed: $(summary.termination)")
    summary.displacement_L[1] < -0.05 ||
        push!(issues, "expected forward (-x) displacement, got $(round.(summary.displacement_L; digits=3))")
    summary.force_z_ratio < 0.05 ||
        push!(issues, "locked heave force too large: |Fz|/|Fxy|=$(round(summary.force_z_ratio; digits=3))")
    return issues
end

# Steering is judged by separability relative to the straight baseline, which
# absorbs the (real) start-up bias of a one-directional travelling wave on a
# free body. We require left and right to split cleanly around straight.
function check_steering(summaries; margin_deg=3.0)
    issues = String[]
    by_mode = Dict(summary.mode => summary for summary in summaries)
    haskey(by_mode, "left") && haskey(by_mode, "right") || return issues
    baseline = haskey(by_mode, "straight") ? by_mode["straight"].heading_change_deg : 0.0
    left = by_mode["left"].heading_change_deg
    right = by_mode["right"].heading_change_deg
    left > baseline + margin_deg ||
        push!(issues, "left should turn positive vs baseline $(round(baseline; digits=1)), got $(round(left; digits=1)) deg")
    right < baseline - margin_deg ||
        push!(issues, "right should turn negative vs baseline $(round(baseline; digits=1)), got $(round(right; digits=1)) deg")
    return issues
end

function run_sanity()
    modes = [strip(item) for item in split(env_string("DOGFISH3D_SANITY_MODES", "straight,left,right"), ",")]
    modes = [mode for mode in modes if !isempty(mode)]
    L = env_int("DOGFISH3D_SANITY_L", 16)
    n_cycles = Float32(env_float("DOGFISH3D_SANITY_CYCLES", 3.0))
    output_root = env_string("DOGFISH3D_SANITY_OUTPUT", joinpath(case_dir, "logs", "free_swim3d_turn_sanity"))
    render_frames = env_bool("DOGFISH3D_SANITY_FRAMES", true)
    write_vtk = env_bool("DOGFISH3D_SANITY_VTK", false)
    vtk_every = max(1, env_int("DOGFISH3D_SANITY_VTK_EVERY", 2))
    domain_scale = (
        env_float("DOGFISH3D_SANITY_DOMAIN_X", 8.0),
        env_float("DOGFISH3D_SANITY_DOMAIN_Y", 4.0),
        env_float("DOGFISH3D_SANITY_DOMAIN_Z", 1.5),
    )
    period = env_float("DOGFISH3D_SANITY_PERIOD", 1.1)
    bias_deg = env_float("DOGFISH3D_SANITY_BIAS_DEG", 9.0)
    backend = env_string("DOGFISH_MEMORY_BACKEND", "auto")
    height_scale = Float32(env_float("DOGFISH3D_SANITY_HEIGHT_SCALE", 1.0))
    fin_enabled = env_bool("DOGFISH3D_SANITY_FIN", false)
    fin = fin_enabled ?
        caudal_fin(
            Float32(L);
            x_start=env_float("DOGFISH3D_FIN_X_START", 0.70),
            x_end=env_float("DOGFISH3D_FIN_X_END", 1.02),
            height=env_float("DOGFISH3D_FIN_HEIGHT", 0.12),
            half_thickness=env_float("DOGFISH3D_FIN_HALF_THICKNESS", 0.012),
        ) :
        nothing

    profile = dogfish3d_thickness_profile(Float32)
    Lf = Float32(L)

    summaries = []
    all_issues = String[]

    for mode in modes
        sign = turn_sign_for_mode(mode)
        design = sine_gait_design(
            turn_sign=sign,
            period=period,
            amp1_deg=20.0,
            amp2_deg=26.0,
            phase_lag_deg=85.0,
            bias_deg=bias_deg,
            ramp_periods=0.6,
        )
        experiment = design.experiments[1]
        mode_root = joinpath(output_root, @sprintf("%s_L%02d", mode, L))
        frame_dir = joinpath(mode_root, "frames")
        render_frames && mkpath(frame_dir)

        derived = design.motion.derive(design.motion.params; L, T=Float32)
        assembled = derived.params
        vtk_stream = write_vtk ? start_free_swim_vtk_stream_3d(mode_root) : nothing
        frame_count = Ref(0)
        hook = if render_frames || write_vtk
            (sim, state, raw_t, sim_t) -> begin
                frame_count[] += 1
                render_frames && frame_count[] % 2 == 1 && render_midplane_frame(
                    sim, state, raw_t, sim_t, frame_count[], frame_dir,
                    design.motion.generator, assembled, profile, Lf, height_scale,
                )
                vtk_stream !== nothing && frame_count[] % vtk_every == 0 &&
                    write_free_swim_vtk_frame_3d!(
                        vtk_stream, sim, state, Float64(size(sim.flow.p, 3) - 2) / 2;
                        period=derived.period,
                    )
            end
        else
            nothing
        end

        @info "running 3D free-swim sanity" mode L domain_scale n_cycles
        rollout = run_free_swim_rollout_3d(
            design,
            experiment;
            L,
            T=Float32,
            backend,
            domain_scale,
            initial_center_fraction=(0.62f0, 0.5f0, 0.5f0),
            n_cycles,
            samples_per_cycle=24,
            height_scale,
            caudal_fin=fin,
            sample_hook=hook,
        )

        vtk_stream !== nothing && close_free_swim_vtk_stream_3d!(vtk_stream)
        outputs = write_free_swim_outputs_3d(mode_root, rollout)
        summary = summarize_mode(mode, rollout)
        issues = check_mode(summary)
        append!(all_issues, ["[$mode] $issue" for issue in issues])
        push!(summaries, summary)

        open(joinpath(mode_root, "sanity_summary.json"), "w") do io
            JSON.print(io, Base2D.jsonable(summary), 2)
            println(io)
        end

        @info "mode finished" mode summary.status summary.steps summary.ms_per_step summary.displacement_L summary.heading_change_deg
        _ = outputs
    end

    append!(all_issues, ["[steering] $issue" for issue in check_steering(summaries)])

    report = (
        schema="dogfish.free_swim3d_turn_sanity.v1",
        grid_L=L,
        domain_scale=domain_scale,
        n_cycles=Float64(n_cycles),
        modes=[summary.mode for summary in summaries],
        summaries=summaries,
        issues=all_issues,
        passed=isempty(all_issues),
    )
    mkpath(output_root)
    open(joinpath(output_root, "turn_sanity3d_report.json"), "w") do io
        JSON.print(io, Base2D.jsonable(report), 2)
        println(io)
    end

    println()
    println("=== 3D free-swim turn sanity ===")
    for summary in summaries
        @printf(
            "%-9s status=%-6s steps=%5d  %.1f ms/step  disp=(%.3f, %.3f)L  dpsi=%+.1f deg  |Fz|/|Fxy|=%.3f  |Mxy|/FxyL=%.3f\n",
            summary.mode,
            summary.status,
            summary.steps,
            summary.ms_per_step,
            summary.displacement_L[1],
            summary.displacement_L[2],
            summary.heading_change_deg,
            summary.force_z_ratio,
            summary.locked_moment_ratio,
        )
    end
    if isempty(all_issues)
        println("PASS: all modes satisfied sanity expectations")
    else
        println("ISSUES:")
        for issue in all_issues
            println("  - $issue")
        end
    end
    return report
end

run_sanity()
