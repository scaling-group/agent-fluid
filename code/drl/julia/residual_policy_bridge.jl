const PPO_ACTION_MODE = lowercase(get(ENV, "PPO_ACTION_MODE", "residual"))
PPO_ACTION_MODE in ("residual", "absolute") || error(
    "PPO_ACTION_MODE must be residual or absolute, got $PPO_ACTION_MODE",
)
const PPO_EMIT_SEED_ACTION = get(ENV, "PPO_EMIT_SEED_ACTION", "0") == "1"
const PPO_NEEDS_SEED = PPO_ACTION_MODE == "residual" || PPO_EMIT_SEED_ACTION

module PPOSeedPolicy

if lowercase(get(ENV, "PPO_ACTION_MODE", "residual")) == "residual" ||
        get(ENV, "PPO_EMIT_SEED_ACTION", "0") == "1"
    const SEED_POLICY_PATH = get(
        ENV,
        "PPO_SEED_POLICY_PATH",
        normpath(joinpath(
            @__DIR__,
            "..",
            "..",
            "simulation",
            "2d",
            "cases",
            "dogfish_2d_shape_policy",
            "candidate_target_policy.jl",
        )),
    )

    include(abspath(SEED_POLICY_PATH))
end

end

const PPO_PROTOCOL_PREFIX = "PPO_JSON\t"
const PPO_HISTORY_LENGTH = parse(
    Int,
    get(ENV, "PPO_OBSERVATION_HISTORY_LENGTH", "8"),
)
PPO_HISTORY_LENGTH > 0 || error(
    "PPO_OBSERVATION_HISTORY_LENGTH must be a positive integer",
)
const PPO_MAX_CYLINDERS = 4
const PPO_OBSERVATION_BASE_DIM = 108
const PPO_OBSERVATION_HISTORY_STEP_DIM = 6
const PPO_OBSERVATION_DIM = PPO_OBSERVATION_BASE_DIM +
                            PPO_OBSERVATION_HISTORY_STEP_DIM * PPO_HISTORY_LENGTH

mutable struct PPOBridgeState
    episode::Int
    previous_distance_L::Union{Nothing, Float64}
    cumulative_dense_reward::Float64
    cumulative_time::Float64
    action_count::Int
end

const PPO_BRIDGE_STATE = PPOBridgeState(0, nothing, 0.0, 0.0, 0)

function ppo_protocol_emit(payload)
    print(stdout, PPO_PROTOCOL_PREFIX)
    JSON.print(stdout, payload)
    println(stdout)
    flush(stdout)
    return nothing
end

function ppo_read_message()
    while !eof(stdin)
        line = strip(readline(stdin))
        isempty(line) && continue
        return JSON.parse(line)
    end
    error("PPO controller closed its input stream")
end

function ppo_bridge_reset!(episode::Integer)
    PPO_BRIDGE_STATE.episode = Int(episode)
    PPO_BRIDGE_STATE.previous_distance_L = nothing
    PPO_BRIDGE_STATE.cumulative_dense_reward = 0.0
    PPO_BRIDGE_STATE.cumulative_time = 0.0
    PPO_BRIDGE_STATE.action_count = 0
    return nothing
end

function ppo_float(value)
    result = Float64(value)
    isfinite(result) || error("PPO observation contains a non-finite value: $value")
    return result
end

function ppo_push_scalar!(names, values, name::AbstractString, value)
    push!(names, String(name))
    push!(values, ppo_float(value))
    return nothing
end

function ppo_push_pair!(names, values, prefix::AbstractString, value)
    ppo_push_scalar!(names, values, "$(prefix)_x", value[1])
    ppo_push_scalar!(names, values, "$(prefix)_y", value[2])
    return nothing
end

function ppo_push_angle!(names, values, prefix::AbstractString, value)
    angle = ppo_float(value)
    ppo_push_scalar!(names, values, "$(prefix)_sin", sin(angle))
    ppo_push_scalar!(names, values, "$(prefix)_cos", cos(angle))
    return nothing
end

function ppo_fixed_sequence(value, count::Int; fill_value=0.0)
    sequence = collect(value)
    if length(sequence) >= count
        return sequence[(end - count + 1):end]
    end
    return vcat(fill(fill_value, count - length(sequence)), sequence)
end

