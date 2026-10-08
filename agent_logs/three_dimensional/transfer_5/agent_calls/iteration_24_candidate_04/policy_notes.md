# Split course/phase carrier-observer candidate

## Evidence read before editing

- The assigned-parent guidance, all four sampled solver artifacts, and the
  inherited optimizer result were read before selecting the candidate. Every
  compared rollout used direct uniform still water at `U_infinity=(0,0,0)`,
  no cylinders and no prewarm, remained finite, and terminated in capture.
- The four sampled examples are exact replications of v33: policy, trajectory,
  and combined-keyframe SHA-256 hashes match. They therefore provide one
  reproducible baseline, not four independent mechanisms. V33 captures at
  `23.8425T`, with score `-0.535091`, scoring mean/final distance
  `2.433543/0.746165L`, and inside-`3L` mean/peak absolute yaw
  `1.6800/3.1848 rad/T`.
- I inspected the sampled v33 and assigned-parent v34 combined sheets from
  release through capture in both views. Their top-down rows start in empty
  water, develop a strong spatially ordered alternating red/blue vortex
  street, and retain that street along the target-directed arc. Their oblique
  rows likewise develop compact three-dimensional Lambda2 structures behind
  the translating fish and preserve them through the terminal bend. Both fish
  are self-propelled rather than advected; neither sheet shows wake breakup,
  collision, boundary exit, or instability. The controller difference is too
  small for the sheets to distinguish, so the trajectory/load histories decide
  the comparison.
- Assigned-parent v34 adds `0.17*(phi_dot[1]+phi_dot[2])` to v33's anterior-only
  instantaneous yaw observer. It preserves capture and improves inside-`3L`
  mean/peak yaw from `1.6800/3.1848` to `1.5977/3.0499 rad/T` and mean
  target-cross-track speed from `0.2281` to `0.2163U`. However, capture is
  delayed by `0.0275T`, score regresses to `-0.536789`, scoring mean/final
  distance worsen to `2.434939/0.747952L`, and peak absolute moment rises from
  `0.013730` to `0.013876`. This is a regulation-for-progress trade, not a
  propulsion or stability failure.
- On the completed v33 trace, the distributed term changes the inferred
  residual-yaw sign in `37.4%` of samples inside `3L` and reduces its magnitude
  in `82.1%`. In v34 the same figures are `47.8%` and `81.1%`. The existing
  implementation uses that one altered residual both to scale the continuous
  target-course bend and to select the beat-side anterior correction. The
  evidence therefore does not support either discarding the distributed cue or
  letting it weaken both feedback roles together.

## Policy hypothesis

Preserve v33's target geometry, response-released C-bend, posterior traveling
wave, cadence, command projection, and continuous terminal course correction.
Add the v34 distributed joint-rate coordinate only to a separate fast
carrier-phase channel that selects and scales the phase-gated anterior
counter-curvature. Keep the course-brake response on v33's anterior-only yaw
channel. This is an observer-role separation rather than a new gain, extra
steering authority, posterior waveform edit, or scalar retune.

The falsifiable expectation is that the slow course channel restores
v33-scale distance progress while the distributed phase channel retains some
of v34's lower terminal yaw/cross-track motion. Reject the mechanism if capture
is lost or delayed toward v34, mean/final distance fails to hold v33 scale, the
coherent alternating wake degrades, terminal yaw/cross-track speed and moment
do not jointly hold or improve, or joint/command-limit exposure grows.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and adaptive wake-disturbance rejection
source_mechanism: separate slow persistent route feedback from fast alternating carrier or disturbance feedback before applying bounded corrections
transferable_invariant: preserve target-derived mean curvature and the posterior traveling-wave carrier while a distinct joint-state phase observation governs only the smallest beat-synchronous residual
nontransferable_details: published CPG gains, dimensional cadence, species-specific envelopes, hardware duty ratios, exact vortex phase, full-body waveforms, and task-specific routes
policy_translation: use normalized body-frame target geometry and v33's anterior-only yaw response for continuous course curvature; use the observed two-joint tangent rate only in the phase channel driving bounded anterior half-cycle counter-curvature
falsification: reject if v33-scale capture and distance progress are not retained together with held or improved terminal yaw, target-cross-track motion, moment, wake coherence, and actuator-envelope behavior

## Validation boundary

- The guidance-materiality check passes after removing the duplicate rendered
  marker for the same assigned optimizer parent from `README.md`.
- The solver boundary check passes, and exactly one nonempty
  `candidate_target_policy.jl` exists under `solver/`.
- A deterministic schema audit finds all `69` direct `params.FIELD` references
  among the `71` fields returned by `target_policy_params()`, with no missing
  declaration; only metadata fields `version` and `control_period` are
  unreferenced. Static guards find no executable clock, step, randomness, file
  I/O, cylinder-coordinate, mutable-global, target-identity, or memorized-route
  access.
- The configured `check-runner` was invoked but its pinned `gpt-5.4-mini` model
  is unsupported on this account. The Julia smoke command also cannot start
  because no Julia executable exists in the environment. No formal CFD was
  run; the candidate remains an unevaluated hypothesis for the post-worker
  evaluator.
