# Posterior half-cycle counter-tangent candidate

## Visual and quantitative diagnosis before editing

- All four sampled rollouts satisfy the frozen experiment contract: direct
  uniform `U_infinity=(0,0,0)`, no cylinders or prewarm, stable dynamics, and
  capture. Their combined sheets show target-directed self-propulsion and a
  coherent alternating top-down vortex street from release to capture; the
  oblique row confirms compact three-dimensional Lambda2 structures rather
  than passive advection. The v24, v25, and v26 terminal-control differences
  are below keyframe resolution and do not change the useful trajectory class.
- V24 is the progress baseline: capture at `23.8315T`, scoring mean distance
  `2.434073L`, final distance `0.746924L`, and score `-0.535794`. V25's
  hard yaw/course consensus reaches `23.8590T` with mean distance `2.434115L`;
  v26's yaw-selected static damping reaches `23.8535T` with mean distance
  `2.434214L`. Their inside-`3L` mean absolute yaw remains effectively v24's
  `1.684 rad/T` (`1.683` and `1.687 rad/T` respectively), so more terminal
  cue arbitration is not the missing mechanism.
- The inherited v28 posterior phase-lag damper is the informative negative
  result. Its wake and capture topology remain coherent, but capture mean and
  final distance regress to `2.435327L` and `0.748560L`; inside-`3L` yaw only
  changes from `1.684` to `1.678 rad/T`. Thus multiplying joint-velocity phase
  into posterior lag perturbs the useful carrier without buying material yaw
  cleanup. The inherited half-cycle-only course curvature lowered inside-`3L`
  yaw/cross-track speed to `1.616 rad/T`/`0.213U`, but delayed capture to
  `23.9085T`, showing that stroke selectivity can affect yaw while removing
  most course authority costs progress.
- In the evaluated v24 terminal trace, tail tangent `phi1+phi2` and the next
  observed yaw acceleration have correlation `0.7585`. This is not a causal
  model, but it supplies an evidence-calibrated sign hypothesis: a small
  posterior counter-tangent applied only when the current tail side supports
  excess yaw should be more selective than changing phase lag or gating away
  the existing course bend.

## Policy hypothesis

Use evaluated v24 as the sole base. Preserve its traveling-wave carrier,
same-sign redirect, response release, continuous target-course terminal bend,
and smooth acceleration projection. Add one bounded posterior wave-shape
residual inside the existing `3L` terminal gate: carrier-rejected excess yaw
sets a counter direction, while normalized observed tail tangent identifies
the yaw-supporting half-cycle. Shift only that half-cycle's posterior tangent
toward the counter direction; leave the other half-cycle and all anterior
motion unchanged.

This should retain v24's approach speed and coherent alternating wake while
reducing terminal yaw, cross-track motion, and load more efficiently than the
v28 lag modulation or the authority-removing half-cycle course gate. Falsify
the mechanism if capture or wake coherence is lost; if capture exceeds
`23.9T` or mean distance exceeds `2.435L` without material yaw/course cleanup;
if terminal yaw, cross-track speed, force, moment, joint-speed exposure, or
command exposure worsens; or if the tangent/yaw-acceleration sign relationship
does not survive the changed closed-loop trajectory. This worker does not
claim the unavailable new CFD result.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: robotic-fish CPG turning and Lighthill-style posterior reactive control
source_mechanism: preserve a traveling propulsive wave while creating a turn or yaw reaction with bounded posterior half-cycle amplitude asymmetry
transferable_invariant: separate slow target-course curvature from fast yaw rejection, and reshape only the observed posterior stroke that supports the unwanted yaw rather than weakening the full carrier
nontransferable_details: published gains, dimensional cadence, robot linkage geometry, full-body envelopes, species-specific tail motion, exact vortex phase, and prescribed routes
policy_translation: normalized body-frame target and velocity observations retain the v24 course bend; carrier-rejected yaw supplies the counter direction and normalized two-joint tail tangent supplies the state-derived half-cycle for a bounded posterior target residual
falsification: reject if capture or the alternating three-dimensional wake is lost, or if arrival, distance integral, terminal yaw/course, loads, joint-speed exposure, and command exposure do not jointly improve on the v24, half-cycle-course, and v28 evidence
```

## Non-CFD contract checks

- The configured check-runner was invoked, but its fixed model is unavailable
  in this account. Its three commands were therefore run directly: the
  material-guidance check, lightweight Julia policy contract, and solver
  boundary check all pass. The guidance check initially exposed and then
  passed after removal of a duplicate marker for the same assigned parent in
  the rendered workspace `README.md`.
- Direct `params.FIELD` references are a subset of the fields returned by
  `target_policy_params()`. A `65,610`-state grid spanning distance, target
  side, velocity, yaw, joint angle, and joint velocity returned finite commands
  within the `31.416 rad/T^2` limit. The new residual was both active and
  inactive across the grid, its tangent sign always matched the yaw-counter
  direction when active, and non-finite input probes returned finite zeros.
- Static comparison with evaluated v24 is bit-exact at and outside the `3L`
  gate. Inside it, the maximum sampled command change was `6.715 rad/T^2` and
  only the posterior command changed through the new counter-tangent. No CFD
  rollout was run.
