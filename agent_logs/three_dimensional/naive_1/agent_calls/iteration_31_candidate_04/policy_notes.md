# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before candidate selection

- All four sampled solver rollouts satisfy the frozen contract: direct uniform
  initialization in still water with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite moving-window transport, and `termination=capture`. Three
  execute the identical half-cycle envelope-redistribution controller and
  capture at `18.6505--18.8815T`, with mean distance
  `2.08855--2.09222L` and score `-0.20418 to -0.20041`. The fourth adds a
  broadside reserve, captures at `18.7055T`, and has mean distance
  `2.09386L`; it does not improve the clean redistribution band.
- I inspected all four sampled combined keyframe sheets and the inherited
  allocator-failure and body-axis-compensation sheets from release through
  termination. Every sheet begins in visibly quiescent water. The sampled
  captures develop coherent alternating top-down streets that bend toward the
  target and compact paired caudal Lambda2 structures through first crossing,
  confirming self-propulsion and productive lateral motion rather than
  advection. The allocator failure retains both energetic wake views but bends
  downward after about `16T`, reaches only `2.43664L`, and exits left at
  `29.7110T`; coherence therefore does not establish route compatibility.
- The completed body-axis-compensation ablation is the new negative evidence.
  It rotates the normalized target vector by up to `7 deg` from centered
  anterior displacement to suppress a trace-correlated beat component. It
  preserves both coherent wake rows and capture, but arrives at `19.5745T`,
  worsens mean distance to `2.14814L` and score to `-0.25886`, and raises peak
  planar force/moment to `0.03296`/`0.01733`, outside the three clean samples'
  `0.03066--0.03217`/`0.01603--0.01663` bands. Its modestly lower rate contact
  (`10.68%`/`13.80%`) is not useful relief because the route integral and loads
  worsen. The strong beat-frequency correlation in raw body-frame target
  geometry was therefore diagnostic, not evidence that it was harmful noise.
- The inherited `15%` steering-residual-priority allocator supplies the
  stronger semantic boundary: it lowered acceleration contact to
  `39.23%`/`57.05%` while keeping both wake views energetic, yet lost capture
  and exited left. Together, these results reject both filtering a useful
  closed-loop phase coupling and coordinating clipping at the cost of the
  established route. The candidate retains the simpler evaluated
  redistribution controller without scalar retuning or another compound.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and asymmetric-flapping steering
source_mechanism: preserve a coordinated posterior-lagged propulsive oscillator while observed beat state and target geometry jointly place bounded steering on the useful half-cycle
transferable_invariant: beat-synchronous sensor motion can be part of useful closed-loop gait coordination; do not filter it merely because it correlates with joint phase when completed route evidence worsens after removal
nontransferable_details: published gains, dimensional cadence, robot geometry, prescribed clock phase, species-specific envelopes, exact vortex phases, and task-specific routes
policy_translation: adopt no new primitive; retain raw normalized body-lateral target feedback, non-inverting correcting-yaw release, displacement-only half-cycle steering, common-envelope redistribution, posterior lag, and exact final acceleration projection
falsification: reject this selection if an executable-equivalent repeat loses capture or either coherent wake row, confirms the inherited 0.81206L near miss, or if a distinct observation mechanism retains capture while improving the 2.08855--2.09222L mean-distance band and planar loads
```

## Single-candidate policy hypothesis

Materialize exactly one clean executable replication of the half-cycle
envelope-redistribution controller already present in `solver/`. Target
geometry owns steering sign, correcting yaw may release but never invert it,
anterior displacement supplies clock-free beat phase, and common amplitude
relief is redistributed without changing its mean. The state-feedback
oscillator, differential-curvature shares, posterior lag, and hard acceleration
projection remain unchanged.

This evidence-led rollback deliberately excludes the completed body-axis
rotation, coupled carrier allocator, scalar gain tuning, terminal schedule,
velocity or flow residual, posterior-only allocation, broadside or rearward
reserve, rate barrier, explicit time, step count, world coordinate, target
identity, mutable state, and memorized phase. Formal CFD runs only after this
worker exits. Count the result as another repeatability test of the clean
carrier, not as evidence that this worker's unevaluated candidate improved it.
