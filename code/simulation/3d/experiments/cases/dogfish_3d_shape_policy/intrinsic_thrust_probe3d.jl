# Tethered open-loop thrust audit for the strict 3D dogfish.
#
# This is deliberately policy-free and obstacle-free.  The material reference
# at s=1/3 is held fixed while the two-joint gait deforms the fish in quiescent
# water.  Surface loads are integrated in material-coordinate bins and split
# into pressure and viscous contributions.  It is the first gate for any 3D
# policy rollout: a straight gait must create positive mean forward thrust.

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
const MATERIAL_REFERENCE_STATION = 1f0 / 3f0
const AXIAL_BINS = (
    (name="head",             lower=-0.25f0, upper=0.25f0),
    (name="anterior_midbody", lower=0.25f0,  upper=0.50f0),
    (name="posterior_body",   lower=0.50f0,  upper=0.70f0),
    (name="peduncle",         lower=0.70f0,  upper=0.80f0),
    (name="caudal_root",      lower=0.80f0,  upper=0.92f0),
    (name="caudal_outer",     lower=0.92f0,  upper=1.30f0),
)

env_string(name, default) = (value = strip(get(ENV, name, "")); isempty(value) ? default : value)
env_int(name, default) = (value = strip(get(ENV, name, "")); isempty(value) ? default : parse(Int, value))
env_float(name, default) = (value = strip(get(ENV, name, "")); isempty(value) ? default : parse(Float64, value))

@inline function sine_gait_bend_angle(s, t, p)
    t_sim = (t - p.reference_time) * p.inv_L
    ramp = Base2D.smootherstep01(t_sim / (p.ramp_periods * p.period))
    omega = 2 * typeof(t_sim)(pi) / p.period
    phi1 = ramp * p.amp1 * sin(omega * t_sim)
    phi2 = ramp * p.amp2 * sin(omega * t_sim - p.phase_lag)
    return phi1 * Base2D.distributed_joint_step(s, p.center1, p.half_width1) +
        phi2 * Base2D.distributed_joint_step(s, p.center2, p.half_width2)
end

# Unlike FreeSwimmingSpineMap3D, this map evaluates the deformed material
# reference at every time.  The station s=1/3 therefore remains exactly fixed
# in the laboratory frame throughout the tethered experiment.
struct TetheredSpineMap3D{T, P} <: Function
    params::P
    Lf::T
    center::SVector{2, T}
    z_plane::T
    reference_station::T
end

@inline function (map::TetheredSpineMap3D)(x, t)
    spine = Base2D.SpineMotionMap(sine_gait_bend_angle, map.params, map.Lf)
    local_reference = Base2D.spine_centerline(spine, map.reference_station, t)
    q = SVector(x[1] - map.center[1], x[2] - map.center[2]) + local_reference
    material = Base2D.closest_spine_reference_coordinate(spine, q, t)
    return SVector(material[1], material[2], x[3] - map.z_plane)
end

function gait_params(::Type{T}, L; phase_lag_deg, period, amp1_deg, amp2_deg, ramp_periods) where {T}
    return (
        amp1=T(amp1_deg * DEG),
        amp2=T(amp2_deg * DEG),
        phase_lag=T(phase_lag_deg * DEG),
        period=T(period),
        ramp_periods=T(ramp_periods),
        center1=T(1 / 3),
        center2=T(2 / 3),
        half_width1=T(1 / 8),
        half_width2=T(1 / 8),
        reference_time=zero(T),
        inv_L=inv(T(L)),
    )
end

