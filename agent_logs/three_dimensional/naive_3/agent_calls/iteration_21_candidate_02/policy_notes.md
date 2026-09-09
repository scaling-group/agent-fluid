# Closure-adaptive posterior phase response

## Evidence diagnosis before editing

- All four sampled rollouts are valid direct-uniform still-water episodes. They
  remain finite and self-propelled through coherent alternating mid-plane wakes
  and compact oblique Lambda2 structures, then rotate the wake into the same
  powered lower-boundary exit. The images and the small local-flow magnitudes
  (95th percentile about `0.023 U`) rule out passive advection or a dramatic
  flow disturbance as the main cause of the miss.
- The assigned parent is the best sampled phase-lag candidate: it improves
  minimum distance from the response-brake baseline's `2.385L` to `2.326L`,
  retains the best scored mean-distance evidence, and keeps anterior/posterior
  acceleration-clamp residence near `0.749/0.355`. This supports preserving
  its carrier, brake, and posterior phase action rather than adding another
  equilibrium bend, scalar drive edit, or post-overshoot burst.
- A pre-minimum trajectory reconstruction supplies a state-based warning that
  is consistent across the samples. For the parent, median closure efficiency
  (window closing speed divided by translational speed) falls from `0.788` at
  `3--4L` to `0.332` inside `2.7L`, while normalized lateral target displacement
  rises from `0.566` to `0.854`. At minimum distance it is still traveling at
  about `0.687 U`, the lateral fraction is `0.977`, and closure efficiency is
  only `0.087`. The other three samples show the same coupled transition, so
  distance or course angle alone does not identify the forming miss as sharply.

## Policy hypothesis

Keep the parent's course-selected, joint-state phase-lag modulation unchanged
as the baseline action. Add one continuous, reflection-invariant response gate:
when normalized lateral target geometry is large *and* smoothed closure per unit
speed is poor, boost the existing posterior phase modulation toward its already
bounded maximum. Good-closing inbound motion and far-field cruise should remain
nearly unchanged. This is one mechanism change, not scalar-only gain tuning.

Expected semantic outcome: a materially smaller closest approach, capture, or
a visible return leg/new termination class without loss of the coherent wake.
Reject the mechanism if it merely shifts the same lower exit, increases clamp
residence materially, produces a tight curl, or degrades the `2.326L` closest
approach and the parent's mean-distance evidence.

```text
bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG modulation
source_mechanism: sensor feedback modulates a low-dimensional gait parameter while the rhythmic carrier continues
transferable_invariant: preserve a productive traveling-wave carrier and apply bounded gait-shape authority only when task-relative state shows that the current response is insufficient
nontransferable_details: published gains, clock phase, species kinematics, exact tail envelopes, and task-specific routes
policy_translation: combine absolute normalized body-frame lateral target displacement with smoothed closing speed normalized by body-frame speed, then use their agreement to boost the existing joint-state posterior phase-lag action
falsification: reject on lost wake coherence, materially higher actuator residence or loads, a tight curl, degraded inbound progress, or the same lower-exit topology without material improvement below 2.326L
```
