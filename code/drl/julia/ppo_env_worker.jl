case_dir = @__DIR__

ENV["DOGFISH_TARGET_POLICY_PATH"] = get(
    ENV,
    "DOGFISH_TARGET_POLICY_PATH",
    joinpath(@__DIR__, "residual_policy_bridge.jl"),
)

include(joinpath(case_dir, "free_swim_wake_episode.jl"))

function worker_main()
    ppo_protocol_emit(Dict(
        "type" => "ready",
        "observation_dim" => PPO_OBSERVATION_DIM,
        "observation_history_length" => PPO_HISTORY_LENGTH,
        "worker_id" => get(ENV, "PPO_WORKER_ID", "0"),
        "cuda_visible_devices" => get(ENV, "CUDA_VISIBLE_DEVICES", ""),
        "action_mode" => PPO_ACTION_MODE,
        "seed_policy_loaded" => PPO_NEEDS_SEED,
        "seed_action_emitted" => PPO_EMIT_SEED_ACTION,
    ))

    while !eof(stdin)
        message = ppo_read_message()
        message_type = get(message, "type", "")
        message_type == "close" && break
        message_type == "reset" || error(
            "PPO environment worker expected reset or close, received $message_type",
        )

        episode = Int(get(message, "episode", 0))
        output_root = abspath(String(message["output_root"]))
        mkpath(output_root)
        ENV["DOGFISH_MULTIWAKE_TARGET_OUTPUT_ROOT"] = output_root
        ppo_bridge_reset!(episode)

        try
            wake_main(
                config_env_names=("DOGFISH_MULTIWAKE_TARGET_CONFIG", "DOGFISH_RUN_CONFIG"),
                config_sections=("free_swim", "free_swim_multiwake_target_episode"),
                output_env_name="DOGFISH_MULTIWAKE_TARGET_OUTPUT_ROOT",
                default_output_subdir="ppo_worker",
                multiwake_target=true,
            )
            summary_path = joinpath(output_root, "summary.json")
            isfile(summary_path) || error("wake episode did not produce $summary_path")
            ppo_bridge_finish!(JSON.parsefile(summary_path))
        catch error
            message = sprint(showerror, error, catch_backtrace())
            println(stderr, message)
            flush(stderr)
            ppo_bridge_fail!(message)
        end
    end
    return nothing
end

if abspath(PROGRAM_FILE) == @__FILE__
    worker_main()
end
