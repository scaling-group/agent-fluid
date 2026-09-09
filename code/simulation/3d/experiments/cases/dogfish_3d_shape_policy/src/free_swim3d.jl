# 3D free swimming with locked vertical/roll/pitch degrees of freedom.
#
# The rigid state remains the planar Base2D.FreeSwimState (x, y, theta): the
# swimmer is constrained to the horizontal mid-plane (no heave, no roll, no
# pitch), which mirrors a dorsoventrally stable fish holding depth. The fluid
# is fully 3D; the unused force/moment components (Fz, Mx, My) are logged as
# diagnostics so the locked-DOF assumption stays auditable.
struct FreeSwimmingSpineMap3D{T, F, P} <: Function
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
    z_plane::T
end

@inline function free_swim_pose_3d(map::FreeSwimmingSpineMap3D, t)
    dt = t - map.reference_time
    center = map.center + map.velocity * dt
    theta = map.theta + map.omega * dt
    local_center = map.reference_center + map.reference_center_velocity * dt
    return center, theta, local_center
end

@inline function (map::FreeSwimmingSpineMap3D)(x, t)
    center, theta, local_center = free_swim_pose_3d(map, t)
    xy = SVector(x[1], x[2])
    q = Base2D.rotate_to_body_frame(xy - center, theta) + local_center
    spine_map = Base2D.SpineMotionMap(map.generator, map.params, map.Lf)
    reference = Base2D.closest_spine_reference_coordinate(spine_map, q, t)
    return SVector(reference[1], reference[2], x[3] - map.z_plane)
end

@inline function deformed_material_reference_3d(generator, params, Lf::T, t::T, station) where {T}
    spine_map = Base2D.SpineMotionMap(generator, params, Lf)
    return Base2D.spine_centerline(spine_map, T(station), t)
end

function deformed_material_reference_velocity_3d(
    generator,
    params,
    Lf::T,
    t::T,
    dt::T,
    station,
) where {T}
    dt_safe = max(abs(dt), sqrt(eps(T)) * Lf)
    forward = deformed_material_reference_3d(generator, params, Lf, t + dt_safe, station)
    backward = deformed_material_reference_3d(generator, params, Lf, t - dt_safe, station)
    return (forward - backward) / (T(2) * dt_safe)
end

function deformed_profile_centroid_velocity_3d(
    generator,
    params,
    profile,
    Lf::T,
    t::T,
    dt::T,
) where {T}
    dt_safe = max(abs(dt), sqrt(eps(T)) * Lf)
    forward = Base2D.deformed_body_centroid(
        generator, params, profile, Lf, t + dt_safe,
    )
    backward = Base2D.deformed_body_centroid(
        generator, params, profile, Lf, t - dt_safe,
    )
    return (forward - backward) / (T(2) * dt_safe)
end

@inline function extended_spine_centerline_3d(spine, s, Lf, t)
    s <= one(s) && return Base2D.spine_centerline(spine, s, t)
    tail = Base2D.spine_centerline(spine, one(s), t)
    tangent = Base2D.spine_tangent(spine, one(s), t)
    return tail + (s - one(s)) * Lf * tangent
end

# Continuous mass centroid for the preserved June-13 superellipse + fan fish.
# The wet fan can be widened to one cell at coarse resolution, but this
# reference always receives the limiting 0.012L-thick physical fan.  The
# post-body chord (1.00L..1.07L) is continued along the terminal spine tangent;
# Base2D.spine_centerline itself intentionally clamps at s=1.
function deformed_combined_centroid_superellipse(
    generator,
    params,
    body::DogfishBodySDF{T, N},
    fin::CaudalFinSDF{T},
    Lf::T,
    t::T;
    body_density::T=one(T),
    fin_material_density::T=one(T),
    n_axial::Int=320,
    n_fin::Int=320,
) where {T, N}
    spine = Base2D.SpineMotionMap(generator, params, Lf)
    total_mass = zero(T)
    first_moment = SVector(zero(T), zero(T))

    ds = one(T) / T(n_axial)
    @inbounds for index in 1:n_axial
        s = (T(index) - T(0.5)) * ds
        p = _superellipse_profiles(body, s)
        section = _superellipse_section(p.W, p.Zt, p.Zb, p.et, p.eb)
        strip_mass = body_density * T(section.area) * Lf * ds
        first_moment += strip_mass * extended_spine_centerline_3d(spine, s, Lf, t)
        total_mass += strip_mass
    end

    du = one(T) / T(n_fin)
    span = fin.x_end - fin.x_start
    full_thickness = T(2) * Lf * fin.half_thickness
    @inbounds for index in 1:n_fin
        u = (T(index) - T(0.5)) * du
        s = fin.x_start + u * span
        half_height = Lf * _fan_height_frac(fin, s)
        strip_mass = fin_material_density * T(2) * half_height *
            full_thickness * (Lf * span * du)
        first_moment += strip_mass * extended_spine_centerline_3d(spine, s, Lf, t)
        total_mass += strip_mass
    end
    total_mass > zero(T) || error("combined body+fan centroid has zero mass")
    return first_moment / total_mass