function gait_kinematic_metrics(params, L, cycles; samples=128)
    T = typeof(params.amp1)
    Lf = T(L)
    spine = Base2D.SpineMotionMap(sine_gait_bend_angle, params, Lf)
    tail_offsets = Float64[]
    tail_angles = Float64[]
    cycle_start = max(0.0, cycles - 1.0) * Float64(params.period)
    for index in 0:(samples - 1)
        dimensionless_time = cycle_start + index / samples * Float64(params.period)
        raw_time = T(dimensionless_time * L)
        reference = Base2D.spine_centerline(spine, T(MATERIAL_REFERENCE_STATION), raw_time)
        tail = Base2D.spine_centerline(spine, one(T), raw_time)
        push!(tail_offsets, Float64((tail - reference)[2] / Lf))
        push!(tail_angles, Float64(sine_gait_bend_angle(one(T), raw_time, params)))
    end
    phase_fraction = abs(Float64(params.phase_lag)) / (2pi)
    joint_separation_L = Float64(params.center2 - params.center1)
    wavelength_L = phase_fraction > 0 ? joint_separation_L / phase_fraction : nothing
    wave_speed_L = phase_fraction > 0 ?
        sign(Float64(params.phase_lag)) * joint_separation_L /
        (phase_fraction * Float64(params.period)) : nothing
    return (
        material_tail_peak_to_peak_amplitude_L=maximum(tail_offsets) - minimum(tail_offsets),
        material_tail_offset_range_L=(minimum(tail_offsets), maximum(tail_offsets)),
        maximum_absolute_tail_tangent_angle_deg=maximum(abs, tail_angles) / DEG,
        effective_two_joint_wavelength_L=wavelength_L,
        effective_two_joint_wave_speed_L_per_dimensionless_time=wave_speed_L,
    )
end

function posterior_two_cell_body(Lf::T) where {T}
    # Numerical hydrodynamic surrogate only: keep the modeler head/anterior
    # samples, but prevent the posterior sample stations from becoming thinner
    # than two full grid cells.  The physical dry-mass model is not changed.
    floor_half_width = one(T) / Lf
    samples = ntuple(length(T3D.BODY_W_SAMPLES)) do index
        value = T(T3D.BODY_W_SAMPLES[index])
        index in (4, 5, 6) ? max(value, floor_half_width) : value
    end
    return T3D.dogfish_body_sdf(Lf; w_samples=samples)
end

function variant_spec(name::AbstractString, Lf::T) where {T}
    body = T3D.dogfish_body_sdf(Lf)
    phase_lag_deg = 85.0
    fin_span_scale = 1.0
    hydrodynamic_surrogate = "none"
    fin_x_start = env_float("DOGFISH3D_THRUST_FIN_X_START", 0.80)
    fin_min_root_half_cells = env_float(
        "DOGFISH3D_THRUST_FIN_MIN_ROOT_HALF_CELLS",
        Lf >= T(32) ? 1.0 : 0.0,
    )
    fin_min_midplane_half_cells = env_float(
        "DOGFISH3D_THRUST_FIN_MIN_MIDPLANE_HALF_CELLS",
        0.0,
    )
    if name == "reverse_wave"
        phase_lag_deg = -85.0
    elseif name == "span_1p5"
        fin_span_scale = 1.5
    elseif name == "posterior_2cell"
        body = posterior_two_cell_body(Lf)
        hydrodynamic_surrogate = "posterior lateral half-width >= 1 grid cell at samples 4:6"
    elseif name == "span_1p5_posterior_2cell"
        body = posterior_two_cell_body(Lf)
        fin_span_scale = 1.5
        hydrodynamic_surrogate = "posterior lateral half-width >= 1 grid cell at samples 4:6"
    elseif name != "baseline"
        error("unknown variant `$name`")
    end
    fin = T3D.modeler_caudal_fin(
        body;
        x_start=fin_x_start,
        upper_height=0.13 * fin_span_scale,
        lower_height=0.09 * fin_span_scale,
        min_root_half_cells=fin_min_root_half_cells,
        min_midplane_half_cells=fin_min_midplane_half_cells,
    )
    return (;
        name,
        body,
        fin,
        phase_lag_deg,
        fin_span_scale,
        fin_x_start,
        fin_min_root_half_cells,
        fin_min_midplane_half_cells,
        hydrodynamic_surrogate,
    )
end

