# Step 32 multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

- All four sampled evaluations satisfy the frozen contract: direct uniform
  initialization in still water at `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite moving-window transport, and capture termination. Three run
  the exact half-cycle envelope-redistribution SHA
  `8634990cd2bf2c66c5f2ee9ee225525a5f1315d82fce65daf92ab4eacb865ac7`;
  they capture at `18.6505--18.8815T`, with mean distance
  `2.08855--2.09222L`. The rearward-route variant captures at `18.9640T` and
  `2.09072L`, but inherited reconstruction says its target remains forward,
  so it establishes only non-interference.
- I inspected every sampled combined keyframe sheet from release through
  termination. Their top-down rows grow a coherent alternating street whose
  axis bends toward the target; their oblique rows retain compact caudal
  Lambda2 structures through capture. The water is visibly quiescent at
  release, so translation is self-propelled rather than advection. There is no
  wake collapse, collision, domain exit, or instability in these sampled
  views, and the best-score and lowest-score exact-policy sheets have the same
  useful wake topology.
- Metrics agree with the images but show that the carrier remains structurally
  actuator-heavy. Across the three exact-policy captures, anterior/posterior
  acceleration contact is `60.85--61.00%`/`72.97--73.27%`, rate contact is
  `11.03--11.07%`/`14.91--15.07%`, peak planar force is
  `0.0307--0.0322`, and peak normalized moment is `0.0160--0.0166`.
  Lower contact alone is not a valid objective because the inherited `15%`
  residual-priority allocator reduced contact but lost the route.
- The inherited completed result changes the semantic conclusion. The step-31
  candidate has the exact same executable SHA as the three sampled captures,
  yet it reached only `1.25093L`, exited left at `9.94426L`, and scored
  `-10.84833`. Together with the earlier executable-equivalent `0.81206L`
  near miss and left exit, this satisfies the existing falsification boundary:
  phase-dependent envelope redistribution is a performance mechanism on some
  realizations, not a robust carrier. A separate cruise-only `6%` posterior-lag
  modulation retained capture but scored `-0.21262`, so it does not answer the
  robustness failure and is not stacked here.
- Previously completed geometry-scheduled carriers, which keep common
  target-geometry amplitude relief but do not redistribute that propulsion
  envelope by beat phase, captured in three repeats at `18.6505--18.7550T`
  with mean distance `2.09340--2.09542L`. That slightly weaker integral band
  is preferable as the next robustness control now that the lower-integral
  redistribution SHA has twice violated capture. The candidate removes one
  contradicted coupling instead of adding a recovery, terminal, velocity,
  flow, rate-barrier, posterior-allocation, or scalar-gain compound.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: robotic-fish sensor-modulated CPG control and asymmetric-flapping turning
source_mechanism: preserve a low-dimensional posterior-lagged propulsive rhythm while normalized target geometry supplies bounded steering; admit beat-phase envelope asymmetry only when it survives route evidence
transferable_invariant: propulsion and target-owned curvature should remain compatible, separable feedback roles, and a phase allocation that repeatedly changes route topology should be ablated without discarding the directed traveling bend
nontransferable_details: published gains, dimensional cadence, robot geometry, prescribed oscillator phase, species-specific envelopes, exact vortex phases, and task-specific routes
policy_translation: retain normalized body-lateral mean curvature, non-inverting correcting-yaw release, displacement-only half-cycle steering, posterior lag, and final acceleration projection; replace phase-redistributed amplitude relief with the previously capture-class common geometry-scheduled relief
falsification: reject if capture or either coherent wake row is lost, if the route develops the inherited downward/left-exit topology, or if mean distance exceeds the prior geometry-scheduled 2.09340--2.09542L band without a distinct robustness or load benefit
```

## Single-candidate policy hypothesis

Materialize exactly one geometry-scheduled envelope candidate. Target geometry
continues to own steering sign and common amplitude relief; correcting yaw may
release but never invert differential curvature; anterior displacement still
biases steering toward the useful beat half; and the posterior-lagged
state-feedback oscillator remains unchanged. The architectural ablation is
that beat phase no longer modulates the propulsion envelope. The expected test
is whether the previously repeated capture-class geometry carrier restores
semantic reliability while preserving both wake rows. Formal CFD occurs only
after this worker exits, so no outcome is claimed here.
