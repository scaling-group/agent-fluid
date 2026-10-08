# Reproduced intercept-supported terminal posture candidate

## Evidence and visual diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen Phase-2 contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite moving-window dynamics, and `capture`
  termination. They reproduce the same `3579`-step trajectory, combined
  two-view keyframe sheet, capture at `19.684490 T`, score `-0.261384287`,
  mean/final distance `2.151092787 L`/`0.748302400 L`, path length
  `12.951133 L`, and `243` moving-window shifts.
- Three samples are byte-identical
  `v40_intercept_supported_terminal_posture` policies. The fourth is the
  prefilled `v41_course_worsening_terminal_response`; its nominal same-sign
  course/yaw branch is exactly trajectory-identical to `v40`. Inherited
  reconstruction explains the dormancy: its added support peaks near `0.240`,
  below the existing `0.82` allocation floor selected by `max`. This is no
  evidence for its sign interpretation or for retuning its thresholds.
- The assigned parent's completed
  `v43_signed_course_yaw_posture_handoff` evaluates the corrected opposite-sign
  response as an independently active additive allocation. It retains the
  same capture step, path topology, saturation counts (`229/302` below-`4 L`
  commands above `30 rad/T^2`), and terminal lateral-force/yaw-moment maxima
  (about `0.02753/0.01567`), but regresses score to `-0.261390567`, mean
  distance to `2.151097816 L`, final distance to `0.748308659 L`, and path
  length to `12.951134 L`. The differences are small but deterministic and
  supply no positive control or load result.
- I inspected the shared sampled `v40`/`v41` combined sheet and the assigned
  parent's `v43` sheet from release to capture. In the top-down row, the fish
  visibly self-propels from quiescent water on a compact target-directed arc
  and sheds a coherent alternating posterior wake. The oblique row retains
  finite localized Lambda2 structures through capture. There is no passive
  advection, collision precursor, boundary exit, out-of-plane motion, wake
  collapse, or volume-filling instability. `v43` is visually
  indistinguishable at sheet resolution, consistent with a small terminal
  response rather than a new useful trajectory. No current sampled rollout
  has a failed termination; the active but slightly worse assigned-parent
  result is the most informative available contrast.
- Prior inherited logs already reject adding or retaining carrier according to
  outward joint response, coupled posture-energy direction, and startup or
  posterior-lag changes. The phase-lag governor's delayed looping capture is
  especially strong evidence that the established traveling-bend coordination
  is route-defining rather than a saturation knob. The new assigned-parent
  evaluation now also closes the signed course/yaw terminal-allocation locus:
  same-sign selection is dormant, while opposite-sign selection is active but
  worse.

## Candidate hypothesis

Use the independently reproduced `v40_intercept_supported_terminal_posture`
exactly as the single candidate. Relative to the prefilled sampled `v41`,
remove only the dormant same-sign course/yaw selector. Relative to the assigned
parent, do not adopt the evaluated opposite-sign additive handoff. Preserve
the state-feedback oscillator, fixed posterior lag, target-angle redirect,
geometry/course-agreed outer allocator, normalized center-intercept corridor,
closure preview, mean-bend equilibrium, flat terminal posture handoff,
carrier floor, and command limit.

This is evidence-backed mechanism selection, not scalar-only gain tuning. The
expected outcome is reproduction of the compact self-propelled path, coherent
two-view wake, capture near `19.684490 T`, score near `-0.261384287`, and no
joint-angle stop dwell. Falsify this selection on material non-reproduction,
slower or lost capture, worse distance integral or final distance, changed
outer topology, renewed joint-stop dwell, material load growth, instability,
or degradation of either wake view. The new CFD rollout occurs only after
this worker exits and is not claimed as evidence here.

bookshelf_consulted: true
source_domain: classical traveling-wave swimming, closed-loop robotic-fish direction control, and continuous terminal approach-hold control
source_mechanism: preserve an established posterior-lagged propulsive bend and hand off continuously toward a bounded target-owned posture only when completed observation-supported evidence improves approach
transferable_invariant: when propulsion and steering share two joints, retain the evidenced traveling-wave relationship and keep any gait-to-posture transition small, continuous, and driven by normalized range, closure, and body-frame target geometry
nontransferable_details: published gains and frequencies, dimensional Strouhal targets, species-specific kinematics, full-body waveforms, exact beat or vortex phases, target coordinates, capture radius, and task-specific routes
policy_translation: retain the reproduced body-frame center-intercept-supported two-joint posture handoff and remove the dormant course/yaw selector; do not transfer the assigned parent's active signed-yaw allocation because its completed rollout regressed
falsification: reject on failed reproduction, delayed or lost capture, worse distance integral, changed compact route, joint-stop dwell, material load growth, instability, or degraded top-down or oblique wake coherence

## Non-CFD implementation audit

- The sole solver candidate is byte-identical to all three sampled evaluated
  `v40` policies: SHA-256
  `624f4cec48f1a4c8d2eada4f72269efd16c22d4785955a09cd208447208cd659`.
  This establishes candidate identity and provenance, not a new CFD result.
- The prescribed check-runner was invoked after the material edits, but its
  pinned `gpt-5.4-mini` model is unsupported on this ChatGPT account and it
  failed before executing a command. Its three configured commands were then
  run directly and separately. The material-guidance check initially exposed
  two identical assigned-parent markers in the rendered root `README.md`;
  removing only the duplicate repaired parent resolution. The guidance/notes
  check, lightweight exact two-output finite Julia contract, and solver
  boundary check all pass.
- A separate deterministic schema audit resolves all `88` direct
  `params.FIELD` references against the `89` fields returned by
  `target_policy_params()`; only the version label is intentionally unused.
  No formal CFD was run in this workspace.