# Kind: 1 pressure force on body, 2 viscous force on body, 3 body-to-fluid
# surface power.  WaterLily's pressure/viscous metrics integrate fluid-oriented
# traction, hence the minus sign for body force.  Positive power means the
# prescribed body motion is doing work on the fluid.
@inline function binned_surface_density(
    I, p, u, nu, body, t, lower, upper, ::Val{Axis}, ::Val{Kind},
) where {Axis, Kind}
    Tp = eltype(p)
    x = WaterLily.loc(0, I, Tp)
    map = body.a.map
    material = map(x, t)
    station = material[1] / map.Lf
    (Tp(lower) <= station < Tp(upper)) || return zero(Tp)
    d, unused_normal, surface_velocity = WaterLily.measure(body, x, t, fastd²=one(Tp))
    abs(d) <= one(Tp) || return zero(Tp)
    n = WaterLily.nds(body, x, t)
    pressure_traction = p[I] * n
    viscous_traction = -2 * nu * WaterLily.S(I, u) * n
    if Kind == 1
        return -pressure_traction[Axis]
    elseif Kind == 2
        return -viscous_traction[Axis]
    end
    return sum((pressure_traction + viscous_traction) .* surface_velocity)
end

function binned_integral(sim, body, bin, axis::Int, kind::Int)
    Tp = eltype(sim.flow.p)
    To = promote_type(Float64, Tp)
    t = WaterLily.time(sim.flow)
    sim.flow.σ .= zero(Tp)
    if axis == 1
        if kind == 1
            WaterLily.@loop sim.flow.σ[I] = binned_surface_density(
                I, sim.flow.p, sim.flow.u, sim.flow.ν, body,
                t, bin.lower, bin.upper, Val(1), Val(1),
            ) over I in WaterLily.inside(sim.flow.p)
        elseif kind == 2
            WaterLily.@loop sim.flow.σ[I] = binned_surface_density(
                I, sim.flow.p, sim.flow.u, sim.flow.ν, body,
                t, bin.lower, bin.upper, Val(1), Val(2),
            ) over I in WaterLily.inside(sim.flow.p)
        else
            WaterLily.@loop sim.flow.σ[I] = binned_surface_density(
                I, sim.flow.p, sim.flow.u, sim.flow.ν, body,
                t, bin.lower, bin.upper, Val(1), Val(3),
            ) over I in WaterLily.inside(sim.flow.p)
        end
    elseif axis == 2
        if kind == 1
            WaterLily.@loop sim.flow.σ[I] = binned_surface_density(
                I, sim.flow.p, sim.flow.u, sim.flow.ν, body,
                t, bin.lower, bin.upper, Val(2), Val(1),
            ) over I in WaterLily.inside(sim.flow.p)
        else
            WaterLily.@loop sim.flow.σ[I] = binned_surface_density(
                I, sim.flow.p, sim.flow.u, sim.flow.ν, body,
                t, bin.lower, bin.upper, Val(2), Val(2),
            ) over I in WaterLily.inside(sim.flow.p)
        end
    else
        if kind == 1
            WaterLily.@loop sim.flow.σ[I] = binned_surface_density(
                I, sim.flow.p, sim.flow.u, sim.flow.ν, body,
                t, bin.lower, bin.upper, Val(3), Val(1),
            ) over I in WaterLily.inside(sim.flow.p)
        else
            WaterLily.@loop sim.flow.σ[I] = binned_surface_density(
                I, sim.flow.p, sim.flow.u, sim.flow.ν, body,
                t, bin.lower, bin.upper, Val(3), Val(2),
            ) over I in WaterLily.inside(sim.flow.p)
        end
    end
    value = sum(To, sim.flow.σ, dims=ntuple(identity, ndims(sim.flow.σ)))[:] |> Array
    return Float64(value[1])
end

function sample_loads(sim, body, L)
    scale = Float64(L)^2
    bins = Base.map(AXIAL_BINS) do bin
        pressure = ntuple(axis -> binned_integral(sim, body, bin, axis, 1) / scale, 3)
        viscous = ntuple(axis -> binned_integral(sim, body, bin, axis, 2) / scale, 3)
        power = binned_integral(sim, body, bin, 1, 3) / scale
        return (
            name=bin.name,
            range=(Float64(bin.lower), Float64(bin.upper)),
            pressure_body_force=pressure,
            viscous_body_force=viscous,
            input_power=power,
        )
    end
    direct_pressure = Tuple(-Float64(value) / scale for value in WaterLily.pressure_force(sim.flow, body))
    direct_viscous = Tuple(-Float64(value) / scale for value in WaterLily.viscous_force(sim.flow, body))
    binned_pressure = ntuple(axis -> sum(bin.pressure_body_force[axis] for bin in bins), 3)
    binned_viscous = ntuple(axis -> sum(bin.viscous_body_force[axis] for bin in bins), 3)
    return (
        bins=bins,
        direct_pressure_body_force_coefficient=direct_pressure,
        direct_viscous_body_force_coefficient=direct_viscous,
        pressure_closure_error=ntuple(axis -> binned_pressure[axis] - direct_pressure[axis], 3),
        viscous_closure_error=ntuple(axis -> binned_viscous[axis] - direct_viscous[axis], 3),
    )
