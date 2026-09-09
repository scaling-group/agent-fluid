# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

- All four sampled rollouts satisfy the frozen contract: direct uniform
  initialization in still water with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite moving-window transport, and `termination=capture`. Three
  samples have executable-identical half-cycle envelope-redistribution
  policies. They capture at `18.6505--18.8815T`, with mean distance
  `2.08855--2.09222L`; the prefilled rearward-multiplier composition captures
  at `18.9640T` and `2.09072L`, but inherited reconstruction shows its target
  remains forward, so the extra branch is inactive and proves only
  non-interference.
- I inspected the combined top-down vorticity and oblique body/Lambda2 rows
  for the best-score redistribution capture, the fastest current repeat, the
  inherited direct-composition failure, and the completed complementary
  handoff. The current captures form a coherent alternating, target-bending
  top-down street from quiescent water and retain compact caudal Lambda2
  structures through first crossing. Their translation is self-propulsion,
  not imposed-flow advection, and productive lateral oscillation survives.
- The informative inherited failure directly combines full envelope
  redistribution with broadside curvature reserve. Its energetic two-view
  wake remains coherent, but the body and street bend below and away from the
  target after about `16T`; it reaches only `1.90495L`, then exits left at
  `31.1905T` and `9.45478L`. This is a route-allocation failure rather than
  wake collapse or instability.
- Two completed arbitration attempts avoid that catastrophic overlap but do
  not recover the redistribution benefit. Releasing redistribution from the
  target axis captures at `18.7385T`, mean distance `2.09850L`; cross-fading
  only when the reserve opens captures at `19.2060T`, mean distance
  `2.09986L`. The latter preserves the target-directed street and compact
  caudal structures, so its worse arrival and integral are a controller
  result rather than loss of propulsion. It fails its stated falsification
  boundary of recovering the isolated redistribution band.
- No new rescue mechanism in the assigned parent or inherited logs survives
  the full evidence. The current three exact redistribution captures improve
  its replication basis, but one inherited executable-equivalent `0.81206L`
  near miss remains contradictory robustness evidence. It would therefore be
  unsound to claim that the near-miss topology is eliminated or to add another
  untested distance, alignment, response-release, or reserve compound.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: classical fish-swimming models and closed-loop robotic-fish CPG control
source_mechanism: preserve a posterior-lagged traveling bend and modulate one bounded gait mechanism at a time from observed geometry
transferable_invariant: retain the organized two-joint traveling wave when a new route modifier lacks semantic evidence, and remove inactive or competing feedback rather than stacking authority
nontransferable_details: published gains, dimensional cadence, species-specific envelopes, robot geometry, clock phase, exact vortex phase, and task-specific routes
policy_translation: keep normalized body-lateral target feedback, displacement-only half-cycle steering, posterior lag, common half-cycle envelope redistribution, correcting-yaw release, and acceleration projection; remove the inactive rearward route multiplier and add no new modifier
falsification: reject the retained carrier as robust if an executable-equivalent repeat again misses capture or loses either coherent wake row; reconsider a distinct mechanism only from a signal demonstrably active before that failure
```

## Single-candidate policy hypothesis

Materialize the executable-identical sampled redistribution controller as the
single candidate, removing the prefill's inactive rearward-target multiplier
and its unused forward-fraction observation. This is a mechanism-preserving
rollback supported by three current captures, not a scalar gain change. It
keeps target-owned turn sign, one-sided correcting-yaw release,
displacement-only half-cycle steering, posterior lag, common geometry-owned
mean relief with half-cycle redistribution, and exact acceleration projection.

The candidate adds no time, world coordinate, target identity, memorized
route, terminal residual, pointwise rate barrier, broadside reserve, or gait
arbitration. Formal CFD occurs only after this worker exits. Accept it as the
current reliable candidate if capture and both wake views repeat; do not call
its rare near-miss boundary resolved without independent repeated evidence.
