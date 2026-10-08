# 3D target-reaching episode. Port of the 2D `free_swim_target_episode.jl`
# with the same observation packet, policy contract, joint limits, scoring,
# and artifact schema — only the simulation layer changes (3D fluid, locked
# heave/roll/pitch, body of revolution). Policy selection supports the 2D→3D
# transfer experiment via DOGFISH3D_POLICY_FILE (see candidate_target_policy.jl).

ENV["GKSwstype"] = get(ENV, "GKSwstype", "100")

case_dir = @__DIR__

include(joinpath(case_dir, "src", "Dogfish3DShapePolicyTestbed.jl"))
using .Dogfish3DShapePolicyTestbed
const T3D = Dogfish3DShapePolicyTestbed
# Alias so the planar helper code copied verbatim from the 2D episode
# resolves against the shared 2D module.
const DogfishShapePolicyTestbed = T3D.Base2D

using Dates
using JSON
using Plots
using Printf
using StaticArrays
using WaterLily

const TARGET_DEG = pi / 180
# Set once from config in main(); used by the planar helpers that need the
# 3D (volume-weighted) reference centroid.
const HEIGHT_SCALE = Ref(1.0f0)

include(joinpath(case_dir, "candidate_target_policy.jl"))

function target_control_design(; control_period=1.0f0)
    base_params = DogfishShapePolicyTestbed.two_joint_bend_params(
        T=Float32;
        phi1=0f0,
        phi2=0f0,
        center1=1f0 / 3f0,
        center2=2f0 / 3f0,
        half_width1=1f0 / 8f0,
        half_width2=1f0 / 8f0,
    )
    params = merge(base_params, (control_period=Float32(control_period),))
    return (
        version="dogfish.target_control_3d.v1",
        lineage=(
            body_regime=:baseline_profile_body_of_revolution,
            motion_regime=:state_feedback_distributed_joint_bend,
            notes="3D locked-DOF target reaching; controller owns joint angular acceleration",
        ),
        morphology=(
            schema=NamedTuple(),
            params=NamedTuple(),
            generator=(s, p) -> 0f0,
        ),
        motion=(
            schema=NamedTuple(),
            params=params,
            generator=DogfishShapePolicyTestbed.two_joint_bend_angle_with_rates,
            derive=target_motion_derived_params,
        ),
        experiments=[
            (
                id="target_reach_3d",
                morphology=NamedTuple(),
                motion=NamedTuple(),
            ),
        ],
    )
end

function target_motion_derived_params(params; L::Int, T::Type=Float32)
    typed = DogfishShapePolicyTestbed.cast_named_tuple(params, T)
    return (params=typed, period=Float64(typed.control_period))
end

function clamp_value(value, limit)
    return clamp(value, -limit, limit)
end

function integrate_joint_state(
    joint,
    phi_ddot,
    dt;
    phi_limit,
    phi_dot_limit,
    phi_ddot_limit,
)
    a1 = clamp_value(phi_ddot[1], phi_ddot_limit)
    a2 = clamp_value(phi_ddot[2], phi_ddot_limit)
    phi_dot1 = clamp_value(joint.phi_dot1 + a1 * dt, phi_dot_limit)
    phi_dot2 = clamp_value(joint.phi_dot2 + a2 * dt, phi_dot_limit)
    phi1 = clamp_value(joint.phi1 + phi_dot1 * dt, phi_limit)
    phi2 = clamp_value(joint.phi2 + phi_dot2 * dt, phi_limit)
    if phi1 == phi_limit || phi1 == -phi_limit
        phi_dot1 = 0.0
    end
    if phi2 == phi_limit || phi2 == -phi_limit
        phi_dot2 = 0.0
    end
    return (
        phi1=phi1,
        phi2=phi2,
        phi_dot1=phi_dot1,
        phi_dot2=phi_dot2,
        phi_ddot1=a1,
        phi_ddot2=a2,
    )
end

function joint_effort_metrics(times, joint_rows)
    length(times) <= 1 && return (command_energy=0.0, command_energy_mean=0.0, power_proxy=0.0, power_proxy_mean=0.0)
    command_energy = 0.0
    power_proxy = 0.0
    for index in 2:length(times)
        dt = max(0.0, Float64(times[index] - times[index - 1]))
        row = joint_rows[index]
        command_energy += (row[5]^2 + row[6]^2) * dt
        power_proxy += (abs(row[5] * row[3]) + abs(row[6] * row[4])) * dt
    end
    duration = max(Float64(last(times) - first(times)), eps(Float64))
    return (
        command_energy=command_energy,
        command_energy_mean=command_energy / duration,
        power_proxy=power_proxy,
        power_proxy_mean=power_proxy / duration,
    )
end

function distance_reward_metrics(times, distances, Lf, rollout_horizon; terminal_distance=0.0)
    length_scale = max(Float64(Lf), eps(Float64))
    horizon = max(Float64(rollout_horizon), eps(Float64))
    distance_rewards = [-Float64(distance) / length_scale for distance in distances]
    cumulative_distance_rewards = zeros(Float64, length(distance_rewards))
    observed_distance_integral_L = 0.0
    for index in 2:length(times)
        dt_fraction = max(0.0, Float64(times[index] - times[index - 1])) / horizon
        previous_distance_L = Float64(distances[index - 1]) / length_scale
        current_distance_L = Float64(distances[index]) / length_scale
        observed_distance_integral_L += 0.5 * (previous_distance_L + current_distance_L) * dt_fraction
        cumulative_distance_rewards[index] = -observed_distance_integral_L
    end
    elapsed = max(0.0, Float64(last(times) - first(times)))
    elapsed_fraction = clamp(elapsed / horizon, 0.0, 1.0)
    remaining_fraction = max(0.0, 1.0 - elapsed_fraction)
    terminal_distance_L = max(0.0, Float64(terminal_distance) / length_scale)
    terminal_hold_integral_L = terminal_distance_L * remaining_fraction
    distance_integral_L = observed_distance_integral_L + terminal_hold_integral_L
    mean_distance_L = distance_integral_L
    return (
        distance_rewards=distance_rewards,
        cumulative_distance_rewards=cumulative_distance_rewards,
        observed_distance_integral_L=observed_distance_integral_L,
        terminal_hold_integral_L=terminal_hold_integral_L,
        distance_integral_L=distance_integral_L,
        distance_integral_score=-distance_integral_L,
        mean_distance_L=mean_distance_L,
        elapsed_fraction=elapsed_fraction,
    )
