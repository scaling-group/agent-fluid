struct FreeSwimState{T}
    center::SVector{2, T}
    theta::T
    velocity::SVector{2, T}
    omega::T
    acceleration::SVector{2, T}
    angular_acceleration::T
end

function FreeSwimState(center::SVector{2, T}, theta::T, velocity::SVector{2, T}, omega::T) where {T}
    return FreeSwimState{T}(center, theta, velocity, omega, zero(velocity), zero(T))
end

struct FreeSwimmingSpineMap{T, F, P} <: Function
    generator::F
    params::P
    Lf::T
    reference_time::T
    center::SVector{2, T}
    theta::T
    velocity::SVector{2, T}
    omega::T
    reference_center::SVector{2, T}
    reference_center_velocity::SVector{2, T}
end

@inline function rotate_to_body_frame(delta, theta)
    c = cos(theta)
    s = sin(theta)
    return SVector(c * delta[1] + s * delta[2], -s * delta[1] + c * delta[2])
end

@inline function rotate_to_world_frame(delta, theta)
    c = cos(theta)
    s = sin(theta)
    return SVector(c * delta[1] - s * delta[2], s * delta[1] + c * delta[2])
end

@inline function free_swim_pose(map::FreeSwimmingSpineMap, t)
    dt = t - map.reference_time
    center = map.center + map.velocity * dt
    theta = map.theta + map.omega * dt
    local_center = map.reference_center + map.reference_center_velocity * dt
    return center, theta, local_center
end

@inline function (map::FreeSwimmingSpineMap)(x, t)
    center, theta, local_center = free_swim_pose(map, t)
    q = rotate_to_body_frame(x - center, theta) + local_center
    spine_map = SpineMotionMap(map.generator, map.params, map.Lf)
    return closest_spine_reference_coordinate(spine_map, q, t)
end

function body_area_from_profile(profile::DogfishThicknessProfile{T, N}, Lf::T) where {T, N}
    n_segments = 320
    ds = one(T) / T(n_segments)
    area = zero(T)
    for index in 1:n_segments
        s = (T(index) - T(0.5)) * ds
        area += T(2) * Lf * profile_width(profile, s) * Lf * ds
    end
    return area
end

function body_centroid_x_from_profile(profile::DogfishThicknessProfile{T, N}, Lf::T) where {T, N}
    n_segments = 320
    ds = one(T) / T(n_segments)
    area = zero(T)
    first_moment_x = zero(T)
    for index in 1:n_segments
        s = (T(index) - T(0.5)) * ds
        strip_area = T(2) * Lf * profile_width(profile, s) * Lf * ds
        first_moment_x += strip_area * (s * Lf)
        area += strip_area
    end
    return first_moment_x / area
end

function body_inertia_from_profile(
    profile::DogfishThicknessProfile{T, N},
    Lf::T;
    density::T=one(T),
) where {T, N}
    n_segments = 320
    ds = one(T) / T(n_segments)
    centroid_x = body_centroid_x_from_profile(profile, Lf)
    inertia = zero(T)
    for index in 1:n_segments
        s = (T(index) - T(0.5)) * ds
        half_width = Lf * profile_width(profile, s)
        dx = Lf * ds
        x_offset = s * Lf - centroid_x
        strip_area = T(2) * half_width * dx
        strip_inertia = strip_area * x_offset * x_offset + (T(2) / T(3)) * half_width^3 * dx
        inertia += density * strip_inertia
    end
    return inertia
end

function equivalent_ellipse_semiaxes(profile::DogfishThicknessProfile{T, N}, Lf::T) where {T, N}
    area = body_area_from_profile(profile, Lf)
    semi_major = Lf / T(2)
    semi_minor = area / (T(pi) * semi_major)
    return (
        area=area,
        semi_major=semi_major,
        semi_minor=semi_minor,
    )
end

