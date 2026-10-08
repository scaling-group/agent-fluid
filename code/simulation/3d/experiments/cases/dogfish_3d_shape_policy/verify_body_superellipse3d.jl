# Verification for the superellipse FSI body base (GPU backend).
#
# Two layers:
#   1. SDF probe — the straight reference-frame DogfishBodySDF is sane: inside
#      points are negative, far points positive, the head/tail close, and the
#      finite-difference |∇d| is ≈1 (approximate-SDF quality BDIM needs).
#   2. End-to-end — drive the body ∪ caudal-fin (the FSI base) with the same
#      open-loop gait as the ellipse sanity, straight/left/right, and confirm it
#      swims forward, the locked vertical DOF stays quiet (z-stable: no roll/
#      heave — the "不翻肚皮" requirement), and steering splits the right way.
#
# Env knobs mirror free_swim_turn_sanity3d.jl:
#   DOGFISH3D_SANITY_MODES / _L / _CYCLES / _OUTPUT / _DOMAIN_{X,Y,Z}
#   DOGFISH_MEMORY_BACKEND (cuda for the GPU backend)
#   DOGFISH3D_VERIFY_FIN  include the caudal fin in the union (default true)

ENV["GKSwstype"] = get(ENV, "GKSwstype", "100")

case_dir = @__DIR__
include(joinpath(case_dir, "src", "Dogfish3DShapePolicyTestbed.jl"))
using .Dogfish3DShapePolicyTestbed
const T3D = Dogfish3DShapePolicyTestbed
const Base2D = Dogfish3DShapePolicyTestbed.Base2D

using JSON
using Printf
using StaticArrays
using Statistics
using WaterLily

const DEG = pi / 180

env_string(n, d) = (v = strip(get(ENV, n, "")); isempty(v) ? d : v)
env_int(n, d) = (v = strip(get(ENV, n, "")); isempty(v) ? d : parse(Int, v))
env_float(n, d) = (v = strip(get(ENV, n, "")); isempty(v) ? d : parse(Float64, v))
env_bool(n, d) = (v = lowercase(strip(get(ENV, n, ""))); isempty(v) ? d :
    v in ("1", "true", "yes", "on"))

# --- open-loop two-joint sine gait (identical to the ellipse sanity) ----------
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
        version = "dogfish3d.superellipse_verify.v1",
        morphology = (schema = NamedTuple(), params = NamedTuple(), generator = (s, p) -> 0f0),
        motion = (schema = NamedTuple(), params = params,
                  generator = sine_gait_bend_angle, derive = gait_derive),
        experiments = [(id = "superellipse_verify_3d", morphology = NamedTuple(), motion = NamedTuple())],
    )
end

turn_sign_for_mode(m) = m == "straight" ? 0.0 : m == "left" ? -1.0 :
    m == "right" ? 1.0 : error("bad mode $m")