function ppo_observation_vector(state)
    names = String[]
    values = Float64[]

    ppo_push_pair!(names, values, "target_body_L", state.target_body_L)
    ppo_push_scalar!(names, values, "distance_L", state.distance_L)
    ppo_push_angle!(names, values, "bearing", state.bearing)
    ppo_push_pair!(names, values, "target_body_delta_L", state.target_body_delta_L)
    ppo_push_pair!(names, values, "target_body_rate_L", state.target_body_rate_L)
    ppo_push_scalar!(names, values, "distance_rate_L", state.distance_rate_L)
    ppo_push_scalar!(names, values, "closing_speed_L", state.closing_speed_L)
    ppo_push_scalar!(names, values, "bearing_rate", state.bearing_rate)
    ppo_push_pair!(names, values, "target_body_window_delta_L", state.target_body_window_delta_L)
    ppo_push_pair!(names, values, "target_body_window_rate_L", state.target_body_window_rate_L)
    ppo_push_scalar!(names, values, "distance_window_delta_L", state.distance_window_delta_L)
    ppo_push_scalar!(names, values, "window_closing_speed_L", state.window_closing_speed_L)
    ppo_push_angle!(names, values, "bearing_window_delta", state.bearing_window_delta)
    ppo_push_scalar!(names, values, "bearing_window_rate", state.bearing_window_rate)
    ppo_push_pair!(names, values, "velocity_body_U", state.velocity_body_U)
    ppo_push_pair!(names, values, "force_body_L", state.force_body_L)
    ppo_push_scalar!(names, values, "moment_z_L2", state.moment_z_L2)
    ppo_push_scalar!(names, values, "heading_rate", state.heading_rate)

    phi_limit = deg2rad(parse(Float64, get(ENV, "PPO_PHI_LIMIT_DEG", "45")))
    phi_dot_limit = deg2rad(parse(Float64, get(ENV, "PPO_PHI_DOT_LIMIT_DEG", "260")))
    phi_ddot_limit = deg2rad(parse(Float64, get(ENV, "PPO_PHI_DDOT_LIMIT_DEG", "1800")))
    ppo_push_pair!(names, values, "phi_normalized", state.phi ./ phi_limit)
    ppo_push_pair!(names, values, "phi_dot_normalized", state.phi_dot ./ phi_dot_limit)
    ppo_push_pair!(names, values, "previous_action_normalized", state.previous_action ./ phi_ddot_limit)

    target_history = ppo_fixed_sequence(
        state.target_body_history_L,
        PPO_HISTORY_LENGTH;
        fill_value=(0.0, 0.0),
    )
    for (index, value) in enumerate(target_history)
        ppo_push_pair!(names, values, "target_body_history_L_$(index)", value)
    end
    distance_history = ppo_fixed_sequence(state.distance_history_L, PPO_HISTORY_LENGTH)
    for (index, value) in enumerate(distance_history)
        ppo_push_scalar!(names, values, "distance_history_L_$(index)", value)
    end
    bearing_history = ppo_fixed_sequence(state.bearing_history, PPO_HISTORY_LENGTH)
    for (index, value) in enumerate(bearing_history)
        ppo_push_angle!(names, values, "bearing_history_$(index)", value)
    end
    history_offsets = ppo_fixed_sequence(state.history_time_offsets, PPO_HISTORY_LENGTH)
    for (index, value) in enumerate(history_offsets)
        ppo_push_scalar!(names, values, "history_time_offset_$(index)", value)
    end
    ppo_push_scalar!(names, values, "history_fraction", state.history_count / PPO_HISTORY_LENGTH)

    ppo_push_pair!(names, values, "local_flow_velocity_body_U", state.local_flow_velocity_body_U)
    ppo_push_pair!(names, values, "relative_flow_velocity_body_U", state.relative_flow_velocity_body_U)
    ppo_push_pair!(names, values, "inflow_velocity_body_U", state.inflow_velocity_body_U)
    ppo_push_scalar!(names, values, "local_vorticity", state.local_vorticity)
    ppo_push_scalar!(names, values, "local_vorticity_rate", state.local_vorticity_rate)
    ppo_push_scalar!(names, values, "local_vorticity_window_delta", state.local_vorticity_window_delta)
    ppo_push_scalar!(names, values, "local_vorticity_window_rate", state.local_vorticity_window_rate)
    ppo_push_scalar!(names, values, "wake_crossflow_velocity_U", state.wake_crossflow_velocity_U)
    ppo_push_scalar!(names, values, "wake_streamwise_velocity_U", state.wake_streamwise_velocity_U)
    ppo_push_scalar!(names, values, "wake_crossflow_velocity_rate", state.wake_crossflow_velocity_rate)
    ppo_push_scalar!(names, values, "wake_streamwise_velocity_rate", state.wake_streamwise_velocity_rate)
    ppo_push_scalar!(names, values, "wake_crossflow_window_delta", state.wake_crossflow_window_delta)
    ppo_push_scalar!(names, values, "wake_streamwise_window_delta", state.wake_streamwise_window_delta)
    ppo_push_scalar!(names, values, "wake_crossflow_window_rate", state.wake_crossflow_window_rate)
    ppo_push_scalar!(names, values, "wake_streamwise_window_rate", state.wake_streamwise_window_rate)
    ppo_push_scalar!(names, values, "force_y_rate_L", state.force_y_rate_L)
    ppo_push_scalar!(names, values, "moment_z_rate_L2", state.moment_z_rate_L2)
    ppo_push_scalar!(names, values, "force_y_window_delta_L", state.force_y_window_delta_L)
    ppo_push_scalar!(names, values, "moment_z_window_delta_L2", state.moment_z_window_delta_L2)
    ppo_push_scalar!(names, values, "force_y_window_rate_L", state.force_y_window_rate_L)
    ppo_push_scalar!(names, values, "moment_z_window_rate_L2", state.moment_z_window_rate_L2)

    probe_flow = ppo_fixed_sequence(state.wake_probe_flow_body_U, 4; fill_value=(0.0, 0.0))
    for (index, value) in enumerate(probe_flow)
        ppo_push_pair!(names, values, "wake_probe_flow_body_U_$(index)", value)
    end
    probe_vorticity = ppo_fixed_sequence(state.wake_probe_vorticity, 4)
    for (index, value) in enumerate(probe_vorticity)
        ppo_push_scalar!(names, values, "wake_probe_vorticity_$(index)", value)
    end

    ppo_push_pair!(names, values, "nearest_cylinder_body_L", state.cylinder_body)
    ppo_push_scalar!(names, values, "nearest_cylinder_distance_L", state.cylinder_distance_L)
    ppo_push_pair!(names, values, "nearest_wake_position_L", state.wake_position_L)
    ppo_push_scalar!(names, values, "nearest_cylinder_clearance_L", state.nearest_cylinder_clearance_L)
    cylinder_centers = collect(state.cylinder_centers_L)
    cylinder_radii = collect(state.cylinder_radii_L)
    for index in 1:PPO_MAX_CYLINDERS
        present = index <= length(cylinder_centers)
        center = present ? cylinder_centers[index] : (0.0, 0.0)
        radius = present ? cylinder_radii[index] : 0.0
        ppo_push_pair!(names, values, "cylinder_center_L_$(index)", center)
        ppo_push_scalar!(names, values, "cylinder_radius_L_$(index)", radius)
        ppo_push_scalar!(names, values, "cylinder_present_$(index)", present ? 1.0 : 0.0)
    end
    nearest_index = Int(state.nearest_cylinder_index)
    for index in 1:PPO_MAX_CYLINDERS
        ppo_push_scalar!(names, values, "nearest_cylinder_onehot_$(index)", index == nearest_index ? 1.0 : 0.0)
    end

    cylinder_probe_flow = ppo_fixed_sequence(
        state.cylinder_wake_probe_velocity_body_U,
        3;
        fill_value=(0.0, 0.0),
    )
    for (index, value) in enumerate(cylinder_probe_flow)
        ppo_push_pair!(names, values, "cylinder_wake_probe_velocity_body_U_$(index)", value)
    end
    cylinder_probe_vorticity = ppo_fixed_sequence(state.cylinder_wake_vorticity, 3)
    for (index, value) in enumerate(cylinder_probe_vorticity)
        ppo_push_scalar!(names, values, "cylinder_wake_vorticity_$(index)", value)
    end
    ppo_push_pair!(names, values, "station_flow_velocity_body_U", state.station_flow_velocity_body_U)
    ppo_push_scalar!(names, values, "station_vorticity", state.station_vorticity)

    length(values) == PPO_OBSERVATION_DIM || error(
        "PPO observation has $(length(values)) values, expected $PPO_OBSERVATION_DIM",
    )
    return names, values
