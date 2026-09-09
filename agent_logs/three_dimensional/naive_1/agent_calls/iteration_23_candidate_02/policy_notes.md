# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

- All four sampled solver rollouts satisfy the frozen evidence contract:
  direct uniform still-water initialization with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite moving-window transport, and capture. I
  inspected the combined keyframe sheets, including the release-to-termination
  top-down vorticity and oblique body/Lambda2 rows, for the strongest sampled
  capture and the assigned-parent failure, then cross-checked them against
  scores, metrics, diagnostics, trajectories, executable policies, inherited
  notes, and the assigned guidance.
- The two executable-identical half-cycle envelope-redistribution samples are
  a coherent self-propelled wake class: an alternating top-down street remains
  body-attached along the target-bending path and compact caudal Lambda2
  structures persist to first crossing. They capture at
  `18.82649--18.88149T` and reproduce mean distance
  `2.088545--2.088964L`. The geometry-scheduled sample and rearward-route
  sample also capture, at mean distance `2.093400L` and `2.090724L`; the
  latter's recovery branch is inactive because its target remains ahead.
- The assigned parent attenuated only the zero-mean posterior wave by at most
  `15%` while retaining both target-signed bias shares. Its top-down street and
  oblique caudal structures remain energetic, so it is self-propelled, but the
  visible route bends upward past the target. It reaches only `3.924760L`,
  exits the upper virtual boundary at `26.21302T` and `6.740994L`, and changes
  posterior acceleration/rate contact to `65.88%`/`9.95%`. Normalized
  head-to-target reconstruction shows `|target_body_L[2]|/distance_L` first
  crosses `0.60` at `12.49601T` and `6.62834L`, then reaches about one near
  closest approach. Coherent wakes and lower rate contact therefore do not
  rescue posterior-specific wave allocation; the traveling relation itself
  is a route-critical part of this carrier.
- A completed inherited broadside-reserve rollout supplies the relevant
  positive ablation. On the geometry-scheduled carrier it strengthens only
  the existing target-signed anterior/posterior mean-curvature shares after
  normalized lateral target fraction exceeds `0.60`; it never changes the
  zero-mean wave. Reconstructing the evaluator's exact head-based observation
  shows that branch actually activates at `17.68251T`, `1.68725L`, reaches
  `0.71484`, then recenters the target and captures at `18.86499T` with mean
  distance `2.097245L`. Its `61.05%`/`72.71%` acceleration and
  `10.85%`/`14.64%` rate contact remain in the ordinary capture class. Thus an
  active broadside curvature reserve is compatible with capture and both wake
  views, though it has not established faster arrival, a lower distance
  integral, or recovery from the parent's much earlier divergence.

## Bookshelf transfer

bookshelf_consulted: true
source_domain: biological burst redirect and closed-loop robotic-fish direction tracking
source_mechanism: large observed direction error gates stronger bounded mean curvature while an organized traveling rhythm is preserved
transferable_invariant: normalized body-frame target direction may schedule a bounded target-signed curvature reserve without modifying the zero-mean propulsive wave
nontransferable_details: published gains, species-specific C-start kinematics, robot geometry, dimensional cadence, clock phase, exact vortex phase, world-frame paths, and task-specific routes
policy_translation: retain the sampled half-cycle envelope-redistribution carrier exactly; when absolute normalized lateral target direction exceeds the completed-rollout broadside sector, smoothly scale both existing curvature shares together while preserving their sign, ratio, displacement-only phase scheduling, and correcting-yaw release
falsification: reject if capture or either coherent wake row is lost, mean distance leaves the replicated redistribution band without a meaningful robustness benefit, the route develops the parent's upward/left exit, or actuator contact and planar loads materially worsen

## Single-candidate policy hypothesis

Add exactly one broadside curvature-reserve layer to the prefilled
half-cycle envelope-redistribution carrier. A smoothstep of absolute normalized
body-lateral target direction is zero through `0.60` and rises continuously to
one at broadside, multiplying both target-signed curvature shares by at most
`1.25`. The posterior displacement-plus-lag wave, common envelope
redistribution, target-owned turn sign, displacement-only phase feedback,
correcting-yaw release, damping, and final acceleration projection remain
unchanged.

This is a small compatible composition of two separately completed mechanisms,
not scalar-only gain tuning. The inherited reserve rollout provides active-gate
capture evidence, while the assigned parent makes preserving the zero-mean
posterior wave the controlling boundary. Formal CFD occurs only after this
worker exits. Accept the candidate only if it retains capture and both wake
rows; then compare its route, arrival, mean distance, demand, and loads against
the two executable-identical redistribution captures. A capture inside ordinary
variability would establish compatibility, not improved recovery.

## Implementation and non-CFD validation

The candidate adds parameter-owned `broadside_curvature_onset=0.60` and
`broadside_curvature_reserve=0.25`, using the completed lane ablation rather
than a published gain. It inserts one smooth positive curvature scale before
the unchanged target-signed bias shares; every propulsion, phase,
redistribution, release, damping, and projection expression is otherwise the
prefilled executable carrier.

The required guidance-provenance/materiality, lightweight Julia policy
contract and parameter-schema, and solver edit-boundary checks pass. A focused
Julia dry ablation confirms exact parent actions below the gate, materially
different actions above it, left/right reflection symmetry, finite outputs,
and the owned acceleration envelope. No CFD was run and no result is claimed
for this unevaluated composition.