# --- SDF probe: straight reference frame (no map needed) ----------------------
function probe_sdf(body::DogfishBodySDF, Lf; fin=nothing)
    f = fin === nothing ? body : x -> min(body(x, 0.0f0), fin(x, 0.0f0))
    issues = String[]

    inside = f(SVector(0.5f0 * Lf, 0.0f0, 0.0f0))
    inside < 0 || push!(issues, "mid-body axis point not inside (d=$(round(inside; digits=3)))")
    outside = f(SVector(0.5f0 * Lf, 5.0f0 * Lf, 0.0f0))
    outside > 0 || push!(issues, "far lateral point not outside (d=$(round(outside; digits=3)))")
    # head/tail must close: a point just past each end, on-axis, is outside.
    f(SVector(-0.1f0 * Lf, 0.0f0, 0.0f0)) > 0 || push!(issues, "head does not close")
    f(SVector(1.1f0 * Lf, 0.0f0, 0.0f0)) > 0 || push!(issues, "tail does not close")

    # |∇d| via central differences on a band of points straddling the surface.
    h = 0.02f0 * Lf
    grads = Float64[]
    for sx in 0.2f0:0.2f0:0.8f0, off in (0.6f0, 0.9f0, 1.0f0, 1.1f0)
        # march outward in +y from the axis to near the lateral surface
        yb = off * Lf * Float32(Base2D.profile_width(body.w, sx))
        p = SVector(sx * Lf, yb, 0.05f0 * Lf)
        gx = (f(p + SVector(h, 0, 0)) - f(p - SVector(h, 0, 0))) / (2h)
        gy = (f(p + SVector(0, h, 0)) - f(p - SVector(0, h, 0))) / (2h)
        gz = (f(p + SVector(0, 0, h)) - f(p - SVector(0, 0, h))) / (2h)
        push!(grads, sqrt(gx^2 + gy^2 + gz^2))
    end
    med = median(grads)
    (0.6 <= med <= 1.6) ||
        push!(issues, "median |∇d|=$(round(med; digits=3)) outside [0.6,1.6] (approx-SDF quality)")
    return (issues = issues, grad_median = med, sample_inside = Float64(inside))
end

# --- end-to-end metrics (subset of the ellipse sanity) ------------------------
function summarize(mode, rollout)
    tr = rollout.trace
    disp = rollout.final_state.displacement
    L = Float64(rollout.grid_L)
    max_fxy = maximum(f -> hypot(f[1], f[2]), tr.force)
    fz_ratio = max_fxy > 0 ? maximum(abs, tr.force_z) / max_fxy : 0.0
    mxy_ratio = max_fxy > 0 ?
        max(maximum(abs, tr.locked_moment_x), maximum(abs, tr.locked_moment_y)) / (max_fxy * L) : 0.0
    return (
        mode = mode, status = rollout.status, termination = rollout.termination,
        steps = rollout.steps, ms_per_step = 1000 * rollout.wall_seconds / max(rollout.steps, 1),
        displacement_L = (disp[1] / L, disp[2] / L),
        heading_change_deg = (tr.heading[end] - tr.heading[1]) / DEG,
        force_z_ratio = fz_ratio, locked_moment_ratio = mxy_ratio,
        body_volume = rollout.body_volume, mass = rollout.mass, inertia = rollout.inertia,
    )
end

function check_mode(s)
    iss = String[]
    s.status == "ok" || push!(iss, "rollout failed: $(s.termination)")
    s.displacement_L[1] < -0.05 ||
        push!(iss, "no forward (-x) progress: $(round.(s.displacement_L; digits=3))")
    s.force_z_ratio < 0.05 ||
        push!(iss, "locked heave too large: |Fz|/|Fxy|=$(round(s.force_z_ratio; digits=3))")
    return iss
end

function check_steering(sums; margin = 3.0)
    iss = String[]
    by = Dict(s.mode => s for s in sums)
    (haskey(by, "left") && haskey(by, "right")) || return iss
    base = haskey(by, "straight") ? by["straight"].heading_change_deg : 0.0
    by["left"].heading_change_deg > base + margin ||
        push!(iss, "left should turn + vs $(round(base; digits=1)), got $(round(by["left"].heading_change_deg; digits=1))")
    by["right"].heading_change_deg < base - margin ||
        push!(iss, "right should turn - vs $(round(base; digits=1)), got $(round(by["right"].heading_change_deg; digits=1))")
    return iss
end

