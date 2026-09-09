case_dir = @__DIR__

include(joinpath(case_dir, "free_swim_target_episode.jl"))

using JLD2
using Random

function configured_float32_vector(config, key::String, env_name::String, default)
    raw = DogfishShapePolicyTestbed.run_config_env_present(env_name) ?
          get(ENV, env_name, join(default, ",")) :
          get(config, key, default)
    values = raw isa AbstractVector ? raw : split(string(raw), ",")
    parsed = Float32[DogfishShapePolicyTestbed.run_config_float32(value, key) for value in values]
    isempty(parsed) && error("$key must contain at least one value")
    return parsed
end

function current_cylinder_centers(cylinder_motions, t)
    return [cylinder_center_at(motion, t) for motion in cylinder_motions]
end

function fish_cylinder_clearance(
    params,
    profile,
    Lf,
    state,
    cylinder_centers,
    cylinder_radii;
    samples=64,
)
    isempty(cylinder_centers) && return Inf
    map = DogfishShapePolicyTestbed.SpineMotionMap(
        DogfishShapePolicyTestbed.two_joint_bend_angle_with_rates,
        params,
        Lf,
    )
    sample_time = body_map_sample_time(params, Lf)
    reference_center = free_swim_reference_center(params, profile, Lf)
    outline = DogfishShapePolicyTestbed.spine_outline_points(map, profile, sample_time; samples)
    clearance = Inf
    for point in outline.closed
        world_point = local_to_world(point, reference_center, state)
        for (center, radius) in zip(cylinder_centers, cylinder_radii)
            distance = hypot(
                Float64(world_point[1] - center[1]),
                Float64(world_point[2] - center[2]),
            ) - Float64(radius)
            clearance = min(clearance, distance)
        end
    end
    return clearance
end

struct CircleSDF{T} <: Function
    radius::T
end

@inline function (body::CircleSDF)(x, t)
    T = typeof(x[1])
    return sqrt(sum(abs2, x)) - T(body.radius)
end

struct CylinderMotionMap{T} <: Function
    base_center::SVector{2, T}
    amplitude::T
    start_time::T
    duration::T
    cycles::T
end

@inline function cylinder_center_at(map::CylinderMotionMap, t)
    T = typeof(t)
    base_center = SVector(T(map.base_center[1]), T(map.base_center[2]))
    amplitude = T(map.amplitude)
    duration = T(map.duration)
    if amplitude == zero(T) || duration <= zero(T)
        return base_center
    end
    tau = (T(t) - T(map.start_time)) / duration
    if tau <= zero(T) || tau >= one(T)
        return base_center
    end
    envelope = sin(T(pi) * tau)^2
    displacement = amplitude * envelope * sin(T(2pi) * T(map.cycles) * tau)
    return base_center + SVector(zero(T), displacement)
end

@inline function (map::CylinderMotionMap)(x, t)
    return x - cylinder_center_at(map, t)
end

function make_fish_body(design, sdf, profile, assembled_params, state, reference_time, centroid_dt, Lf)
    return AutoBody(
        sdf,
        DogfishShapePolicyTestbed.free_swim_map(
            design,
            assembled_params,
            profile,
            Lf,
            state,
            reference_time,
            centroid_dt,
        ),
    )
end

function set_wake_swim_body!(
    sim,
    design,
    sdf,
    profile,
    assembled_params,
    state,
    reference_time,
    centroid_dt,
    Lf,
    cylinder_body,
)
    fish_body = make_fish_body(
        design,
        sdf,
        profile,
        assembled_params,
        state,
        reference_time,
        centroid_dt,
        Lf,
    )
    sim.body = fish_body + cylinder_body
    return fish_body
end

function fish_surface_moment_z(sim, fish_body, center)
    t = WaterLily.time(sim.flow)
    Tp = eltype(sim.flow.p)
    To = promote_type(Float64, Tp)
    center_t = SVector(Tp(center[1]), Tp(center[2]))
    sim.flow.σ .= zero(Tp)
    WaterLily.@loop sim.flow.σ[I] = DogfishShapePolicyTestbed.free_swim_moment_density(
        I,
        sim.flow.p,
        sim.flow.u,
        sim.flow.ν,
        fish_body,
        t,
        center_t,
    ) over I in WaterLily.inside(sim.flow.p)
    moment = sum(To, sim.flow.σ, dims=ntuple(i -> i, ndims(sim.flow.σ)))[:] |> Array
    return Float64(moment[1])
end

function fish_body_force_moment(sim, fish_body, center)
    force = WaterLily.pressure_force(sim.flow, fish_body) .+
        WaterLily.viscous_force(sim.flow, fish_body)
    force_x, force_y = DogfishShapePolicyTestbed.force_components(force)
    moment_z = fish_surface_moment_z(sim, fish_body, center)
    return SVector(-force_x, -force_y), -moment_z
end

function array_scalar(a, index::CartesianIndex, component::Int)
    if DogfishShapePolicyTestbed.is_cuda_storage(a)
        cuda = DogfishShapePolicyTestbed.CUDA_MODULE[]
        cuda === nothing && return Float64(a[index, component])
        return cuda.allowscalar() do
            Float64(a[index, component])
        end
    end
    return Float64(a[index, component])
end

function centered_flow_velocity(sim, point)
    nx, ny = size(sim.flow.p)
    ix = clamp(round(Int, Float64(point[1])), 2, nx - 1)
    iy = clamp(round(Int, Float64(point[2])), 2, ny - 1)
    I = CartesianIndex(ix, iy)
    ux = 0.5 * (
        array_scalar(sim.flow.u, I, 1) +
        array_scalar(sim.flow.u, I + WaterLily.δ(1, I), 1)
    )
    uy = 0.5 * (
        array_scalar(sim.flow.u, I, 2) +
        array_scalar(sim.flow.u, I + WaterLily.δ(2, I), 2)
    )
    return SVector(ux, uy)
end

function local_vorticity_estimate(sim, point)
    px = SVector(Float64(point[1]), Float64(point[2]))
    u_xp = centered_flow_velocity(sim, px + SVector(1.0, 0.0))
    u_xm = centered_flow_velocity(sim, px - SVector(1.0, 0.0))
    u_yp = centered_flow_velocity(sim, px + SVector(0.0, 1.0))
    u_ym = centered_flow_velocity(sim, px - SVector(0.0, 1.0))
    duy_dx = 0.5 * (u_xp[2] - u_xm[2])
    dux_dy = 0.5 * (u_yp[1] - u_ym[1])
    scale = Float64(sim.L) / max(abs(Float64(sim.U)), eps(Float64))
    return Float64(duy_dx - dux_dy) * scale
end

function body_probe_point(obs, state, offset_L, Lf)
    T = eltype(state.center)
    offset_body = SVector(T(offset_L[1]) * Lf, T(offset_L[2]) * Lf)
    return obs.head + DogfishShapePolicyTestbed.rotate_to_world_frame(offset_body, state.theta)
end

function flow_body_at(sim, point, state)
    local_flow = centered_flow_velocity(sim, point)
    T = eltype(state.center)
    return DogfishShapePolicyTestbed.rotate_to_body_frame(
        SVector(T(local_flow[1]), T(local_flow[2])),
        state.theta,
    )
end

function tuple2(value)
    return (Float64(value[1]), Float64(value[2]))
end

function history_scalar(row, name::Symbol, fallback)
    return row !== nothing && hasproperty(row, name) ?
        Float64(getproperty(row, name)) :
        Float64(fallback)
end

function wake_vorticity_field!(sim)
    WaterLily.@inside sim.flow.σ[I] = WaterLily.curl(3, I, sim.flow.u) * sim.L / sim.U
    return Array(sim.flow.σ)
end

function wake_sdf_field!(sim)
    WaterLily.measure_sdf!(sim.flow.σ, sim.body, WaterLily.time(sim.flow); fastd²=0f0)
    return Array(sim.flow.σ)
end

function wake_plot_axis(n::Integer)
    return collect(range(-0.5f0; step=1.0f0, length=n))
end

function optional_configured_path(config, key::AbstractString, env_name::AbstractString)
    value = DogfishShapePolicyTestbed.configured_string(config, key, env_name, "")
    stripped = strip(String(value))
    return isempty(stripped) ? nothing : stripped
end

function snapshot_sidecar_path(snapshot_path::AbstractString)
    return string(snapshot_path, ".json")
end

function save_wake_snapshot!(sim, snapshot_path::AbstractString; metadata)
    snapshot_dir = dirname(snapshot_path)
    isempty(snapshot_dir) && (snapshot_dir = ".")
    mkpath(snapshot_dir)
    WaterLily.save!(basename(snapshot_path), sim; dir=snapshot_dir)
    sidecar = snapshot_sidecar_path(snapshot_path)
    open(sidecar, "w") do io
        JSON.print(io, DogfishShapePolicyTestbed.jsonable(metadata), 2)
        println(io)
    end
    return sidecar
end

function load_wake_snapshot!(sim, snapshot_path::AbstractString)
    isfile(snapshot_path) || error("wake snapshot not found: $snapshot_path")
    snapshot_dir = dirname(snapshot_path)
    isempty(snapshot_dir) && (snapshot_dir = ".")
    WaterLily.load!(sim; fname=basename(snapshot_path), dir=snapshot_dir)
    sidecar = snapshot_sidecar_path(snapshot_path)
    return isfile(sidecar) ? JSON.parsefile(sidecar) : nothing
end

save_wake_prewarm_snapshot!(sim, snapshot_path::AbstractString; metadata) =
    save_wake_snapshot!(sim, snapshot_path; metadata)

load_wake_prewarm_snapshot!(sim, snapshot_path::AbstractString) =
    load_wake_snapshot!(sim, snapshot_path)

function free_swim_state_metadata(state)
    return Dict(
        "center" => collect(Float64.(state.center)),
        "theta" => Float64(state.theta),
        "velocity" => collect(Float64.(state.velocity)),
        "omega" => Float64(state.omega),
        "acceleration" => collect(Float64.(state.acceleration)),
        "angular_acceleration" => Float64(state.angular_acceleration),
    )
end

function restore_free_swim_state(metadata, ::Type{T}) where {T}
    row = metadata["free_swim_state"]
    return DogfishShapePolicyTestbed.FreeSwimState{T}(
        SVector(T(row["center"][1]), T(row["center"][2])),
        T(row["theta"]),
        SVector(T(row["velocity"][1]), T(row["velocity"][2])),
        T(row["omega"]),
        SVector(T(row["acceleration"][1]), T(row["acceleration"][2])),
        T(row["angular_acceleration"]),
    )
end

function joint_state_metadata(joint)
    return Dict(
        "phi1" => Float64(joint.phi1),
        "phi2" => Float64(joint.phi2),
        "phi_dot1" => Float64(joint.phi_dot1),
        "phi_dot2" => Float64(joint.phi_dot2),
        "phi_ddot1" => Float64(joint.phi_ddot1),
        "phi_ddot2" => Float64(joint.phi_ddot2),
    )
end

function restore_joint_state(metadata)
    row = metadata["joint_state"]
    return (
        phi1=Float64(row["phi1"]),
        phi2=Float64(row["phi2"]),
        phi_dot1=Float64(row["phi_dot1"]),
        phi_dot2=Float64(row["phi_dot2"]),
        phi_ddot1=Float64(row["phi_ddot1"]),
        phi_ddot2=Float64(row["phi_ddot2"]),
    )
end

function observation_history_metadata(observation_history)
    return [
        Dict(
            "time" => Float64(row.time),
            "target_body" => collect(Float64.(row.target_body)),
            "distance" => Float64(row.distance),
            "bearing" => Float64(row.bearing),
            "wake_crossflow_velocity" => Float64(row.wake_crossflow_velocity),
            "wake_streamwise_velocity" => Float64(row.wake_streamwise_velocity),
            "local_vorticity" => Float64(row.local_vorticity),
            "force_body_y" => Float64(row.force_body_y),
            "moment_z" => Float64(row.moment_z),
        ) for row in observation_history
    ]
end

function restore_observation_history(metadata, ::Type{T}) where {T}
    rows = get(metadata, "observation_history", Any[])
    return Any[
        (
            time=Float64(row["time"]),
            target_body=SVector(T(row["target_body"][1]), T(row["target_body"][2])),
            distance=T(row["distance"]),
            bearing=T(row["bearing"]),
            wake_crossflow_velocity=Float64(row["wake_crossflow_velocity"]),
            wake_streamwise_velocity=Float64(row["wake_streamwise_velocity"]),
            local_vorticity=Float64(row["local_vorticity"]),
            force_body_y=Float64(row["force_body_y"]),
            moment_z=Float64(row["moment_z"]),
        ) for row in rows
    ]
end

function finite_mean(values)
    filtered = [Float64(value) for value in values if isfinite(Float64(value))]
    return isempty(filtered) ? nothing : sum(filtered) / length(filtered)
end

