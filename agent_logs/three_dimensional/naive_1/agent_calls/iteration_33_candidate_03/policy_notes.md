# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before candidate selection

- All four sampled rollouts satisfy the frozen experiment contract: direct
  uniform initialization in still water with `U_infinity=(0,0,0)`, no
  cylinders or prewarm, finite moving-window transport, and
  `termination=capture`. Three execute the identical clean common-envelope
  half-cycle redistribution policy. They capture at
  `18.6505--18.8815T`, hold mean distance at `2.08855--2.09222L`, and span
  score `-0.20418-- -0.20041`. The fourth adds a rearward-only multiplier,
  captures at `18.9640T`, and has mean distance `2.09072L`; inherited
  reconstruction shows that its target remains forward, so the extra branch
  is inactive rather than a demonstrated recovery mechanism.
- I inspected the combined top-down vorticity and oblique body/Lambda2 rows
  for the best clean repeat (`solver_649d7e789a5a`), the distinct rearward
  sample (`solver_bae498322681`), and the inherited allocator failure
  (`solver_e85f93889aec`) from direct release through termination. The clean
  and rearward captures begin in visibly quiescent water, self-propel along a
  smoothly target-bending path with a coherent alternating top-down street,
  and retain compact paired caudal Lambda2 structures through first crossing.
  Their lateral motion is productive; neither view shows passive advection,
  wake collapse, collision, or instability.
- The allocator failure is the informative visual counterexample. It also
  begins in quiescent water and retains an energetic two-view wake, but after
  about `16T` the top-down path bends downward, the oblique trajectory turns
  away from the target, and it exits left at `29.7110T`. Metrics agree: it
  reaches only `2.43664L` and finishes at `9.22177L`, despite reducing
  anterior/posterior acceleration contact from the clean carrier's roughly
  `60.85--61.17%`/`72.97--73.27%` to `39.23%`/`57.05%`. Lower clipping and
  wake coherence therefore do not validate an actuator allocator that changes
  the carrier/steering balance.
- The assigned-parent sequence adds a second completed negative mechanism.
  Joint-displacement target-axis compensation preserved capture and both wake
  rows but slowed arrival to `19.5745T`, worsened mean distance to `2.14814L`,
  and raised peak planar force/moment to `0.03296`/`0.01733`, outside the
  clean-repeat bands. The following completed iterations selected or restored
  the clean executable without a new success class, termination class, route
  topology, demand benefit, or lower distance band. This is the structured
  plateau trigger for consulting the bookshelf again; it is not evidence for
  scalar retuning.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: Taylor/Lighthill traveling-wave propulsion and closed-loop robotic-fish CPG asymmetric-flapping control
source_mechanism: preserve a posterior-lagged traveling bend while target geometry and observed displacement phase place bounded steering on the useful beat half
transferable_invariant: a coordinated self-propelled carrier and target-signed phase allocation that already produce repeatable capture should be preserved until one independently testable mechanism improves route semantics, robustness, or loads
nontransferable_details: published gains, dimensional cadence, species-specific kinematics and envelopes, prescribed clock phase, exact vortex phase, task coordinates, and memorized routes
policy_translation: adopt no additional primitive; retain normalized body-lateral route sign, non-inverting correcting-yaw release, displacement-only half-cycle steering, common-envelope relief redistribution, posterior lag, and exact final acceleration projection
falsification: reject this selection if an executable-equivalent rollout loses capture or either coherent wake row, leaves the 2.08855--2.09222L mean-distance band without a distinct benefit, materially worsens actuator/load contact, or confirms the inherited 0.81206L near-miss topology
```

## Single-candidate policy hypothesis

Materialize exactly one clean common-envelope half-cycle redistribution
candidate already present in `solver/`. Target geometry owns turn sign;
correcting yaw may release but never invert the request. Centered anterior
displacement supplies clock-free beat phase, the common amplitude-relief
budget is redistributed without changing its mean, and the posterior-lagged
traveling wave and exact acceleration projection remain intact.

The source shelf was consulted because completed iterations had plateaued,
but no source primitive survives the current evidence as a justified edit.
This candidate therefore adds no scalar retune, target-axis filter, actuator
allocator, terminal or recovery compound, velocity/flow/moment residual,
posterior-only allocation, rate barrier, explicit time, step count, world
coordinate, target identity, mutable state, or prescribed wake phase. Formal
CFD occurs only after this worker exits. Count its result as a robustness
replication of the selected architecture, not as same-worker improvement
evidence.
