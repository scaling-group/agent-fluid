# Point-consistent countersteer half-cycle relief candidate

## Evidence-led visual diagnosis recorded before the policy edit

- All four sampled evaluations satisfy the frozen contract: direct uniform
  initialization in still water with `U_infinity=(0,0,0)`, no cylinders or
  prewarm, finite traces, and capture termination. Three samples reproduce the
  prefilled target-signed adverse-yaw allocator exactly at `16.93205T`, score
  `-0.20004481`, mean distance `2.08513L`, and crossing distance `0.74389L`.
- I inspected both rows of the combined keyframe sheets for the replicated
  reference and the course-agreeing target-ray continuation. From release
  through capture, their top-down rows show continuous target-directed motion
  with a coherent alternating red/blue street; their oblique rows retain
  compact caudal Lambda2 structures into the capture sphere. Neither shows a
  held-joint coast, passive advection, wake collapse, collision, boundary exit,
  or numerical instability. The reference trace agrees: peak fish speed is
  `1.39123U` while peak sampled local flow is only `0.03270U`.
- The target-ray continuation is an informative semantic null despite its
  slightly higher scalar score. It first departs inside `2.25L`, preserves the
  same arrival step and all whole-trace mechanical maxima, and changes the
  final distance by only `0.000052L` and mean distance by `0.000044L`. The
  visually indistinguishable route and wake do not support another additive
  terminal steering residual.
- The assigned parent's inherited log tested a different actuator channel:
  point-consistent slip reduced the posterior carrier on every gated terminal
  phase by up to 15 percent. The completed result still captured, but score
  regressed to `-0.20618842` and crossing distance deteriorated to
  `0.74984097L`, within `0.00016L` of the capture boundary. No completed visual
  sheet for that rollout is present in this workspace, so the supported
  conclusion is limited to control outcome: blanket carrier relief removes
  useful terminal work as well as competing work.

## Single-candidate policy hypothesis

Preserve the replicated reference's zero-centered anterior oscillator, lagged
posterior carrier, full body-frame velocity-course steering, posterior
acceleration reserve, C1 acceleration envelope, high-onset positive-power
speed guards, target-signed measured-yaw reallocation, receiver-speed taper,
and posterior stopping-risk projection. Add one posterior duty-ratio
mechanism: reconstruct the inherited point-consistent head-course slip from
normalized range closing and matched-window target-ray rotation, but use it
only to identify a terminal need for correction. During that need, reduce a
bounded portion of posterior carrier acceleration only when the carrier sign
opposes the existing steering acceleration. Carrier half-cycles that assist
steering, every anterior cycle, and the entire broad route remain unchanged.

This isolates whether the parent's regression came from removing useful
carrier work rather than from the slip observation itself. Expect fewer
countersteering posterior half-cycles without loss of the alternating wake,
capture margin, or broad-route equivalence. Require a meaningful improvement
over the replicated reference's `-0.20004481/2.08513L/0.74389L`, or a clear
mechanical benefit at equivalent distance quality; do not accept the sampled
target-ray residual's `0.000054` score-scale change alone. Falsify the
mechanism if it loses capture, repeats the parent's near-threshold crossing,
weakens the wake, changes states outside `2.25L`, touches a joint limit,
exceeds `0.5993 rad` posterior excursion or `0.0370/0.0184` force/moment, or
cannot improve on blanket terminal carrier relief.

```text
bookshelf_consulted: true
source_domain: robotic-fish CPG turning and asymmetric flapping
source_mechanism: target-directed half-cycle amplitude or duty-ratio asymmetry superposed on a propulsive rhythm
transferable_invariant: allocate corrective authority to the carrier half-cycle that opposes the requested turn while preserving the assisting half-cycle and the traveling-wave scaffold
nontransferable_details: published gains, dimensional beat rates, species-specific amplitude envelopes, full-body oscillator networks, exact vortex phases, capture radius, and task-specific routes
policy_translation: infer posterior half-cycle sign from joint-state carrier acceleration; gate a bounded countersteer-only relief by normalized body-frame distance, closing speed, and matched-window head-course slip while leaving target-course steering and all downstream viability layers intact
falsification: reject if broad-route equivalence, capture, or alternating three-dimensional shedding is lost; if assisting carrier phases are altered; or if score, distance integral, crossing depth, joint viability, posterior angle, or force/moment loads regress without a new semantic benefit
```

No formal CFD is run in this worker. The candidate's rollout becomes evidence
only after this worker exits.

## Non-CFD gate-overlap check after the edit

Replaying the new observation and phase selector over the replicated
reference's 3,079 recorded states activates 184 countersteering samples from
`15.718T/2.243L` through capture, while preserving the 38 assisting samples
inside the same point-consistent slip window. The smooth active gate averages `0.396`
and reaches one; the largest pre-allocation carrier change is
`17.282 rad/T^2`, with the parameter-owned relief remaining in `[0,0.15]`.
The gate is zero over the entire broad route and all inherited allocation,
soft-envelope, speed, receiver, and stopping-risk projections remain
downstream. This establishes a phase-discriminating, behaviorally non-inert
test; it does not evolve the fish or fluid or predict the unevaluated CFD
outcome.
