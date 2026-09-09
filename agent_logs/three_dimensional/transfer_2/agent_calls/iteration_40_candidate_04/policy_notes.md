# Candidate diagnosis and hypothesis

## Inherited evidence

- All four sampled L64 rollouts are valid direct-uniform still-water releases
  (`U_infinity=0`, no prewarm) and capture at `15.560--15.604T`. The score
  range is narrow (`0.08493--0.09410`), so this iteration treats the complete
  trajectory, actuator, load, and visual class as evidence rather than tuning
  to final distance alone.
- In both rows of the strongest combined sheet, the fish is self-propelled
  rather than advected: its head advances about `11.6L` toward the target while
  the top-down row develops an alternating reverse-street-like vorticity wake.
  The oblique Lambda2 row shows compact vortical structures shed behind the
  body and a smooth target-directed track, without visible out-of-plane escape
  or loss of wake coherence. The lowest-score full-demand local guard has the
  same useful wake and capture topology, not a distinct flow failure.
- The prefilled course-resolved local guard leads score (`0.09410`) and
  distance integral (`1.78768L`) and reaches `4/2/1L` at
  `11.352/13.822/15.191T`. Its cost is the longest sampled head path
  (`13.190L`). Across all four samples, anterior rate residence above 90% is
  tightly clustered at `17.31--17.45%`, versus only `6.35--6.66%` posterior.
  Mean commands remain about `16.22--16.39` and `15.02--15.16 rad/T^2`, and
  peak planar force/yaw moment remain `0.0380--0.0423/0.0183--0.0208`.
- The sampled tail-work release, shared predictive guard, and local full-demand
  guard change the score and path slightly but do not remove that role
  imbalance. This argues against another guard threshold or global carrier
  gain edit. No inherited optimizer log is present in this workspace; the
  assigned parent guidance and the four complete sampled evaluations provide
  the available evidence.

## One candidate mechanism

Keep the complete capture scaffold and the prefilled course-resolved,
joint-local carrier governor. Add a bounded rate-margin-aware allocation of the
target-conditioned mean bend: when body-frame velocity-course error is still
unresolved and the anterior joint has less normalized rate margin than the
posterior joint, move a fraction of the head-bias angle into posterior mean
curvature. This changes one architectural role allocation while leaving the
state-feedback oscillator, posterior lag, half-cycle asymmetry, approach
relief, carrier decomposition, and actuator guard unchanged.

Expected test: preserve capture and the coherent two-view wake while reducing
anterior rate residence and the prefill's path excess without delaying the
`4/2/1L` milestones or increasing load. Falsify the mechanism if the posterior
shift produces a different-sign turn, raises posterior rate contact or loads,
breaks traveling-wave coherence, lengthens the path, or loses the leader's
timing/distance-integral class.

```text
bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG direction tracking and mean-curvature turning
source_mechanism: preserve a rhythmic carrier while sensor feedback modulates bounded joint offset or wave shape for steering
transferable_invariant: keep propulsion phase structure separate from the slower target-conditioned curvature residual and allocate that residual using current actuator state
nontransferable_details: published CPG gains, robot linkage geometry, species kinematics, dimensional beat settings, exact vortex phase, and task-specific routes
policy_translation: use body-frame velocity-course residual and normalized two-joint rate-margin imbalance to shift only bounded mean bend from anterior bias to posterior curvature
falsification: reject if capture, milestone timing, distance integral, short path, rate margin, load, or either coherent wake view leaves the sampled useful class
```