function finite_rms(values)
    filtered = [Float64(value) for value in values if isfinite(Float64(value))]
    return isempty(filtered) ? nothing : sqrt(sum(abs2, filtered) / length(filtered))
end

function finite_max_abs(values)
    filtered = [abs(Float64(value)) for value in values if isfinite(Float64(value))]
    return isempty(filtered) ? nothing : maximum(filtered)
end

function wake_body_frame_observation(
    obs,
    state,
    sim,
    cylinder_center,
    cylinder_radius,
    local_flow,
    inflow_velocity,
    Lf;
    observation_history=(),
)
    T = eltype(state.center)
    cylinder_delta = SVector(T(cylinder_center[1] - obs.head[1]), T(cylinder_center[2] - obs.head[2]))
    cylinder_body = DogfishShapePolicyTestbed.rotate_to_body_frame(cylinder_delta, state.theta)
    wake_delta = SVector(T(obs.head[1] - cylinder_center[1]), T(obs.head[2] - cylinder_center[2]))
    local_flow_body = DogfishShapePolicyTestbed.rotate_to_body_frame(
        SVector(T(local_flow[1]), T(local_flow[2])),
        state.theta,
    )
    inflow_body = DogfishShapePolicyTestbed.rotate_to_body_frame(
        SVector(T(inflow_velocity[1]), T(inflow_velocity[2])),
        state.theta,
    )
    relative_flow_body = local_flow_body - obs.velocity_body
    local_vorticity = local_vorticity_estimate(sim, obs.head)

    wake_probe_names = (:ahead, :left, :right, :tail)
    wake_probe_offsets_L = ((-0.50, 0.0), (0.0, 0.35), (0.0, -0.35), (0.80, 0.0))
    wake_probe_points = Tuple(body_probe_point(obs, state, offset_L, Lf) for offset_L in wake_probe_offsets_L)
    wake_probe_flow_body = Tuple(tuple2(flow_body_at(sim, point, state)) for point in wake_probe_points)
    wake_probe_vorticity = Tuple(local_vorticity_estimate(sim, point) for point in wake_probe_points)

    cylinder_wake_probe_offsets_L = ((1.0, 0.0), (2.0, 0.0), (3.0, 0.0))
    cylinder_wake_probe_points = Tuple(
        SVector(
            T(cylinder_center[1]) + T(offset_L[1]) * Lf,
            T(cylinder_center[2]) + T(offset_L[2]) * Lf,
        ) for offset_L in cylinder_wake_probe_offsets_L
    )
    cylinder_wake_probe_velocity = Tuple(tuple2(centered_flow_velocity(sim, point)) for point in cylinder_wake_probe_points)
    cylinder_wake_probe_velocity_body = Tuple(tuple2(flow_body_at(sim, point, state)) for point in cylinder_wake_probe_points)
    cylinder_wake_vorticity = Tuple(local_vorticity_estimate(sim, point) for point in cylinder_wake_probe_points)

    station_point = obs.head + obs.target_delta
    station_flow = centered_flow_velocity(sim, station_point)
    station_flow_body = DogfishShapePolicyTestbed.rotate_to_body_frame(
        SVector(T(station_flow[1]), T(station_flow[2])),
        state.theta,
    )
    station_vorticity = local_vorticity_estimate(sim, station_point)

    history_count = length(observation_history)
    previous_row = history_count > 0 ? observation_history[end] : nothing
    dt = Float64(getproperty(obs, :history_dt))
    has_history = previous_row !== nothing && isfinite(dt) && dt > 0.0
    stack_length = max(1, Int(getproperty(obs, :history_count)))
    previous_stack_count = min(history_count, stack_length - 1)
    oldest_row = previous_stack_count > 0 ? observation_history[history_count - previous_stack_count + 1] : nothing
    history_window_dt = Float64(getproperty(obs, :history_window_dt))

    wake_crossflow_velocity = Float64(local_flow_body[2])
    wake_streamwise_velocity = Float64(local_flow_body[1])
    force_body_y = Float64(obs.force_body[2])
    moment_z_value = Float64(obs.moment_z)
    previous_wake_crossflow = history_scalar(previous_row, :wake_crossflow_velocity, wake_crossflow_velocity)
    previous_wake_streamwise = history_scalar(previous_row, :wake_streamwise_velocity, wake_streamwise_velocity)
    previous_vorticity = history_scalar(previous_row, :local_vorticity, local_vorticity)
    previous_force_y = history_scalar(previous_row, :force_body_y, force_body_y)
    previous_moment_z = history_scalar(previous_row, :moment_z, moment_z_value)
    oldest_wake_crossflow = history_scalar(oldest_row, :wake_crossflow_velocity, wake_crossflow_velocity)
    oldest_wake_streamwise = history_scalar(oldest_row, :wake_streamwise_velocity, wake_streamwise_velocity)
    oldest_vorticity = history_scalar(oldest_row, :local_vorticity, local_vorticity)
    oldest_force_y = history_scalar(oldest_row, :force_body_y, force_body_y)
    oldest_moment_z = history_scalar(oldest_row, :moment_z, moment_z_value)

    wake_crossflow_window_delta = wake_crossflow_velocity - oldest_wake_crossflow
    wake_streamwise_window_delta = wake_streamwise_velocity - oldest_wake_streamwise
    local_vorticity_window_delta = local_vorticity - oldest_vorticity
    force_y_window_delta = force_body_y - oldest_force_y
    moment_z_window_delta = moment_z_value - oldest_moment_z
    force_scale = max(Float64(Lf), eps(Float64))
    moment_scale = max(Float64(Lf)^2, eps(Float64))
    return merge(
        obs,
        (
            task_family=:cylinder_wake_station_holding,
            cylinder_center=Tuple(Float64.(cylinder_center)),
            cylinder_center_L=(
                Float64(cylinder_center[1]) / Float64(Lf),
                Float64(cylinder_center[2]) / Float64(Lf),
            ),
            cylinder_radius_L=Float64(cylinder_radius) / Float64(Lf),
            cylinder_body=(
                Float64(cylinder_body[1]) / Float64(Lf),
                Float64(cylinder_body[2]) / Float64(Lf),
            ),
            cylinder_distance_L=(
                hypot(Float64(cylinder_delta[1]), Float64(cylinder_delta[2])) -
                Float64(cylinder_radius)
            ) / Float64(Lf),
            wake_position_L=(
                Float64(wake_delta[1]) / Float64(Lf),
                Float64(wake_delta[2]) / Float64(Lf),
            ),
            inflow_velocity_body=Tuple(Float64.(inflow_body)),
            inflow_velocity_body_U=Tuple(Float64.(inflow_body)),
            local_flow_velocity_body=Tuple(Float64.(local_flow_body)),
            local_flow_velocity_body_U=Tuple(Float64.(local_flow_body)),
            relative_flow_velocity_body=Tuple(Float64.(relative_flow_body)),
            relative_flow_velocity_body_U=Tuple(Float64.(relative_flow_body)),
            local_flow_speed=Float64(hypot(local_flow[1], local_flow[2])),
            local_flow_speed_U=Float64(hypot(local_flow[1], local_flow[2])),
            local_vorticity=local_vorticity,
            local_vorticity_rate=has_history ? (local_vorticity - previous_vorticity) / dt : 0.0,
            local_vorticity_window_delta=local_vorticity_window_delta,
            local_vorticity_window_rate=history_window_dt > 0.0 ? local_vorticity_window_delta / history_window_dt : 0.0,
            wake_crossflow_velocity=wake_crossflow_velocity,
            wake_crossflow_velocity_U=wake_crossflow_velocity,
            wake_streamwise_velocity=wake_streamwise_velocity,
            wake_streamwise_velocity_U=wake_streamwise_velocity,
            wake_crossflow_velocity_rate=has_history ? (wake_crossflow_velocity - previous_wake_crossflow) / dt : 0.0,
            wake_streamwise_velocity_rate=has_history ? (wake_streamwise_velocity - previous_wake_streamwise) / dt : 0.0,
            wake_crossflow_window_delta=wake_crossflow_window_delta,
            wake_streamwise_window_delta=wake_streamwise_window_delta,
            wake_crossflow_window_rate=history_window_dt > 0.0 ? wake_crossflow_window_delta / history_window_dt : 0.0,
            wake_streamwise_window_rate=history_window_dt > 0.0 ? wake_streamwise_window_delta / history_window_dt : 0.0,
            force_y_rate=has_history ? (force_body_y - previous_force_y) / dt : 0.0,
            force_y_rate_L=has_history ? (force_body_y - previous_force_y) / (force_scale * dt) : 0.0,
            moment_z_rate=has_history ? (moment_z_value - previous_moment_z) / dt : 0.0,
            moment_z_rate_L2=has_history ? (moment_z_value - previous_moment_z) / (moment_scale * dt) : 0.0,
            force_y_window_delta=force_y_window_delta,
            force_y_window_delta_L=force_y_window_delta / force_scale,
            moment_z_window_delta=moment_z_window_delta,
            moment_z_window_delta_L2=moment_z_window_delta / moment_scale,
            force_y_window_rate=history_window_dt > 0.0 ? force_y_window_delta / history_window_dt : 0.0,
            force_y_window_rate_L=history_window_dt > 0.0 ? force_y_window_delta / (force_scale * history_window_dt) : 0.0,
            moment_z_window_rate=history_window_dt > 0.0 ? moment_z_window_delta / history_window_dt : 0.0,
            moment_z_window_rate_L2=history_window_dt > 0.0 ? moment_z_window_delta / (moment_scale * history_window_dt) : 0.0,
            wake_probe_names=wake_probe_names,
            wake_probe_offsets_L=wake_probe_offsets_L,
            wake_probe_flow_body=wake_probe_flow_body,
            wake_probe_flow_body_U=wake_probe_flow_body,
            wake_probe_vorticity=wake_probe_vorticity,
            ahead_probe_flow_body=wake_probe_flow_body[1],
            left_probe_flow_body=wake_probe_flow_body[2],
            right_probe_flow_body=wake_probe_flow_body[3],
            tail_probe_flow_body=wake_probe_flow_body[4],
            ahead_probe_vorticity=wake_probe_vorticity[1],
            left_probe_vorticity=wake_probe_vorticity[2],
            right_probe_vorticity=wake_probe_vorticity[3],
            tail_probe_vorticity=wake_probe_vorticity[4],
            cylinder_wake_probe_offsets_L=cylinder_wake_probe_offsets_L,
            cylinder_wake_probe_velocity=cylinder_wake_probe_velocity,
            cylinder_wake_probe_velocity_body=cylinder_wake_probe_velocity_body,
            cylinder_wake_probe_velocity_body_U=cylinder_wake_probe_velocity_body,
            cylinder_wake_streamwise_velocity=Tuple(value[1] for value in cylinder_wake_probe_velocity),
            cylinder_wake_crossflow_velocity=Tuple(value[2] for value in cylinder_wake_probe_velocity),
            cylinder_wake_vorticity=cylinder_wake_vorticity,
            station_flow_velocity_body=tuple2(station_flow_body),
            station_flow_velocity_body_U=tuple2(station_flow_body),
            station_streamwise_velocity=Float64(station_flow_body[1]),
            station_crossflow_velocity=Float64(station_flow_body[2]),
            station_vorticity=station_vorticity,
        ),
    )
end

function wake_body_frame_observation(
    obs,
    state,
    sim,
    cylinder_centers::AbstractVector,
    cylinder_radii::AbstractVector,
    local_flow,
    inflow_velocity,
    Lf;
    observation_history=(),
)
    length(cylinder_centers) == length(cylinder_radii) ||
        error("cylinder center/radius counts must match")
    isempty(cylinder_centers) && error("at least one cylinder is required")
    distances = [
        hypot(
            Float64(center[1] - obs.head[1]),
            Float64(center[2] - obs.head[2]),
        ) - Float64(radius)
        for (center, radius) in zip(cylinder_centers, cylinder_radii)
    ]
    nearest_index = argmin(distances)
    enriched = wake_body_frame_observation(
        obs,
        state,
        sim,
        cylinder_centers[nearest_index],
        cylinder_radii[nearest_index],
        local_flow,
        inflow_velocity,
        Lf;
        observation_history,
    )
    return merge(
        enriched,
        (
            task_family=length(cylinder_centers) == 1 ?
                        :cylinder_wake_station_holding :
                        :multi_cylinder_wake_targeting,
            cylinder_centers=Tuple(Tuple(Float64.(center)) for center in cylinder_centers),
            cylinder_centers_L=Tuple(
                (
                    Float64(center[1]) / Float64(Lf),
                    Float64(center[2]) / Float64(Lf),
                ) for center in cylinder_centers
            ),
            cylinder_radii_L=Tuple(Float64(radius) / Float64(Lf) for radius in cylinder_radii),
            nearest_cylinder_index=nearest_index,
            nearest_cylinder_clearance_L=distances[nearest_index] / Float64(Lf),
        ),
    )
end

