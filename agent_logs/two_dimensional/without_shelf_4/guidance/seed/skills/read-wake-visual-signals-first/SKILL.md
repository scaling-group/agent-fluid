---
name: read-wake-visual-signals-first
description: "Inspect multi-wake flow keyframes before changing the dogfish target policy."
---

Use this skill whenever sampled wake-policy examples contain
`logs/evaluate/agent_observation/wake_keyframes.jpg`.

1. Read `guidance/README.md` and the example's `wake_observation.md` first so
   the image is anchored to the score, termination, trajectory, and force/flow
   diagnostics.
2. Inspect `shared_prewarm_keyframes.jpg` with the image tool when it is
   present. Treat it as common initial-condition evidence: held fish, cylinder
   layout, and developed vortex streets are identical for every candidate in
   this environment.
3. Inspect `wake_keyframes.jpg` with the image tool before editing the policy.
   Read the sheet from release to termination and compare at least the best
   finite example with the most informative failure example.
4. Diagnose visible behavior in control terms: whether the fish is advected or
   self-propelled, whether it enters the useful wake region, whether lateral
   oscillation is productive or wasteful, whether it turns toward the target,
   and what immediately precedes collision, domain exit, or numerical
   instability.
5. Cross-check every visual claim against `wake_metrics.csv` and
   `wake_diagnostics.json`. A visually dramatic vortex is not evidence of
   improvement unless distance progress and stability agree.
6. Use the compact keyframe sheets as the normal multimodal input. MP4 and VTK
   paths are archival evidence for human audit; do not load full VTK fields
   into the agent context.
7. Record the visual diagnosis and the corresponding policy hypothesis in
   `logs/optimize/wake_policy_notes.md` before editing.
8. Before finishing, distill the reusable part of the prior evidence into one
   new or materially revised bullet in `guidance/control_experience.md`. If the
   evidence shows no improvement, write a concrete negative lesson with the
   tested mechanism, observed result, and future avoid/test implication.
