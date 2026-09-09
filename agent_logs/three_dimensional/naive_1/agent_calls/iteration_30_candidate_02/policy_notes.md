# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

- All four sampled solver rollouts satisfy the frozen direct-uniform contract:
  `U_infinity=(0,0,0)`, no cylinders or prewarm, finite moving-window
  transport, and `termination=capture`. The three executable-identical clean
  half-cycle envelope-redistribution samples capture at
  `18.6505--18.8815T`, with score-metric mean distance
  `2.08855--2.09222L`; the rearward-multiplier variant captures at
  `18.9640T` and `2.09072L`, but inherited reconstruction says its extra
  branch remains dormant.
- I inspected the combined top-down vorticity and oblique body/Lambda2 rows
  from release through termination for the best-score current capture and the
  prefill capture, then cross-checked them against scores, metrics,
  diagnostics, trajectories, executable hashes, assigned-parent results, and
  inherited notes. Both current traces begin in visibly quiescent water,
  self-propel with an energetic alternating top-down street, bend toward the
  target, and retain compact caudal Lambda2 packets through first crossing.
  Their lateral oscillation is productive and neither view indicates
  advection, wake collapse, collision, or numerical instability.
- The assigned parent's fresh rollout is the decisive failure comparator. It
  executes the exact clean redistribution hash used by three current captures,
  retains the same energetic top-down street and compact 3D caudal wake, but
  is already more broadside by `16--18T`, reaches only `1.28476L` at
  `19.1400T`, passes below the target, and exits left at `32.7195T` with
  final distance `9.94538L`. Its acceleration contact remains actuator-heavy
  at about `64.3%/70.5%`; the failure is route semantics, not loss of
  propulsion. Together with the earlier executable-equivalent `0.81206L`
  near miss, this falsifies the lower `2.08855--2.08896L` distance-integral
  band as a robust improvement.
- The other inherited architectural changes do not repair this topology. An
  active forward-qualified broadside reserve keeps both wake views but reaches
  only `2.46559L` before a left exit; a `15%` steering-priority allocator
  lowers acceleration contact but reaches only `2.43664L`; full reserve-plus-
  redistribution composition and posterior-specific allocation also lose
  capture. The common pattern is that a coherent wake survives while competing
  phase, recovery, or actuator channels perturb the target route.
- Three earlier executable-identical common-envelope geometry-scheduled
  samples remain the cleanest reliability evidence: they capture at
  `18.6505--18.7550T` with mean distance `2.09340--2.09542L`. The candidate
  therefore removes only phase redistribution of amplitude relief and returns
  to that carrier. This is an architecture rollback selected by termination
  class and route repeatability, not scalar-only gain tuning.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG control and asymmetric-flapping turning
source_mechanism: preserve a coordinated posterior-lagged propulsive oscillator while normalized target geometry supplies bounded mean curvature and only one compatible gait-envelope modulation
transferable_invariant: when extra phase allocation has both capture and coherent-wake miss outcomes, keep the low-dimensional traveling-wave carrier and the smallest target-signed state-feedback steering structure that has repeated semantic success
nontransferable_details: published gains, dimensional cadence, robot geometry, species-specific envelopes, prescribed oscillator phase, exact vortex phase, and task-specific routes
policy_translation: restore common geometry-scheduled amplitude relief while preserving body-lateral route sign, non-inverting correcting-yaw release, displacement-only half-cycle curvature, posterior lag, and exact acceleration projection
falsification: reject the rollback if it loses capture or either coherent wake row, reproduces the broadside near-miss and left-exit topology, or fails to retain the established 18.6505--18.7550T and 2.09340--2.09542L carrier class without a distinct semantic benefit
```

## Single-candidate policy hypothesis

Materialize exactly one common-envelope geometry-scheduled candidate. Remove
`half_cycle_relief_redistribution` and make rhythmic amplitude relief depend
only on the magnitude of normalized body-lateral target geometry. Preserve the
current target-owned route sign, one-sided response release, differential mean
curvature, displacement-only half-cycle steering, state-feedback oscillator,
posterior lag, and exact final acceleration projection.

This isolates the reliability hypothesis: the extra phase-dependent envelope
allocation produced a slightly lower integral in captures but also two
executable-equivalent near-miss/exit outcomes, whereas the common-envelope
carrier has three completed captures in a narrow route band. No new terminal
stage, velocity or flow residual, broadside reserve, posterior allocation,
rate barrier, world coordinate, clock, mutable state, or scalar carrier gain
is added. Formal CFD runs only after this worker exits; this note does not
claim the new evaluation outcome.
