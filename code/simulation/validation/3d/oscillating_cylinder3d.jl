using WaterLily
using StaticArrays
using CUDA
using Random
using JSON
using Printf
using Statistics
using Dates

CUDA.allowscalar(false)

env_int(name, default) = parse(Int, get(ENV, name, string(default)))
env_float(name, default) = parse(Float64, get(ENV, name, string(default)))
env_string(name, default) = get(ENV, name, default)

function trapz_average(t, y)
    length(t) == length(y) || error("time/value length mismatch")
    length(t) >= 2 || return NaN
    duration = t[end] - t[1]
    duration > 0 || return NaN
    integral = sum((t[i + 1] - t[i]) * (y[i + 1] + y[i]) / 2 for i in 1:length(t)-1)
    return integral / duration
end

function cylinder_kinematics(t, n, D, U, Vr, Ax_D, Ay_D, theta)
    omega = 2pi * U / (Vr * D)
    dx = Ax_D * D * sin(2omega * t + theta)
    dy = Ay_D * D * sin(omega * t)
    vx = 2omega * Ax_D * D * cos(2omega * t + theta)
    vy = omega * Ay_D * D * cos(omega * t)
    return (x=n + dx, y=n + dy, vx=vx, vy=vy)
end

function extract_midplane_vorticity(sim, D, U)
    u = sim.flow.u
    k = cld(size(u, 3), 2)
    plane = Array(@view u[:, :, k, 1:2])
    nx, ny = size(u, 1) - 2, size(u, 2) - 2
    omega_z = Matrix{Float32}(undef, nx, ny)
    scale = Float32(D / (2U))
    @inbounds for j in 2:ny+1, i in 2:nx+1
        dv_dx = plane[i + 1, j, 2] - plane[i - 1, j, 2]
        du_dy = plane[i, j + 1, 1] - plane[i, j - 1, 1]
        omega_z[i - 1, j - 1] = scale * (dv_dx - du_dy)
    end
    return omega_z
end

function write_frame!(io, root, frame_index, sim, params)
    t_raw = WaterLily.time(sim)
    t_ctu = WaterLily.sim_time(sim)
    kin = cylinder_kinematics(
        t_raw, params.n, params.D, params.U, params.Vr,
        params.Ax_D, params.Ay_D, params.theta,
    )
    omega_z = extract_midplane_vorticity(sim, params.D, params.U)
    filename = @sprintf("omega_z_%04d.f32", frame_index)
    open(joinpath(root, filename), "w") do frame_io
        write(frame_io, omega_z)
    end
    @printf(
        io,
        "%d,%.12g,%.12g,%.12g,%.12g,%s\n",
        frame_index,
        t_ctu,
        kin.x / params.D,
        kin.y / params.D,
        t_raw,
        filename,
    )
    flush(io)
end