end

tuple_add(a, b) = ntuple(i -> a[i] + b[i], length(a))
tuple_scale(a, scale) = ntuple(i -> a[i] * scale, length(a))

function summarize_samples(samples, average_start, average_end)
    # Never include a sample at the terminal time: a tiny floating-point
    # remainder step can corrupt the pressure projection at that instant.
    selected = [
        sample for sample in samples
        if sample.time >= average_start && sample.time < average_end - 1e-6
    ]
    isempty(selected) && error("no diagnostic samples in averaging window")
    n = length(selected)
    bin_summaries = map(eachindex(AXIAL_BINS)) do index
        pressure = (0.0, 0.0, 0.0)
        viscous = (0.0, 0.0, 0.0)
        power = 0.0
        for sample in selected
            load = sample.bins[index]
            pressure = tuple_add(pressure, load.pressure_body_force)
            viscous = tuple_add(viscous, load.viscous_body_force)
            power += load.input_power
        end
        return (
            name=AXIAL_BINS[index].name,
            range=(Float64(AXIAL_BINS[index].lower), Float64(AXIAL_BINS[index].upper)),
            mean_pressure_body_force_coefficient=tuple_scale(pressure, 1 / n),
            mean_viscous_body_force_coefficient=tuple_scale(viscous, 1 / n),
            mean_input_power_coefficient=power / n,
        )
    end
    total_pressure = (0.0, 0.0, 0.0)
    total_viscous = (0.0, 0.0, 0.0)
    total_power = 0.0
    for bin in bin_summaries
        total_pressure = tuple_add(total_pressure, bin.mean_pressure_body_force_coefficient)
        total_viscous = tuple_add(total_viscous, bin.mean_viscous_body_force_coefficient)
        total_power += bin.mean_input_power_coefficient
    end
    total_force = tuple_add(total_pressure, total_viscous)
    forward_thrust = -total_force[1] # the dogfish head is material -x
    caudal_forward = -sum(
        bin.mean_pressure_body_force_coefficient[1] + bin.mean_viscous_body_force_coefficient[1]
        for bin in bin_summaries if bin.name in ("caudal_root", "caudal_outer")
    )
    max_pressure_closure_error = maximum(
        maximum(abs, sample.pressure_closure_error) for sample in selected
    )
    max_viscous_closure_error = maximum(
        maximum(abs, sample.viscous_closure_error) for sample in selected
    )
    mean_pressure_closure_error = ntuple(
        axis -> mean(sample.pressure_closure_error[axis] for sample in selected), 3
    )
    mean_viscous_closure_error = ntuple(
        axis -> mean(sample.viscous_closure_error[axis] for sample in selected), 3
    )
    return (
        sample_count=n,
        bins=bin_summaries,
        mean_pressure_body_force_coefficient=total_pressure,
        mean_viscous_body_force_coefficient=total_viscous,
        mean_total_body_force_coefficient=total_force,
        mean_forward_thrust_coefficient=forward_thrust,
        mean_input_power_coefficient=total_power,
        caudal_forward_thrust_coefficient=caudal_forward,
        caudal_fraction_of_forward_thrust=abs(forward_thrust) > 1e-12 ? caudal_forward / forward_thrust : nothing,
        max_pressure_bin_closure_error=max_pressure_closure_error,
        max_viscous_bin_closure_error=max_viscous_closure_error,
        mean_pressure_bin_closure_error=mean_pressure_closure_error,
        mean_viscous_bin_closure_error=mean_viscous_closure_error,
        intrinsic_thrust_gate_passed=forward_thrust > 0,
    )