function main()
    modes = [strip(m) for m in split(env_string("DOGFISH3D_SANITY_MODES", "straight,left,right"), ",") if !isempty(strip(m))]
    L = env_int("DOGFISH3D_SANITY_L", 32)
    n_cycles = Float32(env_float("DOGFISH3D_SANITY_CYCLES", 4.0))
    out = env_string("DOGFISH3D_SANITY_OUTPUT", joinpath(case_dir, "logs", "body_superellipse_verify"))
    backend = env_string("DOGFISH_MEMORY_BACKEND", "auto")
    domain = (env_float("DOGFISH3D_SANITY_DOMAIN_X", 8.0),
              env_float("DOGFISH3D_SANITY_DOMAIN_Y", 4.0),
              env_float("DOGFISH3D_SANITY_DOMAIN_Z", 1.5))
    use_fin = env_bool("DOGFISH3D_VERIFY_FIN", true)
    mkpath(out)

    Lf = Float32(L)
    body = dogfish_body_sdf(Lf)
    # caudal params from the modeler (start 0.80, tip 1.07, ½thick 0.012). The
    # modeler tail is heterocercal (upper 0.13 / lower 0.09); the physics
    # CaudalFinSDF is still a SYMMETRIC fan, so height = total-span equivalent
    # (0.13+0.09)/2 = 0.11. Heterocercal (upper≠lower) is a later step — an
    # asymmetric tail loads the locked z-DOF (see design note).
    fin = use_fin ? caudal_fin(Lf; x_start = 0.80, x_end = 1.07, height = 0.11, half_thickness = 0.012) : nothing

    @info "SDF probe (straight reference frame)" L use_fin
    probe = probe_sdf(body, Lf; fin = fin)
    println("=== superellipse SDF probe ===")
    @printf("median |grad d| = %.3f   mid-body d = %.3f   issues = %d\n",
        probe.grad_median, probe.sample_inside, length(probe.issues))
    for i in probe.issues
        println("  - $i")
    end

    all_issues = ["[probe] $i" for i in probe.issues]
    sums = []
    for mode in modes
        design = sine_gait_design(turn_sign_for_mode(mode))
        @info "rollout" mode L n_cycles
        rollout = run_free_swim_rollout_3d(
            design, design.experiments[1];
            L, T = Float32, backend, domain_scale = domain,
            initial_center_fraction = (0.62f0, 0.5f0, 0.5f0),
            n_cycles, samples_per_cycle = 24,
            caudal_fin = fin, body_sdf = body,
        )
        s = summarize(mode, rollout)
        append!(all_issues, ["[$mode] $i" for i in check_mode(s)])
        push!(sums, s)
        open(joinpath(out, "verify_$(mode)_L$(L).json"), "w") do io
            JSON.print(io, Base2D.jsonable(s), 2); println(io)
        end
        @info "mode done" mode s.status s.steps s.displacement_L s.heading_change_deg
    end
    append!(all_issues, ["[steering] $i" for i in check_steering(sums)])

    report = (
        schema = "dogfish.body_superellipse_verify.v1",
        grid_L = L, domain_scale = domain, n_cycles = Float64(n_cycles), fin = use_fin,
        sdf_probe = (grad_median = probe.grad_median, issues = probe.issues),
        summaries = sums, issues = all_issues, passed = isempty(all_issues),
    )
    open(joinpath(out, "body_superellipse_verify_report.json"), "w") do io
        JSON.print(io, Base2D.jsonable(report), 2); println(io)
    end

    println()
    println("=== superellipse body FSI verify (L=$L) ===")
    for s in sums
        @printf("%-9s status=%-6s steps=%5d  %.1f ms/step  disp=(%.3f, %.3f)L  dpsi=%+.1f deg  |Fz|/|Fxy|=%.3f  |Mxy|/FxyL=%.3f\n",
            s.mode, s.status, s.steps, s.ms_per_step,
            s.displacement_L[1], s.displacement_L[2], s.heading_change_deg,
            s.force_z_ratio, s.locked_moment_ratio)
    end
    if !isempty(sums)
        v = sums[1]
        @printf("body volume=%.2f  mass=%.2f  inertia_z=%.2f  (grid units)\n", v.body_volume, v.mass, v.inertia)
    end
    if isempty(all_issues)
        println("PASS: superellipse body is a valid, z-stable, steerable FSI base")
    else
        println("ISSUES:")
        for i in all_issues
            println("  - $i")
        end
    end
    return report
end

main()