end

function current_joint_params(base_params, joint)
    return DogfishShapePolicyTestbed.merge_two_joint_state(base_params, joint)
end

function current_joint_params(base_params, joint, reference_time, L)
    return DogfishShapePolicyTestbed.merge_two_joint_state(
        base_params,
        joint;
        reference_time,
        L,
    )
end

function local_to_world(point, reference_center, state)
    return state.center + DogfishShapePolicyTestbed.rotate_to_world_frame(point - reference_center, state.theta)
end

# 3D override: the motion map anchors at the volume-weighted centroid of the
# swept body, so world-frame reconstruction must use the same centroid.
function free_swim_reference_center(params, profile, Lf)
    reference_time = hasproperty(params, :reference_time) ? params.reference_time : zero(Lf)
    return T3D.deformed_body_centroid_3d(
        DogfishShapePolicyTestbed.two_joint_bend_angle_with_rates,
        params,
        profile,
        Lf,
        reference_time;
        height_scale=typeof(Lf)(HEIGHT_SCALE[]),
    )
end

function head_position(state, params, profile, Lf)
    reference_center = free_swim_reference_center(params, profile, Lf)
    return local_to_world(SVector(zero(Lf), zero(Lf)), reference_center, state)
end

function body_map_sample_time(params, Lf)
    return hasproperty(params, :reference_time) ? params.reference_time : zero(Lf)
end

function wrapped_angle_delta(current, previous)
    return atan(sin(current - previous), cos(current - previous))
end

function normalized_body_vector(value, Lf)
    return SVector(Float64(value[1]) / Float64(Lf), Float64(value[2]) / Float64(Lf))
end

function body_frame_observation(
    state,
    joint,
    target,
    force,
    moment_z,
    params,
    profile,
    Lf;
    observation_history=(),
    current_time=0.0,
    history_length=8,
)
    head = head_position(state, params, profile, Lf)
    target_delta = SVector(target[1] - head[1], target[2] - head[2])
    target_body = DogfishShapePolicyTestbed.rotate_to_body_frame(target_delta, state.theta)
    velocity_body = DogfishShapePolicyTestbed.rotate_to_body_frame(state.velocity, state.theta)
    force_body = DogfishShapePolicyTestbed.rotate_to_body_frame(force, state.theta)
    distance = sqrt(sum(abs2, target_delta))
    forward_distance = -target_body[1]
    lateral_distance = target_body[2]
    bearing = atan(lateral_distance, max(abs(forward_distance), eltype(target_body)(0.25) * Lf))
    current_time_value = Float64(current_time)
    history_count = length(observation_history)
    previous_row = history_count > 0 ? observation_history[end] : nothing
    dt = previous_row === nothing ? 0.0 : current_time_value - Float64(previous_row.time)
    has_history = previous_row !== nothing && isfinite(dt) && dt > 0.0
    previous_target_body = has_history ? previous_row.target_body : target_body
    previous_distance = has_history ? previous_row.distance : distance
    previous_bearing = has_history ? previous_row.bearing : bearing
    target_body_delta_L = has_history ?
        (target_body - previous_target_body) / Lf :
        SVector(zero(eltype(target_body)), zero(eltype(target_body)))
    target_body_rate_L = has_history ? target_body_delta_L / dt : target_body_delta_L
    distance_rate_L = has_history ?
        (Float64(distance) - Float64(previous_distance)) / (Float64(Lf) * dt) :
        0.0
    bearing_rate = has_history ? wrapped_angle_delta(Float64(bearing), Float64(previous_bearing)) / dt : 0.0
    heading_rate = Float64(state.omega) * Float64(Lf)
    stack_length = max(1, Int(history_length))
    previous_stack_count = min(history_count, stack_length - 1)
    selected_start = history_count - previous_stack_count + 1
    selected_rows = previous_stack_count > 0 ? observation_history[selected_start:history_count] : ()
    current_target_body_L = normalized_body_vector(target_body, Lf)
    current_distance_L = Float64(distance) / Float64(Lf)
    current_bearing = Float64(bearing)
    target_body_history_L_values = SVector{2, Float64}[]
    distance_history_L_values = Float64[]
    bearing_history_values = Float64[]
    history_time_offsets = Float64[]
    for _ in 1:(stack_length - previous_stack_count - 1)
        push!(target_body_history_L_values, current_target_body_L)
        push!(distance_history_L_values, current_distance_L)
        push!(bearing_history_values, current_bearing)
        push!(history_time_offsets, 0.0)
    end
    for row in selected_rows
        push!(target_body_history_L_values, normalized_body_vector(row.target_body, Lf))
        push!(distance_history_L_values, Float64(row.distance) / Float64(Lf))
        push!(bearing_history_values, Float64(row.bearing))
        push!(history_time_offsets, Float64(row.time) - current_time_value)
    end
    push!(target_body_history_L_values, current_target_body_L)
    push!(distance_history_L_values, current_distance_L)
    push!(bearing_history_values, current_bearing)
    push!(history_time_offsets, 0.0)
    oldest_row = previous_stack_count > 0 ? selected_rows[1] : nothing
    oldest_target_body_L = oldest_row === nothing ?
        current_target_body_L :
        normalized_body_vector(oldest_row.target_body, Lf)
    oldest_distance_L = oldest_row === nothing ?
        current_distance_L :
        Float64(oldest_row.distance) / Float64(Lf)
    oldest_bearing = oldest_row === nothing ? current_bearing : Float64(oldest_row.bearing)
    oldest_offset = oldest_row === nothing ? 0.0 : Float64(oldest_row.time) - current_time_value
    history_window_dt = max(0.0, -oldest_offset)
    target_body_window_delta_L = current_target_body_L - oldest_target_body_L
    target_body_window_rate_L = history_window_dt > 0.0 ?
        target_body_window_delta_L / history_window_dt :
        SVector(0.0, 0.0)
    distance_window_delta_L = current_distance_L - oldest_distance_L
    window_closing_speed_L = history_window_dt > 0.0 ? -distance_window_delta_L / history_window_dt : 0.0
    bearing_window_delta = wrapped_angle_delta(current_bearing, oldest_bearing)
    bearing_window_rate = history_window_dt > 0.0 ? bearing_window_delta / history_window_dt : 0.0
    return (
        head=head,
        target_delta=target_delta,
        target_body=target_body,
        previous_target_body=previous_target_body,
        target_body_delta_L=target_body_delta_L,
        target_body_rate_L=target_body_rate_L,
        target_body_history_L=Tuple(target_body_history_L_values),
        target_body_window_delta_L=target_body_window_delta_L,
        target_body_window_rate_L=target_body_window_rate_L,
        velocity_body=velocity_body,
        force_body=force_body,
        distance=distance,
        previous_distance=previous_distance,
        distance_rate_L=distance_rate_L,
        closing_speed_L=-distance_rate_L,
        distance_history_L=Tuple(distance_history_L_values),
        distance_window_delta_L=distance_window_delta_L,
        window_closing_speed_L=window_closing_speed_L,
        forward_distance=forward_distance,
        lateral_distance=lateral_distance,
        bearing=bearing,
        previous_bearing=previous_bearing,
        bearing_rate=bearing_rate,
        bearing_history=Tuple(bearing_history_values),
        bearing_window_delta=bearing_window_delta,
        bearing_window_rate=bearing_window_rate,
        history_dt=dt,
        history_count=previous_stack_count + 1,
        history_window_dt=history_window_dt,
        history_time_offsets=Tuple(history_time_offsets),
        moment_z=moment_z,
        heading_rate=heading_rate,
        turn_rate_recent=heading_rate,
        phi=(joint.phi1, joint.phi2),
        phi_dot=(joint.phi_dot1, joint.phi_dot2),
        previous_action=(joint.phi_ddot1, joint.phi_ddot2),
    )