end

function deformed_combined_centroid_velocity_superellipse(
    generator,
    params,
    body::DogfishBodySDF{T, N},
    fin::CaudalFinSDF{T},
    Lf::T,
    t::T,
    dt::T;
    body_density::T=one(T),
    fin_material_density::T=one(T),
    n_axial::Int=320,
    n_fin::Int=320,
) where {T, N}
    dt_safe = max(abs(dt), sqrt(eps(T)) * Lf)
    forward = deformed_combined_centroid_superellipse(
        generator,
        params,
        body,
        fin,
        Lf,
        t + dt_safe;
        body_density,
        fin_material_density,
        n_axial,
        n_fin,
    )
    backward = deformed_combined_centroid_superellipse(
        generator,
        params,
        body,
        fin,
        Lf,
        t - dt_safe;
        body_density,
        fin_material_density,
        n_axial,
        n_fin,
    )
    return (forward - backward) / (T(2) * dt_safe)
end

function free_swim_map_3d(
    design,
    assembled_params,
    profile,
    Lf::T,
    state::Base2D.FreeSwimState{T},
    reference_time::T,
    centroid_dt::T,
    z_plane::T;
    height_scale::T=one(T),
    reference_station=nothing,
    centroid_body_sdf=nothing,
    centroid_profile_2d=nothing,
    centroid_caudal_fin=nothing,
    centroid_body_density::T=one(T),
    centroid_fin_material_density::T=one(T),
) where {T}
    centroid_body_sdf !== nothing && centroid_profile_2d !== nothing &&
        error("centroid_body_sdf and centroid_profile_2d are mutually exclusive")
    centroid_caudal_fin !== nothing && centroid_body_sdf === nothing &&
        error("centroid_caudal_fin requires centroid_body_sdf")
    centroid_caudal_fin !== nothing && centroid_profile_2d !== nothing &&
        error("centroid_caudal_fin and centroid_profile_2d are mutually exclusive")
    reference_center = reference_station === nothing ? (
        centroid_profile_2d !== nothing ? Base2D.deformed_body_centroid(
            design.motion.generator,
            assembled_params,
            centroid_profile_2d,
            Lf,
            reference_time,
        ) : centroid_body_sdf === nothing ? deformed_body_centroid_3d(
            design.motion.generator,
            assembled_params,
            profile,
            Lf,
            reference_time;
            height_scale,
        ) : centroid_caudal_fin === nothing ? deformed_body_centroid_superellipse(
            design.motion.generator,
            assembled_params,
            centroid_body_sdf,
            Lf,
            reference_time,
        ) : deformed_combined_centroid_superellipse(
            design.motion.generator,
            assembled_params,
            centroid_body_sdf,
            centroid_caudal_fin,
            Lf,
            reference_time;
            body_density=centroid_body_density,
            fin_material_density=centroid_fin_material_density,
        )
    ) :
        deformed_material_reference_3d(
            design.motion.generator,
            assembled_params,
            Lf,
            reference_time,
            reference_station,
        )
    reference_center_velocity = reference_station === nothing ? (
        centroid_profile_2d !== nothing ? deformed_profile_centroid_velocity_3d(
            design.motion.generator,
            assembled_params,
            centroid_profile_2d,
            Lf,
            reference_time,
            centroid_dt,
        ) : centroid_body_sdf === nothing ? deformed_body_centroid_velocity_3d(
            design.motion.generator,
            assembled_params,
            profile,
            Lf,
            reference_time,
            centroid_dt;
            height_scale,
        ) : centroid_caudal_fin === nothing ? deformed_body_centroid_velocity_superellipse(
            design.motion.generator,
            assembled_params,
            centroid_body_sdf,
            Lf,
            reference_time,
            centroid_dt,
        ) : deformed_combined_centroid_velocity_superellipse(
            design.motion.generator,
            assembled_params,
            centroid_body_sdf,
            centroid_caudal_fin,
            Lf,
            reference_time,
            centroid_dt;
            body_density=centroid_body_density,
            fin_material_density=centroid_fin_material_density,
        )
    ) :
        deformed_material_reference_velocity_3d(
            design.motion.generator,
            assembled_params,
            Lf,
            reference_time,
            centroid_dt,
            reference_station,
        )
    return FreeSwimmingSpineMap3D(
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
        z_plane,
    )
