# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

- All four sampled solver rollouts satisfy the frozen direct-uniform still-water
  contract, contain both required visual views, and capture. The two exact
  clean half-cycle envelope-redistribution policies capture at `18.8265T` and
  `18.8815T` with distance integrals `2.08855L` and `2.08896L`. The prefilled
  rearward-multiplier policy captures at `18.9640T` and `2.09072L`, but its
  target remains forward throughout, so its extra branch is dormant. The
  broadside-reserve sample captures earlier at `18.7055T`, but its `2.09386L`
  integral is outside the clean redistribution band.
- I inspected every sampled combined sheet from release through termination.
  The clean best-score capture and the broadside capture both begin in visibly
  quiescent water, form energetic alternating top-down vorticity streets that
  bend toward the target, and retain compact alternating caudal Lambda2
  structures in the oblique row through first crossing. Their translation is
  self-propelled rather than advected, and neither view shows wake collapse or
  instability.
- The assigned-parent broadside-reserve replication is the informative visual
  failure. It keeps the same energetic top-down street and compact 3D caudal
  packets, but its route is already more broadside by `14--16T`, stalls at
  `2.46559L` near `18.68T`, then bends away and exits left at `31.718T` with
  final distance `10.32467L`. Thus an isolated forward-qualified curvature
  reserve has one active capture and one active failure; coherent propulsion
  does not make that terminal channel robust.
- A sampled inherited `15%` steering-residual-priority allocator supplies a
  complementary negative. It also retains both wake structures yet stalls at
  `2.43664L`, exits left, and finishes at `9.22177L`. Independent clipping is
  actuator-heavy, but changing its coordination perturbed the evidenced route
  before it established demand relief. The phase-separated inherited failure
  likewise keeps its wake, misses at `0.95507L`, and confirms that removing
  displacement-phase curvature is not a safe simplification.
- Across the successful samples, exact clean redistribution is therefore the
  strongest interpretable candidate. Removing the dormant rearward multiplier
  is a structural rollback to that controller, not scalar gain tuning. It also
  removes a behind-target branch that prior evidence says activates too late
  to prevent the broadside miss.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: robotic-fish CPG control and asymmetric-flapping turning
source_mechanism: retain a coordinated posterior-lagged propulsive oscillator while target geometry supplies bounded mean curvature and observed beat side redistributes steering effort
transferable_invariant: preserve one low-dimensional traveling-wave carrier and one target-signed state-feedback allocation when extra recovery or saturation channels do not survive route evidence
nontransferable_details: published gains, dimensional cadence, robot geometry, species-specific envelopes, prescribed oscillator phase, exact vortex phase, and task-specific routes
policy_translation: remove the dormant rearward route multiplier and reproduce the sampled clean body-lateral mean-curvature, correcting-yaw release, displacement-only half-cycle steering and common-envelope redistribution controller exactly
falsification: reject the clean carrier as robust if the new executable-equivalent repeat loses capture or either coherent wake row, reproduces a terminal left-exit topology, or leaves the established 2.08855--2.09072L distance-integral band without a distinct semantic benefit
```

## Single-candidate policy hypothesis

Materialize exactly one clean half-cycle envelope-redistribution candidate by
removing `rearward_route_boost`, the unused forward-fraction observation, and
the behind-target route-argument multiplier from the prefill. Preserve every
active carrier and steering value, the target-lateral turn sign, non-inverting
correcting-yaw release, displacement-only phase estimate, common amplitude
redistribution, posterior lag, and exact final acceleration projection.

This is a reliability replication and evidence-backed removal of an inactive,
too-late mechanism. It adds no clock, world coordinate, target identity,
velocity residual, flow term, terminal schedule, broadside reserve,
posterior-only allocation, rate barrier, or saturation allocator. Formal CFD
runs only after this worker exits; this note does not claim its outcome.
