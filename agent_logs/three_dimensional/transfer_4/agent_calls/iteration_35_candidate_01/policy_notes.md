# Course-consensus posterior duty-ratio candidate

## Visual and quantitative diagnosis before editing

- I read the workspace and guidance contracts, all four sampled policies,
  scores, observations, diagnostics, and trajectories, plus the assigned
  parent's completed step-31 through step-34 notes and evaluations. Every
  reviewed rollout is a finite capture from direct-uniform still water with
  `U_infinity=(0,0,0)`, no prewarm, no cylinders, and no boundary or numerical
  termination.
- I inspected the sampled v31 score leader, the sampled v26 mechanism
  regression, and the inherited v35 phase-energy regression in their combined
  keyframe sheets. In each sheet the top-down row shows target-directed
  self-propulsion and a coherent alternating wake, while the oblique row shows
  compact persistent three-dimensional posterior structures. None shows
  passive advection, reciprocal standing motion, wake breakup, or out-of-plane
  instability. The useful distinction is terminal allocation, not propulsion
  creation.
- Relative to the prefilled v20 policy, sampled v31 improves score from
  `-0.0640276` to `-0.0640004`, final course alignment from `0.1092` to
  `0.1297`, and final absolute yaw from `0.9840` to `0.8077 rad/T`, while
  retaining capture and the same wake class. Its tradeoff is a `0.0055T`
  later capture and slightly longer center path/head cross-track
  (`13.2149L/0.7327L` versus `13.2108L/0.7317L`). It is nevertheless the only
  sampled mechanism that improves the scalar objective and terminal direction
  together.
- The inherited follow-ups do not support stacking another terminal surface.
  Slip-synchronous phase reset improves final alignment/yaw to
  `0.1713/0.5535 rad/T`, but delays capture to `18.0180T`, lengthens the path
  to `13.2163L`, and regresses score to `-0.0645541`. Balanced slip-duty
  modulation scores `-0.0642123` and ends at only
  `0.1236/0.9654 rad/T`. The posterior phase-energy envelope scores
  `-0.0649629`, ends at `0.1101/0.9794 rad/T`, and leaves global
  acceleration-ceiling residence essentially unchanged from v31
  (`69.36/66.10%` versus `69.37/66.11%`). These are concrete evidence against
  another phase-reset, duty-sign/gain, or energy-envelope stack.

## Single policy hypothesis

Replace the prefilled v20 policy with the already evaluated v31
course-consensus posterior duty-ratio controller. Preserve its odd body-frame
route request, state-feedback anterior oscillator, posterior lag and emphasis,
raw-yaw-power approach envelope, conserved forward mean-bend allocation,
half-cycle steering, and reversal-preserving rate governor. Add only v31's
evaluated terminal mechanism: signed course error may qualify, but never add
to, the existing turn request; when the two agree during a moving misaligned
approach, observed summed joint rate redistributes a bounded posterior wave
factor around unity between half-cycles.

This is an evidence-backed exploitation candidate rather than a new gain
sweep. Expected evidence is reproduction of v31-class capture, score,
coherent two-view wake, and improved terminal alignment/yaw relative to v20.
Falsify the choice if evaluation does not reproduce capture and score near
`-0.064000`, if either wake view changes class, or if terminal alignment/yaw
falls back to the v20 class without a compensating improvement in arrival,
distance integral, path, or non-migrating actuator residence.

```text
bookshelf_consulted: true
source_domain: robotic-fish CPG turning and elongated-body reactive propulsion
source_mechanism: preserve a posterior-emphasized traveling bend while redistributing bounded effort between observed stroke half-cycles for turning
transferable_invariant: keep cadence, posterior lag, and mean curvature intact while a slow body-frame directional consensus gates a small joint-state-phase asymmetry
nontransferable_details: published gains, dimensional cadence, robot linkage geometry, species-specific envelopes, exact vortex phases, world coordinates, capture geometry, and task-specific routes
policy_translation: use normalized signed course error only to qualify the existing odd turn request, then use normalized summed joint rate to center a bounded posterior duty factor on unity during the established approach
falsification: reject if capture or coherent wake is lost, v31 score is not reproduced, terminal alignment and yaw revert without another material benefit, saturation migrates upward, or reflected observations fail to produce reflected commands
```

## Lightweight validation after editing

- The mandated check-runner was invoked, but its pinned `gpt-5.4-mini` model
  is unsupported on this account. Its immutable checks were therefore run
  directly. The rendered README contained the same assigned-parent entry
  twice; removing only that duplicate made the guidance materiality check pass.
- The guidance materiality and solver editable-boundary checks pass. The
  candidate contains one definition of each public function, every direct
  `params.FIELD` reference is present in `target_policy_params()`, and no
  elapsed-time, step-count, random, file-I/O, cylinder, wake-position, or
  world-route input is used.
- Julia is not installed, so the executable include/action probe could not
  start. As a stronger available provenance check, the candidate is byte-for-
  byte identical to the sampled v31 policy that completed the contract-valid
  `18.0125T` CFD capture, with SHA-256
  `8b35036121fc14a9221cc081f234535a877aad2b6c1b0364a94ab7a5ac582a6e`.
  No CFD was run in this worker.