end

# Compose the swimmer body: revolution body alone, or unioned with a caudal
# fin sharing the same motion map (so the fin bends and sweeps with the
# peduncle). `∪` is WaterLily's SetBody(min, ...).
@inline function compose_body_3d(sdf, map, caudal_fin)
    body = AutoBody(sdf, map)
    caudal_fin === nothing && return body
    return body ∪ AutoBody(caudal_fin, map)
end

function build_free_swim_simulation_3d(
    design,
    experiment::NamedTuple;
    L::Int=16,
    Re::Float32=2000f0,
    T::Type=Float32,
    backend="auto",
    mem=nothing,
    domain_scale=(12, 6, 2),
    initial_center_fraction=(0.75f0, 0.5f0, 0.5f0),
    initial_heading=0.0f0,
    initial_velocity=(0.0f0, 0.0f0),
    initial_omega=0.0f0,
    height_scale::Float32=Float32(DEFAULT_DOGFISH_HEIGHT_SCALE),
    caudal_fin=nothing,
    body_sdf=nothing,
    time_step_fraction::Float32=0.01f0,
    reference_station=nothing,
)
    resolved_backend = Base2D.resolve_memory_backend(backend=backend, mem=mem)
    _, assembled_params, period = Base2D.assemble_experiment_for_length(design, experiment; L, T)
    morphology_params = Base2D.baseline_morphology_parameters(T)
    Lf = T(L)
    raw_period = T(period) * Lf
    raw_dt_cap = max(eps(T), raw_period * T(time_step_fraction))
    profile = dogfish3d_thickness_profile(T)
    dims = (
        max(4L, Int(round(domain_scale[1] * L))),
        max(2L, Int(round(domain_scale[2] * L))),
        max(L, Int(round(domain_scale[3] * L))),
    )
    center = SVector(
        T(initial_center_fraction[1]) * T(dims[1]),
        T(initial_center_fraction[2]) * T(dims[2]),
    )
    z_plane = T(initial_center_fraction[3]) * T(dims[3])
    state = Base2D.FreeSwimState(
        center,
        T(initial_heading),
        SVector(T(initial_velocity[1]), T(initial_velocity[2])),
        T(initial_omega),
    )
    typed_height_scale = T(height_scale)
    sdf = body_sdf === nothing ? Dogfish3DSDF(Lf, profile, typed_height_scale) : body_sdf
    map = free_swim_map_3d(
        design,
        assembled_params,
        profile,
        Lf,
        state,
        zero(T),
        raw_dt_cap,
        z_plane;
        height_scale=typed_height_scale,
        reference_station,
    )
    simulation_builder = () -> Simulation(
        dims,
        (zero(T), zero(T), zero(T)),
        L;
        U=T(1),
        Δt=raw_dt_cap,
        ν=Lf / Re,
        body=compose_body_3d(sdf, map, caudal_fin),
        T,
        mem=resolved_backend.mem,
    )
    sim = resolved_backend.name == "cuda" ? Base.invokelatest(simulation_builder) : simulation_builder()
    return sim, state, z_plane, period, morphology_params, assembled_params, resolved_backend, profile
end

@inline function free_swim_moment_density_3d(I, p, u, ν, body, t, center, ::Val{Axis}) where {Axis}
    Tp = eltype(p)
    x = WaterLily.loc(0, I, Tp)
    d, unused_normal, unused_velocity = WaterLily.measure(body, x, t, fastd²=1)
    abs(d) > one(Tp) && return zero(Tp)

    n = WaterLily.nds(body, x, t)
    traction = p[I] * n - 2 * ν * WaterLily.S(I, u) * n
    lever = x - center
    Axis == 3 && return lever[1] * traction[2] - lever[2] * traction[1]
    Axis == 1 && return lever[2] * traction[3] - lever[3] * traction[2]
    return lever[3] * traction[1] - lever[1] * traction[3]