end

function render_target_episode_frame(
    output_path,
    state,
    params,
    profile,
    Lf,
    centers,
    heads,
    target,
    success_radius,
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
        local_to_world(DogfishShapePolicyTestbed.spine_centerline(map, Float32(i / 160), sample_time), reference_center, state)
        for i in 0:160
    ]

    target_theta = range(0, 2pi; length=121)
    target_x = [target[1] + success_radius * cos(theta) for theta in target_theta]
    target_y = [target[2] + success_radius * sin(theta) for theta in target_theta]

    plt = plot(
        size=(1600, 800),
        aspect_ratio=:equal,
        legend=false,
        xlims=(0, dims[1]),
        ylims=(0, dims[2]),
        xlabel="x",
        ylabel="y",
        title=@sprintf("3D target episode (mid-plane) | t=%.3f / %.3f | distance=%.3f L", elapsed_time, horizon, distance / Float64(Lf)),
        margin=6Plots.mm,
        background_color=:white,
    )
    plot!(plt, target_x, target_y; color=:red, linewidth=1.5)
    scatter!(plt, [target[1]], [target[2]]; markercolor=:red, markersize=3)
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

function encode_mp4(frames_dir::AbstractString, output_path::AbstractString, fps::Int)
    Sys.which("ffmpeg") === nothing && return nothing
    frame_pattern = joinpath(frames_dir, "frame_%04d.png")
    cmd = Cmd([
        "ffmpeg",
        "-y",
        "-framerate",
        string(fps),
        "-i",
        frame_pattern,
        "-vf",
        "pad=ceil(iw/2)*2:ceil(ih/2)*2",
        "-c:v",
        "libx264",
        "-pix_fmt",
        "yuv420p",
        output_path,
    ])
    run(pipeline(cmd; stdout=devnull, stderr=devnull))
    return output_path
end