end

function run_variant(name; L, backend_name, cycles, period, dt, Re, inflow, samples_per_cycle, output_root)
    T = Float32
    Lf = T(L)
    spec = variant_spec(name, Lf)
    params = gait_params(
        T, L;
        phase_lag_deg=spec.phase_lag_deg,
        period,
        amp1_deg=env_float("DOGFISH3D_THRUST_AMP1_DEG", 20.0),
        amp2_deg=env_float("DOGFISH3D_THRUST_AMP2_DEG", 26.0),
        ramp_periods=env_float("DOGFISH3D_THRUST_RAMP_PERIODS", 0.6),
    )
    domain_scale = (
        env_float("DOGFISH3D_THRUST_DOMAIN_X", 4.5),
        env_float("DOGFISH3D_THRUST_DOMAIN_Y", 3.0),
        env_float("DOGFISH3D_THRUST_DOMAIN_Z", 2.0),
    )
    dims = Tuple(max(8, round(Int, scale * L)) for scale in domain_scale)
    center = SVector(T(1.5 * L), T(1.5 * L))
    z_plane = T(domain_scale[3] * L / 2)
    tether_map = TetheredSpineMap3D(params, Lf, center, z_plane, T(MATERIAL_REFERENCE_STATION))
    fish_body = T3D.compose_body_3d(spec.body, tether_map, spec.fin)
    backend = Base2D.resolve_memory_backend(backend=backend_name)
    raw_dt_cap = T(dt * L)
    builder = () -> Simulation(
        dims,
        (T(inflow), zero(T), zero(T)),
        L;
        U=one(T),
        Δt=raw_dt_cap,
        ν=Lf / T(Re),
        body=fish_body,
        T,
        mem=backend.mem,
    )
    sim = backend.name == "cuda" ? Base.invokelatest(builder) : builder()

    end_time = cycles * period
    sample_interval = period / samples_per_cycle
    next_sample = 0.0
    samples = NamedTuple[]
    steps = 0
    wall_start = time_ns()
    while Float64(Base2D.sim_time(sim)) < end_time - 1e-8
        current = Float64(Base2D.sim_time(sim))
        if current + 1e-8 >= next_sample
            loads = sample_loads(sim, fish_body, L)
            push!(samples, (time=current, loads...))
            next_sample += sample_interval
        end
        target_raw = T(end_time * L)
        remaining = target_raw - T(WaterLily.time(sim.flow))
        remaining > eps(T) || break
        sim.flow.Δt[end] = min(T(sim.flow.Δt[end]), raw_dt_cap, remaining)
        sim_step!(sim; remeasure=true)
        sim.flow.Δt[end] = min(T(sim.flow.Δt[end]), raw_dt_cap)
        steps += 1
    end
    final_time = Float64(Base2D.sim_time(sim))
    wall_seconds = (time_ns() - wall_start) / 1e9
    average_cycles = min(env_float("DOGFISH3D_THRUST_AVERAGE_CYCLES", 2.0), cycles)
    summary = summarize_samples(samples, end_time - average_cycles * period, end_time)
    report = (
        schema="dogfish.intrinsic_thrust_probe3d.v1",
        status="ok",
        variant=name,
        grid_L=L,
        backend=backend.name,
        dimensions=dims,
        cell_count=prod(dims),
        Re,
        max_dimensionless_dt=dt,
        cycles,
        period,
        phase_lag_deg=spec.phase_lag_deg,
        amplitudes_deg=(Float64(params.amp1 / DEG), Float64(params.amp2 / DEG)),
        kinematic_metrics=gait_kinematic_metrics(params, L, cycles),
        fin_span_scale=spec.fin_span_scale,
        fin_x_start=spec.fin_x_start,
        fin_min_root_half_cells=spec.fin_min_root_half_cells,
        fin_min_midplane_half_cells=spec.fin_min_midplane_half_cells,
        fin_effective_full_root_thickness_cells=Float64(2 * spec.fin.root_half_thickness * Lf),
        hydrodynamic_surrogate=spec.hydrodynamic_surrogate,
        material_reference_station=Float64(MATERIAL_REFERENCE_STATION),
        rigid_motion="tethered: x/y/yaw fixed; heave/roll/pitch fixed",
        fluid=inflow == 0 ? "quiescent" : "uniform +x inflow (head-to-tail in the tethered body frame)",
        inflow_velocity_L=T(inflow),
        steps,
        wall_seconds,
        ms_per_step=1000 * wall_seconds / max(steps, 1),
        averaging_window=(end_time - average_cycles * period, end_time),
        terminal_sample_policy="excluded; all loads sampled before a nondegenerate flow step",
        summary...,
        samples=samples,
    )
    variant_root = joinpath(output_root, name)
    mkpath(variant_root)
    open(joinpath(variant_root, "intrinsic_thrust_report.json"), "w") do io
        JSON.print(io, Base2D.jsonable(report), 2)
        println(io)
    end
    @printf(
        "%-28s gate=%-5s CT_forward=%+.6f  CT_pressure_x=%+.6f  CT_viscous_x=%+.6f  CP=%+.6f  %.1f ms/step\n",
        name,
        summary.intrinsic_thrust_gate_passed,
        summary.mean_forward_thrust_coefficient,
        summary.mean_pressure_body_force_coefficient[1],
        summary.mean_viscous_body_force_coefficient[1],
        summary.mean_input_power_coefficient,
        report.ms_per_step,
    )
    return report