function build_wake_swim_simulation(
    design,
    experiment::NamedTuple;
    L::Int=32,
    Re::Float32=1000f0,
    T::Type=Float32,
    backend="auto",
    mem=nothing,
    domain_scale=(16.0f0, 8.0f0),
    initial_center_x_L::Float32=5.0f0,
    initial_head_distance_from_target_L::Union{Nothing, Float32}=nothing,
    initial_center_y_fraction::Float32=0.5f0,
    initial_center_y_L::Union{Nothing, Float32}=nothing,
    initial_heading=0.0f0,
    initial_velocity=(0.0f0, 0.0f0),
    initial_omega=0.0f0,
    max_dimensionless_dt::Float32=0.0055f0,
    flow_speed::Float32=1.0f0,
    target_x_L::Float32=3.0f0,
    cylinder_center_x_L::Float32=1.5f0,
    cylinder_center_y_fraction::Float32=0.5f0,
    cylinder_diameter_L::Float32=0.30f0,
    cylinder_centers_x_L::Union{Nothing, Vector{Float32}}=nothing,
    cylinder_centers_y_L::Union{Nothing, Vector{Float32}}=nothing,
    cylinder_diameters_L::Union{Nothing, Vector{Float32}}=nothing,
    cylinder_kick_amplitude_L::Float32=0.0f0,
    cylinder_kick_start::Float32=0.0f0,
    cylinder_kick_duration::Float32=0.0f0,
    cylinder_kick_cycles::Float32=1.0f0,
    exit_bc::Bool=true,
)
    max_dimensionless_dt > 0f0 || error("max_dimensionless_dt must be positive")
    flow_speed >= 0f0 || error("flow_speed must be nonnegative")
    cylinder_diameter_L > 0f0 || error("cylinder_diameter_L must be positive")
    Re > 0f0 || error("Re must be positive")

    resolved_backend = DogfishShapePolicyTestbed.resolve_memory_backend(backend=backend, mem=mem)
    _, assembled_params, period = DogfishShapePolicyTestbed.assemble_experiment_for_length(
        design,
        experiment;
        L,
        T,
    )
    morphology_params = DogfishShapePolicyTestbed.baseline_morphology_parameters(T)
    Lf = T(L)
    raw_dt_cap = max(eps(T), T(max_dimensionless_dt) * Lf)
    profile = DogfishShapePolicyTestbed.baseline_thickness_profile(T)
    dims = (
        max(4L, Int(round(Float64(domain_scale[1]) * L))),
        max(2L, Int(round(Float64(domain_scale[2]) * L))),
    )
    center_x = T(initial_center_x_L) * Lf
    if initial_head_distance_from_target_L !== nothing
        reference_center = free_swim_reference_center(assembled_params, profile, Lf)
        head_offset = DogfishShapePolicyTestbed.rotate_to_world_frame(-reference_center, T(initial_heading))
        center_x = T(target_x_L + initial_head_distance_from_target_L) * Lf - head_offset[1]
    end
    center_y = initial_center_y_L === nothing ?
               T(initial_center_y_fraction) * T(dims[2]) :
               T(initial_center_y_L) * Lf
    center = SVector(center_x, center_y)
    state = DogfishShapePolicyTestbed.FreeSwimState(
        center,
        T(initial_heading),
        SVector(T(initial_velocity[1]), T(initial_velocity[2])),
        T(initial_omega),
    )
    sdf = DogfishShapePolicyTestbed.DogfishSDF(Lf, profile)
    fish_body = make_fish_body(design, sdf, profile, assembled_params, state, zero(T), raw_dt_cap, Lf)
    centers_x_L = cylinder_centers_x_L === nothing ? Float32[cylinder_center_x_L] : cylinder_centers_x_L
    centers_y_L = cylinder_centers_y_L === nothing ?
                  Float32[cylinder_center_y_fraction * Float32(domain_scale[2])] :
                  cylinder_centers_y_L
    diameters_L = cylinder_diameters_L === nothing ? Float32[cylinder_diameter_L] : cylinder_diameters_L
    length(centers_x_L) == length(centers_y_L) == length(diameters_L) ||
        error("cylinder_centers_x_L, cylinder_centers_y_L, and cylinder_diameters_L must have equal lengths")
    isempty(centers_x_L) && error("at least one cylinder is required")
    all(>(0f0), diameters_L) || error("all cylinder diameters must be positive")
    cylinder_centers = [SVector(T(x_L) * Lf, T(y_L) * Lf) for (x_L, y_L) in zip(centers_x_L, centers_y_L)]
    cylinder_radii = [T(0.5f0 * diameter_L) * Lf for diameter_L in diameters_L]
    cylinder_motions = [
        CylinderMotionMap(
            center,
            T(cylinder_kick_amplitude_L) * Lf,
            T(cylinder_kick_start) * Lf,
            T(cylinder_kick_duration) * Lf,
            T(cylinder_kick_cycles),
        ) for center in cylinder_centers
    ]
    cylinder_bodies = [
        AutoBody(CircleSDF(radius), motion)
        for (radius, motion) in zip(cylinder_radii, cylinder_motions)
    ]
    cylinder_body = reduce(+, cylinder_bodies)
    simulation_builder = () -> Simulation(
        dims,
        (T(flow_speed), zero(T)),
        L;
        U=one(T),
        Δt=raw_dt_cap,
        ν=Lf / T(Re),
        body=fish_body + cylinder_body,
        T,
        mem=resolved_backend.mem,
        exitBC=exit_bc,
    )
    sim = resolved_backend.name == "cuda" ? Base.invokelatest(simulation_builder) : simulation_builder()
    return (
        sim,
        state,
        period,
        morphology_params,
        assembled_params,
        resolved_backend,
        profile,
        sdf,
        fish_body,
        cylinder_body,
        cylinder_motions,
        cylinder_centers,
        cylinder_radii,
    )
end

function render_wake_episode_frame(
    output_path,
    state,
    params,
    profile,
    Lf,
    centers,
    heads,
    target,
    success_radius,
    cylinder_centers,
    cylinder_radii,
    dims,
    elapsed_time,
    horizon,
    distance,
)
    map = DogfishShapePolicyTestbed.SpineMotionMap(
        DogfishShapePolicyTestbed.two_joint_bend_angle_with_rates,
        params,
        Lf,
    )
    sample_time = body_map_sample_time(params, Lf)
    reference_center = free_swim_reference_center(params, profile, Lf)
    outline = DogfishShapePolicyTestbed.spine_outline_points(map, profile, sample_time; samples=192)
    world_outline = [local_to_world(point, reference_center, state) for point in outline.closed]
    centerline = [
        local_to_world(
            DogfishShapePolicyTestbed.spine_centerline(map, Float32(i / 160), sample_time),
            reference_center,
            state,
        )
        for i in 0:160
    ]

    circle_theta = range(0, 2pi; length=121)

    plt = plot(
        size=(1600, 800),
        aspect_ratio=:equal,
        legend=false,
        xlims=(0, dims[1]),
        ylims=(0, dims[2]),
        xlabel="x",
        ylabel="y",
        title=@sprintf(
            "wake station | t=%.3f / %.3f | distance=%.3f L",
            elapsed_time,
            horizon,
            distance / Float64(Lf),
        ),
        margin=6Plots.mm,
        background_color=:white,
    )
    for (cylinder_center, cylinder_radius) in zip(cylinder_centers, cylinder_radii)
        cylinder_x = [cylinder_center[1] + cylinder_radius * cos(theta) for theta in circle_theta]
        cylinder_y = [cylinder_center[2] + cylinder_radius * sin(theta) for theta in circle_theta]
        plot!(plt, Shape(cylinder_x, cylinder_y); fillcolor=RGBA(0.15, 0.15, 0.15, 0.75), linecolor=:black)
    end
    if success_radius > 0
        target_x = [target[1] + success_radius * cos(theta) for theta in circle_theta]
        target_y = [target[2] + success_radius * sin(theta) for theta in circle_theta]
        plot!(plt, target_x, target_y; color=:red, linewidth=1.0, alpha=0.55)
    end
    scatter!(plt, [target[1]], [target[2]]; markercolor=:red, markerstrokecolor=:black, markersize=3)
    if !isempty(heads)
        plot!(
            plt,
            [heads[1][1], target[1]],
            [heads[1][2], target[2]];
            color=:red,
            linestyle=:dash,
            linewidth=1.0,
            alpha=0.35,
        )
    end
    if length(centers) > 1
        plot!(plt, [p[1] for p in centers], [p[2] for p in centers]; color=:gray45, linewidth=1)
        plot!(plt, [p[1] for p in heads], [p[2] for p in heads]; color=:orange, linewidth=1.5)
    end
    plot!(
        plt,
        Shape([point[1] for point in world_outline], [point[2] for point in world_outline]);
        fillcolor=RGBA(0.45, 0.78, 0.72, 0.45),
        linecolor=:black,
        linewidth=1,
    )
    plot!(plt, [point[1] for point in centerline], [point[2] for point in centerline]; color=:orange, linewidth=1.5)
    scatter!(plt, [heads[end][1]], [heads[end][2]]; markercolor=:white, markerstrokecolor=:orange, markersize=4)
    savefig(plt, output_path)
    return output_path
end

function render_wake_flow_frame!(
    sim,
    output_path,
    centers,
    heads,
    target,
    success_radius,
    phase_label,
    elapsed_time,
    total_horizon;
    clims=(-2.0, 2.0),
    image_size=(1600, 800),
)
    omega = wake_vorticity_field!(sim)
    sdf = wake_sdf_field!(sim)
    x_axis = wake_plot_axis(size(omega, 1))
    y_axis = wake_plot_axis(size(omega, 2))
    omega_plot = permutedims(omega)
    sdf_plot = permutedims(sdf)
    xs = [point[1] for point in heads]
    ys = [point[2] for point in heads]
    plt = heatmap(
        x_axis,
        y_axis,
        omega_plot;
        color=cgrad([:blue, :white, :red]),
        clims,
        aspect_ratio=:equal,
        legend=false,
        colorbar=false,
        border=:none,
        ticks=nothing,
        size=image_size,
        margin=0Plots.mm,
        xlims=(first(x_axis), last(x_axis)),
        ylims=(first(y_axis), last(y_axis)),
    )
    contour!(
        plt,
        x_axis,
        y_axis,
        sdf_plot;
        levels=[0.0],
        color=:black,
        linewidth=1,
        colorbar=false,
    )
    if success_radius > 0
        target_theta = range(0, 2pi; length=121)
        target_x = [target[1] + success_radius * cos(theta) for theta in target_theta]
        target_y = [target[2] + success_radius * sin(theta) for theta in target_theta]
        plot!(plt, target_x, target_y; color=:red, linewidth=1.0, alpha=0.55)
    end
    scatter!(plt, [target[1]], [target[2]]; color=:red, markerstrokecolor=:black, markersize=3)
    if !isempty(heads)
        plot!(
            plt,
            [heads[1][1], target[1]],
            [heads[1][2], target[2]];
            color=:red,
            linestyle=:dash,
            linewidth=1.0,
            alpha=0.35,
        )
    end
    if length(xs) > 1
        plot!(plt, xs, ys; color=:orange, linewidth=1.4, alpha=0.95)
    end
    if !isempty(heads)
        scatter!(plt, [heads[end][1]], [heads[end][2]]; color=:orange, markerstrokecolor=:black, markersize=4)
    end
    annotate!(
        plt,
        first(x_axis) + 0.02 * (last(x_axis) - first(x_axis)),
        last(y_axis) - 0.05 * (last(y_axis) - first(y_axis)),
        text(
            @sprintf(
                "%s | t=%.3f / %.3f | L=%d",
                phase_label,
                elapsed_time,
                total_horizon,
                sim.L,
            ),
            10,
            :black,
            :left,
        ),
    )
    savefig(plt, output_path)
    return output_path
end