function main()
    run_config = DogfishShapePolicyTestbed.load_run_config(
        case_dir;
        env_names=("DOGFISH_FREE_SWIM_TARGET_CONFIG", "DOGFISH_RUN_CONFIG"),
    )
    config = DogfishShapePolicyTestbed.merged_run_config_sections(
        run_config,
        ("free_swim", "free_swim_target_episode"),
    )
    output_root = DogfishShapePolicyTestbed.configured_string(
        config,
        "output_root",
        "DOGFISH_FREE_SWIM_TARGET_OUTPUT_ROOT",
        joinpath(pwd(), "logs", "free_swim_target_episode3d"),
    )
    L = DogfishShapePolicyTestbed.configured_int(config, "L", "DOGFISH_FREE_SWIM_L", 24)
    requested_horizon = DogfishShapePolicyTestbed.configured_optional_float32(config, "horizon", "DOGFISH_TARGET_HORIZON")
    backend = DogfishShapePolicyTestbed.configured_string(config, "backend", "DOGFISH_MEMORY_BACKEND", "cpu")
    domain_scale = (
        DogfishShapePolicyTestbed.configured_float32(config, "domain_scale_x", "DOGFISH_FREE_SWIM_DOMAIN_SCALE_X", 12.0f0),
        DogfishShapePolicyTestbed.configured_float32(config, "domain_scale_y", "DOGFISH_FREE_SWIM_DOMAIN_SCALE_Y", 6.0f0),
        DogfishShapePolicyTestbed.configured_float32(config, "domain_scale_z", "DOGFISH_FREE_SWIM_DOMAIN_SCALE_Z", 2.0f0),
    )
    initial_center_fraction = (
        DogfishShapePolicyTestbed.configured_float32(config, "initial_center_fraction_x", "DOGFISH_TARGET_INITIAL_CENTER_X", 0.75f0),
        DogfishShapePolicyTestbed.configured_float32(config, "initial_center_fraction_y", "DOGFISH_TARGET_INITIAL_CENTER_Y", 0.50f0),
        DogfishShapePolicyTestbed.configured_float32(config, "initial_center_fraction_z", "DOGFISH_TARGET_INITIAL_CENTER_Z", 0.50f0),
    )
    initial_heading = DogfishShapePolicyTestbed.configured_float32(config, "initial_heading", "DOGFISH_TARGET_INITIAL_HEADING", 0.0f0)
    target_fraction = (
        DogfishShapePolicyTestbed.configured_float32(config, "target_fraction_x", "DOGFISH_TARGET_X", 0.25f0),
        DogfishShapePolicyTestbed.configured_float32(config, "target_fraction_y", "DOGFISH_TARGET_Y", 0.70f0),
    )
    success_radius_L = DogfishShapePolicyTestbed.configured_float32(config, "success_radius_L", "DOGFISH_TARGET_SUCCESS_RADIUS_L", 0.6f0)
    time_step_fraction = DogfishShapePolicyTestbed.configured_float32(config, "time_step_fraction", "DOGFISH_FREE_SWIM_DT_FRACTION", 0.01f0)
    frame_count = DogfishShapePolicyTestbed.configured_int(config, "frame_count", "DOGFISH_TARGET_FRAME_COUNT", 60)
    fps = DogfishShapePolicyTestbed.configured_int(config, "fps", "DOGFISH_TARGET_RENDER_FPS", 12)
    render_frames = DogfishShapePolicyTestbed.configured_bool(config, "render_frames", "DOGFISH_TARGET_RENDER_FRAMES", true)
    observation_history_length = max(
        1,
        DogfishShapePolicyTestbed.configured_int(
            config,
            "observation_history_length",
            "DOGFISH_TARGET_OBSERVATION_HISTORY_LENGTH",
            8,
        ),
    )
    wall_time_limit_s = DogfishShapePolicyTestbed.configured_optional_float32(config, "wall_time_limit_s", "DOGFISH_TARGET_WALL_TIME_LIMIT_S")
    vtk_enabled = DogfishShapePolicyTestbed.configured_bool(config, "vtk", "DOGFISH_TARGET_VTK", false)
    vtk_collection_name = DogfishShapePolicyTestbed.configured_string(
        config,
        "vtk_collection_name",
        "DOGFISH_TARGET_VTK_COLLECTION_NAME",
        "target_flow3d",
    )
    vtk_fields = DogfishShapePolicyTestbed.configured_string_list(
        config,
        "vtk_fields",
        "DOGFISH_TARGET_VTK_FIELDS",
        ["lambda2", "body"],
    )
    vtk_flush_collection = DogfishShapePolicyTestbed.configured_bool(
        config,
        "vtk_flush_collection",
        "DOGFISH_TARGET_VTK_FLUSH_COLLECTION",
        true,
    )
    vtk_compress = DogfishShapePolicyTestbed.configured_bool(
        config,
        "vtk_compress",
        "DOGFISH_TARGET_VTK_COMPRESS",
        true,
    )
    dynamics_force_limit = Float64(DogfishShapePolicyTestbed.configured_float32(
        config,
        "dynamics_force_limit",
        "DOGFISH_TARGET_FORCE_LIMIT",
        1.0f6,
    ))
    dynamics_speed_limit = Float64(DogfishShapePolicyTestbed.configured_float32(
        config,
        "dynamics_speed_limit",
        "DOGFISH_TARGET_SPEED_LIMIT",
        100f0,
    ))
    command_energy_weight = Float64(DogfishShapePolicyTestbed.configured_float32(
        config,
        "command_energy_weight",
        "DOGFISH_TARGET_COMMAND_ENERGY_WEIGHT",
        0.0f0,
    ))
    power_proxy_weight = Float64(DogfishShapePolicyTestbed.configured_float32(
        config,
        "power_proxy_weight",
        "DOGFISH_TARGET_POWER_WEIGHT",
        0.0f0,
    ))
    unstable_dynamics_penalty = Float64(DogfishShapePolicyTestbed.configured_float32(
        config,
        "unstable_dynamics_penalty",
        "DOGFISH_TARGET_UNSTABLE_PENALTY",
        2.0f0,
    ))
    target_success_bonus = Float64(DogfishShapePolicyTestbed.configured_float32(
        config,
        "success_bonus",
        "DOGFISH_TARGET_SUCCESS_BONUS",
        0.0f0,
    ))
    final_distance_weight = Float64(DogfishShapePolicyTestbed.configured_float32(
        config,
        "final_distance_weight",
        "DOGFISH_TARGET_FINAL_DISTANCE_WEIGHT",
        0.0f0,
    ))
    distance_integral_weight = Float64(DogfishShapePolicyTestbed.configured_float32(
        config,
        "distance_integral_weight",
        "DOGFISH_TARGET_DISTANCE_INTEGRAL_WEIGHT",
        1.0f0,
    ))
    time_cost_weight = Float64(DogfishShapePolicyTestbed.configured_float32(
        config,
        "time_cost_weight",
        "DOGFISH_TARGET_TIME_WEIGHT",
        0.0f0,
    ))

    body_density = DogfishShapePolicyTestbed.configured_float32(config, "body_density", "DOGFISH_FREE_SWIM_BODY_DENSITY", 1.0f0)
    added_mass_scale = DogfishShapePolicyTestbed.configured_float32(config, "added_mass_scale", "DOGFISH_FREE_SWIM_ADDED_MASS_SCALE", 1.0f0)
    added_inertia_scale = DogfishShapePolicyTestbed.configured_float32(config, "added_inertia_scale", "DOGFISH_FREE_SWIM_ADDED_INERTIA_SCALE", added_mass_scale)
    added_mass_forward_coefficient = DogfishShapePolicyTestbed.configured_float32(
        config,
        "added_mass_forward_coefficient",
        "DOGFISH_FREE_SWIM_ADDED_MASS_FORWARD_COEFF",
        0.1f0,
    )
    height_scale = DogfishShapePolicyTestbed.configured_float32(config, "height_scale", "DOGFISH3D_HEIGHT_SCALE", 1.0f0)
    HEIGHT_SCALE[] = height_scale
    fin_enabled = DogfishShapePolicyTestbed.configured_bool(config, "caudal_fin", "DOGFISH3D_FIN", false)
    fin = fin_enabled ?
        T3D.caudal_fin(
            Float32(L);
            x_start=Float64(DogfishShapePolicyTestbed.configured_float32(config, "fin_x_start", "DOGFISH3D_FIN_X_START", 0.70f0)),
            x_end=Float64(DogfishShapePolicyTestbed.configured_float32(config, "fin_x_end", "DOGFISH3D_FIN_X_END", 1.02f0)),
            height=Float64(DogfishShapePolicyTestbed.configured_float32(config, "fin_height", "DOGFISH3D_FIN_HEIGHT", 0.12f0)),
            half_thickness=Float64(DogfishShapePolicyTestbed.configured_float32(config, "fin_half_thickness", "DOGFISH3D_FIN_HALF_THICKNESS", 0.012f0)),
        ) :
        nothing
    locked_moment_diagnostics = DogfishShapePolicyTestbed.configured_bool(
        config,
        "locked_moment_diagnostics",
        "DOGFISH3D_LOCKED_MOMENT_DIAGNOSTICS",
        true,
    )

    phi_limit = Float64(DogfishShapePolicyTestbed.configured_float32(config, "phi_limit_deg", "DOGFISH_TARGET_PHI_LIMIT_DEG", 45f0)) * TARGET_DEG
    phi_dot_limit = Float64(DogfishShapePolicyTestbed.configured_float32(config, "phi_dot_limit_deg", "DOGFISH_TARGET_PHI_DOT_LIMIT_DEG", 140f0)) * TARGET_DEG
    phi_ddot_limit = Float64(DogfishShapePolicyTestbed.configured_float32(config, "phi_ddot_limit_deg", "DOGFISH_TARGET_PHI_DDOT_LIMIT_DEG", 900f0)) * TARGET_DEG
    initial_phi1 = Float64(DogfishShapePolicyTestbed.configured_float32(config, "initial_phi1_deg", "DOGFISH_TARGET_INITIAL_PHI1_DEG", 8f0)) * TARGET_DEG
    initial_phi2 = Float64(DogfishShapePolicyTestbed.configured_float32(config, "initial_phi2_deg", "DOGFISH_TARGET_INITIAL_PHI2_DEG", -8f0)) * TARGET_DEG
    # Policy dynamics and gains belong exclusively to the candidate policy.
    # Episode TOML owns the environment and actuator safety limits only.
    policy_params = target_policy_params(; L)
    control_period = Float64(policy_params.control_period)

    design = target_control_design(control_period=Float32(control_period))
    experiment = first(DogfishShapePolicyTestbed.design_experiments(design))
    sim, state, z_plane, period, morphology_params, assembled_params, resolved_backend, profile =
        T3D.build_free_swim_simulation_3d(
            design,
            experiment;
            L,
            backend,
            domain_scale,
            initial_center_fraction,
            initial_heading,
            height_scale,
            caudal_fin=fin,
            time_step_fraction,
        )

    T = eltype(sim.flow.p)
    Lf = T(L)
    typed_height_scale = T(height_scale)
    sdf = T3D.Dogfish3DSDF(Lf, profile, typed_height_scale)
    props = T3D.combined_body_properties_3d(
        profile,
        Lf;
        density=T(body_density),
        height_scale=typed_height_scale,
        fin=fin,
    )
    volume = props.volume
    mass = props.mass
    inertia = props.inertia_z
    added_mass = T3D.free_swim_added_mass_properties_3d(
        profile,
        Lf;
        density=T(body_density),
        height_scale=typed_height_scale,
        forward_coefficient=T(added_mass_forward_coefficient),
        translational_scale=T(added_mass_scale),
        rotational_scale=T(added_inertia_scale),
    )
    if fin !== nothing
        fin_am = T3D.caudal_fin_added_mass(
            fin; density=T(body_density), centroid_x=props.centroid_x,
        )
        added_mass = merge(added_mass, (
            lateral=added_mass.lateral + T(added_mass_scale) * fin_am.lateral,
            inertia=added_mass.inertia + T(added_inertia_scale) * fin_am.inertia,
        ))
    end
    rollout_horizon = requested_horizon === nothing ? 5.5 : Float64(requested_horizon)
    rollout_horizon = max(rollout_horizon, eps(Float64))
    raw_dt_cap = max(eps(T), T(period) * Lf * T(time_step_fraction))
    frame_dt = rollout_horizon / max(1, frame_count)
    next_frame_time = 0.0

    dims_tuple = size(sim.flow.p) .- 2
    dims = (Float64(dims_tuple[1]), Float64(dims_tuple[2]))
    target = SVector(T(target_fraction[1]) * T(dims[1]), T(target_fraction[2]) * T(dims[2]))
    success_radius = T(success_radius_L) * Lf

    joint = (
        phi1=initial_phi1,
        phi2=initial_phi2,
        phi_dot1=0.0,
        phi_dot2=0.0,
        phi_ddot1=0.0,
        phi_ddot2=0.0,
    )
    assembled_params = current_joint_params(
        assembled_params,
        joint,
        T(WaterLily.time(sim.flow)),
        L,
    )
    T3D.set_free_swim_body_3d!(
        sim,
        design,
        sdf,
        profile,
        assembled_params,
        state,
        T(WaterLily.time(sim.flow)),
        raw_dt_cap,
        Lf,
        z_plane;
        height_scale=typed_height_scale,
        caudal_fin=fin,
    )

    mkpath(output_root)
    frames_dir = joinpath(output_root, "frames")
    render_frames && mkpath(frames_dir)
    vtk_stream = vtk_enabled ?
        T3D.start_free_swim_vtk_stream_3d(
            output_root;
            collection_name=vtk_collection_name,
            fields=vtk_fields,
            flush_collection=vtk_flush_collection,
            compress=vtk_compress,
        ) :
        nothing
    frame_index = 0
    steps = 0
    termination = "horizon"
    failure_message = nothing
    wall_start = time()

    centers = [Tuple(Float64.(state.center))]
    heads = [Tuple(Float64.(head_position(state, assembled_params, profile, Lf)))]
    times = [0.0]
    distances = [Float64(sqrt(sum(abs2, SVector(T(heads[end][1]), T(heads[end][2])) - target)))]
    headings = [Float64(state.theta)]
    velocities = [Tuple(Float64.(state.velocity))]
    forces = [(0.0, 0.0)]
    forces_z = [0.0]
    moments = [0.0]
    joint_rows = [(joint.phi1, joint.phi2, joint.phi_dot1, joint.phi_dot2, joint.phi_ddot1, joint.phi_ddot2)]
    observation_history = Any[]
    locked_moment_rows = NTuple{3, Float64}[]
    max_force_z = 0.0
    max_force_xy = 0.0
    max_locked_moment_x = 0.0
    max_locked_moment_y = 0.0

    while sim_time(sim) < rollout_horizon
        if wall_time_limit_s !== nothing && Float64(wall_time_limit_s) > 0 && time() - wall_start >= Float64(wall_time_limit_s)
            termination = "wall_time_limit"
            break
        end

        DogfishShapePolicyTestbed.cap_free_swim_timestep!(sim, raw_dt_cap, rollout_horizon)
        raw_dt = T(sim.flow.Δt[end])
        current_time = Float64(sim_time(sim))
        raw_t1 = T(WaterLily.time(sim.flow)) + raw_dt
        sim_dt = Float64(raw_dt / Lf)

        # All surface quantities measured pre-step on one consistent field
        # (post-step sampling is unsafe on the final degenerate-dt step).
        force, moment_z, force_z = T3D.free_swim_body_force_moment_3d(sim, state.center, z_plane)
        projected_time = Float64((T(WaterLily.time(sim.flow)) + raw_dt) / Lf)
        frame_due_after_step = projected_time + eps(projected_time) >= next_frame_time ||
            projected_time >= rollout_horizon
        if locked_moment_diagnostics && frame_due_after_step
            locked_mx, locked_my = T3D.free_swim_locked_moments_3d(sim, state.center, z_plane)
            push!(locked_moment_rows, (current_time, locked_mx, locked_my))
            max_locked_moment_x = max(max_locked_moment_x, abs(locked_mx))
            max_locked_moment_y = max(max_locked_moment_y, abs(locked_my))
        end
        max_force_z = max(max_force_z, abs(Float64(force_z)))
        max_force_xy = max(max_force_xy, hypot(Float64(force[1]), Float64(force[2])))

        obs = body_frame_observation(
            state,
            joint,
            target,
            force,
            moment_z,
            assembled_params,
            profile,
            Lf;
            observation_history=observation_history,
            current_time=current_time,
            history_length=observation_history_length,
        )
        action = target_policy(obs, policy_params)
        push!(
            observation_history,
            (
                time=current_time,
                target_body=obs.target_body,
                distance=obs.distance,
                bearing=obs.bearing,
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
            isfinite(force_z) &&
            all(isfinite, next_state.center) &&
            all(isfinite, next_state.velocity) &&
            isfinite(next_state.theta) &&
            isfinite(next_state.omega) &&
            all(isfinite, (joint.phi1, joint.phi2, joint.phi_dot1, joint.phi_dot2))
        )
            termination = "nonfinite_state"
            failure_message = "free-swim 3D target episode state became nonfinite"
            break
        end

        body_state = DogfishShapePolicyTestbed.free_swim_step_body_state(state, next_state, raw_dt)
        T3D.set_free_swim_body_3d!(
            sim,
            design,
            sdf,
            profile,
            assembled_params,
            body_state,
            raw_t1,
            raw_dt,
            Lf,
            z_plane;
            height_scale=typed_height_scale,
            caudal_fin=fin,
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
        current_time = sim_time(sim)
        head = head_position(state, assembled_params, profile, Lf)
        distance = sqrt(sum(abs2, head - target))

        push!(times, Float64(current_time))
        push!(centers, Tuple(Float64.(state.center)))
        push!(heads, Tuple(Float64.(head)))
        push!(distances, Float64(distance))
        push!(headings, Float64(state.theta))
        push!(velocities, Tuple(Float64.(state.velocity)))
        push!(forces, Tuple(Float64.(force)))
        push!(forces_z, Float64(force_z))
        push!(moments, Float64(moment_z))
        push!(joint_rows, (joint.phi1, joint.phi2, joint.phi_dot1, joint.phi_dot2, joint.phi_ddot1, joint.phi_ddot2))

        scheduled_frame_due = current_time + eps(current_time) >= next_frame_time || current_time >= rollout_horizon
        speed_norm = hypot(Float64(state.velocity[1]), Float64(state.velocity[2]))
        force_norm = hypot(Float64(force[1]), Float64(force[2]))
        force_limit_exceeded = force_norm >= dynamics_force_limit
        speed_limit_exceeded = speed_norm >= dynamics_speed_limit
        dynamics_unstable = force_limit_exceeded || speed_limit_exceeded

        if (render_frames || vtk_stream !== nothing) && scheduled_frame_due
            frame_index += 1
            if vtk_stream !== nothing
                T3D.write_free_swim_vtk_frame_3d!(
                    vtk_stream,
                    sim,
                    state,
                    Float64(z_plane);
                    period=rollout_horizon,
                )
            end
            if render_frames
                frame_path = joinpath(frames_dir, @sprintf("frame_%04d.png", frame_index))
                render_target_episode_frame(
                    frame_path,
                    state,
                    assembled_params,
                    profile,
                    Lf,
                    centers,
                    heads,
                    target,
                    success_radius,
                    dims,
                    Float64(current_time),
                    Float64(rollout_horizon),
                    Float64(distance),
                )
            end
            next_frame_time += frame_dt
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

        if distance <= success_radius
            termination = "reached_target"
            break
        end
        if !(0 <= head[1] <= T(dims[1]) && 0 <= head[2] <= T(dims[2]))
            termination = "left_domain"
            break
        end
    end

    wall_elapsed = time() - wall_start
    video_path = render_frames && frame_index > 0 ?
        encode_mp4(frames_dir, joinpath(output_root, "target_episode3d.mp4"), fps) :
        nothing
    vtk_collection = vtk_stream === nothing ?
        nothing :
        T3D.close_free_swim_vtk_stream_3d!(vtk_stream)
    initial_distance = first(distances)
    final_distance = last(distances)
    min_distance = minimum(distances)
    min_distance_L = min_distance / Float64(Lf)
    final_distance_L = final_distance / Float64(Lf)
    time_fraction = Float64(sim_time(sim)) / max(Float64(rollout_horizon), eps(Float64))
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
    success = termination == "reached_target"
    terminal_reward_distance = success ? 0.0 : final_distance
    reward_metrics = distance_reward_metrics(
        times,
        distances,
        Lf,
        rollout_horizon;
        terminal_distance=terminal_reward_distance,
    )
    unstable_failure = termination in ("unstable_dynamics", "nonfinite_state", "solver_error")
    weighted_distance_integral_score = distance_integral_weight * reward_metrics.distance_integral_score
    final_distance_score = -final_distance_weight * final_distance_L
    distance_score = weighted_distance_integral_score + final_distance_score
    time_cost = time_cost_weight * time_fraction
    effort_cost =
        command_energy_weight * effort.command_energy_mean +
        power_proxy_weight * effort.power_proxy_mean
    success_score = success ? target_success_bonus : 0.0
    unstable_penalty = unstable_failure ? unstable_dynamics_penalty : 0.0
    score = distance_score -
        time_cost -
        effort_cost +
        success_score -
        unstable_penalty
    force_z_ratio_max = max_force_xy > 0 ? max_force_z / max_force_xy : 0.0
    locked_moment_ratio_max = max_force_xy > 0 ?
        max(max_locked_moment_x, max_locked_moment_y) / (max_force_xy * Float64(Lf)) : 0.0

    trajectory_path = joinpath(output_root, "trajectory.csv")
    open(trajectory_path, "w") do io
        println(io, "time,center_x,center_y,head_x,head_y,distance,distance_reward,cumulative_distance_reward,velocity_x,velocity_y,force_x,force_y,force_z,moment_z,heading,phi1,phi2,phi_dot1,phi_dot2,phi_ddot1,phi_ddot2")
        for index in eachindex(times)
            center = centers[index]
            head = heads[index]
            velocity = velocities[index]
            force = forces[index]
            joint_row = joint_rows[index]
            println(io, join((times[index], center[1], center[2], head[1], head[2], distances[index], reward_metrics.distance_rewards[index], reward_metrics.cumulative_distance_rewards[index], velocity[1], velocity[2], force[1], force[2], forces_z[index], moments[index], headings[index], joint_row...), ","))
        end
    end

    locked_moments_path = nothing
    if locked_moment_diagnostics && !isempty(locked_moment_rows)
        locked_moments_path = joinpath(output_root, "locked_moments.csv")
        open(locked_moments_path, "w") do io
            println(io, "time,locked_moment_x,locked_moment_y")
            for row in locked_moment_rows
                println(io, join(row, ","))
            end
        end
    end

    summary = Dict(
        "schema_version" => "dogfish.free_swim_target_episode_3d.v1",
        "status" => termination in ("reached_target", "horizon", "wall_time_limit") ? "ok" : "failed",
        "date" => string(now()),
        "run_config" => run_config.path,
        "termination" => termination,
        "failure_message" => failure_message,
        "success" => success,
        "score" => score,
        "L" => L,
        "backend" => resolved_backend.name,
        "domain_dims" => collect(dims_tuple),
        "z_plane" => Float64(z_plane),
        "height_scale" => Float64(height_scale),
        "caudal_fin" => fin === nothing ? nothing : Dict(
            "shape" => "fan",
            "x_start" => Float64(fin.x_start),
            "x_end" => Float64(fin.x_end),
            "height" => Float64(fin.height),
            "half_thickness" => Float64(fin.half_thickness),
            "volume" => Float64(props.fin_volume),
        ),
        "policy_file" => get(ENV, "DOGFISH3D_POLICY_FILE", joinpath(case_dir, "target_policy.jl")),
        "horizon" => Float64(rollout_horizon),
        "sim_time" => Float64(sim_time(sim)),
        "steps" => steps,
        "frames" => frame_index,
        "target" => collect(Float64.(target)),
        "target_fraction" => collect(Float64.(target_fraction)),
        "success_radius" => Float64(success_radius),
        "success_radius_L" => Float64(success_radius_L),
        "initial_center_fraction" => collect(Float64.(initial_center_fraction)),
        "initial_center" => collect(centers[1]),
        "initial_head" => collect(heads[1]),
        "final_center" => collect(centers[end]),
        "final_head" => collect(heads[end]),
        "initial_distance" => initial_distance,
        "final_distance" => final_distance,
        "min_distance" => min_distance,
        "min_distance_L" => min_distance_L,
        "final_distance_L" => final_distance_L,
        "mean_distance_L" => reward_metrics.mean_distance_L,
        "observed_distance_integral_L" => reward_metrics.observed_distance_integral_L,
        "terminal_hold_integral_L" => reward_metrics.terminal_hold_integral_L,
        "distance_integral_L" => reward_metrics.distance_integral_L,
        "distance_integral_score" => reward_metrics.distance_integral_score,
        "weighted_distance_integral_score" => weighted_distance_integral_score,
        "final_distance_score" => final_distance_score,
        "distance_integral_weight" => distance_integral_weight,
        "terminal_reward_distance" => terminal_reward_distance,
        "progress" => progress,
        "min_progress" => min_progress,
        "distance_score" => distance_score,
        "time_cost" => time_cost,
        "effort_cost" => effort_cost,
        "success_score" => success_score,
        "unstable_penalty" => unstable_penalty,
        "command_energy" => effort.command_energy,
        "command_energy_mean" => effort.command_energy_mean,
        "power_proxy" => effort.power_proxy,
        "power_proxy_mean" => effort.power_proxy_mean,
        "unstable_failure" => unstable_failure,
        "final_heading" => headings[end],
        "final_joint_state" => collect(joint_rows[end]),
        "joint_angle_limit_deg" => Float64(phi_limit / TARGET_DEG),
        "phi_dot_limit_deg" => Float64(phi_dot_limit / TARGET_DEG),
        "phi_ddot_limit_deg" => Float64(phi_ddot_limit / TARGET_DEG),
        "observation_history_length" => observation_history_length,
        "max_abs_incremental_joint_angles_deg" => [
            Float64(max_abs_phi1 / TARGET_DEG),
            Float64(max_abs_phi2 / TARGET_DEG),
        ],
        "max_abs_body_frame_tail_tangent_deg" => Float64(max_abs_tail_tangent / TARGET_DEG),
        "max_abs_phi_dot_deg" => [
            Float64(max_abs_phi_dot1 / TARGET_DEG),
            Float64(max_abs_phi_dot2 / TARGET_DEG),
        ],
        "max_abs_phi_ddot_deg" => [
            Float64(max_abs_phi_ddot1 / TARGET_DEG),
            Float64(max_abs_phi_ddot2 / TARGET_DEG),
        ],
        "locked_dof_audit" => Dict(
            "max_force_z" => max_force_z,
            "max_force_xy" => max_force_xy,
            "force_z_ratio_max" => force_z_ratio_max,
            "max_locked_moment_x" => max_locked_moment_x,
            "max_locked_moment_y" => max_locked_moment_y,
            "locked_moment_ratio_max" => locked_moment_ratio_max,
            "locked_moments_csv" => locked_moments_path,
        ),
        "mass" => Float64(mass),
        "inertia" => Float64(inertia),
        "body_volume" => Float64(volume),
        "added_mass_model" => String(added_mass.model),
        "added_mass_forward" => Float64(added_mass.forward),
        "added_mass_lateral" => Float64(added_mass.lateral),
        "added_inertia" => Float64(added_mass.inertia),
        "added_mass_forward_coefficient" => Float64(added_mass_forward_coefficient),
        "policy" => "candidate_target_policy.target_policy",
        "policy_params_source" => "candidate_target_policy",
        "policy_params" => DogfishShapePolicyTestbed.jsonable(policy_params),
        "wall_s" => wall_elapsed,
        "frames_dir" => render_frames ? frames_dir : nothing,
        "video" => video_path,
        "vtk_enabled" => vtk_stream !== nothing,
        "vtk_collection" => vtk_collection,
        "dynamics_force_limit" => dynamics_force_limit,
        "dynamics_speed_limit" => dynamics_speed_limit,
        "trajectory" => trajectory_path,
        "morphology_parameters" => DogfishShapePolicyTestbed.jsonable(morphology_params),
    )
    summary_path = joinpath(output_root, "summary.json")
    open(summary_path, "w") do io
        JSON.print(io, DogfishShapePolicyTestbed.jsonable(summary), 2)
        println(io)
    end

    println("status=$(summary["status"])")
    println("termination=$termination")
    println("success=$success")
    println("score=$score")
    println("steps=$steps")
    println("frames=$frame_index")
    println("backend=$(resolved_backend.name)")
    println("horizon=$(rollout_horizon)")
    println("initial_distance_L=$(initial_distance / L)")
    println("final_distance_L=$(final_distance / L)")
    println("min_distance_L=$(min_distance / L)")
    println("force_z_ratio_max=$(force_z_ratio_max)")
    println("locked_moment_ratio_max=$(locked_moment_ratio_max)")
    println("target=$(Tuple(Float64.(target)))")
    println("final_head=$(heads[end])")
    println("summary=$summary_path")
    println("trajectory=$trajectory_path")
    println("video=$video_path")
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
