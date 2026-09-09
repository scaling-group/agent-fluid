# Production entry point for the final 16L × 16L × 2L, L32 projected
# multiwake target episode.  All physics live in the tested rollout engine;
# this wrapper selects the candidate-policy/EvE-safe behavior.

ENV["DOGFISH3D_CONTROL_MODE"] = get(ENV, "DOGFISH3D_CONTROL_MODE", "candidate_policy")
ENV["DOGFISH3D_ALLOW_SCIENTIFIC_FAILURE"] = get(
    ENV,
    "DOGFISH3D_ALLOW_SCIENTIFIC_FAILURE",
    "true",
)
ENV["DOGFISH3D_ROLLOUT_MIDPLANE"] = get(ENV, "DOGFISH3D_ROLLOUT_MIDPLANE", "true")
ENV["DOGFISH3D_ROLLOUT_MIDPLANE_FRAMES"] = get(
    ENV,
    "DOGFISH3D_ROLLOUT_MIDPLANE_FRAMES",
    "21",
)
ENV["DOGFISH3D_ROLLOUT_VTK"] = get(ENV, "DOGFISH3D_ROLLOUT_VTK", "false")

include(joinpath(@__DIR__, "projected_multiwake_policy_smoke3d.jl"))