end

function main()
    L = env_int("DOGFISH3D_THRUST_L", 16)
    backend = env_string("DOGFISH_MEMORY_BACKEND", "auto")
    cycles = env_float("DOGFISH3D_THRUST_CYCLES", 3.0)
    period = env_float("DOGFISH3D_THRUST_PERIOD", 1.1)
    dt = env_float("DOGFISH3D_THRUST_DT", 0.011)
    Re = env_float("DOGFISH3D_THRUST_RE", 1000.0)
    inflow = env_float("DOGFISH3D_THRUST_INFLOW", 0.0)
    inflow_list = strip(get(ENV, "DOGFISH3D_THRUST_INFLOWS", ""))
    inflows = isempty(inflow_list) ? [inflow] : parse.(Float64, strip.(split(inflow_list, ',')))
    samples_per_cycle = env_int("DOGFISH3D_THRUST_SAMPLES_PER_CYCLE", 16)
    output_root = abspath(env_string(
        "DOGFISH3D_THRUST_OUTPUT",
        joinpath(case_dir, "logs", "intrinsic_thrust_probe3d_L$(L)"),
    ))
    variants = filter(item -> !isempty(item), strip.(split(env_string(
        "DOGFISH3D_THRUST_VARIANTS",
        "baseline,reverse_wave,span_1p5,posterior_2cell,span_1p5_posterior_2cell",
    ), ',')))
    mkpath(output_root)
    reports = NamedTuple[]
    for flow_speed in inflows
        flow_label = replace(@sprintf("U%.3f", flow_speed), "-" => "m", "." => "p")
        flow_root = length(inflows) == 1 ? output_root : joinpath(output_root, flow_label)
        for name in variants
            push!(reports, run_variant(
                name;
                L,
                backend_name=backend,
                cycles,
                period,
                dt,
                Re,
                inflow=flow_speed,
                samples_per_cycle,
                output_root=flow_root,
            ))
        end
    end
    comparison = (
        schema="dogfish.intrinsic_thrust_comparison3d.v1",
        generated_variants=variants,
        inflows,
        reports=[(
            variant=report.variant,
            inflow_velocity_L=report.inflow_velocity_L,
            forward_thrust_coefficient=report.mean_forward_thrust_coefficient,
            pressure_body_force_coefficient=report.mean_pressure_body_force_coefficient,
            viscous_body_force_coefficient=report.mean_viscous_body_force_coefficient,
            input_power_coefficient=report.mean_input_power_coefficient,
            caudal_fraction=report.caudal_fraction_of_forward_thrust,
            gate_passed=report.intrinsic_thrust_gate_passed,
        ) for report in reports],
    )
    open(joinpath(output_root, "intrinsic_thrust_comparison.json"), "w") do io
        JSON.print(io, Base2D.jsonable(comparison), 2)
        println(io)
    end
    return comparison
end

main()
