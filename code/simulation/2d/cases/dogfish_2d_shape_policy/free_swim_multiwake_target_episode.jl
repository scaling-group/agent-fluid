case_dir = @__DIR__

include(joinpath(case_dir, "free_swim_wake_episode.jl"))

function multiwake_target_main()
    return wake_main(
        config_env_names=("DOGFISH_MULTIWAKE_TARGET_CONFIG", "DOGFISH_RUN_CONFIG"),
        config_sections=("free_swim", "free_swim_multiwake_target_episode"),
        output_env_name="DOGFISH_MULTIWAKE_TARGET_OUTPUT_ROOT",
        default_output_subdir="free_swim_multiwake_target_episode",
        multiwake_target=true,
    )
end

if abspath(PROGRAM_FILE) == @__FILE__
    multiwake_target_main()
end
