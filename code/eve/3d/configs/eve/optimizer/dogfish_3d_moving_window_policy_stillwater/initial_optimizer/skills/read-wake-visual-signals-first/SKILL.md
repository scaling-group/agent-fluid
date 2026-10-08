---
name: read-wake-visual-signals-first
description: "Inspect both 3D moving-window visual views before changing the dogfish target policy."
---

Use this skill whenever sampled wake-policy examples contain
`logs/evaluate/agent_observation/wake_keyframes.jpg`.

1. Read `guidance/README.md` and the example's `wake_observation.md` first so
   the image is anchored to the score, termination, trajectory, and force/flow
   diagnostics.
2. Confirm the evidence reports direct uniform still-water `U_infinity=0` initialization. A pre-warm
   image or snapshot is a contract failure in this experiment.
3. Inspect the combined `wake_keyframes.jpg`, including its top-down vorticity
   row and oblique 3D body/Lambda2 row, before editing the policy. Read the
   sheets from release to termination and compare at least the best
   finite example with the most informative failure example.
4. Diagnose visible behavior in control terms: whether the fish is advected or
   self-propelled, whether its wake is coherent, whether lateral
   oscillation is productive or wasteful, whether it turns toward the target,
   and what immediately precedes collision, domain exit, or numerical
   instability.
5. Cross-check every visual claim against `wake_metrics.csv` and
   `wake_diagnostics.json`. A visually dramatic vortex is not evidence of
   improvement unless distance progress and stability agree.
6. Use the compact combined sheet as the normal multimodal input. The two MP4s
   remain available for human audit; do not load full volume fields into the
   agent context.
7. Record the visual diagnosis and the corresponding policy hypothesis in
   `logs/optimize/wake_policy_notes.md` before editing.
8. Before finishing, distill the reusable part of the prior evidence into one
   new or materially revised bullet in `guidance/control_experience.md`. If the
   evidence shows no improvement, write a concrete negative lesson with the
   tested mechanism, observed result, and future avoid/test implication.