function free_swim_added_mass_properties(
    profile::DogfishThicknessProfile{T, N},
    Lf::T;
    density::T=one(T),
    translational_scale::T=one(T),
    rotational_scale::T=one(T),
) where {T, N}
    axes = equivalent_ellipse_semiaxes(profile, Lf)
    a = axes.semi_major
    b = axes.semi_minor
    added_forward = translational_scale * density * T(pi) * b^2
    added_lateral = translational_scale * density * T(pi) * a^2
    added_inertia = rotational_scale * density * (T(pi) / T(8)) * (a^2 - b^2)^2
    return (
        model="equivalent_ellipse_body_frame",
        forward=added_forward,
        lateral=added_lateral,
        inertia=added_inertia,
        translational_scale=translational_scale,
        rotational_scale=rotational_scale,
        semi_major=a,
        semi_minor=b,
        reference_area=axes.area,
    )
end

function legacy_isotropic_added_mass_properties(
    mass::T,
    inertia::T,
    factor::T,
) where {T}
    return (
        model="legacy_isotropic_factor",
        forward=mass * factor,
        lateral=mass * factor,
        inertia=inertia * factor,
        translational_scale=factor,
        rotational_scale=factor,
        semi_major=nothing,
        semi_minor=nothing,
        reference_area=nothing,
    )
end

function deformed_body_centroid(
    generator,
    params,
    profile::DogfishThicknessProfile{T, N},
    Lf::T,
    t::T,
) where {T, N}
    n_segments = 96
    ds = one(T) / T(n_segments)
    spine_map = SpineMotionMap(generator, params, Lf)
    area = zero(T)
    first_moment = SVector(zero(T), zero(T))

    for index in 1:n_segments
        s = (T(index) - T(0.5)) * ds
        strip_area = T(2) * Lf * profile_width(profile, s) * Lf * ds
        centerline = spine_centerline(spine_map, s, t)
        first_moment += strip_area * centerline
        area += strip_area
    end

    return first_moment / area
end

function deformed_body_centroid_velocity(generator, params, profile, Lf::T, t::T, dt::T) where {T}
    dt_safe = max(abs(dt), sqrt(eps(T)) * Lf)
    c_forward = deformed_body_centroid(generator, params, profile, Lf, t + dt_safe)
    c_backward = deformed_body_centroid(generator, params, profile, Lf, t - dt_safe)
    return (c_forward - c_backward) / (T(2) * dt_safe)
end

function free_swim_map(
    design,
    assembled_params,
    profile,
    Lf::T,
    state::FreeSwimState{T},
    reference_time::T,
    centroid_dt::T,
) where {T}
    reference_center = deformed_body_centroid(
        design.motion.generator,
        assembled_params,
        profile,
        Lf,
        reference_time,
    )
    reference_center_velocity = deformed_body_centroid_velocity(
        design.motion.generator,
        assembled_params,
        profile,
        Lf,
        reference_time,
        centroid_dt,
    )
    return FreeSwimmingSpineMap(
        design.motion.generator,
        assembled_params,
        Lf,
        reference_time,
        state.center,
        state.theta,
        state.velocity,
        state.omega,
        reference_center,
        reference_center_velocity,
    )
end

function build_free_swim_simulation(
    design,
    experiment::NamedTuple;
    L::Int=32,
    Re::Float32=2000f0,
    T::Type=Float32,
    backend="auto",
    mem=nothing,
    domain_scale=(8, 4),
    initial_center_fraction=(0.25f0, 0.5f0),
    initial_heading=0.0f0,
    initial_velocity=(0.0f0, 0.0f0),
    initial_omega=0.0f0,
    time_step_fraction::Float32=0.01f0,
)
    resolved_backend = resolve_memory_backend(backend=backend, mem=mem)
    _, assembled_params, period = assemble_experiment_for_length(design, experiment; L, T)
    morphology_params = baseline_morphology_parameters(T)
    Lf = T(L)
    raw_period = T(period) * Lf
    raw_dt_cap = max(eps(T), raw_period * T(time_step_fraction))
    profile = baseline_thickness_profile(T)
    dims = (
        max(4L, Int(round(domain_scale[1] * L))),
        max(2L, Int(round(domain_scale[2] * L))),
    )
    center = SVector(T(initial_center_fraction[1]) * T(dims[1]), T(initial_center_fraction[2]) * T(dims[2]))
    state = FreeSwimState(
        center,
        T(initial_heading),
        SVector(T(initial_velocity[1]), T(initial_velocity[2])),
        T(initial_omega),
    )
    sdf = DogfishSDF(Lf, profile)
    map = free_swim_map(design, assembled_params, profile, Lf, state, zero(T), raw_dt_cap)
    simulation_builder = () -> Simulation(
        dims,
        (zero(T), zero(T)),
        L;
        U=T(1),
        Δt=raw_dt_cap,
        ν=Lf / Re,
        body=AutoBody(sdf, map),
        T,
        mem=resolved_backend.mem,
    )
    sim = resolved_backend.name == "cuda" ? Base.invokelatest(simulation_builder) : simulation_builder()
    return sim, state, period, morphology_params, assembled_params, resolved_backend, profile