function wake_main(;
    config_env_names=("DOGFISH_FREE_SWIM_WAKE_CONFIG", "DOGFISH_RUN_CONFIG"),
    config_sections=("free_swim", "free_swim_wake_episode"),
    output_env_name="DOGFISH_WAKE_OUTPUT_ROOT",
    default_output_subdir="free_swim_wake_episode",
    multiwake_target=false,
)
    run_config = DogfishShapePolicyTestbed.load_run_config(
        case_dir;
        env_names=config_env_names,
    )
    config = DogfishShapePolicyTestbed.merged_run_config_sections(
        run_config,
        config_sections,
    )
    output_root = DogfishShapePolicyTestbed.configured_string(
        config,
        "output_root",
        output_env_name,
        joinpath(pwd(), "logs", default_output_subdir),
    )
    L = DogfishShapePolicyTestbed.configured_int(config, "L", "DOGFISH_FREE_SWIM_L", 32)
    Re = DogfishShapePolicyTestbed.configured_float32(config, "Re", "DOGFISH_WAKE_RE", 1000f0)
    requested_horizon = DogfishShapePolicyTestbed.configured_optional_float32(config, "horizon", "DOGFISH_WAKE_HORIZON")
    requested_prewarm_horizon = DogfishShapePolicyTestbed.configured_float32(
        config,
        "prewarm_horizon",
        "DOGFISH_WAKE_PREWARM_HORIZON",
        0.0f0,
    )
    backend = DogfishShapePolicyTestbed.configured_string(config, "backend", "DOGFISH_MEMORY_BACKEND", "cpu")
    domain_scale = (
        DogfishShapePolicyTestbed.configured_float32(config, "domain_scale_x", "DOGFISH_WAKE_DOMAIN_SCALE_X", 16.0f0),
        DogfishShapePolicyTestbed.configured_float32(config, "domain_scale_y", "DOGFISH_WAKE_DOMAIN_SCALE_Y", 8.0f0),
    )
    initial_center_x_L = DogfishShapePolicyTestbed.configured_float32(
        config,
        "initial_center_x_L",
        "DOGFISH_WAKE_INITIAL_CENTER_X_L",
        5.0f0,
    )
    initial_head_distance_from_target_L = DogfishShapePolicyTestbed.configured_optional_float32(
        config,
        "initial_head_distance_from_target_L",
        "DOGFISH_WAKE_INITIAL_HEAD_DISTANCE_FROM_TARGET_L",
    )
    initial_center_y_fraction = DogfishShapePolicyTestbed.configured_float32(
        config,
        "initial_center_y_fraction",
        "DOGFISH_WAKE_INITIAL_CENTER_Y",
        0.5f0,
    )
    initial_center_y_L = DogfishShapePolicyTestbed.configured_optional_float32(
        config,
        "initial_center_y_L",
        "DOGFISH_WAKE_INITIAL_CENTER_Y_L",
    )
    initial_heading = DogfishShapePolicyTestbed.configured_float32(config, "initial_heading", "DOGFISH_WAKE_INITIAL_HEADING", 0.0f0)
    initial_heading_deg = DogfishShapePolicyTestbed.configured_optional_float32(
        config,
        "initial_heading_deg",
        "DOGFISH_WAKE_INITIAL_HEADING_DEG",
    )
    initial_heading_deg !== nothing && (initial_heading = Float32(deg2rad(initial_heading_deg)))
    cylinder_center_x_L = DogfishShapePolicyTestbed.configured_float32(
        config,
        "cylinder_center_x_L",
        "DOGFISH_WAKE_CYLINDER_X_L",
        1.5f0,
    )
    cylinder_center_y_fraction = DogfishShapePolicyTestbed.configured_float32(
        config,
        "cylinder_center_y_fraction",
        "DOGFISH_WAKE_CYLINDER_Y",
        0.5f0,
    )
    cylinder_diameter_L = DogfishShapePolicyTestbed.configured_float32(
        config,
        "cylinder_diameter_L",
        "DOGFISH_WAKE_CYLINDER_DIAMETER_L",
        0.30f0,
    )
    cylinder_centers_x_L = multiwake_target ? configured_float32_vector(
        config,
        "cylinder_centers_x_L",
        "DOGFISH_WAKE_CYLINDER_XS_L",
        Float32[3.0, 3.0, 3.0, 6.0, 6.0],
    ) : Float32[cylinder_center_x_L]
    cylinder_centers_y_L = multiwake_target ? configured_float32_vector(
        config,
        "cylinder_centers_y_L",
        "DOGFISH_WAKE_CYLINDER_YS_L",
        Float32[4.5, 7.0, 9.5, 5.75, 8.25],
    ) : Float32[cylinder_center_y_fraction * domain_scale[2]]
    cylinder_diameters_L = multiwake_target ? configured_float32_vector(
        config,
        "cylinder_diameters_L",
        "DOGFISH_WAKE_CYLINDER_DIAMETERS_L",
        fill(cylinder_diameter_L, length(cylinder_centers_x_L)),
    ) : Float32[cylinder_diameter_L]
    length(cylinder_centers_x_L) == length(cylinder_centers_y_L) == length(cylinder_diameters_L) ||
        error("multiwake cylinder x/y/diameter arrays must have equal lengths")
    if multiwake_target
        cylinder_center_x_L = first(cylinder_centers_x_L)
        cylinder_center_y_fraction = first(cylinder_centers_y_L) / domain_scale[2]
        cylinder_diameter_L = first(cylinder_diameters_L)
    end
    target_offset_from_cylinder_L = DogfishShapePolicyTestbed.configured_float32(
        config,
        "target_offset_from_cylinder_L",
        "DOGFISH_WAKE_TARGET_OFFSET_FROM_CYLINDER_L",
        multiwake_target ? 2.5f0 : 1.5f0,
    )
    target_x_L = DogfishShapePolicyTestbed.configured_float32(
        config,
        "target_x_L",
        "DOGFISH_WAKE_TARGET_X_L",
        cylinder_center_x_L + target_offset_from_cylinder_L,
    )
    target_y_fraction = DogfishShapePolicyTestbed.configured_float32(config, "target_y_fraction", "DOGFISH_WAKE_TARGET_Y", 0.5f0)
    target_y_L = DogfishShapePolicyTestbed.configured_optional_float32(
        config,
        "target_y_L",
        "DOGFISH_WAKE_TARGET_Y_L",
    )
    success_radius_L = DogfishShapePolicyTestbed.configured_float32(config, "success_radius_L", "DOGFISH_WAKE_SUCCESS_RADIUS_L", 0.0f0)
    collision_clearance_L = DogfishShapePolicyTestbed.configured_float32(
        config,
        "collision_clearance_L",
        "DOGFISH_WAKE_COLLISION_CLEARANCE_L",
        0.0f0,
    )
    domain_exit_margin_L = max(0.0f0, DogfishShapePolicyTestbed.configured_float32(
        config,
        "domain_exit_margin_L",
        "DOGFISH_WAKE_DOMAIN_EXIT_MARGIN_L",
        0.0f0,
    ))
    cylinder_kick_amplitude_L = DogfishShapePolicyTestbed.configured_float32(
        config,
        "cylinder_kick_amplitude_L",
        "DOGFISH_WAKE_CYLINDER_KICK_AMPLITUDE_L",
        0.0f0,
    )
    cylinder_kick_start = DogfishShapePolicyTestbed.configured_float32(
        config,
        "cylinder_kick_start",
        "DOGFISH_WAKE_CYLINDER_KICK_START",
        0.0f0,
    )
    cylinder_kick_duration = DogfishShapePolicyTestbed.configured_float32(
        config,
        "cylinder_kick_duration",
        "DOGFISH_WAKE_CYLINDER_KICK_DURATION",
        0.0f0,
    )
    cylinder_kick_cycles = DogfishShapePolicyTestbed.configured_float32(
        config,
        "cylinder_kick_cycles",
        "DOGFISH_WAKE_CYLINDER_KICK_CYCLES",
        1.0f0,
    )
    flow_perturbation = DogfishShapePolicyTestbed.configured_float32(
        config,
        "flow_perturbation",
        "DOGFISH_WAKE_FLOW_PERTURBATION",
        1.0f-3,
    )
    flow_speed = DogfishShapePolicyTestbed.configured_float32(config, "flow_speed", "DOGFISH_WAKE_FLOW_SPEED", 1.0f0)
    flow_seed = DogfishShapePolicyTestbed.configured_int(config, "flow_seed", "DOGFISH_WAKE_FLOW_SEED", 20260625)
    save_prewarm_snapshot_path = optional_configured_path(
        config,
        "save_prewarm_snapshot",
        "DOGFISH_WAKE_SAVE_PREWARM_SNAPSHOT",
    )
    load_prewarm_snapshot_path = optional_configured_path(
        config,
        "load_prewarm_snapshot",
        "DOGFISH_WAKE_LOAD_PREWARM_SNAPSHOT",
    )
    save_final_snapshot = DogfishShapePolicyTestbed.configured_bool(
        config,
        "save_final_snapshot",
        "DOGFISH_WAKE_SAVE_FINAL_SNAPSHOT",
        true,
    )
    final_snapshot_path = DogfishShapePolicyTestbed.configured_string(
        config,
        "final_snapshot_path",
        "DOGFISH_WAKE_FINAL_SNAPSHOT_PATH",
        joinpath(output_root, "final_state.jld2"),
    )
    isempty(strip(final_snapshot_path)) && (final_snapshot_path = joinpath(output_root, "final_state.jld2"))
    load_episode_snapshot_path = optional_configured_path(
        config,
        "load_episode_snapshot",
        "DOGFISH_WAKE_LOAD_EPISODE_SNAPSHOT",
    )
    load_prewarm_snapshot_path !== nothing && load_episode_snapshot_path !== nothing &&
        error("load_prewarm_snapshot and load_episode_snapshot are mutually exclusive")
    prewarm_only = DogfishShapePolicyTestbed.configured_bool(
        config,
        "prewarm_only",
        "DOGFISH_WAKE_PREWARM_ONLY",
        false,
    )
    prewarm_with_fish = DogfishShapePolicyTestbed.configured_bool(
        config,
        "prewarm_with_fish",
        "DOGFISH_WAKE_PREWARM_WITH_FISH",
        !multiwake_target,
    )
    if haskey(config, "time_step_fraction") ||
       DogfishShapePolicyTestbed.run_config_env_present("DOGFISH_FREE_SWIM_DT_FRACTION")
        error(
            "wake episodes no longer accept time_step_fraction; " *
            "set the testbed-owned max_dimensionless_dt instead",
        )
    end
    max_dimensionless_dt = DogfishShapePolicyTestbed.configured_float32(
        config,
        "max_dimensionless_dt",
        "DOGFISH_WAKE_MAX_DIMENSIONLESS_DT",
        0.0055f0,
    )
    frame_count = DogfishShapePolicyTestbed.configured_int(config, "frame_count", "DOGFISH_WAKE_FRAME_COUNT", 80)
    fps = DogfishShapePolicyTestbed.configured_int(config, "fps", "DOGFISH_WAKE_RENDER_FPS", 16)
    render_frames = DogfishShapePolicyTestbed.configured_bool(config, "render_frames", "DOGFISH_WAKE_RENDER_FRAMES", false)
    plot_frames = DogfishShapePolicyTestbed.configured_bool(config, "plot_frames", "DOGFISH_WAKE_PLOT_FRAMES", false)
    plot_clim = Float64(DogfishShapePolicyTestbed.configured_float32(config, "plot_clim", "DOGFISH_WAKE_PLOT_CLIM", 2.0f0))
    actuation_mode = DogfishShapePolicyTestbed.configured_string(config, "actuation_mode", "DOGFISH_WAKE_ACTUATION_MODE", "policy")
    actuation_mode in ("policy", "locked", "straight_locked") ||
        error("Unsupported wake actuation_mode: $actuation_mode")
    observation_history_length = max(
        1,
        DogfishShapePolicyTestbed.configured_int(
            config,
            "observation_history_length",
            "DOGFISH_WAKE_OBSERVATION_HISTORY_LENGTH",
            8,
        ),
    )
    wall_time_limit_s = DogfishShapePolicyTestbed.configured_optional_float32(config, "wall_time_limit_s", "DOGFISH_WAKE_WALL_TIME_LIMIT_S")
    exit_bc = DogfishShapePolicyTestbed.configured_bool(config, "exit_bc", "DOGFISH_WAKE_EXIT_BC", true)
    vtk_enabled = DogfishShapePolicyTestbed.configured_bool(config, "vtk", "DOGFISH_WAKE_VTK", false)
    vtk_collection_name = DogfishShapePolicyTestbed.configured_string(
        config,
        "vtk_collection_name",
        "DOGFISH_WAKE_VTK_COLLECTION_NAME",
        "wake_flow",
    )
    vtk_fields = DogfishShapePolicyTestbed.configured_string_list(
        config,
        "vtk_fields",
        "DOGFISH_WAKE_VTK_FIELDS",
        ["vorticity", "body"],
    )
    vtk_flush_collection = DogfishShapePolicyTestbed.configured_bool(
        config,
        "vtk_flush_collection",
        "DOGFISH_WAKE_VTK_FLUSH_COLLECTION",
        true,
    )
    vtk_compress = DogfishShapePolicyTestbed.configured_bool(config, "vtk_compress", "DOGFISH_WAKE_VTK_COMPRESS", false)
    vtk_force_trigger = DogfishShapePolicyTestbed.configured_optional_float32(config, "vtk_force_trigger", "DOGFISH_WAKE_VTK_FORCE_TRIGGER")
    vtk_speed_trigger = DogfishShapePolicyTestbed.configured_optional_float32(config, "vtk_speed_trigger", "DOGFISH_WAKE_VTK_SPEED_TRIGGER")
    vtk_trigger_min_interval = Float64(DogfishShapePolicyTestbed.configured_float32(
        config,
        "vtk_trigger_min_interval",
        "DOGFISH_WAKE_VTK_TRIGGER_MIN_INTERVAL",
        0.05f0,
    ))
    dynamics_force_limit = Float64(DogfishShapePolicyTestbed.configured_float32(
        config,
        "dynamics_force_limit",
        "DOGFISH_WAKE_FORCE_LIMIT",
        1.0f6,
    ))
    dynamics_speed_limit = Float64(DogfishShapePolicyTestbed.configured_float32(
        config,
        "dynamics_speed_limit",
        "DOGFISH_WAKE_SPEED_LIMIT",
        100f0,
    ))
    command_energy_weight = Float64(DogfishShapePolicyTestbed.configured_float32(
        config,
        "command_energy_weight",
        "DOGFISH_WAKE_COMMAND_ENERGY_WEIGHT",
        0.0f0,
    ))
    power_proxy_weight = Float64(DogfishShapePolicyTestbed.configured_float32(
        config,
        "power_proxy_weight",
        "DOGFISH_WAKE_POWER_WEIGHT",
        0.0f0,
    ))
    unstable_dynamics_penalty = Float64(DogfishShapePolicyTestbed.configured_float32(
        config,
        "unstable_dynamics_penalty",
        "DOGFISH_WAKE_UNSTABLE_PENALTY",
        2.0f0,
    ))
    station_success_bonus = Float64(DogfishShapePolicyTestbed.configured_float32(
        config,
        "station_success_bonus",
        "DOGFISH_WAKE_SUCCESS_BONUS",
        0.0f0,
    ))
    survival_bonus_weight = Float64(DogfishShapePolicyTestbed.configured_float32(
        config,
        "survival_bonus_weight",
        "DOGFISH_WAKE_SURVIVAL_WEIGHT",
        0.2f0,
    ))
    final_distance_weight = Float64(DogfishShapePolicyTestbed.configured_float32(
        config,
        "final_distance_weight",
        "DOGFISH_WAKE_FINAL_DISTANCE_WEIGHT",
        0.2f0,
    ))
    distance_integral_weight = Float64(DogfishShapePolicyTestbed.configured_float32(
        config,
        "distance_integral_weight",
        "DOGFISH_WAKE_DISTANCE_INTEGRAL_WEIGHT",
        1.0f0,
    ))

    body_density = DogfishShapePolicyTestbed.configured_float32(config, "body_density", "DOGFISH_FREE_SWIM_BODY_DENSITY", 1.0f0)
    added_mass_scale = DogfishShapePolicyTestbed.configured_float32(config, "added_mass_scale", "DOGFISH_FREE_SWIM_ADDED_MASS_SCALE", 1.0f0)
    added_inertia_scale = DogfishShapePolicyTestbed.configured_float32(config, "added_inertia_scale", "DOGFISH_FREE_SWIM_ADDED_INERTIA_SCALE", added_mass_scale)

    phi_limit = Float64(DogfishShapePolicyTestbed.configured_float32(config, "phi_limit_deg", "DOGFISH_WAKE_PHI_LIMIT_DEG", 45f0)) * TARGET_DEG
    phi_dot_limit = Float64(DogfishShapePolicyTestbed.configured_float32(config, "phi_dot_limit_deg", "DOGFISH_WAKE_PHI_DOT_LIMIT_DEG", 140f0)) * TARGET_DEG
    phi_ddot_limit = Float64(DogfishShapePolicyTestbed.configured_float32(config, "phi_ddot_limit_deg", "DOGFISH_WAKE_PHI_DDOT_LIMIT_DEG", 900f0)) * TARGET_DEG
    initial_phi1 = Float64(DogfishShapePolicyTestbed.configured_float32(config, "initial_phi1_deg", "DOGFISH_WAKE_INITIAL_PHI1_DEG", 8f0)) * TARGET_DEG
    initial_phi2 = Float64(DogfishShapePolicyTestbed.configured_float32(config, "initial_phi2_deg", "DOGFISH_WAKE_INITIAL_PHI2_DEG", -8f0)) * TARGET_DEG
    # Policy dynamics and gains belong exclusively to the candidate policy.
    # Episode TOML owns the environment and actuator safety limits only.
    policy_params = target_policy_params()
    control_period = Float64(policy_params.control_period)

    design = target_control_design(control_period=Float32(control_period))
    experiment = first(DogfishShapePolicyTestbed.design_experiments(design))
    (
        sim,
        state,
        _motion_period,
        morphology_params,
        assembled_params,
        resolved_backend,
        profile,
        sdf,
        fish_body,
        cylinder_body,
        cylinder_motions,
        cylinder_centers,
        cylinder_radii,
    ) = build_wake_swim_simulation(
        design,
        experiment;
        L,
        Re,
        backend,
        domain_scale,
        initial_center_x_L,
        initial_head_distance_from_target_L,
        initial_center_y_fraction,
        initial_center_y_L,
        initial_heading,
        max_dimensionless_dt,
        flow_speed,
        target_x_L,
        cylinder_center_x_L,
        cylinder_center_y_fraction,
        cylinder_diameter_L,
        cylinder_centers_x_L,
        cylinder_centers_y_L,
        cylinder_diameters_L,
        cylinder_kick_amplitude_L,
        cylinder_kick_start,
        cylinder_kick_duration,
        cylinder_kick_cycles,
        exit_bc,
    )
    cylinder_center = first(cylinder_centers)
    cylinder_radius = first(cylinder_radii)
    cylinder_motion = first(cylinder_motions)

    T = eltype(sim.flow.p)
    Lf = T(L)
    area = DogfishShapePolicyTestbed.body_area_from_profile(profile, Lf)
    mass = T(body_density) * area
    inertia = DogfishShapePolicyTestbed.body_inertia_from_profile(profile, Lf; density=T(body_density))
    added_mass = DogfishShapePolicyTestbed.free_swim_added_mass_properties(
        profile,
        Lf;
        density=T(body_density),
        translational_scale=T(added_mass_scale),
        rotational_scale=T(added_inertia_scale),
    )
    rollout_horizon = requested_horizon === nothing ? 8.0 : Float64(requested_horizon)
    rollout_horizon = max(rollout_horizon, eps(Float64))
    prewarm_horizon = max(0.0, Float64(requested_prewarm_horizon))
    raw_dt_cap = max(eps(T), T(max_dimensionless_dt) * Lf)
    next_frame_time = 0.0

    dims_tuple = size(sim.flow.p) .- 2
    dims = (Float64(dims_tuple[1]), Float64(dims_tuple[2]))
    target_y = target_y_L === nothing ? T(target_y_fraction) * T(dims[2]) : T(target_y_L) * Lf
    target = SVector(T(target_x_L) * Lf, target_y)
    success_radius = T(success_radius_L) * Lf
    inflow_velocity = SVector(T(flow_speed), zero(T))

    joint = (
        phi1=initial_phi1,
        phi2=initial_phi2,
        phi_dot1=0.0,
        phi_dot2=0.0,
        phi_ddot1=0.0,
        phi_ddot2=0.0,
    )
    if actuation_mode == "straight_locked"
        joint = (
            phi1=0.0,
            phi2=0.0,
            phi_dot1=0.0,
            phi_dot2=0.0,
            phi_ddot1=0.0,
            phi_ddot2=0.0,
        )
    end
    assembled_params = current_joint_params(
        assembled_params,
        joint,
        T(WaterLily.time(sim.flow)),
        L,
    )
    fish_body = set_wake_swim_body!(
        sim,
        design,
        sdf,
        profile,
        assembled_params,
        state,
        T(WaterLily.time(sim.flow)),
        raw_dt_cap,
        Lf,
        cylinder_body,
    )

    loaded_prewarm_snapshot = false
    prewarm_snapshot_metadata = nothing
    loaded_episode_snapshot = false
    episode_snapshot_metadata = nothing
    episode_elapsed_offset = 0.0
    restored_observation_history = Any[]
    if load_episode_snapshot_path !== nothing
        episode_snapshot_metadata = load_wake_snapshot!(sim, load_episode_snapshot_path)
        episode_snapshot_metadata === nothing &&
            error("wake episode snapshot sidecar not found: $(snapshot_sidecar_path(load_episode_snapshot_path))")
        get(episode_snapshot_metadata, "schema_version", nothing) == "dogfish.wake_episode_snapshot.v1" ||
            error("unsupported wake episode snapshot schema: $(get(episode_snapshot_metadata, "schema_version", nothing))")
        state = restore_free_swim_state(episode_snapshot_metadata, T)
        joint = restore_joint_state(episode_snapshot_metadata)
        restored_observation_history = restore_observation_history(episode_snapshot_metadata, T)
        episode_elapsed_offset = Float64(get(episode_snapshot_metadata, "episode_elapsed", 0.0))
        assembled_params = current_joint_params(
            assembled_params,
            joint,
            T(WaterLily.time(sim.flow)),
            L,
        )
        fish_body = set_wake_swim_body!(
            sim,
            design,
            sdf,
            profile,
            assembled_params,
            state,
            T(WaterLily.time(sim.flow)),
            raw_dt_cap,
            Lf,
            cylinder_body,
        )
        loaded_episode_snapshot = true
        prewarm_horizon = 0.0
    elseif load_prewarm_snapshot_path !== nothing
        prewarm_snapshot_metadata = load_wake_prewarm_snapshot!(sim, load_prewarm_snapshot_path)
        loaded_prewarm_snapshot = true
        prewarm_horizon = 0.0
    elseif flow_perturbation > 0f0
        Random.seed!(flow_seed)
        WaterLily.perturb!(sim; noise=flow_perturbation)
    end

    if !prewarm_with_fish && !loaded_episode_snapshot
        sim.body = cylinder_body
    end

    total_horizon = prewarm_horizon + rollout_horizon
    visual_total_horizon = Float64(sim_time(sim)) + total_horizon
    frame_dt = max(total_horizon, eps(Float64)) / max(1, frame_count)

    mkpath(output_root)
    frames_dir = joinpath(output_root, "frames")
    (render_frames || plot_frames) && mkpath(frames_dir)
    vtk_stream = vtk_enabled ?
        DogfishShapePolicyTestbed.start_free_swim_vtk_stream(
            output_root;
            collection_name=vtk_collection_name,
            fields=vtk_fields,
            flush_collection=vtk_flush_collection,
            compress=vtk_compress,
        ) :
        nothing
    frame_index = 0
    prewarm_steps = 0
    steps = 0
    termination = "horizon"
    failure_message = nothing
    wall_start = time()
    last_trigger_vtk_time = -Inf

    video_centers = [Tuple(Float64.(state.center))]
    video_heads = [Tuple(Float64.(head_position(state, assembled_params, profile, Lf)))]

    while sim_time(sim) < prewarm_horizon
        if wall_time_limit_s !== nothing && Float64(wall_time_limit_s) > 0 && time() - wall_start >= Float64(wall_time_limit_s)
            termination = "wall_time_limit"
            break
        end

        DogfishShapePolicyTestbed.cap_free_swim_timestep!(sim, raw_dt_cap, prewarm_horizon)
        try
            sim_step!(sim; remeasure=true)
        catch error
            termination = "solver_error"
            failure_message = sprint(showerror, error)
            break
        end
        sim.flow.Δt[end] = min(T(sim.flow.Δt[end]), raw_dt_cap)
        prewarm_steps += 1

        current_time = Float64(sim_time(sim))
        scheduled_frame_due = current_time + eps(current_time) >= next_frame_time || current_time >= prewarm_horizon
        if (plot_frames || render_frames || vtk_stream !== nothing) && scheduled_frame_due
            frame_index += 1
            if vtk_stream !== nothing
                DogfishShapePolicyTestbed.write_free_swim_vtk_frame!(
                    vtk_stream,
                    sim,
                    state.center,
                    state.theta;
                    period=max(visual_total_horizon, eps(Float64)),
                )
            end
            if plot_frames
                frame_path = joinpath(frames_dir, @sprintf("frame_%04d.png", frame_index))
                render_wake_flow_frame!(
                    sim,
                    frame_path,
                    video_centers,
                    video_heads,
                    target,
                    success_radius,
                    "fixed prewarm",
                    current_time,
                    visual_total_horizon;
                    clims=(-plot_clim, plot_clim),
                )
            elseif render_frames
                frame_path = joinpath(frames_dir, @sprintf("frame_%04d.png", frame_index))
                render_wake_episode_frame(
                    frame_path,
                    state,
                    assembled_params,
                    profile,
                    Lf,
                    video_centers,
                    video_heads,
                    target,
                    success_radius,
                    current_cylinder_centers(cylinder_motions, T(WaterLily.time(sim.flow))),
                    cylinder_radii,
                    dims,
                    current_time,
                    visual_total_horizon,
                    sqrt(sum(abs2, SVector(T(video_heads[end][1]), T(video_heads[end][2])) - target)),
                )
            end
            next_frame_time += frame_dt
        end
    end

    saved_prewarm_snapshot_sidecar = nothing
    if save_prewarm_snapshot_path !== nothing && termination == "horizon"
        snapshot_metadata = Dict(
            "schema_version" => "dogfish.wake_prewarm_snapshot.v0",
            "date" => string(now()),
            "run_config" => run_config.path,
            "snapshot_path" => save_prewarm_snapshot_path,
            "sim_time" => Float64(sim_time(sim)),
            "raw_time" => Float64(WaterLily.time(sim.flow)),
            "prewarm_horizon" => Float64(requested_prewarm_horizon),
            "prewarm_steps" => prewarm_steps,
            "prewarm_with_fish" => prewarm_with_fish,
            "max_dimensionless_dt" => Float64(max_dimensionless_dt),
            "raw_dt_cap" => Float64(raw_dt_cap),
            "L" => L,
            "Re" => Float64(Re),
            "flow_speed" => Float64(flow_speed),
            "flow_perturbation" => Float64(flow_perturbation),
            "flow_seed" => flow_seed,
            "domain_scale" => collect(Float64.(domain_scale)),
            "domain_dims" => collect(dims_tuple),
            "target" => collect(Float64.(target)),
            "target_x_L" => Float64(target_x_L),
            "target_y_L" => target_y_L === nothing ? nothing : Float64(target_y_L),
            "target_y_fraction" => Float64(target_y_fraction),
            "success_radius" => Float64(success_radius),
            "success_radius_L" => Float64(success_radius_L),
            "cylinder_center_x_L" => Float64(cylinder_center_x_L),
            "cylinder_center_y_fraction" => Float64(cylinder_center_y_fraction),
            "cylinder_diameter_L" => Float64(cylinder_diameter_L),
            "cylinder_centers_x_L" => collect(Float64.(cylinder_centers_x_L)),
            "cylinder_centers_y_L" => collect(Float64.(cylinder_centers_y_L)),
            "cylinder_diameters_L" => collect(Float64.(cylinder_diameters_L)),
            "cylinder_kick_amplitude_L" => Float64(cylinder_kick_amplitude_L),
            "cylinder_kick_start" => Float64(cylinder_kick_start),
            "cylinder_kick_duration" => Float64(cylinder_kick_duration),
            "cylinder_kick_cycles" => Float64(cylinder_kick_cycles),
            "initial_center_x_L" => Float64(initial_center_x_L),
            "initial_head_distance_from_target_L" => initial_head_distance_from_target_L === nothing ?
                                                     nothing :
                                                     Float64(initial_head_distance_from_target_L),
            "initial_center_y_fraction" => Float64(initial_center_y_fraction),
            "initial_center_y_L" => initial_center_y_L === nothing ? nothing : Float64(initial_center_y_L),
            "initial_heading" => Float64(initial_heading),
            "initial_joint_state" => collect((joint.phi1, joint.phi2, joint.phi_dot1, joint.phi_dot2)),
        )
        saved_prewarm_snapshot_sidecar = save_wake_prewarm_snapshot!(
            sim,
            save_prewarm_snapshot_path;
            metadata=snapshot_metadata,
        )
    end

    if prewarm_only
        wall_elapsed = time() - wall_start
        prewarm_summary = Dict(
            "schema_version" => "dogfish.free_swim_wake_prewarm_only.v0",
            "status" => termination == "horizon" ? "ok" : "failed",
            "date" => string(now()),
            "run_config" => run_config.path,
            "termination" => termination,
            "failure_message" => failure_message,
            "L" => L,
            "Re" => Float64(Re),
            "flow_speed" => Float64(flow_speed),
            "prewarm_horizon" => Float64(requested_prewarm_horizon),
            "prewarm_with_fish" => prewarm_with_fish,
            "sim_time" => Float64(sim_time(sim)),
            "prewarm_steps" => prewarm_steps,
            "max_dimensionless_dt" => Float64(max_dimensionless_dt),
            "raw_dt_cap" => Float64(raw_dt_cap),
            "backend" => resolved_backend.name,
            "domain_scale" => collect(Float64.(domain_scale)),
            "domain_dims" => collect(dims_tuple),
            "target" => collect(Float64.(target)),
            "target_x_L" => Float64(target_x_L),
            "target_y_L" => target_y_L === nothing ? nothing : Float64(target_y_L),
            "target_y_fraction" => Float64(target_y_fraction),
            "success_radius" => Float64(success_radius),
            "success_radius_L" => Float64(success_radius_L),
            "cylinder_center" => collect(Float64.(cylinder_center)),
            "cylinder_diameter_L" => Float64(cylinder_diameter_L),
            "cylinder_centers" => [collect(Float64.(center)) for center in cylinder_centers],
            "cylinder_diameters_L" => collect(Float64.(cylinder_diameters_L)),
            "save_prewarm_snapshot" => save_prewarm_snapshot_path,
            "saved_prewarm_snapshot_sidecar" => saved_prewarm_snapshot_sidecar,
            "wall_s" => wall_elapsed,
        )
        summary_path = joinpath(output_root, "summary.json")
        open(summary_path, "w") do io
            JSON.print(io, DogfishShapePolicyTestbed.jsonable(prewarm_summary), 2)
            println(io)
        end
        println("status=$(prewarm_summary["status"])")
        println("termination=$termination")
        println("prewarm_only=true")
        println("prewarm_steps=$prewarm_steps")
        println("prewarm_horizon=$(Float64(requested_prewarm_horizon))")
        println("sim_time=$(Float64(sim_time(sim)))")
        println("snapshot=$save_prewarm_snapshot_path")
        println("summary=$summary_path")
        return
    end


    if !prewarm_with_fish && !loaded_episode_snapshot
        fish_body = set_wake_swim_body!(
            sim,
            design,
            sdf,
            profile,
            assembled_params,
            state,
            T(WaterLily.time(sim.flow)),
            raw_dt_cap,
            Lf,
            cylinder_body,
        )
    end

    release_start_time = Float64(sim_time(sim))
    release_end_time = release_start_time + rollout_horizon
    release_visual_horizon = Float64(rollout_horizon)
    release_frame_dt = max(release_visual_horizon, eps(Float64)) / max(1, frame_count)
    next_frame_time = 0.0
    last_trigger_vtk_time = -Inf

    centers = [Tuple(Float64.(state.center))]
    heads = [Tuple(Float64.(head_position(state, assembled_params, profile, Lf)))]
    times = [0.0]
    distances = [Float64(sqrt(sum(abs2, SVector(T(heads[end][1]), T(heads[end][2])) - target)))]
    headings = [Float64(state.theta)]
    velocities = [Tuple(Float64.(state.velocity))]
    forces = [(0.0, 0.0)]
    moments = [0.0]
    local_flows = [Tuple(Float64.(centered_flow_velocity(sim, SVector(T(heads[end][1]), T(heads[end][2])))))]
    joint_rows = [(joint.phi1, joint.phi2, joint.phi_dot1, joint.phi_dot2, joint.phi_ddot1, joint.phi_ddot2)]
    initial_cylinder_centers = current_cylinder_centers(cylinder_motions, T(WaterLily.time(sim.flow)))
    clearances = [fish_cylinder_clearance(
        assembled_params,
        profile,
        Lf,
        state,
        initial_cylinder_centers,
        cylinder_radii,
    )]
    observation_history = restored_observation_history

    while termination == "horizon" && sim_time(sim) < release_end_time
        if wall_time_limit_s !== nothing && Float64(wall_time_limit_s) > 0 && time() - wall_start >= Float64(wall_time_limit_s)
            termination = "wall_time_limit"
            break
        end

        DogfishShapePolicyTestbed.cap_free_swim_timestep!(sim, raw_dt_cap, release_end_time)
        raw_dt = T(sim.flow.Δt[end])
        current_time = Float64(sim_time(sim)) - release_start_time
        episode_time = episode_elapsed_offset + current_time
        raw_t1 = T(WaterLily.time(sim.flow)) + raw_dt
        sim_dt = Float64(raw_dt / Lf)

        force, moment_z = fish_body_force_moment(sim, fish_body, state.center)
        base_obs = body_frame_observation(
            state,
            joint,
            target,
            force,
            moment_z,
            assembled_params,
            profile,
            Lf;
            observation_history=observation_history,
            current_time=episode_time,
            history_length=observation_history_length,
        )
        local_flow = centered_flow_velocity(sim, base_obs.head)
        obs = wake_body_frame_observation(
            base_obs,
            state,
            sim,
            current_cylinder_centers(cylinder_motions, T(WaterLily.time(sim.flow))),
            cylinder_radii,
            local_flow,
            inflow_velocity,
            Lf;
            observation_history=observation_history,
        )
        if actuation_mode == "policy"
            action = target_policy(obs, policy_params)
            push!(
                observation_history,
                (
                    time=episode_time,
                    target_body=obs.target_body,
                    distance=obs.distance,
                    bearing=obs.bearing,
                    wake_crossflow_velocity=obs.wake_crossflow_velocity,
                    wake_streamwise_velocity=obs.wake_streamwise_velocity,
                    local_vorticity=obs.local_vorticity,
                    force_body_y=obs.force_body[2],
                    moment_z=obs.moment_z,
                ),
            )
            while length(observation_history) > observation_history_length - 1
                popfirst!(observation_history)
            end
            phi_ddot = action.phi_ddot
            joint = integrate_joint_state(
                joint,
                phi_ddot,
                sim_dt;
                phi_limit,
                phi_dot_limit,
                phi_ddot_limit,
            )
        else
            joint = (
                phi1=joint.phi1,
                phi2=joint.phi2,
                phi_dot1=0.0,
                phi_dot2=0.0,
                phi_ddot1=0.0,
                phi_ddot2=0.0,
            )
        end
        assembled_params = current_joint_params(assembled_params, joint, raw_t1, L)
        next_state = DogfishShapePolicyTestbed.update_free_swim_state(
            state,
            force,
            moment_z,
            raw_dt,
            mass,
            inertia;
            added_mass,
        )

        if !(
            all(isfinite, force) &&
            isfinite(moment_z) &&
            all(isfinite, next_state.center) &&
            all(isfinite, next_state.velocity) &&
            isfinite(next_state.theta) &&
            isfinite(next_state.omega) &&
            all(isfinite, (joint.phi1, joint.phi2, joint.phi_dot1, joint.phi_dot2))
        )
            termination = "nonfinite_state"
            failure_message = "free-swim wake episode state became nonfinite"
            break
        end

        body_state = DogfishShapePolicyTestbed.free_swim_step_body_state(state, next_state, raw_dt)
        fish_body = set_wake_swim_body!(
            sim,
            design,
            sdf,
            profile,
            assembled_params,
            body_state,
            raw_t1,
            raw_dt,
            Lf,
            cylinder_body,
        )
        try
            sim_step!(sim; remeasure=true)
        catch error
            termination = "solver_error"
            failure_message = sprint(showerror, error)
            break
        end
        sim.flow.Δt[end] = min(T(sim.flow.Δt[end]), raw_dt_cap)

        state = next_state
        steps += 1
        current_time_abs = sim_time(sim)
        current_time = current_time_abs - release_start_time
        head = head_position(state, assembled_params, profile, Lf)
        distance = sqrt(sum(abs2, head - target))
        local_flow_after = centered_flow_velocity(sim, head)
        active_cylinder_centers = current_cylinder_centers(
            cylinder_motions,
            T(WaterLily.time(sim.flow)),
        )
        clearance = fish_cylinder_clearance(
            assembled_params,
            profile,
            Lf,
            state,
            active_cylinder_centers,
            cylinder_radii,
        )

        push!(times, Float64(current_time))
        push!(centers, Tuple(Float64.(state.center)))
        push!(heads, Tuple(Float64.(head)))
        push!(distances, Float64(distance))
        push!(headings, Float64(state.theta))
        push!(velocities, Tuple(Float64.(state.velocity)))
        push!(forces, Tuple(Float64.(force)))
        push!(moments, Float64(moment_z))
        push!(local_flows, Tuple(Float64.(local_flow_after)))
        push!(joint_rows, (joint.phi1, joint.phi2, joint.phi_dot1, joint.phi_dot2, joint.phi_ddot1, joint.phi_ddot2))
        push!(clearances, clearance)
        push!(video_centers, Tuple(Float64.(state.center)))
        push!(video_heads, Tuple(Float64.(head)))

        scheduled_frame_due = current_time + eps(current_time) >= next_frame_time || current_time >= rollout_horizon
        speed_norm = hypot(Float64(state.velocity[1]), Float64(state.velocity[2]))
        force_norm = hypot(Float64(force[1]), Float64(force[2]))
        force_triggered = vtk_force_trigger !== nothing && force_norm >= Float64(vtk_force_trigger)
        speed_triggered = vtk_speed_trigger !== nothing && speed_norm >= Float64(vtk_speed_trigger)
        force_limit_exceeded = force_norm >= dynamics_force_limit
        speed_limit_exceeded = speed_norm >= dynamics_speed_limit
        dynamics_unstable = force_limit_exceeded || speed_limit_exceeded
        domain_exit_margin = Float64(domain_exit_margin_L) * Float64(Lf)
        center_inside_exit_margin =
            domain_exit_margin <= Float64(state.center[1]) <= dims[1] - domain_exit_margin &&
            domain_exit_margin <= Float64(state.center[2]) <= dims[2] - domain_exit_margin
        boundary_exit = !center_inside_exit_margin
        trigger_interval_ok = Float64(current_time) - last_trigger_vtk_time >= vtk_trigger_min_interval
        diagnostic_frame_due = vtk_stream !== nothing &&
            trigger_interval_ok &&
            (force_triggered || speed_triggered || dynamics_unstable || boundary_exit)

        if (plot_frames || render_frames || vtk_stream !== nothing) && (scheduled_frame_due || diagnostic_frame_due)
            frame_index += 1
            if vtk_stream !== nothing
                DogfishShapePolicyTestbed.write_free_swim_vtk_frame!(
                    vtk_stream,
                    sim,
                    state.center,
                    state.theta;
                    period=max(release_visual_horizon, eps(Float64)),
                )
            end
            if plot_frames
                frame_path = joinpath(frames_dir, @sprintf("frame_%04d.png", frame_index))
                render_wake_flow_frame!(
                    sim,
                    frame_path,
                    video_centers,
                    video_heads,
                    target,
                    success_radius,
                    "fish released",
                    Float64(current_time),
                    release_visual_horizon;
                    clims=(-plot_clim, plot_clim),
                )
            elseif render_frames
                frame_path = joinpath(frames_dir, @sprintf("frame_%04d.png", frame_index))
                render_wake_episode_frame(
                    frame_path,
                    state,
                    assembled_params,
                    profile,
                    Lf,
                    centers,
                    heads,
                    target,
                    success_radius,
                    active_cylinder_centers,
                    cylinder_radii,
                    dims,
                    Float64(current_time),
                    release_visual_horizon,
                    Float64(distance),
                )
            end
            scheduled_frame_due && (next_frame_time += release_frame_dt)
            diagnostic_frame_due && (last_trigger_vtk_time = Float64(current_time))
        end

        if boundary_exit
            termination = "left_domain"
            failure_message = @sprintf(
                "fish center entered %.6f L domain exit margin at (%.6f L, %.6f L)",
                Float64(domain_exit_margin_L),
                Float64(state.center[1]) / Float64(Lf),
                Float64(state.center[2]) / Float64(Lf),
            )
            break
        end

        if dynamics_unstable
            termination = "unstable_dynamics"
            failure_message = @sprintf(
                "dynamics exceeded limit: |F|=%.6e limit=%.6e, |U|=%.6e limit=%.6e",
                force_norm,
                dynamics_force_limit,
                speed_norm,
                dynamics_speed_limit,
            )
            break
        end

        if clearance <= Float64(collision_clearance_L) * Float64(Lf)
            termination = "collision"
            failure_message = @sprintf(
                "fish/cylinder clearance %.6f L fell below %.6f L",
                clearance / Float64(Lf),
                Float64(collision_clearance_L),
            )
            break
        end

        if multiwake_target && success_radius > 0 && distance <= success_radius
            termination = "target_reached"
            break
        end

        if !(0 <= head[1] <= T(dims[1]) && 0 <= head[2] <= T(dims[2]))
            termination = "left_domain"
            break
        end
    end

    wall_elapsed = time() - wall_start
    release_elapsed = max(0.0, Float64(sim_time(sim)) - release_start_time)
    saved_final_snapshot_sidecar = nothing
    if save_final_snapshot && termination in ("horizon", "target_reached")
        final_snapshot_metadata = Dict(
            "schema_version" => "dogfish.wake_episode_snapshot.v1",
            "date" => string(now()),
            "run_config" => run_config.path,
            "snapshot_path" => final_snapshot_path,
            "resumable" => true,
            "termination" => termination,
            "sim_time" => Float64(sim_time(sim)),
            "raw_time" => Float64(WaterLily.time(sim.flow)),
            "segment_elapsed" => release_elapsed,
            "episode_elapsed" => episode_elapsed_offset + release_elapsed,
            "source_episode_snapshot" => load_episode_snapshot_path,
            "L" => L,
            "Re" => Float64(Re),
            "flow_speed" => Float64(flow_speed),
            "domain_scale" => collect(Float64.(domain_scale)),
            "domain_dims" => collect(dims_tuple),
            "target_x_L" => Float64(target_x_L),
            "target_y_fraction" => Float64(target_y_fraction),
            "cylinder_center_x_L" => Float64(cylinder_center_x_L),
            "cylinder_center_y_fraction" => Float64(cylinder_center_y_fraction),
            "cylinder_diameter_L" => Float64(cylinder_diameter_L),
            "control_period" => control_period,
            "max_dimensionless_dt" => Float64(max_dimensionless_dt),
            "raw_dt_cap" => Float64(raw_dt_cap),
            "actuation_mode" => actuation_mode,
            "policy_params_source" => "candidate_target_policy",
            "policy_params" => DogfishShapePolicyTestbed.jsonable(policy_params),
            "morphology_parameters" => DogfishShapePolicyTestbed.jsonable(morphology_params),
            "free_swim_state" => free_swim_state_metadata(state),
            "joint_state" => joint_state_metadata(joint),
            "observation_history" => observation_history_metadata(observation_history),
            "observation_history_length" => observation_history_length,
            "body_map_reference_time" => hasproperty(assembled_params, :reference_time) ?
                                         Float64(assembled_params.reference_time) :
                                         nothing,
        )
        saved_final_snapshot_sidecar = save_wake_snapshot!(
            sim,
            final_snapshot_path;
            metadata=final_snapshot_metadata,
        )
    end
    video_path = (plot_frames || render_frames) && frame_index > 0 ?
        encode_mp4(frames_dir, joinpath(output_root, "wake_episode.mp4"), fps) :
        nothing
    vtk_collection = vtk_stream === nothing ?
        nothing :
        DogfishShapePolicyTestbed.close_free_swim_vtk_stream!(
            vtk_stream;
            status=termination in ("horizon", "wall_time_limit") ? "complete" : "failed",
        )
    initial_distance = first(distances)
    final_distance = last(distances)
    min_distance = minimum(distances)
    min_distance_L = min_distance / Float64(Lf)
    final_distance_L = final_distance / Float64(Lf)
    time_fraction = release_elapsed / max(Float64(rollout_horizon), eps(Float64))
    progress = (initial_distance - final_distance) / max(initial_distance, eps(Float64))
    min_progress = (initial_distance - min_distance) / max(initial_distance, eps(Float64))
    effort = joint_effort_metrics(times, joint_rows)
    max_abs_phi1 = maximum(row -> abs(row[1]), joint_rows)
    max_abs_phi2 = maximum(row -> abs(row[2]), joint_rows)
    max_abs_tail_tangent = maximum(row -> abs(row[1] + row[2]), joint_rows)
    max_abs_phi_dot1 = maximum(row -> abs(row[3]), joint_rows)
    max_abs_phi_dot2 = maximum(row -> abs(row[4]), joint_rows)
    max_abs_phi_ddot1 = maximum(row -> abs(row[5]), joint_rows)
    max_abs_phi_ddot2 = maximum(row -> abs(row[6]), joint_rows)
    reward_metrics = distance_reward_metrics(times, distances, Lf, rollout_horizon; terminal_distance=final_distance)
    station_success = final_distance <= Float64(success_radius) &&
        reward_metrics.mean_distance_L <= 2.0 * Float64(success_radius_L)
    target_reached = termination == "target_reached" ||
        (multiwake_target && final_distance <= Float64(success_radius))
    task_success = multiwake_target ? target_reached : station_success
    unstable_failure = termination in ("unstable_dynamics", "nonfinite_state", "solver_error")
    weighted_distance_integral_score = distance_integral_weight * reward_metrics.distance_integral_score
    final_distance_score = -final_distance_weight * final_distance_L
    survival_score = survival_bonus_weight * clamp(time_fraction, 0.0, 1.0)
    effort_cost =
        command_energy_weight * effort.command_energy_mean +
        power_proxy_weight * effort.power_proxy_mean
    success_score = task_success ? station_success_bonus : 0.0
    unstable_penalty = unstable_failure ? unstable_dynamics_penalty : 0.0
    score = weighted_distance_integral_score +
        final_distance_score +
        survival_score -
        effort_cost +
        success_score -
        unstable_penalty

    trajectory_path = joinpath(output_root, "trajectory.csv")
    open(trajectory_path, "w") do io
        println(io, "time,center_x,center_y,head_x,head_y,distance,cylinder_clearance,distance_reward,cumulative_distance_reward,velocity_x,velocity_y,force_x,force_y,moment_z,local_flow_x,local_flow_y,heading,phi1,phi2,phi_dot1,phi_dot2,phi_ddot1,phi_ddot2")
        for index in eachindex(times)
            center = centers[index]
            head = heads[index]
            velocity = velocities[index]
            force = forces[index]
            local_flow = local_flows[index]
            joint_row = joint_rows[index]
            println(io, join((times[index], center[1], center[2], head[1], head[2], distances[index], clearances[index], reward_metrics.distance_rewards[index], reward_metrics.cumulative_distance_rewards[index], velocity[1], velocity[2], force[1], force[2], moments[index], local_flow[1], local_flow[2], headings[index], joint_row...), ","))
        end
    end

    cylinder_re = Float64(Re) * Float64(cylinder_diameter_L)
    inflow_re = Float64(flow_speed) * Float64(Re)
    inflow_cylinder_re = Float64(flow_speed) * cylinder_re
    nominal_shedding_st = 0.20
    nominal_shedding_frequency = nominal_shedding_st * Float64(flow_speed) / max(Float64(cylinder_diameter_L), eps(Float64))
    nominal_shedding_period = 1.0 / max(nominal_shedding_frequency, eps(Float64))
    nominal_tailbeat_frequency = 1.0 / max(Float64(control_period), eps(Float64))
    wake_diagnostics = Dict(
        "schema_version" => "dogfish.wake_release_diagnostics.v0",
        "tailbeat_frequency_estimate" => nominal_tailbeat_frequency,
        "cylinder_shedding_st_assumed" => nominal_shedding_st,
        "cylinder_shedding_frequency_estimate" => nominal_shedding_frequency,
        "cylinder_shedding_period_estimate" => nominal_shedding_period,
        "tailbeat_to_shedding_frequency_ratio_estimate" => nominal_tailbeat_frequency / max(nominal_shedding_frequency, eps(Float64)),
        "release_shedding_cycles_estimate" => release_elapsed / max(nominal_shedding_period, eps(Float64)),
        "head_displacement_x_L" => (heads[end][1] - heads[1][1]) / Float64(Lf),
        "head_displacement_y_L" => (heads[end][2] - heads[1][2]) / Float64(Lf),
        "center_displacement_x_L" => (centers[end][1] - centers[1][1]) / Float64(Lf),
        "center_displacement_y_L" => (centers[end][2] - centers[1][2]) / Float64(Lf),
        "max_abs_lateral_target_offset_L" => finite_max_abs((head[2] - Float64(target[2])) / Float64(Lf) for head in heads),
        "mean_velocity_x" => finite_mean(velocity[1] for velocity in velocities),
        "mean_velocity_y" => finite_mean(velocity[2] for velocity in velocities),
        "mean_local_flow_x" => finite_mean(flow[1] for flow in local_flows),
        "mean_local_flow_y" => finite_mean(flow[2] for flow in local_flows),
        "rms_local_crossflow_y" => finite_rms(flow[2] for flow in local_flows),
        "mean_relative_flow_x" => finite_mean(local_flows[i][1] - velocities[i][1] for i in eachindex(local_flows)),
        "mean_relative_flow_y" => finite_mean(local_flows[i][2] - velocities[i][2] for i in eachindex(local_flows)),
        "rms_relative_crossflow_y" => finite_rms(local_flows[i][2] - velocities[i][2] for i in eachindex(local_flows)),
        "mean_force_x" => finite_mean(force[1] for force in forces),
        "mean_force_y" => finite_mean(force[2] for force in forces),
        "rms_force_y" => finite_rms(force[2] for force in forces),
        "rms_moment_z" => finite_rms(moments),
        "max_abs_phi1" => Float64(max_abs_phi1),
        "max_abs_phi2" => Float64(max_abs_phi2),
        "max_abs_phi_dot1" => Float64(max_abs_phi_dot1),
        "max_abs_phi_dot2" => Float64(max_abs_phi_dot2),
        "max_abs_phi_ddot1" => Float64(max_abs_phi_ddot1),
        "max_abs_phi_ddot2" => Float64(max_abs_phi_ddot2),
    )
    wake_diagnostics_path = joinpath(output_root, "wake_diagnostics.json")
    open(wake_diagnostics_path, "w") do io
        JSON.print(io, DogfishShapePolicyTestbed.jsonable(wake_diagnostics), 2)
        println(io)
    end
    summary = Dict(
        "schema_version" => multiwake_target ?
                            "dogfish.free_swim_multiwake_target_episode.v0" :
                            "dogfish.free_swim_wake_episode.v0",
        "task_family" => multiwake_target ? "multi_cylinder_wake_targeting" : "cylinder_wake_station_holding",
        "status" => termination in ("horizon", "target_reached", "wall_time_limit") ? "ok" : "failed",
        "date" => string(now()),
        "run_config" => run_config.path,
        "termination" => termination,
        "failure_message" => failure_message,
        "station_success" => station_success,
        "target_reached" => target_reached,
        "task_success" => task_success,
        "score" => score,
        "L" => L,
        "Re" => Float64(Re),
        "cylinder_Re" => cylinder_re,
        "flow_speed" => Float64(flow_speed),
        "inflow_Re" => inflow_re,
        "inflow_cylinder_Re" => inflow_cylinder_re,
        "actuation_mode" => actuation_mode,
        "backend" => resolved_backend.name,
        "domain_scale" => collect(Float64.(domain_scale)),
        "domain_dims" => collect(dims_tuple),
        "body_density" => Float64(body_density),
        "mass" => Float64(mass),
        "inertia" => Float64(inertia),
        "added_mass_model" => String(added_mass.model),
        "added_mass_scale" => Float64(added_mass.translational_scale),
        "added_inertia_scale" => Float64(added_mass.rotational_scale),
        "added_mass_forward" => Float64(added_mass.forward),
        "added_mass_lateral" => Float64(added_mass.lateral),
        "added_inertia" => Float64(added_mass.inertia),
        "added_mass_equivalent_semi_major" => added_mass.semi_major === nothing ?
                                             nothing :
                                             Float64(added_mass.semi_major),
        "added_mass_equivalent_semi_minor" => added_mass.semi_minor === nothing ?
                                             nothing :
                                             Float64(added_mass.semi_minor),
        "added_mass_reference_area" => added_mass.reference_area === nothing ?
                                      nothing :
                                      Float64(added_mass.reference_area),
        "dynamic_mass_forward" => Float64(mass + T(added_mass.forward)),
        "dynamic_mass_lateral" => Float64(mass + T(added_mass.lateral)),
        "dynamic_inertia" => Float64(inertia + T(added_mass.inertia)),
        "horizon" => Float64(rollout_horizon),
        "prewarm_horizon" => Float64(prewarm_horizon),
        "requested_prewarm_horizon" => Float64(requested_prewarm_horizon),
        "prewarm_with_fish" => prewarm_with_fish,
        "total_horizon" => Float64(total_horizon),
        "physical_total_horizon" => Float64(release_start_time + rollout_horizon),
        "release_start_time" => Float64(release_start_time),
        "release_elapsed" => Float64(release_elapsed),
        "sim_time" => Float64(sim_time(sim)),
        "prewarm_steps" => prewarm_steps,
        "loaded_prewarm_snapshot" => loaded_prewarm_snapshot,
        "load_prewarm_snapshot" => load_prewarm_snapshot_path,
        "save_prewarm_snapshot" => save_prewarm_snapshot_path,
        "saved_prewarm_snapshot_sidecar" => saved_prewarm_snapshot_sidecar,
        "prewarm_snapshot_metadata" => prewarm_snapshot_metadata,
        "loaded_episode_snapshot" => loaded_episode_snapshot,
        "load_episode_snapshot" => load_episode_snapshot_path,
        "episode_snapshot_metadata" => episode_snapshot_metadata,
        "episode_elapsed_offset" => episode_elapsed_offset,
        "episode_elapsed" => episode_elapsed_offset + release_elapsed,
        "save_final_snapshot" => save_final_snapshot,
        "final_snapshot" => save_final_snapshot && termination in ("horizon", "target_reached") ? final_snapshot_path : nothing,
        "saved_final_snapshot_sidecar" => saved_final_snapshot_sidecar,
        "steps" => steps,
        "max_dimensionless_dt" => Float64(max_dimensionless_dt),
        "raw_dt_cap" => Float64(raw_dt_cap),
        "frames" => frame_index,
        "target" => collect(Float64.(target)),
        "target_x_L" => Float64(target_x_L),
        "target_offset_from_cylinder_L" => Float64(target_offset_from_cylinder_L),
        "target_y_fraction" => Float64(target_y_fraction),
        "target_y_L" => target_y_L === nothing ? nothing : Float64(target_y_L),
        "success_radius" => Float64(success_radius),
        "success_radius_L" => Float64(success_radius_L),
        "cylinder_center" => collect(Float64.(cylinder_center)),
        "cylinder_center_x_L" => Float64(cylinder_center_x_L),
        "cylinder_center_y_fraction" => Float64(cylinder_center_y_fraction),
        "cylinder_radius" => Float64(cylinder_radius),
        "cylinder_diameter_L" => Float64(cylinder_diameter_L),
        "cylinder_centers" => [collect(Float64.(center)) for center in cylinder_centers],
        "cylinder_centers_x_L" => collect(Float64.(cylinder_centers_x_L)),
        "cylinder_centers_y_L" => collect(Float64.(cylinder_centers_y_L)),
        "cylinder_radii" => collect(Float64.(cylinder_radii)),
        "cylinder_diameters_L" => collect(Float64.(cylinder_diameters_L)),
        "cylinder_kick_amplitude_L" => Float64(cylinder_kick_amplitude_L),
        "cylinder_kick_start" => Float64(cylinder_kick_start),
        "cylinder_kick_duration" => Float64(cylinder_kick_duration),
        "cylinder_kick_cycles" => Float64(cylinder_kick_cycles),
        "initial_center_x_L" => Float64(initial_center_x_L),
        "initial_head_distance_from_target_L" => initial_head_distance_from_target_L === nothing ?
                                                 nothing :
                                                 Float64(initial_head_distance_from_target_L),
        "initial_center_y_fraction" => Float64(initial_center_y_fraction),
        "initial_center_y_L" => initial_center_y_L === nothing ? nothing : Float64(initial_center_y_L),
        "initial_heading_deg" => rad2deg(Float64(initial_heading)),
        "initial_center" => collect(centers[1]),
        "initial_head" => collect(heads[1]),
        "final_center" => collect(centers[end]),
        "final_head" => collect(heads[end]),
        "initial_distance" => initial_distance,
        "initial_distance_L" => initial_distance / Float64(L),
        "final_distance" => final_distance,
        "min_distance" => min_distance,
        "min_distance_L" => min_distance_L,
        "min_cylinder_clearance_L" => minimum(clearances) / Float64(Lf),
        "collision_clearance_L" => Float64(collision_clearance_L),
        "domain_exit_margin_L" => Float64(domain_exit_margin_L),
        "final_distance_L" => final_distance_L,
        "mean_distance_L" => reward_metrics.mean_distance_L,
        "observed_distance_integral_L" => reward_metrics.observed_distance_integral_L,
        "terminal_hold_integral_L" => reward_metrics.terminal_hold_integral_L,
        "distance_integral_L" => reward_metrics.distance_integral_L,
        "distance_integral_score" => reward_metrics.distance_integral_score,
        "weighted_distance_integral_score" => weighted_distance_integral_score,
        "final_distance_score" => final_distance_score,
        "survival_score" => survival_score,
        "survival_bonus_weight" => survival_bonus_weight,
        "progress" => progress,
        "min_progress" => min_progress,
        "effort_cost" => effort_cost,
        "success_score" => success_score,
        "unstable_penalty" => unstable_penalty,
        "distance_integral_weight" => distance_integral_weight,
        "final_distance_weight" => final_distance_weight,
        "command_energy" => effort.command_energy,
        "command_energy_mean" => effort.command_energy_mean,
        "power_proxy" => effort.power_proxy,
        "power_proxy_mean" => effort.power_proxy_mean,
        "command_energy_weight" => command_energy_weight,
        "power_proxy_weight" => power_proxy_weight,
        "unstable_dynamics_penalty" => unstable_dynamics_penalty,
        "unstable_failure" => unstable_failure,
        "flow_perturbation" => Float64(flow_perturbation),
        "flow_seed" => flow_seed,
        "exit_bc" => exit_bc,
        "final_heading" => headings[end],
        "final_joint_state" => collect(joint_rows[end]),
        "joint_angle_limit_deg" => Float64(phi_limit / TARGET_DEG),
        "phi_dot_limit_deg" => Float64(phi_dot_limit / TARGET_DEG),
        "phi_ddot_limit_deg" => Float64(phi_ddot_limit / TARGET_DEG),
        "observation_history_length" => observation_history_length,
        "policy" => "candidate_target_policy.target_policy",
        "policy_params_source" => "candidate_target_policy",
        "policy_params" => DogfishShapePolicyTestbed.jsonable(policy_params),
        "wall_s" => wall_elapsed,
        "plot_frames" => plot_frames,
        "plot_clim" => plot_clim,
        "frames_dir" => (plot_frames || render_frames) ? frames_dir : nothing,
        "video" => video_path,
        "vtk_enabled" => vtk_stream !== nothing,
        "vtk_fields" => vtk_stream === nothing ? String[] : vtk_stream.fields,
        "vtk_compress" => vtk_stream === nothing ? nothing : vtk_stream.compress,
        "vtk_dir" => vtk_stream === nothing ? nothing : vtk_stream.vtk_dir,
        "vtk_collection" => vtk_collection,
        "vtk_latest_frame" => vtk_stream === nothing ? nothing : vtk_stream.latest_path,
        "vtk_frame_manifest" => vtk_stream === nothing ? nothing : vtk_stream.manifest_path,
        "vtk_force_trigger" => vtk_force_trigger === nothing ? nothing : Float64(vtk_force_trigger),
        "vtk_speed_trigger" => vtk_speed_trigger === nothing ? nothing : Float64(vtk_speed_trigger),
        "vtk_trigger_min_interval" => vtk_trigger_min_interval,
        "dynamics_force_limit" => dynamics_force_limit,
        "dynamics_speed_limit" => dynamics_speed_limit,
        "trajectory" => trajectory_path,
        "wake_diagnostics" => wake_diagnostics,
        "wake_diagnostics_path" => wake_diagnostics_path,
        "morphology_parameters" => DogfishShapePolicyTestbed.jsonable(morphology_params),
    )
    summary_path = joinpath(output_root, "summary.json")
    open(summary_path, "w") do io
        JSON.print(io, DogfishShapePolicyTestbed.jsonable(summary), 2)
        println(io)
    end

    println("status=$(summary["status"])")
    println("termination=$termination")
    println("station_success=$station_success")
    println("target_reached=$target_reached")
    println("task_success=$task_success")
    println("score=$score")
    println("steps=$steps")
    println("prewarm_steps=$prewarm_steps")
    println("frames=$frame_index")
    println("backend=$(resolved_backend.name)")
    println("horizon=$(rollout_horizon)")
    println("prewarm_horizon=$(prewarm_horizon)")
    println("requested_prewarm_horizon=$(Float64(requested_prewarm_horizon))")
    println("prewarm_with_fish=$prewarm_with_fish")
    println("total_horizon=$(total_horizon)")
    println("physical_total_horizon=$(Float64(release_start_time + rollout_horizon))")
    println("loaded_prewarm_snapshot=$loaded_prewarm_snapshot")
    println("load_prewarm_snapshot=$load_prewarm_snapshot_path")
    println("loaded_episode_snapshot=$loaded_episode_snapshot")
    println("load_episode_snapshot=$load_episode_snapshot_path")
    println("final_snapshot=$(save_final_snapshot && termination in ("horizon", "target_reached") ? final_snapshot_path : nothing)")
    println("Re=$(Float64(Re))")
    println("cylinder_Re=$cylinder_re")
    println("initial_distance_L=$(initial_distance / L)")
    println("final_distance_L=$(final_distance / L)")
    println("mean_distance_L=$(reward_metrics.mean_distance_L)")
    println("target=$(Tuple(Float64.(target)))")
    println("cylinder_centers=$([Tuple(Float64.(center)) for center in cylinder_centers])")
    println("final_head=$(heads[end])")
    println("summary=$summary_path")
    println("trajectory=$trajectory_path")
    println("wake_diagnostics=$wake_diagnostics_path")
    println("video=$video_path")
    println("vtk_collection=$vtk_collection")
    println("vtk_latest_frame=$(vtk_stream === nothing ? nothing : vtk_stream.latest_path)")
end

function wake_program_main()
    config_env_names = ("DOGFISH_FREE_SWIM_WAKE_CONFIG", "DOGFISH_RUN_CONFIG")
    run_config = DogfishShapePolicyTestbed.load_run_config(
        case_dir;
        env_names=config_env_names,
    )
    if haskey(run_config.data, "free_swim_multiwake_target_episode")
        return wake_main(
            config_env_names=config_env_names,
            config_sections=("free_swim", "free_swim_multiwake_target_episode"),
            output_env_name="DOGFISH_WAKE_OUTPUT_ROOT",
            default_output_subdir="free_swim_multiwake_target_episode",
            multiwake_target=true,
        )
    end
    return wake_main()
end

if abspath(PROGRAM_FILE) == @__FILE__
    wake_program_main()
end