end

function target_policy_params()
    seed_params = PPO_NEEDS_SEED ?
        PPOSeedPolicy.target_policy_params() :
        (control_period=parse(Float64, get(ENV, "PPO_CONTROL_PERIOD", "0.55")),)
    return merge(
        seed_params,
        (
            residual_acceleration_limit=deg2rad(parse(
                Float64,
                get(ENV, "PPO_PHI_DDOT_LIMIT_DEG", "1800"),
            )),
        ),
    )
end

function target_policy(state, params)
    seed_action = PPO_NEEDS_SEED ?
        PPOSeedPolicy.target_policy(state, params).phi_ddot : nothing
    names, observation = ppo_observation_vector(state)
    distance_L = ppo_float(state.distance_L)
    dt = max(0.0, ppo_float(state.history_dt))
    horizon = parse(Float64, get(ENV, "PPO_ROLLOUT_HORIZON", "300"))
    transition_reward = 0.0
    if PPO_BRIDGE_STATE.previous_distance_L !== nothing
        transition_reward = -0.5 *
            (PPO_BRIDGE_STATE.previous_distance_L + distance_L) *
            dt / max(horizon, eps(Float64))
        PPO_BRIDGE_STATE.cumulative_dense_reward += transition_reward
        PPO_BRIDGE_STATE.cumulative_time += dt
    end

    payload = Dict(
        "type" => "observation",
        "episode" => PPO_BRIDGE_STATE.episode,
        "observation" => observation,
        "reward" => transition_reward,
        "distance_L" => distance_L,
        "time" => PPO_BRIDGE_STATE.cumulative_time,
        "action_count" => PPO_BRIDGE_STATE.action_count,
    )
    if PPO_EMIT_SEED_ACTION
        acceleration_limit = Float64(params.residual_acceleration_limit)
        payload["seed_action_normalized"] = [
            clamp(Float64(seed_action[1]) / acceleration_limit, -1.0, 1.0),
            clamp(Float64(seed_action[2]) / acceleration_limit, -1.0, 1.0),
        ]
    end
    PPO_BRIDGE_STATE.action_count == 0 && (payload["observation_names"] = names)
    ppo_protocol_emit(payload)

    message = ppo_read_message()
    get(message, "type", "") == "action" || error(
        "PPO worker expected an action message, received $(get(message, "type", nothing))",
    )
    network_action = get(message, "action", nothing)
    network_action isa AbstractVector && length(network_action) == 2 || error(
        "PPO action must contain exactly two values",
    )
    action_1 = clamp(ppo_float(network_action[1]), -1.0, 1.0)
    action_2 = clamp(ppo_float(network_action[2]), -1.0, 1.0)
    acceleration_limit = Float64(params.residual_acceleration_limit)

    PPO_BRIDGE_STATE.previous_distance_L = distance_L
    PPO_BRIDGE_STATE.action_count += 1
    if PPO_ACTION_MODE == "residual"
        return (
            phi_ddot=(
                Float64(seed_action[1]) + action_1 * acceleration_limit,
                Float64(seed_action[2]) + action_2 * acceleration_limit,
            ),
        )
    end
    return (phi_ddot=(action_1 * acceleration_limit, action_2 * acceleration_limit),)
