# Evidence-selected terminal release of auxiliary yaw correction

## Visual and quantitative diagnosis recorded before the policy edit

- All four current solver examples satisfy the direct-uniform still-water
  contract: `U_infinity=(0,0,0)`, no cylinders, no prewarm, finite dynamics,
  and `capture` after `2,919` steps at `16.054482T`. Three examples
  (`solver_0b4f3f55c611`, `solver_13f39699efc8`, and
  `solver_d9f2302868e3`) are exact policy and wake-sheet repetitions of the
  prefill: score `-0.048654057`, held distance integral `1.931257L`, and
  crossing distance `0.747530L`. They establish repeatability, not three
  independent controller mechanisms.
- I inspected both rows of the combined sheets for the best finite example
  `solver_10780c7bba63`, the prefill, and the inherited approach-support
  regression `solver_b2d799c7da39`. From a clean release, the top-down rows
  show a traveling posterior bend, self-translation toward the target, and a
  spatially trailing alternating red/blue wake established by about `4T` and
  retained through capture. The oblique rows show compact three-dimensional
  Lambda2 structures shed behind the posterior body without visible breakup,
  collision, boundary exit, or locked-axis motion. The sheets are visually
  nearly indistinguishable at their coarse keyframe times; the useful and
  adverse differences are terminal closed-loop geometry, not new wake
  topology or passive advection.
- No current or inherited sampled sheet has a failure termination. The most
  informative available negative visual comparison is therefore the
  capture-class approach-support policy `solver_b2d799c7da39`, which retains
  the same coherent two-view wake but regresses to score `-0.048763231` and
  crossing distance `0.747637L`. The inherited broad proximity/closing taper
  `solver_e64db192c75a` is a stronger numerical negative at `-0.051096956`,
  `1.933230L` held distance integral, and `0.749879L` crossing. These results
  argue against using proximity alone or a target-bearing support ratio to
  decide that the auxiliary yaw correction is obsolete.
- `solver_10780c7bba63` makes one different control-role decision: inside the
  already safe closing capture corridor, target-signed measured yaw releases
  only the supplemental carrier-residual yaw curvature. Relative to the three
  exact prefill repetitions, it preserves the same `16.054482T` capture,
  `2,919` steps, `239` window shifts, and coherent wake while improving held
  distance integral from `1.931257L` to `1.930773L`, crossing from
  `0.747530L` to `0.746955L`, and score from `-0.048654057` to
  `-0.048054833`. Its observed pre-capture integral is effectively unchanged
  (`1.30373807L` versus `1.30373861L`), which localizes the benefit to the
  terminal crossing/hold geometry rather than cruise propulsion.

## Single candidate hypothesis

Adopt the evaluated `solver_10780c7bba63` mechanism as the one candidate.
Preserve the state-feedback oscillator, carrier-phase residual redirect
selector, raw target-versus-course direction, one-sided opposing-wave relief,
mean-first posterior allocation, response-subordinate approach settling,
intercept-conditioned anterior damping release, exact speed-boundary
projection, and far/middle carrier-residual yaw-opposition correction. Add a
bounded response veto only to that auxiliary yaw correction: when normalized
body-frame target and velocity establish the closing capture corridor and
measured yaw is already signed toward the requested redirect, taper the extra
posterior curvature continuously. The proven base mean steering and posterior
wave shaping remain unchanged.

The closed-loop sample predicts the same route, wake, and arrival with a
slightly better terminal crossing. Falsify reuse if evaluation loses capture,
changes a pre-corridor milestone, weakens the alternating two-view wake,
increases limiting/load without a crossing benefit, or fails to reproduce the
sampled terminal improvement. This worker makes no same-worker CFD claim; the
new evaluation occurs after exit.

bookshelf_consulted: true
source_domain: biological burst redirects and sensor-modulated robotic-fish CPG control
source_mechanism: preserve rhythmic propulsion and bounded redirect authority, then release only an auxiliary correction after measured target-compatible response appears
transferable_invariant: a persistent task error may authorize corrective action, but a safe closing course plus target-signed measured response can veto the extra response correction without removing the carrier or base steering
nontransferable_details: published gains, dimensional frequencies, species-specific C-start shapes, full-body kinematics, exact wake phase, source-task capture radii, and task-specific routes
policy_translation: smoothstep measured heading rate normalized by carrier frequency in the raw redirect direction, combine it with the existing normalized body-frame closing-corridor gate, and taper only carrier-residual posterior yaw curvature
falsification: reject if the veto acts outside a reliable closing corridor, breaks lateral reflection equivariance, changes base redirect or posterior-wave semantics, delays capture or earlier milestones, degrades the coherent wake, or fails to improve terminal distance without adverse loads

## Non-CFD verification after the policy edit

- The final candidate SHA-256 is
  `505e677d9c18f859e3dabe4d47acc711b910b7d6fcfad8f59fa6e58511260b0f`,
  byte-identical to evaluated `solver_10780c7bba63`. This establishes exact
  evidence-selected reuse, not a same-worker CFD result.
- The required dedicated check-runner was invoked, but its pinned
  `gpt-5.4-mini` model is unavailable for this account. Its three prescribed
  checks were then run directly and separately: the material guidance check,
  lightweight Julia policy contract, and solver editable-boundary check all
  pass. No CFD was run.
- Static schema inspection finds exactly one non-empty
  `candidate_target_policy.jl`; all `42` direct `params.FIELD` references are
  among the `42` fields returned by `target_policy_params()`.
