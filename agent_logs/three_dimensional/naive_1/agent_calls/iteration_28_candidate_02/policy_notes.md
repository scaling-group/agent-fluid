# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before editing

- All four sampled rollouts satisfy the frozen contract: direct uniform
  initialization in still water with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite moving-window transport, and `termination=capture`. Three
  samples execute the identical half-cycle envelope-redistribution policy and
  capture at `18.6505--18.8815T` with mean distance
  `2.08855--2.09222L`. The broadside-reserve sample captures at `18.7055T`,
  but its `2.09386L` mean distance does not recover the redistribution band.
  The current set therefore contains no semantic failure and does not support
  gain selection from scalar ordering.
- I inspected the combined top-down vorticity and oblique body/Lambda2 rows
  for the best-score redistribution capture and the lower-score, faster
  broadside-reserve capture. Both start from visibly quiescent water, generate
  an alternating target-bending top-down street, and retain compact paired
  caudal Lambda2 structures through first crossing. Motion is self-propelled,
  lateral oscillation remains productive, and neither sheet shows wake
  collapse, advection, collision, domain exit, or instability before capture.
- The assigned-parent notes supply the informative negative comparator that
  is not present as a failure in this sampled batch. Directly composing full
  redistribution and broadside reserve kept an energetic two-view wake but
  bent away after about `16T`, reached only `1.90495L`, and exited left at
  `31.1905T` with final distance `9.45478L`. Two later geometry handoffs
  restored capture but worsened mean distance to `2.09850L` and `2.09986L`.
  The reusable diagnosis is competition for the same two joints, not lack of
  wake production or steering gain.
- Demand remains structural in the successful carrier. Current and inherited
  trace summaries put anterior/posterior acceleration contact near
  `60.85--61.17%`/`72.97--73.27%` and rate contact near
  `10.9--11.1%`/`14.7--15.1%`; peak planar force/moment remains in the narrow
  `0.03066--0.03217`/`0.01603--0.01663` band. Replaying the current equations
  on all three identical capture traces shows that independent joint clipping
  intervenes on about `94.3%` of rows. A full common projection would be too
  disruptive (median carrier scale about `0.53`), so the hypothesis below
  tests only a bounded partial allocation and retains the exact hard envelope.

## Bookshelf transfer

```text
bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and residual control over rhythmic gait parameters
source_mechanism: preserve a coordinated propulsive oscillator while applying bounded sensor-driven steering as a separate low-dimensional residual
transferable_invariant: when propulsion and route correction share actuators, retain the target-signed steering residual while coordinating any saturation-induced reduction of the two-joint rhythmic carrier
nontransferable_details: published gains, robot geometry, dimensional cadence, prescribed clock phase, species-specific envelopes, exact vortex phase, and task-specific routes
policy_translation: keep the sampled normalized body-lateral route request, response release, displacement-only half-cycle redistribution, and posterior lag; decompose the raw two-joint command into zero-curvature carrier plus target-curvature residual, compute a shared carrier scale that leaves room for the residual inside the existing acceleration envelope, and blend only a bounded fraction toward that priority allocation
falsification: reject if capture or either coherent wake row is lost, arrival or mean distance leaves the sampled redistribution band without a distinct demand or robustness benefit, the route bends away as in the competing-modifier failure, or rate contact and planar loads worsen
```

## Single-candidate policy hypothesis

Add one steering-residual-priority actuator allocator to the proven
redistribution carrier. The existing raw command and all target geometry stay
unchanged. At each state, recompute the same envelope-modulated oscillator with
zero mean-curvature bias, treat the difference from the target-steered raw
command as the bounded steering residual, and apply one common positive scale
to the two carrier accelerations so that the residual fits within the existing
`1800 deg/T^2` envelope. Blend `15%` toward that coordinated allocation and
retain `85%` of the validated independent projection; this keeps the replayed
command change modest (about `1.56 rad/T^2` mean and below
`4.7 rad/T^2` maximum on the sampled states) while making the architectural
ablation measurable.

This is not a new route channel or scalar-only carrier retune. It adds no time,
step count, world coordinate, target identity, mutable state, wake phase,
velocity residual, broadside reserve, terminal gate, posterior-only
allocation, or joint-rate barrier. Formal CFD occurs only after this worker
exits. Credit the allocator only if capture, both wake views, and the established
route band survive and demand or repeatability changes outside the current
repeat spread.
