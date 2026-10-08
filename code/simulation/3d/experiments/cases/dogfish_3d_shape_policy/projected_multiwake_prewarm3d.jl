# Configuration-specific 3D prewarm/timestep probe for the final projected
# 24L x 16L multiwake case. The fish is intentionally absent during prewarm;
# only the four domain-spanning cylinders seed the wake. This is not a rollout.

ENV["GKSwstype"] = get(ENV, "GKSwstype", "100")

case_dir = @__DIR__
include(joinpath(case_dir, "src", "Dogfish3DShapePolicyTestbed.jl"))
using .Dogfish3DShapePolicyTestbed
const T3D = Dogfish3DShapePolicyTestbed
const Base2D = Dogfish3DShapePolicyTestbed.Base2D

using Dates
using JLD2
using JSON
using Random
using SHA
using StaticArrays
using TOML
using WaterLily

const DEG = pi / 180
const MATERIAL_REFERENCE_STATION = 1f0 / 3f0

env_string(name, default) = (value = strip(get(ENV, name, "")); isempty(value) ? default : value)
env_int(name, default) = (value = strip(get(ENV, name, "")); isempty(value) ? default : parse(Int, value))
env_float(name, default) = (value = strip(get(ENV, name, "")); isempty(value) ? default : parse(Float64, value))
env_bool(name, default) = begin
    value = lowercase(strip(get(ENV, name, "")))
    isempty(value) && return default
    value in ("1", "true", "yes", "on") && return true
    value in ("0", "false", "no", "off") && return false
    error("$name must be a boolean")
end

sha256_file(path) = bytes2hex(sha256(read(path)))

function static_joint_design(phi1, phi2)
    params = Base2D.two_joint_bend_params(
        T=Float32,
        phi1=Float32(phi1),
        phi2=Float32(phi2),
        center1=1f0 / 3f0,
        center2=2f0 / 3f0,
        half_width1=1f0 / 8f0,
        half_width2=1f0 / 8f0,
    )
    derive = function (p; L::Int, T::Type=Float32)
        typed = Base2D.cast_named_tuple(p, T)
        return (params=merge(typed, (inv_L=inv(T(L)),)), period=1.0)
    end
    return (
        version="dogfish.projected_multiwake_held_prewarm3d.v1",
        morphology=(schema=NamedTuple(), params=NamedTuple(), generator=(s, p) -> 0f0),
        motion=(
            schema=NamedTuple(),
            params=params,
            generator=Base2D.two_joint_bend_angle_with_rates,
            derive=derive,
        ),
        experiments=[(id="held_fish_prewarm_3d", morphology=NamedTuple(), motion=NamedTuple())],
    )
end

function synchronize_backend(backend)
    if backend.name == "cuda" && isdefined(Base2D, :CUDA)
        Base.invokelatest(Base2D.CUDA.synchronize)
    end
    return nothing
end

function field_health(sim)
    pressure = Array(sim.flow.p)
    velocity = Array(sim.flow.u)
    pressure_finite = all(isfinite, pressure)
    velocity_finite = all(isfinite, velocity)
    return (
        finite=pressure_finite && velocity_finite,
        pressure_finite,
        velocity_finite,
        max_abs_pressure=maximum(abs, pressure),
        max_abs_velocity=maximum(abs, velocity),
    )
end

function write_json(path, value)
    open(path, "w") do io
        JSON.print(io, Base2D.jsonable(value), 2)
        println(io)
    end
    return path
end