function main()
    n = env_int("WATERLILY_OSC_N", 64)
    n >= 16 || error("WATERLILY_OSC_N must be at least 16")
    Re = env_float("WATERLILY_OSC_RE", 7620.0)
    U = env_float("WATERLILY_OSC_U", 1.0)
    Vr = env_float("WATERLILY_OSC_VR", 5.4)
    Ax_D = env_float("WATERLILY_OSC_AX_D", 0.4)
    Ay_D = env_float("WATERLILY_OSC_AY_D", 1.6)
    theta = env_float("WATERLILY_OSC_THETA", pi / 6)
    warmup_periods = env_float("WATERLILY_OSC_WARMUP_PERIODS", 2.0)
    sample_periods = env_float("WATERLILY_OSC_SAMPLE_PERIODS", 2.0)
    samples_per_period = env_int("WATERLILY_OSC_SAMPLES_PER_PERIOD", 100)
    frame_count = env_int("WATERLILY_OSC_FRAME_COUNT", 61)
    seed = env_int("WATERLILY_OSC_SEED", 1234)
    output = abspath(env_string("WATERLILY_OSC_OUTPUT", "oscillating_cylinder3d_output"))

    D = n / 6
    H = n
    nu = U * D / Re
    omega = 2pi * U / (Vr * D)
    t_sample_start = warmup_periods * Vr
    t_end = (warmup_periods + sample_periods) * Vr
    dims = (4n, 2n, n)
    mkpath(output)
    midplane_root = joinpath(output, "midplane")
    mkpath(midplane_root)

    sdf(x, t) = hypot(x[1] - n, x[2] - n) - D / 2
    map(x, t) = x - SA[
        Ax_D * D * sin(2omega * t + theta),
        Ay_D * D * sin(omega * t),
        0,
    ]

    println("Building official WaterLily 3D oscillating-cylinder case")
    println("dims=$dims D=$D Re=$Re Vr=$Vr output=$output")
    body = AutoBody(sdf, map)
    sim = Simulation(
        dims,
        (Float32(U), 0f0, 0f0),
        D;
        ν=nu,
        body=body,
        T=Float32,
        mem=CUDA.CuArray,
        exitBC=true,
        perdir=(),
    )
    CUDA.synchronize()

    wall_start = time()
    WaterLily.sim_step!(sim, 1.0; remeasure=true)
    Random.seed!(seed)
    R = WaterLily.inside_u(size(sim.flow.p))
    noise = Float32.(0.1 .* (0.5 .- rand(Float32, size(R)))) |> CUDA.CuArray
    sim.flow.u[R] .+= noise
    WaterLily.BC!(
        sim.flow.u,
        sim.flow.uBC,
        sim.flow.exitBC,
        sim.flow.perdir,
        WaterLily.time(sim.flow),
    )
    CUDA.synchronize()

    sample_step = Vr / samples_per_period
    sample_times = collect(range(t_sample_start, t_end; step=sample_step))
    sample_times[end] < t_end - 1e-10 && push!(sample_times, t_end)
    frame_times = collect(range(1.0, t_end; length=frame_count))
    key(t) = round(Float64(t); digits=10)
    sample_keys = Set(key.(sample_times))
    frame_numbers = Dict(key(t) => i for (i, t) in enumerate(frame_times))
    event_times = sort(unique(vcat(sample_times, frame_times)))

    force_t = Float64[]
    force_x_D = Float64[]
    force_y_D = Float64[]
    force_u = Float64[]
    force_v = Float64[]
    force_Cx = Float64[]
    force_Cy = Float64[]
    force_CP_raw = Float64[]
    force_CP = Float64[]

    force_path = joinpath(output, "forces.csv")
    frames_path = joinpath(midplane_root, "frames.csv")
    open(force_path, "w") do force_io
        println(force_io, "t_ctu,x_D,y_D,u_over_U,v_over_U,Cx,Cy,CP_raw,CP_official_signed,t_raw")
        open(frames_path, "w") do frames_io
            println(frames_io, "frame,t_ctu,x_D,y_D,t_raw,file")
            for target in event_times
                WaterLily.sim_step!(sim, target; remeasure=true)
                CUDA.synchronize()
                actual_ctu = Float64(WaterLily.sim_time(sim))
                actual_raw = Float64(WaterLily.time(sim))
                event_key = key(target)

                if event_key in sample_keys
                    kin = cylinder_kinematics(actual_raw, n, D, U, Vr, Ax_D, Ay_D, theta)
                    F = WaterLily.total_force(sim)
                    Cx = 2Float64(F[1]) / (D * H * U^2)
                    Cy = 2Float64(F[2]) / (D * H * U^2)
                    u_D = kin.vx / U
                    v_D = kin.vy / U
                    cp_raw = Cx * u_D + Cy * v_D
                    cp_official = -cp_raw
                    push!(force_t, actual_ctu)
                    push!(force_x_D, kin.x / D)
                    push!(force_y_D, kin.y / D)
                    push!(force_u, u_D)
                    push!(force_v, v_D)
                    push!(force_Cx, Cx)
                    push!(force_Cy, Cy)
                    push!(force_CP_raw, cp_raw)
                    push!(force_CP, cp_official)
                    @printf(
                        force_io,
                        "%.12g,%.12g,%.12g,%.12g,%.12g,%.12g,%.12g,%.12g,%.12g,%.12g\n",
                        actual_ctu,
                        kin.x / D,
                        kin.y / D,
                        u_D,
                        v_D,
                        Cx,
                        Cy,
                        cp_raw,
                        cp_official,
                        actual_raw,
                    )
                    flush(force_io)
                end

                if haskey(frame_numbers, event_key)
                    write_frame!(frames_io, midplane_root, frame_numbers[event_key], sim, (
                        n=n, D=D, U=U, Vr=Vr, Ax_D=Ax_D, Ay_D=Ay_D, theta=theta,
                    ))
                end
                @printf(
                    "target=%.6f actual=%.6f samples=%d frames=%d wall=%.1fs\n",
                    target,
                    actual_ctu,
                    length(force_t),
                    count(t -> t <= target + 1e-10, frame_times),
                    time() - wall_start,
                )
            end
        end
    end

    mean_cp_raw = trapz_average(force_t, force_CP_raw)
    mean_cp = trapz_average(force_t, force_CP)
    wall_seconds = time() - wall_start
    summary = Dict(
        "case" => "WaterLily official prescribed 3D oscillating cylinder",
        "validation_level" => n == 128 && warmup_periods == 8 && sample_periods == 8 ?
            "official_resolution_and_duration" : "smoke_or_nonofficial",
        "generated_at_utc" => string(Dates.now(Dates.UTC)),
        "waterlily_version" => string(Base.pkgversion(WaterLily)),
        "n" => n,
        "dimensions" => collect(dims),
        "cell_count" => prod(dims),
        "D_cells" => D,
        "H_cells" => H,
        "Re_D" => Re,
        "U" => U,
        "nu" => nu,
        "Vr" => Vr,
        "Ax_D" => Ax_D,
        "Ay_D" => Ay_D,
        "theta_rad" => theta,
        "warmup_periods" => warmup_periods,
        "sample_periods" => sample_periods,
        "samples_per_period" => samples_per_period,
        "force_sample_count" => length(force_t),
        "frame_count" => frame_count,
        "actual_final_t_ctu" => Float64(WaterLily.sim_time(sim)),
        "mean_CP_raw" => mean_cp_raw,
        "mean_CP_official_signed" => mean_cp,
        "official_waterlily_mean_CP" => -4.39,
        "experimental_mean_CP" => -4.52,
        "relative_error_vs_official" => abs(mean_cp - (-4.39)) / 4.39,
        "relative_error_vs_experiment" => abs(mean_cp - (-4.52)) / 4.52,
        "wall_seconds" => wall_seconds,
        "gpu" => CUDA.name(CUDA.device()),
        "seed" => seed,
        "force_sign_note" => "CP_official_signed = -(Cx*u/U + Cy*v/U), matching the official plotting convention",
    )
    open(joinpath(output, "summary.json"), "w") do io
        JSON.print(io, summary, 2)
        println(io)
    end
    println(JSON.json(summary))
end

main()