end

function free_swim_surface_moment_3d(sim, center, z_plane, axis::Int)
    t = WaterLily.time(sim.flow)
    Tp = eltype(sim.flow.p)
    To = promote_type(Float64, Tp)
    center_t = SVector(Tp(center[1]), Tp(center[2]), Tp(z_plane))
    sim.flow.σ .= zero(Tp)
    if axis == 3
        WaterLily.@loop sim.flow.σ[I] = free_swim_moment_density_3d(
            I, sim.flow.p, sim.flow.u, sim.flow.ν, sim.body, t, center_t, Val(3),
        ) over I ∈ inside(sim.flow.p)
    elseif axis == 1
        WaterLily.@loop sim.flow.σ[I] = free_swim_moment_density_3d(
            I, sim.flow.p, sim.flow.u, sim.flow.ν, sim.body, t, center_t, Val(1),
        ) over I ∈ inside(sim.flow.p)
    else
        WaterLily.@loop sim.flow.σ[I] = free_swim_moment_density_3d(
            I, sim.flow.p, sim.flow.u, sim.flow.ν, sim.body, t, center_t, Val(2),
        ) over I ∈ inside(sim.flow.p)
    end
    moment = sum(To, sim.flow.σ, dims=ntuple(i -> i, ndims(sim.flow.σ)))[:] |> Array
    return Float64(moment[1])
end

# Planar dynamics use (Fx, Fy, Mz); Fz comes back as a diagnostic for the
# locked heave DOF. Signs follow the 2D case (body force = -fluid integral).
function free_swim_body_force_moment_3d(sim, center, z_plane)
    total = WaterLily.total_force(sim)
    moment_z = free_swim_surface_moment_3d(sim, center, z_plane, 3)
    return SVector(-total[1], -total[2]), -moment_z, -Float64(total[3])
end

function free_swim_locked_moments_3d(sim, center, z_plane)
    moment_x = free_swim_surface_moment_3d(sim, center, z_plane, 1)
    moment_y = free_swim_surface_moment_3d(sim, center, z_plane, 2)
    return -moment_x, -moment_y
end

function set_free_swim_body_3d!(
    sim,
    design,
    sdf,
    profile,
    assembled_params,
    state::Base2D.FreeSwimState{T},
    reference_time::T,
    centroid_dt::T,
    Lf::T,
    z_plane::T;
    height_scale::T=one(T),
    caudal_fin=nothing,
    reference_station=nothing,
) where {T}
    map = free_swim_map_3d(
        design,
        assembled_params,
        profile,
        Lf,
        state,
        reference_time,
        centroid_dt,
        z_plane;
        height_scale,
        reference_station,
    )
    sim.body = compose_body_3d(sdf, map, caudal_fin)
    return sim
end