function main()
    config_path = abspath(env_string(
        "DOGFISH3D_PREWARM_CONFIG",
        joinpath(
            case_dir,
            "configs",
            "free_swim_multiwake_target_secondrow_capture0p75_24x16_l32_3d.toml",
        ),
    ))
    geometry_path = abspath(env_string(
        "DOGFISH3D_GEOMETRY_CONFIG",
        joinpath(case_dir, "configs", "dogfish_nurbs_modeler_default_body_caudal_v1.json"),
    ))
    config = TOML.parsefile(config_path)
    projected = config["projected_multiwake_3d"]
    free_swim = config["free_swim"]
    source_spec = load_projected_multiwake_spec_3d(config_path)
    validate_projected_multiwake_spec_3d(source_spec)

    L = env_int("DOGFISH3D_PREWARM_L", 16)
    L > 0 || error("DOGFISH3D_PREWARM_L must be positive")
    max_dimensionless_dt = env_float(
        "DOGFISH3D_PREWARM_DT",
        Float64(free_swim["max_dimensionless_dt"]),
    )
    max_dimensionless_dt > 0 || error("DOGFISH3D_PREWARM_DT must be positive")
    horizon = env_float("DOGFISH3D_PREWARM_HORIZON", source_spec.prewarm_horizon)
    horizon > 0 || error("DOGFISH3D_PREWARM_HORIZON must be positive")
    check_interval = env_float("DOGFISH3D_PREWARM_CHECK_INTERVAL", 10.0)
    check_interval > 0 || error("DOGFISH3D_PREWARM_CHECK_INTERVAL must be positive")
    max_steps = env_int("DOGFISH3D_PREWARM_MAX_STEPS", 1_000_000)
    prewarm_with_fish = env_bool("DOGFISH3D_PREWARM_WITH_FISH", true)
    vtk_enabled = env_bool("DOGFISH3D_PREWARM_VTK", false)
    vtk_frame_count = env_int("DOGFISH3D_PREWARM_VTK_FRAMES", 41)
    vtk_frame_count >= 2 || error("DOGFISH3D_PREWARM_VTK_FRAMES must be at least 2")
    output_root = abspath(env_string(
        "DOGFISH3D_PREWARM_OUTPUT",
        joinpath(case_dir, "logs", "projected_multiwake_prewarm3d"),
    ))
    backend_name = env_string("DOGFISH_MEMORY_BACKEND", source_spec.backend)
    mkpath(output_root)

    T = Float32
    runtime_spec = merge(source_spec, (L=L, backend=backend_name))
    validate_projected_multiwake_spec_3d(runtime_spec)
    backend = Base2D.resolve_memory_backend(backend=backend_name)
    Lf = T(L)
    dims = Tuple(max(4, Int(round(scale * L))) for scale in runtime_spec.domain_scale_L)
    raw_dt_cap = T(max_dimensionless_dt) * Lf
    inflow = Tuple(T(value) for value in runtime_spec.flow_velocity_L)
    cylinders = projected_cylinder_union_3d(runtime_spec; T)
    phi1_deg = Float64(projected["initial_phi1_deg"])
    phi2_deg = Float64(projected["initial_phi2_deg"])
    state = Base2D.FreeSwimState(
        SVector(T(runtime_spec.initial_center_L[1]) * Lf, T(runtime_spec.initial_center_L[2]) * Lf),
        T(runtime_spec.initial_heading_deg * DEG),
        SVector(zero(T), zero(T)),
        zero(T),
    )
    z_plane = T(runtime_spec.z_plane_fraction * runtime_spec.domain_scale_L[3] * L)
    body_sdf = T3D.dogfish_body_sdf(Lf)
    physical_fin_x_start = 0.80
    fin_x_start = env_float(
        "DOGFISH3D_PREWARM_FIN_X_START",
        L < 32 ? 0.70 : physical_fin_x_start,
    )
    fin_min_root_half_cells = env_float(
        "DOGFISH3D_PREWARM_FIN_MIN_ROOT_HALF_CELLS",
        L < 32 ? 0.50 : 1.0,
    )
    fin_min_midplane_half_cells = env_float(
        "DOGFISH3D_PREWARM_FIN_MIN_MIDPLANE_HALF_CELLS",
        L < 32 ? 0.50 : 0.0,
    )
    fin = T3D.modeler_caudal_fin(
        body_sdf;
        x_start=fin_x_start,
        min_root_half_cells=fin_min_root_half_cells,
        min_midplane_half_cells=fin_min_midplane_half_cells,
    )
    body_root_half_width_L = Float64(Base2D.profile_width(body_sdf.w, T(fin_x_start)))
    root_u_at_midplane = fin.root_upper / (fin.root_upper + fin.root_lower)
    fin_root_midplane_half_thickness_L = Float64(
        T3D._modeler_thickness_fraction(fin, root_u_at_midplane, zero(T)),
    )
    fin_root_midplane_half_thickness_L <= body_root_half_width_L + 1.0e-6 ||
        error(
            "caudal root protrudes beyond the body at z=0: " *
            "fin=$(fin_root_midplane_half_thickness_L)L, " *
            "body=$(body_root_half_width_L)L",
        )
    design = static_joint_design(phi1_deg * DEG, phi2_deg * DEG)
    experiment = first(Base2D.design_experiments(design))
    _, assembled_params, unused_period = Base2D.assemble_experiment_for_length(
        design,
        experiment;
        L,
        T,
    )
    profile = T3D.dogfish3d_thickness_profile(T)
    fish_map = T3D.free_swim_map_3d(
        design,
        assembled_params,
        profile,
        Lf,
        state,
        zero(T),
        raw_dt_cap,
        z_plane;
        reference_station=MATERIAL_REFERENCE_STATION,
    )
    fish_body = T3D.compose_body_3d(body_sdf, fish_map, fin)
    full_body = prewarm_with_fish ? fish_body ∪ cylinders : cylinders
    exit_bc = Bool(projected["exit_bc"])

    simulation_builder = () -> Simulation(
        dims,
        inflow,
        L;
        U=one(T),
        Δt=raw_dt_cap,
        ν=Lf / T(runtime_spec.Re),
        body=full_body,
        T,
        mem=backend.mem,
        exitBC=exit_bc,
    )
    sim = backend.name == "cuda" ? Base.invokelatest(simulation_builder) : simulation_builder()
    perturbation = T(projected["flow_perturbation"])
    if perturbation > zero(T)
        Random.seed!(runtime_spec.flow_seed)
        WaterLily.perturb!(sim; noise=perturbation)
    end
    synchronize_backend(backend)

    vtk_stream = vtk_enabled ? T3D.start_free_swim_vtk_stream_3d(
        output_root;
        collection_name="projected_multiwake_prewarm3d",
        fields=("velocity", "lambda2", "body"),
        flush_collection=true,
        compress=true,
    ) : nothing
    vtk_times = collect(range(0.0, horizon; length=vtk_frame_count))
    vtk_index = 1
    function write_due_vtk_frames!()
        vtk_stream === nothing && return nothing
        current_time = Float64(sim_time(sim))
        while vtk_index <= length(vtk_times) && current_time + 1.0e-8 >= vtk_times[vtk_index]
            T3D.write_free_swim_vtk_frame_3d!(
                vtk_stream,
                sim,
                state,
                z_plane;
                period=max(horizon, eps(Float64)),
            )
            vtk_index += 1
        end
        return nothing
    end
    write_due_vtk_frames!()

    checkpoints = NamedTuple[]
    dimensionless_dts = Float64[]
    next_check = min(check_interval, horizon)
    steps = 0
    status = "ok"
    termination = "horizon"
    failure_message = nothing
    wall_start = time_ns()

    while Float64(sim_time(sim)) + eps(Float64) < horizon && steps < max_steps
        Base2D.cap_free_swim_timestep!(sim, raw_dt_cap, horizon)
        dt_before = Float64(sim.flow.Δt[end]) / L
        if !(isfinite(dt_before) && dt_before > 0)
            status = "failed"
            termination = "invalid_timestep"
            failure_message = "nonfinite or nonpositive timestep before sim_step!"
            break
        end
        step_start = time_ns()
        try
            sim_step!(sim; remeasure=true)
            synchronize_backend(backend)
        catch error
            status = "failed"
            termination = "solver_error"
            failure_message = sprint(showerror, error)
            break
        end
        push!(dimensionless_dts, dt_before)
        steps += 1
        sim.flow.Δt[end] = min(T(sim.flow.Δt[end]), raw_dt_cap)
        current_time = Float64(sim_time(sim))
        write_due_vtk_frames!()

        if current_time + eps(current_time) >= next_check || current_time + eps(current_time) >= horizon
            health = field_health(sim)
            checkpoint = (
                step=steps,
                sim_time=current_time,
                dimensionless_dt=dt_before,
                step_wall_seconds=(time_ns() - step_start) / 1.0e9,
                health...,
            )
            push!(checkpoints, checkpoint)
            println(JSON.json(Base2D.jsonable(checkpoint)))
            flush(stdout)
            if !health.finite
                status = "failed"
                termination = "nonfinite_field"
                failure_message = "pressure or velocity field became nonfinite"
                break
            end
            next_check += check_interval
        end
    end
    synchronize_backend(backend)
    vtk_collection = vtk_stream === nothing ? nothing : T3D.close_free_swim_vtk_stream_3d!(vtk_stream)
    wall_seconds = (time_ns() - wall_start) / 1.0e9
    steps >= max_steps && Float64(sim_time(sim)) < horizon && begin
        status = "failed"
        termination = "max_steps"
        failure_message = "maximum step count reached before horizon"
    end

    snapshot_path = joinpath(output_root, "projected_multiwake_prewarm3d.jld2")
    if status == "ok"
        WaterLily.save!(basename(snapshot_path), sim; dir=dirname(snapshot_path))
    end
    report = (
        schema="dogfish.projected_multiwake_prewarm3d.v1",
        status,
        termination,
        failure_message,
        generated_at=Dates.format(now(), dateformat"yyyy-mm-ddTHH:MM:SS"),
        config_path,
        config_sha256=sha256_file(config_path),
        geometry_path,
        geometry_sha256=sha256_file(geometry_path),
        source_resolution=source_spec.L,
        runtime_resolution=L,
        resolution_override=source_spec.L != L,
        domain_scale_L=runtime_spec.domain_scale_L,
        domain_dims=dims,
        cell_count=prod(dims),
        target_L=runtime_spec.target_L,
        success_radius_L=runtime_spec.success_radius_L,
        Re=runtime_spec.Re,
        inflow_velocity=runtime_spec.flow_velocity_L,
        flow_perturbation=Float64(perturbation),
        flow_seed=runtime_spec.flow_seed,
        exit_bc,
        cylinder_count=length(runtime_spec.cylinder_centers_L),
        cylinder_span_mode=runtime_spec.cylinder_span_mode,
        fish_present=prewarm_with_fish,
        fish_motion=prewarm_with_fish ? "held_fixed" : "absent",
        fish_geometry="nurbs_modeler_default_body_caudal_only",
        physical_fin_x_start,
        runtime_fin_x_start=fin_x_start,
        fin_min_root_half_cells,
        fin_min_midplane_half_cells,
        fin_nominal_root_half_thickness_L=0.012,
        fin_effective_root_half_thickness_L=Float64(fin.root_half_thickness),
        fin_effective_full_thickness_cells=Float64(2 * fin.root_half_thickness * Lf),
        body_root_half_width_L,
        fin_root_midplane_half_thickness_L,
        fin_root_midplane_margin_L=body_root_half_width_L - fin_root_midplane_half_thickness_L,
        fin_no_midplane_root_protrusion=true,
        fin_connectivity_surrogate=fin_x_start != physical_fin_x_start ?
            "L16-only internal root overlap with one-cell medial web; outer root does not exceed body width" : nothing,
        fish_initial_center_L=runtime_spec.initial_center_L,
        fish_initial_heading_deg=runtime_spec.initial_heading_deg,
        fish_initial_joint_angles_deg=(phi1_deg, phi2_deg),
        material_reference_station=Float64(MATERIAL_REFERENCE_STATION),
        free_dofs=("surge_x", "sway_y", "yaw_z"),
        locked_dofs=runtime_spec.locked_dofs,
        simulation_created=true,
        backend=backend.name,
        requested_max_dimensionless_dt=max_dimensionless_dt,
        raw_dt_cap=Float64(raw_dt_cap),
        horizon,
        achieved_horizon=Float64(sim_time(sim)),
        steps,
        wall_seconds,
        ms_per_step=steps > 0 ? 1000 * wall_seconds / steps : nothing,
        min_dimensionless_dt=isempty(dimensionless_dts) ? nothing : minimum(dimensionless_dts),
        mean_dimensionless_dt=isempty(dimensionless_dts) ? nothing : sum(dimensionless_dts) / length(dimensionless_dts),
        max_dimensionless_dt=isempty(dimensionless_dts) ? nothing : maximum(dimensionless_dts),
        vtk_enabled,
        vtk_frame_count=vtk_stream === nothing ? 0 : vtk_stream.count,
        vtk_collection,
        checkpoints,
        snapshot_path=status == "ok" ? snapshot_path : nothing,
    )
    write_json(joinpath(output_root, "prewarm_report.json"), report)
    println(JSON.json(Base2D.jsonable(report)))
    status == "ok" || error("3D prewarm failed: $termination: $failure_message")
    return report
end

main()
