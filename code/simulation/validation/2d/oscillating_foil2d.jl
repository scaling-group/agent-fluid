using WaterLily
using StaticArrays
using Statistics
using Printf
using Dates
using JSON
using CUDA
using ParametricBodies

function parse_args(args)
    values = Dict{String, String}()
    for value in args
        startswith(value, "--") || error("expected --key=value, got $value")
        parts = split(value[3:end], "="; limit=2)
        length(parts) == 2 || error("expected --key=value, got $value")
        values[parts[1]] = parts[2]
    end
    values
end

arg(values, key, default, ::Type{String}) = get(values, key, default)
arg(values, key, default, ::Type{Int}) = parse(Int, get(values, key, string(default)))
arg(values, key, default, ::Type{Float64}) = parse(Float64, get(values, key, string(default)))

function force_components(force)
    force isa CUDA.CuArray && return CUDA.@allowscalar (Float64(force[1]), Float64(force[2]))
    (Float64(force[1]), Float64(force[2]))
end

@inline function moment_density(I, p, u, viscosity, body, t, center)
    T = eltype(p)
    x = WaterLily.loc(0, I, T)
    distance, unused_normal, unused_velocity = WaterLily.measure(body, x, t; fastd²=1)
    abs(distance) > one(T) && return zero(T)
    normal = WaterLily.nds(body, x, t)
    traction = p[I] * normal - T(2) * viscosity * WaterLily.S(I, u) * normal
    lever = x - center
    lever[1] * traction[2] - lever[2] * traction[1]
end

function body_on_fluid_moment(sim, center)
    t = WaterLily.time(sim.flow)
    T = eltype(sim.flow.p)
    center_t = SVector(T(center[1]), T(center[2]))
    sim.flow.σ .= zero(T)
    WaterLily.@loop sim.flow.σ[I] = moment_density(
        I, sim.flow.p, sim.flow.u, sim.flow.ν, sim.body, t, center_t,
    ) over I ∈ inside(sim.flow.p)
    raw_moment = sum(Float64, sim.flow.σ,
                     dims=ntuple(index -> index, ndims(sim.flow.σ)))[:] |> Array
    Float64(raw_moment[1])
end

function save_vorticity_frame!(vorticity, sim, output, frame_index, cycle)
    T = eltype(vorticity)
    fill!(vorticity, zero(T))
    @inside vorticity[I] = WaterLily.curl(3, I, sim.flow.u) * sim.L / sim.U
    frame_dir = joinpath(output, "vorticity_frames")
    mkpath(frame_dir)
    filename = @sprintf("vorticity_%04d.f32", frame_index)
    open(joinpath(frame_dir, filename), "w") do io
        write(io, reinterpret(UInt8, vec(Array(vorticity))))
    end
    Dict("file" => filename, "cycle" => cycle, "tU_over_c" => sim_time(sim))
end

"""Upper surface of a closed NACA0016, parameterised without a LE square-root singularity."""
@inline function naca0016_upper(s)
    T = typeof(s)
    q = one(T) - s
    T(0.8) * (
        T(0.2969) * q - T(0.1260) * q^2 - T(0.3516) * q^4 +
        T(0.2843) * q^6 - T(0.1036) * q^8
    )
end