end

function cap_free_swim_timestep!(sim, raw_dt_cap, target_sim_time)
    T = eltype(sim.flow.p)
    capped_dt = min(T(sim.flow.Δt[end]), T(raw_dt_cap))
    remaining_sim_time = max(zero(T), T(target_sim_time) - T(sim_time(sim)))
    if remaining_sim_time > eps(T)
        remaining_raw_time = remaining_sim_time * T(sim.L) / T(sim.U)
        capped_dt = min(capped_dt, remaining_raw_time)
    end
    sim.flow.Δt[end] = max(eps(T), capped_dt)
    return sim
end

@inline function free_swim_moment_density(I, p, u, ν, body, t, center)
    Tp = eltype(p)
    x = WaterLily.loc(0, I, Tp)
    d, unused_normal, unused_velocity = WaterLily.measure(body, x, t, fastd²=1)
    abs(d) > one(Tp) && return zero(Tp)

    n = WaterLily.nds(body, x, t)
    traction = p[I] * n - 2 * ν * WaterLily.S(I, u) * n
    lever = x - center
    return lever[1] * traction[2] - lever[2] * traction[1]
end

function free_swim_surface_moment_z(sim, center)
    t = WaterLily.time(sim.flow)
    Tp = eltype(sim.flow.p)
    To = promote_type(Float64, Tp)
    center_t = SVector(Tp(center[1]), Tp(center[2]))
    sim.flow.σ .= zero(Tp)
    WaterLily.@loop sim.flow.σ[I] = free_swim_moment_density(
        I,
        sim.flow.p,
        sim.flow.u,
        sim.flow.ν,
        sim.body,
        t,
        center_t,
    ) over I ∈ inside(sim.flow.p)
    moment = sum(To, sim.flow.σ, dims=ntuple(i -> i, ndims(sim.flow.σ)))[:] |> Array
    return Float64(moment[1])
end

function free_swim_body_force_moment(sim, center)
    force_x, force_y = force_components(WaterLily.total_force(sim))
    moment_z = free_swim_surface_moment_z(sim, center)
    # WaterLily's force convention matches the VIV example, where the structural
    # force is the negative of pressure_force(sim). Use body-force sign here.
    return SVector(-force_x, -force_y), -moment_z
end