end

function ppo_bridge_finish!(summary::AbstractDict)
    raw_score = Float64(summary["score"])
    terminal_reward = raw_score - PPO_BRIDGE_STATE.cumulative_dense_reward
    ppo_protocol_emit(Dict(
        "type" => "terminal",
        "episode" => PPO_BRIDGE_STATE.episode,
        "reward" => terminal_reward,
        "raw_score" => raw_score,
        "shifted_score" => raw_score - 2.0,
        "distance_integral_score" => get(summary, "distance_integral_score", nothing),
        "termination" => get(summary, "termination", "unknown"),
        "target_reached" => get(summary, "target_reached", false),
        "release_elapsed" => get(summary, "release_elapsed", nothing),
        "steps" => get(summary, "steps", PPO_BRIDGE_STATE.action_count),
        "action_count" => PPO_BRIDGE_STATE.action_count,
        "cumulative_dense_reward" => PPO_BRIDGE_STATE.cumulative_dense_reward,
    ))
    return nothing
end

function ppo_bridge_fail!(message::AbstractString)
    raw_score = -100.0
    ppo_protocol_emit(Dict(
        "type" => "terminal",
        "episode" => PPO_BRIDGE_STATE.episode,
        "reward" => raw_score - PPO_BRIDGE_STATE.cumulative_dense_reward,
        "raw_score" => raw_score,
        "shifted_score" => raw_score - 2.0,
        "termination" => "bridge_error",
        "target_reached" => false,
        "action_count" => PPO_BRIDGE_STATE.action_count,
        "error" => String(message),
    ))
    return nothing
end
