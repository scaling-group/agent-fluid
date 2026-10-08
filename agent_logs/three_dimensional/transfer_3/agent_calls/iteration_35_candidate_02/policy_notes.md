# Reproduced intercept-supported terminal posture selection

## Evidence and visual diagnosis before candidate selection

- All four current solver samples satisfy the frozen Phase-2 contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders, no prewarm, finite moving-window dynamics, and `capture`
  termination. Their trajectory CSVs and combined keyframe sheets are
  byte-identical. Each captures at `19.684490 T` with score `-0.261384287`,
  mean/final distance `2.151092787 L`/`0.748302400 L`, and `243` moving-window
  shifts. Three use the byte-identical `v40` policy; the fourth carries a
  nominal course/yaw branch but realizes the same commands and trajectory, so
  it is a dormant intervention rather than independent positive evidence.
- I inspected the complete combined sheets for a reproduced `v40` rollout and
  the nominally different current sample, including the top-down mid-plane
  vorticity row and oblique body/Lambda2 row from release through capture. The
  fish self-propels from quiescent water on a compact target-directed arc and
  sheds a coherent alternating posterior wake. The oblique structures remain
  finite and localized. There is no passive advection, collision precursor,
  boundary exit, out-of-plane motion, wake collapse, or numerical instability.
- I also inspected the inherited active signed course/yaw handoff as the most
  informative available lower-quality visual comparison. Its combined sheet
  is visually indistinguishable at the sampled keyframes and it preserves the
  same capture step, but the completed CFD result regresses score, mean
  distance, and final distance to `-0.261390567`, `2.151097816 L`, and
  `0.748308659 L`. Inherited replay evidence places its command changes only
  in the final yaw-reversal interval. The absence of a new visible wake or
  trajectory family and the numerical regression identify an ineffective
  terminal allocation change, not a propulsion or stability problem.
- The assigned-parent logs already close the neighboring mechanisms. Adding
  or retaining carrier according to outward joint response and adding posture
  while coupled posture error decreases all regress relative to the flat
  `v40` handoff. An outer phase-lag governor produces a large loop and capture
  only at `46.145020 T`, while a small-angle startup mean-curvature branch
  delays capture to `23.375013 T` through stable mis-steering. These completed
  results rule out another terminal response selector, posterior-lag change,
  or startup bend merely because it is bounded and state-dependent.

## Candidate hypothesis

Retain `v40_intercept_supported_terminal_posture` exactly as the one solver
candidate. It preserves the evidenced state-feedback traveling bend, fixed
posterior lag, geometry/course-agreed outer residual allocation, center-course
intercept corridor, closure preview, and small flat terminal handoff toward
the existing damped two-joint mean bend. The current sample supplies four
exact trajectory reproductions, while every available independently active
neighboring mechanism is worse and the nominal alternative is dormant.

This is an evidence-backed negative selection, not a claim that an unevaluated
edit improved CFD. The expected next rollout is the same compact self-propelled
capture near `19.684490 T`, with coherent alternating top-down shedding,
localized finite oblique structures, and no joint-stop dwell. Falsify the
selection on material non-reproduction, slower or lost capture, worse distance
integral, a changed outer route, renewed joint-stop dwell, material load
growth, instability, or degradation of either visual row. The new evaluation
occurs only after this worker exits and is not evidence in these notes.

bookshelf_consulted: true
source_domain: classical traveling-wave swimming, closed-loop robotic-fish direction control, and continuous terminal approach-hold control
source_mechanism: preserve an established posterior-lagged traveling bend and transfer only a small target-supported share from rhythm to bounded posture near capture
transferable_invariant: when propulsion and steering share two joints, preserve an evidenced traveling-wave phase relationship and make any approach handoff continuous, normalized, target-relative, and contingent on observed range, closure, and intercept state
nontransferable_details: published gains and frequencies, dimensional Strouhal values, species-specific kinematics, full-body envelopes, exact beat or vortex phase, actuator models, target coordinates, capture radius, and task-specific routes
policy_translation: retain the reproduced body-frame v40 law; reject the evaluated terminal response, startup-curvature, and posterior-lag additions rather than using the shelf to justify a scalar retune
falsification: reject on failed reproduction, delayed or lost capture, worse distance integral, a loop or changed compact route, joint-stop dwell, material load growth, instability, or degraded top-down or oblique wake coherence

## Pre-evaluation identity audit

The retained candidate has SHA-256
`624f4cec48f1a4c8d2eada4f72269efd16c22d4785955a09cd208447208cd659`,
matching the three byte-identical current `v40` solver samples. The fourth
sample has a different source policy but the same trajectory and keyframes.
This establishes candidate identity and evidence provenance only; no formal
CFD is run in this workspace.

## Non-CFD validation

- The prescribed `.codex/agents/check-runner.toml` was invoked after both
  required evidence files were updated, but its pinned `gpt-5.4-mini` model is
  unsupported on this ChatGPT account and failed before executing a command.
  Its three configured checks were then run directly and separately.
- The material-guidance check passes, the lightweight Julia public-contract
  check returns exactly two finite accelerations, and the solver edit-boundary
  check passes. A separate deterministic schema audit resolves all `88` direct
  `params.FIELD` references against the `89` fields returned by
  `target_policy_params()`; only the version field is intentionally unused.