function main(args=ARGS)
    values = parse_args(args)
    grid_L = arg(values, "L", 64, Int)
    reynolds = arg(values, "Re", 1173.0, Float64)
    amplitude_D = arg(values, "A-D", 0.7, Float64)
    strouhal_D = arg(values, "Sr", 0.2, Float64)
    motion = lowercase(arg(values, "motion", "heave", String))
    pivot_fraction = arg(values, "pivot-fraction", 0.25, Float64)
    warmup_cycles = arg(values, "warmup-cycles", 30, Int)
    sample_cycles = arg(values, "sample-cycles", 4, Int)
    samples_per_cycle = arg(values, "samples-per-cycle", 200, Int)
    grid_dt = arg(values, "grid-dt", 0.024, Float64)
    domain_x_c = arg(values, "domain-x-c", 20.0, Float64)
    domain_y_c = arg(values, "domain-y-c", 16.0, Float64)
    leading_edge_x_c = arg(values, "leading-edge-x-c", 5.0, Float64)
    backend = lowercase(arg(values, "backend", "cuda", String))
    save_vorticity = lowercase(arg(values, "save-vorticity", "false", String)) in ("1", "true", "yes")
    save_video_frames = lowercase(arg(values, "save-video-frames", "false", String)) in ("1", "true", "yes")
    video_frames_per_cycle = arg(values, "video-frames-per-cycle", 24, Int)
    output = abspath(arg(values, "output", joinpath(@__DIR__, "runs", "L$(grid_L)_AD$(amplitude_D)_Sr$(strouhal_D)"), String))

    grid_L > 0 || error("L must be positive")
    reynolds > 0 || error("Re must be positive")
    amplitude_D >= 0 || error("A-D must be nonnegative")
    strouhal_D > 0 || error("Sr must be positive")
    motion in ("heave", "pitch") || error("motion must be heave or pitch")
    0 <= pivot_fraction < 1 || error("pivot-fraction must lie in [0,1)")
    warmup_cycles >= 0 || error("warmup-cycles must be nonnegative")
    sample_cycles > 0 || error("sample-cycles must be positive")
    samples_per_cycle > 0 || error("samples-per-cycle must be positive")
    grid_dt > 0 || error("grid-dt must be positive")
    backend in ("cpu", "cuda") || error("backend must be cpu or cuda")
    video_frames_per_cycle > 0 || error("video-frames-per-cycle must be positive")
    mkpath(output)

    T = Float32
    Lf = T(grid_L)
    U = one(T)
    thickness_ratio = T(0.16)
    thickness = thickness_ratio * Lf
    heave_amplitude = T(amplitude_D) * thickness / T(2)
    pitch_argument = T(amplitude_D) * thickness_ratio / (T(2) * (one(T) - T(pivot_fraction)))
    pitch_argument <= one(T) || error("A-D is too large for the selected pitch pivot")
    pitch_amplitude = asin(pitch_argument)
    frequency = T(strouhal_D) * U / thickness
    period_raw = inv(frequency)
    period_convective = Float64(thickness_ratio / T(strouhal_D))
    viscosity = U * Lf / T(reynolds)
    phase_dt = grid_dt / Float64(period_raw)
    dimensions = (
        round(Int, domain_x_c * grid_L),
        round(Int, domain_y_c * grid_L),
    )
    origin = SVector(T(leading_edge_x_c) * Lf, T(domain_y_c / 2) * Lf)
    pivot_local = SVector(T(pivot_fraction) * Lf, zero(T))
    pivot_lab = origin + pivot_local
    memory = backend == "cuda" ? CUDA.CuArray : Array
    backend == "cuda" && !CUDA.functional() && error("CUDA is not functional")
    is_pitch = motion == "pitch"

    foil(s, t) = Lf * SVector((one(s) - s)^2, naca0016_upper(s))
    angular_frequency = T(2pi) * frequency
    body_map = let origin=origin, heave_amplitude=heave_amplitude,
                   pitch_amplitude=pitch_amplitude, angular_frequency=angular_frequency,
                   is_pitch=is_pitch, pivot_local=pivot_local, pivot_lab=pivot_lab
        (x, t) -> begin
            phase = angular_frequency * t
            if is_pitch
                theta = pitch_amplitude * sin(phase)
                c, s = cos(theta), sin(theta)
                delta = x - pivot_lab
                ξ = pivot_local + SVector(c * delta[1] + s * delta[2], -s * delta[1] + c * delta[2])
            else
                heave = heave_amplitude * sin(phase)
                ξ = x - origin - SVector(zero(x[1]), heave)
            end
            SVector(ξ[1], abs(ξ[2]))
        end
    end
    body = HashedBody(foil, (zero(T), one(T)); map=body_map, T, mem=memory)
    builder = () -> Simulation(
        dimensions, (U, zero(T)), grid_L;
        U, ν=viscosity, body, T, mem=memory, Δt=T(grid_dt), exitBC=true,
    )
    sim = backend == "cuda" ? Base.invokelatest(builder) : builder()

    @printf("Lagopoulos 2019 NACA0016: motion=%s L=%d Re=%.0f A_D=%.4f Sr=%.4f\n",
            motion, grid_L, reynolds, amplitude_D, strouhal_D)
    @printf("h0/c=%.6f theta0=%.6fdeg pivot=%.3fc f*c/U=%.6f period*U/c=%.6f domain=%.1fc x %.1fc backend=%s\n",
            Float64(heave_amplitude / Lf), rad2deg(Float64(pitch_amplitude)), pivot_fraction,
            Float64(frequency * Lf / U),
            period_convective, domain_x_c, domain_y_c, backend)

    integration_steps = 0
    minimum_cfl_ratio = Inf
    initial_cfl_dt = Float64(WaterLily.CFL(sim.flow))
    function fixed_step!()
        cfl_dt = integration_steps == 0 ? initial_cfl_dt : Float64(sim.flow.Δt[end])
        ratio = cfl_dt / grid_dt
        minimum_cfl_ratio = min(minimum_cfl_ratio, ratio)
        ratio >= 1 || error(@sprintf("fixed grid dt %.8g exceeds CFL limit %.8g", grid_dt, cfl_dt))
        sim.flow.Δt[end] = T(grid_dt)
        sim_step!(sim; remeasure=true)
        integration_steps += 1
    end

    wall_start = time()
    warmup_steps = ceil(Int, warmup_cycles / phase_dt)
    for _ in 1:warmup_steps
        fixed_step!()
    end
    @printf("warmup complete: cycles=%.4f tU/c=%.6f steps=%d wall=%.1fs\n",
            warmup_steps * phase_dt, sim_time(sim), warmup_steps, time() - wall_start)

    sample_stride = max(1, round(Int, inv(phase_dt * samples_per_cycle)))
    sample_steps = ceil(Int, sample_cycles / phase_dt)
    norm = T(0.5) * U^2 * Lf
    times = Float64[]
    cycles = Float64[]
    thrust = Float64[]
    lift = Float64[]
    pressure_thrust = Float64[]
    viscous_thrust = Float64[]
    pressure_lift = Float64[]
    viscous_lift = Float64[]
    moment = Float64[]
    input_power = Float64[]
    video_frames = Vector{Dict{String, Any}}()
    video_vorticity = save_video_frames ? similar(sim.flow.σ) : nothing
    video_stride = max(1, round(Int, inv(phase_dt * video_frames_per_cycle)))

    for sample_step in 1:sample_steps
        fixed_step!()
        common_cycle = (warmup_steps + sample_step) * phase_dt
        if save_video_frames && common_cycle >= warmup_cycles + sample_cycles - 1 &&
           (sample_step - 1) % video_stride == 0
            push!(video_frames, save_vorticity_frame!(
                video_vorticity, sim, output, length(video_frames) + 1, common_cycle,
            ))
        end
        (sample_step - 1) % sample_stride == 0 || continue
        pfx, pfy = force_components(WaterLily.pressure_force(sim))
        vfx, vfy = force_components(WaterLily.viscous_force(sim))
        raw_moment = body_on_fluid_moment(sim, pivot_lab)
        phase = angular_frequency * WaterLily.time(sim.flow)
        heave_velocity = is_pitch ? zero(T) : heave_amplitude * angular_frequency * cos(phase)
        pitch_velocity = is_pitch ? pitch_amplitude * angular_frequency * cos(phase) : zero(T)
        moment_coefficient = raw_moment / (Float64(norm) * Float64(Lf))
        power_coefficient = ((pfy + vfy) / Float64(norm)) * Float64(heave_velocity / U) +
                            moment_coefficient * Float64(pitch_velocity * Lf / U)
        push!(times, common_cycle * period_convective)
        push!(cycles, common_cycle)
        push!(thrust, (pfx + vfx) / norm)
        push!(lift, -(pfy + vfy) / norm)
        push!(pressure_thrust, pfx / norm)
        push!(viscous_thrust, vfx / norm)
        push!(pressure_lift, -pfy / norm)
        push!(viscous_lift, -vfy / norm)
        push!(moment, moment_coefficient)
        push!(input_power, power_coefficient)
    end

    csv_path = joinpath(output, "force_history.csv")
    open(csv_path, "w") do io
        println(io, "tU_over_c,cycle,C_T,C_L,C_T_pressure,C_T_viscous,C_L_pressure,C_L_viscous,C_M_body_on_fluid,C_P_input")
        for i in eachindex(times)
            @printf(io, "%.8f,%.8f,%.10f,%.10f,%.10f,%.10f,%.10f,%.10f,%.10f,%.10f\n",
                    times[i], cycles[i], thrust[i], lift[i], pressure_thrust[i],
                    viscous_thrust[i], pressure_lift[i], viscous_lift[i],
                    moment[i], input_power[i])
        end
    end

    mean_input_power = mean(input_power)
    efficiency = mean(thrust) / mean_input_power

    summary = Dict{String, Any}(
        "schema_version" => "waterlily_validation.lagopoulos2019_flapping.v1",
        "generated_at" => string(now()),
        "reference" => "Lagopoulos, Weymouth & Ganapathisubramani, JFM 872, R1 (2019)",
        "motion" => motion,
        "foil" => "NACA0016",
        "grid_L" => grid_L,
        "Re" => reynolds,
        "A_D" => amplitude_D,
        "Sr" => strouhal_D,
        "St_A" => amplitude_D * strouhal_D,
        "heave_amplitude_over_c" => Float64(heave_amplitude / Lf),
        "pitch_amplitude_degrees" => rad2deg(Float64(pitch_amplitude)),
        "pivot_fraction" => pivot_fraction,
        "frequency_c_over_U" => Float64(frequency * Lf / U),
        "period_tU_over_c" => period_convective,
        "domain_c" => [domain_x_c, domain_y_c],
        "leading_edge_x_c" => leading_edge_x_c,
        "warmup_cycles" => warmup_cycles,
        "sample_cycles" => sample_cycles,
        "fixed_grid_dt" => grid_dt,
        "fixed_phase_dt" => phase_dt,
        "sample_stride_steps" => sample_stride,
        "minimum_cfl_to_fixed_dt_ratio" => minimum_cfl_ratio,
        "force_convention" => "CT=(pressure_force_x+viscous_force_x)/(0.5*rho*U^2*c)",
        "moment_convention" => "CM is the body-on-fluid moment about the prescribed pivot divided by 0.5*rho*U^2*c^2",
        "power_convention" => "CP_input=(F_body_on_fluid_y*hdot+M_body_on_fluid*thetadot)/(0.5*rho*U^3*c)",
        "efficiency_convention" => "eta=mean_CT/mean_CP_input, following Wang et al., JFM 984 A9 (2024)",
        "mean_C_T" => mean(thrust),
        "mean_C_T_pressure" => mean(pressure_thrust),
        "mean_C_T_viscous" => mean(viscous_thrust),
        "minimum_C_T" => minimum(thrust),
        "maximum_C_T" => maximum(thrust),
        "peak_to_peak_C_T" => maximum(thrust) - minimum(thrust),
        "mean_C_L" => mean(lift),
        "rms_C_L" => sqrt(mean(abs2, lift)),
        "mean_C_M_body_on_fluid" => mean(moment),
        "mean_C_P_input" => mean_input_power,
        "propulsive_efficiency" => efficiency,
        "wall_seconds" => time() - wall_start,
        "trace_csv" => basename(csv_path),
        "alignment_note" => "Physical foil, Re, Sr, A_D, no-slip condition and force normalisation match the paper. The paper does not report domain dimensions or stretching function; this run uses a uniform WaterLily domain with convective outlet.",
    )
    if save_vorticity
        vorticity = similar(sim.flow.σ)
        # `@inside` excludes halo cells.  Initialise the full allocation so the
        # archived binary is deterministic across devices and contains no
        # meaningless uninitialised values outside the physical interior.
        fill!(vorticity, zero(T))
        @inside vorticity[I] = WaterLily.curl(3, I, sim.flow.u) * sim.L / sim.U
        host_vorticity = Array(vorticity)
        vorticity_path = joinpath(output, "vorticity_final.f32")
        open(vorticity_path, "w") do io
            write(io, reinterpret(UInt8, vec(host_vorticity)))
        end
        summary["vorticity_snapshot"] = Dict(
            "file" => basename(vorticity_path),
            "array_shape" => collect(size(vorticity)),
            "array_order" => "Julia column-major",
            "dtype" => "Float32 little-endian",
            "phase_cycles" => cycles[end],
        )
    end
    if save_video_frames
        summary["vorticity_video_frames"] = Dict(
            "directory" => "vorticity_frames",
            "array_shape" => collect(size(video_vorticity)),
            "array_order" => "Julia column-major",
            "dtype" => "Float32 little-endian",
            "frames_per_cycle_requested" => video_frames_per_cycle,
            "frames" => video_frames,
        )
    end
    summary_path = joinpath(output, "summary.json")
    open(summary_path, "w") do io
        JSON.print(io, summary, 2)
        println(io)
    end
    @printf("mean_CT=%+.6f pressure=%+.6f viscous=%+.6f range=[%+.6f,%+.6f]\n",
            mean(thrust), mean(pressure_thrust), mean(viscous_thrust),
            minimum(thrust), maximum(thrust))
    @printf("mean_CP_input=%+.6f eta=%+.6f mean_CM=%+.6f\n",
            mean_input_power, efficiency, mean(moment))
    @printf("trace=%s\nsummary=%s\n", csv_path, summary_path)
end

main()