function run_free_swim_rollout_3d(
    design,
    experiment::NamedTuple;
    L::Int=16,
    Re::Float32=2000f0,
    T::Type=Float32,
    backend="auto",
    mem=nothing,
    domain_scale=(12, 6, 2),
    initial_center_fraction=(0.75f0, 0.5f0, 0.5f0),
    initial_heading=0.0f0,
    initial_velocity=(0.0f0, 0.0f0),
    initial_omega=0.0f0,
    n_cycles::Float32=1.0f0,
    samples_per_cycle::Int=24,
    body_density::Float32=1.0f0,
    height_scale::Float32=Float32(DEFAULT_DOGFISH_HEIGHT_SCALE),
    caudal_fin=nothing,
    body_sdf=nothing,
    reference_station=nothing,
    fin_material_density::Float32=body_density,
    added_mass_forward_coefficient::Float32=0.1f0,
    added_mass_scale::Float32=1.0f0,
    added_inertia_scale::Float32=1.0f0,
    linear_damping::Float32=0.0f0,
    angular_damping::Float32=0.0f0,
    time_step_fraction::Float32=0.01f0,
    max_steps::Int=200000,
    locked_moment_diagnostics::Bool=true,
    sample_hook=nothing,
)
    body_density >= 0f0 || error("body_density must be nonnegative")
    fin_material_density >= 0f0 || error("fin_material_density must be nonnegative")
    height_scale > 0f0 || error("height_scale must be positive")
    added_mass_forward_coefficient >= 0f0 ||
        error("added_mass_forward_coefficient must be nonnegative")
    added_mass_scale >= 0f0 || error("added_mass_scale must be nonnegative")
    added_inertia_scale >= 0f0 || error("added_inertia_scale must be nonnegative")
    time_step_fraction > 0f0 || error("time_step_fraction must be positive")

    sim, state, z_plane, period, morphology_params, assembled_params, resolved_backend, profile =
        build_free_swim_simulation_3d(
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
            height_scale,
            caudal_fin,
            body_sdf,
            time_step_fraction,
            reference_station,
        )

    Lf = T(L)
    typed_height_scale = T(height_scale)
    sdf = body_sdf === nothing ? Dogfish3DSDF(Lf, profile, typed_height_scale) : body_sdf
    props = body_sdf === nothing ?
        combined_body_properties_3d(
            profile,
            Lf;
            density=T(body_density),
            height_scale=typed_height_scale,
            fin=caudal_fin,
        ) :
        combined_body_properties_superellipse(
            body_sdf;
            density=T(body_density),
            fin=caudal_fin,
            fin_material_density=T(fin_material_density),
            reference_x=reference_station === nothing ? nothing : T(reference_station) * Lf,
        )
    volume = props.volume
    mass = props.mass
    inertia = props.inertia_z
    added_mass = body_sdf === nothing ?
        free_swim_added_mass_properties_3d(
            profile,
            Lf;
            density=T(body_density),
            height_scale=typed_height_scale,
            forward_coefficient=T(added_mass_forward_coefficient),
            translational_scale=T(added_mass_scale),
            rotational_scale=T(added_inertia_scale),
        ) :
        superellipse_added_mass(
            body_sdf;
            density=T(body_density),
            forward_coefficient=T(added_mass_forward_coefficient),
            translational_scale=T(added_mass_scale),
            rotational_scale=T(added_inertia_scale),
            reference_x=reference_station === nothing ? nothing : T(reference_station) * Lf,
        )
    if caudal_fin !== nothing
        fin_am = caudal_fin_added_mass(
            caudal_fin; density=T(body_density), centroid_x=props.centroid_x,
        )
        added_mass = merge(added_mass, (
            lateral=added_mass.lateral + T(added_mass_scale) * fin_am.lateral,
            inertia=added_mass.inertia + T(added_inertia_scale) * fin_am.inertia,
        ))
    end
    target_time = Float64(n_cycles) * period
    raw_dt_cap = max(eps(T), T(period) * Lf * T(time_step_fraction))
    sample_dt = period / max(1, samples_per_cycle)
    next_sample_time = sample_dt
    steps = 0

    times = Float64[0.0]
    centers = [(Float64(state.center[1]), Float64(state.center[2]))]
    velocities = [(Float64(state.velocity[1]), Float64(state.velocity[2]))]
    forces = [(0.0, 0.0)]
    forces_z = [0.0]
    moments = [0.0]
    locked_moments_x = [0.0]
    locked_moments_y = [0.0]
    headings = [Float64(state.theta)]
    angular_velocities = [Float64(state.omega)]

    termination = "horizon"
    failure_message = nothing
    wall_start = time_ns()

    while sim_time(sim) < target_time && steps < max_steps
        Base2D.cap_free_swim_timestep!(sim, raw_dt_cap, target_time)
        raw_t0 = T(WaterLily.time(sim.flow))
        raw_dt = T(sim.flow.Δt[end])
        raw_t1 = raw_t0 + raw_dt

        if !(isfinite(raw_t0) && isfinite(raw_dt) && raw_dt > zero(T))
            termination = "nonfinite_time_step"
            failure_message = "nonfinite or nonpositive solver time step before body update"
            break
        end

        # All recorded surface quantities (force, Mz, and the locked-DOF
        # moments) are measured here, before the flow step, on the same field.
        # Sampling after the step is unsafe: the episode's final step can be a
        # degenerate float-remainder dt, whose pressure field corrupts any
        # post-step surface integral.
        projected_time = Float64((raw_t0 + raw_dt) / Lf)
        sampling_now = projected_time + eps(projected_time) >= next_sample_time ||
            projected_time >= target_time
        force, moment_z, force_z = free_swim_body_force_moment_3d(sim, state.center, z_plane)
        locked_mx, locked_my = (locked_moment_diagnostics && sampling_now) ?
            free_swim_locked_moments_3d(sim, state.center, z_plane) : (0.0, 0.0)
        next_state = Base2D.update_free_swim_state(
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
            isfinite(force_z) &&
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

        body_state = Base2D.free_swim_step_body_state(state, next_state, raw_dt)
        sim.body = compose_body_3d(
            sdf,
            free_swim_map_3d(
                design,
                assembled_params,
                profile,
                Lf,
                body_state,
                raw_t1,
                raw_dt,
                z_plane;
                height_scale=typed_height_scale,
                reference_station,
            ),
            caudal_fin,
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
            push!(forces_z, Float64(force_z))
            push!(moments, Float64(moment_z))
            push!(locked_moments_x, locked_mx)
            push!(locked_moments_y, locked_my)
            push!(headings, Float64(state.theta))
            push!(angular_velocities, Float64(state.omega))
            if sample_hook !== nothing
                sample_hook(sim, state, Float64(WaterLily.time(sim.flow)), Float64(current_time))
            end
            next_sample_time += sample_dt
        end
    end

    wall_seconds = (time_ns() - wall_start) / 1.0e9
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
        wall_seconds=wall_seconds,
        grid_L=L,
        Re=Float64(Re),
        domain_dims=size(sim.flow.p) .- 2,
        cell_count=prod(size(sim.flow.p) .- 2),
        memory_backend=resolved_backend.name,
        cuda_available=resolved_backend.cuda_available,
        body_density=Float64(body_density),
        fin_material_density=Float64(fin_material_density),
        material_reference_station=reference_station === nothing ? nothing : Float64(reference_station),
        material_reference_x=reference_station === nothing ? nothing : Float64(reference_station) * Float64(Lf),
        physical_mass_centroid_x=hasproperty(props, :physical_mass_centroid_x) ?
            Float64(props.physical_mass_centroid_x) : Float64(props.centroid_x),
        uniform_density_mass_centroid_x=hasproperty(props, :uniform_density_mass_centroid_x) ?
            Float64(props.uniform_density_mass_centroid_x) : Float64(props.centroid_x),
        body_volume_centroid_x=hasproperty(props, :body_volume_centroid_x) ?
            Float64(props.body_volume_centroid_x) : Float64(props.centroid_x),
        fin_material_mass=hasproperty(props, :fin_mass) ? Float64(props.fin_mass) : nothing,
        height_scale=Float64(height_scale),
        mass=Float64(mass),
        inertia=Float64(inertia),
        body_volume=Float64(volume),
        z_plane=Float64(z_plane),
        added_mass_model=String(added_mass.model),
        added_mass_forward=Float64(added_mass.forward),
        added_mass_lateral=Float64(added_mass.lateral),
        added_inertia=Float64(added_mass.inertia),
        added_mass_forward_coefficient=Float64(added_mass_forward_coefficient),
        added_mass_scale=Float64(added_mass_scale),
        added_inertia_scale=Float64(added_inertia_scale),
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
            force_z=forces_z,
            moment_z=moments,
            locked_moment_x=locked_moments_x,
            locked_moment_y=locked_moments_y,
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

function write_free_swim_outputs_3d(output_root::AbstractString, rollout)
    mkpath(output_root)
    open(joinpath(output_root, "free_swim3d_result.json"), "w") do io
        JSON.print(io, Base2D.jsonable(rollout), 2)
        println(io)
    end
    open(joinpath(output_root, "free_swim3d_trajectory.csv"), "w") do io
        println(
            io,
            "time,center_x,center_y,velocity_x,velocity_y,force_x,force_y,force_z," *
            "moment_z,locked_moment_x,locked_moment_y,heading,omega",
        )
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
                        rollout.trace.force_z[index],
                        rollout.trace.moment_z[index],
                        rollout.trace.locked_moment_x[index],
                        rollout.trace.locked_moment_y[index],
                        rollout.trace.heading[index],
                        rollout.trace.omega[index],
                    ),
                    ",",
                ),
            )
        end
    end
    return (
        result=joinpath(output_root, "free_swim3d_result.json"),
        trajectory=joinpath(output_root, "free_swim3d_trajectory.csv"),
    )
end