function update_free_swim_state(
    state::FreeSwimState{T},
    force,
    moment_z,
    dt::T,
    mass::T,
    inertia::T;
    added_mass=nothing,
    linear_damping::T=zero(T),
    angular_damping::T=zero(T),
) where {T}
    effective_added_mass = added_mass === nothing ?
        (forward=zero(T), lateral=zero(T), inertia=zero(T)) :
        added_mass
    body_force = rotate_to_body_frame(
        SVector(T(force[1]), T(force[2])) - linear_damping * state.velocity,
        state.theta,
    )
    previous_acceleration = rotate_to_body_frame(state.acceleration, state.theta)
    added_forward = T(effective_added_mass.forward)
    added_lateral = T(effective_added_mass.lateral)
    acceleration_body = SVector(
        (body_force[1] + added_forward * previous_acceleration[1]) / (mass + added_forward),
        (body_force[2] + added_lateral * previous_acceleration[2]) / (mass + added_lateral),
    )
    acceleration = rotate_to_world_frame(acceleration_body, state.theta)
    next_velocity = state.velocity + acceleration * dt
    next_center = state.center + (state.velocity + next_velocity) * (T(0.5) * dt)

    added_inertia = T(effective_added_mass.inertia)
    angular_acceleration = (
        T(moment_z) - angular_damping * state.omega + added_inertia * state.angular_acceleration
    ) / (inertia + added_inertia)
    next_omega = state.omega + angular_acceleration * dt
    next_theta = state.theta + (state.omega + next_omega) * (T(0.5) * dt)

    return FreeSwimState(
        next_center,
        next_theta,
        next_velocity,
        next_omega,
        acceleration,
        angular_acceleration,
    )
end

function free_swim_step_body_state(
    previous::FreeSwimState{T},
    next::FreeSwimState{T},
    dt::T,
) where {T}
    dt_safe = max(abs(dt), eps(T))
    step_velocity = (next.center - previous.center) / dt_safe
    step_omega = (next.theta - previous.theta) / dt_safe
    return FreeSwimState(
        next.center,
        next.theta,
        step_velocity,
        step_omega,
        next.acceleration,
        next.angular_acceleration,
    )
end

function set_free_swim_body!(
    sim,
    design,
    sdf,
    profile,
    assembled_params,
    state::FreeSwimState{T},
    reference_time::T,
    centroid_dt::T,
    Lf::T,
) where {T}
    sim.body = AutoBody(
        sdf,
        free_swim_map(design, assembled_params, profile, Lf, state, reference_time, centroid_dt),
    )
    return sim
end

function run_free_swim_rollout(
    design,
    experiment::NamedTuple;
    L::Int=32,
    Re::Float32=2000f0,
    T::Type=Float32,
    backend="auto",
    mem=nothing,
    domain_scale=(8, 4),
    initial_center_fraction=(0.25f0, 0.5f0),
    initial_heading=0.0f0,
    initial_velocity=(0.0f0, 0.0f0),
    initial_omega=0.0f0,
    n_cycles::Float32=1.0f0,
    samples_per_cycle::Int=24,
    body_density::Float32=1.0f0,
    added_mass_factor::Union{Nothing, Float32}=nothing,
    added_mass_scale::Float32=1.0f0,
    added_inertia_scale::Float32=1.0f0,
    inertia_coeff::Union{Nothing, Float32}=nothing,
    linear_damping::Float32=0.0f0,
    angular_damping::Float32=0.0f0,
    time_step_fraction::Float32=0.01f0,
    max_steps::Int=200000,
)
    body_density >= 0f0 || error("body_density must be nonnegative")
    added_mass_factor === nothing || added_mass_factor >= 0f0 ||
        error("added_mass_factor must be nonnegative")
    added_mass_scale >= 0f0 || error("added_mass_scale must be nonnegative")
    added_inertia_scale >= 0f0 || error("added_inertia_scale must be nonnegative")
    inertia_coeff === nothing || inertia_coeff > 0f0 || error("inertia_coeff must be positive")
    time_step_fraction > 0f0 || error("time_step_fraction must be positive")

    sim, state, period, morphology_params, assembled_params, resolved_backend, profile =
        build_free_swim_simulation(
            design,
            experiment;
            L,
            Re,
            T,
            backend,
            mem,
            domain_scale,
            initial_center_fraction,
            initial_heading,
            initial_velocity,
            initial_omega,
            time_step_fraction,
        )

    Lf = T(L)
    sdf = DogfishSDF(Lf, profile)
    area = body_area_from_profile(profile, Lf)
    mass = T(body_density) * area
    profile_inertia = body_inertia_from_profile(profile, Lf; density=T(body_density))
    inertia = inertia_coeff === nothing ? profile_inertia : T(inertia_coeff) * mass * Lf * Lf
    inertia_model = inertia_coeff === nothing ? "profile_density_integral" : "legacy_coeff_mass_L2"
    added_mass = added_mass_factor === nothing ?
        free_swim_added_mass_properties(
            profile,
            Lf;
            density=T(body_density),
            translational_scale=T(added_mass_scale),
            rotational_scale=T(added_inertia_scale),
        ) :
        legacy_isotropic_added_mass_properties(mass, inertia, T(added_mass_factor))
    dynamic_mass_forward = mass + T(added_mass.forward)
    dynamic_mass_lateral = mass + T(added_mass.lateral)
    dynamic_inertia = inertia + T(added_mass.inertia)
    target_time = Float64(n_cycles) * period
    raw_dt_cap = max(eps(T), T(period) * Lf * T(time_step_fraction))
    sample_dt = period / max(1, samples_per_cycle)
    next_sample_time = sample_dt
    steps = 0

    times = Float64[0.0]
    centers = [(Float64(state.center[1]), Float64(state.center[2]))]
    velocities = [(Float64(state.velocity[1]), Float64(state.velocity[2]))]
    forces = [(0.0, 0.0)]
    moments = [0.0]
    headings = [Float64(state.theta)]
    angular_velocities = [Float64(state.omega)]

    termination = "horizon"
    failure_message = nothing

    while sim_time(sim) < target_time && steps < max_steps
        cap_free_swim_timestep!(sim, raw_dt_cap, target_time)
        raw_t0 = T(WaterLily.time(sim.flow))
        raw_dt = T(sim.flow.Δt[end])
        raw_t1 = raw_t0 + raw_dt

        if !(isfinite(raw_t0) && isfinite(raw_dt) && raw_dt > zero(T))
            termination = "nonfinite_time_step"
            failure_message = "nonfinite or nonpositive solver time step before body update"
            break
        end

        force, moment_z = free_swim_body_force_moment(sim, state.center)
        next_state = update_free_swim_state(
            state,
            force,
            moment_z,
            raw_dt,
            mass,
            inertia;
            added_mass,
            linear_damping=T(linear_damping),
            angular_damping=T(angular_damping),
        )

        if !(
            all(isfinite, force) &&
            isfinite(moment_z) &&
            all(isfinite, next_state.center) &&
            all(isfinite, next_state.velocity) &&
            all(isfinite, next_state.acceleration) &&
            isfinite(next_state.theta) &&
            isfinite(next_state.omega) &&
            isfinite(next_state.angular_acceleration)
        )
            termination = "nonfinite_state"
            failure_message = "fluid force or free-swim state became nonfinite"
            break
        end

        body_state = free_swim_step_body_state(state, next_state, raw_dt)
        set_free_swim_body!(
            sim,
            design,
            sdf,
            profile,
            assembled_params,
            body_state,
            raw_t1,
            raw_dt,
            Lf,
        )
        try
            sim_step!(sim; remeasure=true)
        catch error
            termination = "solver_error"
            failure_message = sprint(showerror, error)
            break
        end

        if !(isfinite(T(sim.flow.Δt[end])) && T(sim.flow.Δt[end]) > zero(T))
            termination = "nonfinite_solver_cfl"
            failure_message = "WaterLily CFL update became nonfinite after the flow step"
            break
        end

        sim.flow.Δt[end] = min(T(sim.flow.Δt[end]), raw_dt_cap)
        state = next_state
        steps += 1

        current_time = sim_time(sim)
        if current_time + eps(current_time) >= next_sample_time || current_time >= target_time
            push!(times, Float64(current_time))
            push!(centers, (Float64(state.center[1]), Float64(state.center[2])))
            push!(velocities, (Float64(state.velocity[1]), Float64(state.velocity[2])))
            push!(forces, (Float64(force[1]), Float64(force[2])))
            push!(moments, Float64(moment_z))
            push!(headings, Float64(state.theta))
            push!(angular_velocities, Float64(state.omega))
            next_sample_time += sample_dt
        end
    end

    termination = steps >= max_steps ? "max_steps" : termination
    final_center = (Float64(state.center[1]), Float64(state.center[2]))
    displacement = (
        final_center[1] - centers[1][1],
        final_center[2] - centers[1][2],
    )

    return (
        status=termination in ("horizon", "max_steps") ? "ok" : "failed",
        termination=termination,
        failure_message=failure_message,
        period=period,
        sim_time=Float64(sim_time(sim)),
        raw_time=Float64(WaterLily.time(sim.flow)),
        steps=steps,
        grid_L=L,
        Re=Float64(Re),
        domain_dims=size(sim.flow.p) .- 2,
        memory_backend=resolved_backend.name,
        cuda_available=resolved_backend.cuda_available,
        body_density=Float64(body_density),
        mass=Float64(mass),
        inertia=Float64(inertia),
        added_mass_factor=added_mass_factor === nothing ? nothing : Float64(added_mass_factor),
        added_mass_model=String(added_mass.model),
        added_mass_scale=Float64(added_mass.translational_scale),
        added_inertia_scale=Float64(added_mass.rotational_scale),
        added_mass_forward=Float64(added_mass.forward),
        added_mass_lateral=Float64(added_mass.lateral),
        added_inertia=Float64(added_mass.inertia),
        added_mass_equivalent_semi_major=added_mass.semi_major === nothing ?
            nothing : Float64(added_mass.semi_major),
        added_mass_equivalent_semi_minor=added_mass.semi_minor === nothing ?
            nothing : Float64(added_mass.semi_minor),
        dynamic_mass=Float64(max(dynamic_mass_forward, dynamic_mass_lateral)),
        dynamic_mass_forward=Float64(dynamic_mass_forward),
        dynamic_mass_lateral=Float64(dynamic_mass_lateral),
        dynamic_inertia=Float64(dynamic_inertia),
        inertia_model=inertia_model,
        inertia_coeff=inertia_coeff === nothing ? nothing : Float64(inertia_coeff),
        profile_inertia=Float64(profile_inertia),
        body_area=Float64(area),
        time_step_fraction=Float64(time_step_fraction),
        raw_dt_cap=Float64(raw_dt_cap),
        morphology_parameters=morphology_params,
        assembled_parameters=assembled_params,
        experiment_id=String(experiment.id),
        trace=(
            time=times,
            center=centers,
            velocity=velocities,
            force=forces,
            moment_z=moments,
            heading=headings,
            omega=angular_velocities,
        ),
        final_state=(
            center=final_center,
            heading=Float64(state.theta),
            velocity=(Float64(state.velocity[1]), Float64(state.velocity[2])),
            acceleration=(Float64(state.acceleration[1]), Float64(state.acceleration[2])),
            omega=Float64(state.omega),
            angular_acceleration=Float64(state.angular_acceleration),
            displacement=displacement,
        ),
    )
end

function write_free_swim_outputs(output_root::AbstractString, rollout)
    mkpath(output_root)
    open(joinpath(output_root, "free_swim_result.json"), "w") do io
        JSON.print(io, jsonable(rollout), 2)
        println(io)
    end
    open(joinpath(output_root, "free_swim_trajectory.csv"), "w") do io
        println(io, "time,center_x,center_y,velocity_x,velocity_y,force_x,force_y,moment_z,heading,omega")
        for index in eachindex(rollout.trace.time)
            center = rollout.trace.center[index]
            velocity = rollout.trace.velocity[index]
            force = rollout.trace.force[index]
            println(
                io,
                join(
                    (
                        rollout.trace.time[index],
                        center[1],
                        center[2],
                        velocity[1],
                        velocity[2],
                        force[1],
                        force[2],
                        rollout.trace.moment_z[index],
                        rollout.trace.heading[index],
                        rollout.trace.omega[index],
                    ),
                    ",",
                ),
            )
        end
    end
    return (
        result=joinpath(output_root, "free_swim_result.json"),
        trajectory=joinpath(output_root, "free_swim_trajectory.csv"),
    )
end
