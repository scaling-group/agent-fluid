# Terminal posterior counter-moment allocation candidate

## Visual diagnosis and completed evidence

- All four sampled solver rollouts and the three inherited velocity-course
  continuations report direct uniform still water with
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm. Peak local flow is only
  about `0.03U` while swimming speed reaches roughly `0.95--1.05U`, so the
  observed translation, turns, and misses are controller-generated rather
  than ambient or moving-window advection.
- The sampled `2.989L` response-released rollout is the useful finite sampled
  case. Its top-down row develops a coherent alternating vorticity street
  through `12T`, and its oblique row shows persistent three-dimensional
  Lambda2 structures. The wake thins as its path hooks away after the pass.
  The `4.859L` anterior-stiffness case is the informative visual failure: both
  rows retain alternating shedding, but peak speed falls from about `1.03U`
  to `0.95U`, raw acceleration-limit occupancy rises from roughly `34/45%`
  to `53/64%`, and the path never develops the needed target-directed course.
  This continues to rule out an anterior restoring-stiffness asymmetry.
- The inherited speed-gated target-ray/velocity-course controller changes the
  broad trajectory to a coherent self-propelled `0.857L` near-pass and a left
  exit. Its distributed-curvature continuation shifts the anterior oscillator
  center by up to `8 deg` inside `2.5L`; the two visual rows remain almost
  indistinguishable through approach, and closest distance improves only to
  `0.838L` before the same left exit. Peak anterior angle grows from `26.3`
  to `34.3 deg`, while raw acceleration-limit occupancy remains about
  `58/67%`. A separate opposite-sign anterior assist reaches only `0.866L`.
  Together with the inherited posterior-ceiling result at `0.832L`, these are
  three completed static terminal allocations with neither capture nor a new
  termination topology.
- The terminal trace separates the remaining error by joint phase. Below
  `2.5L` in the `0.857L` course baseline, the half-cycle where anterior angle
  has the same sign as the saturated turn request has mean yaw moment
  `-0.00564`, whereas the opposite half has mean `+0.00589`; the requested
  terminal yaw is positive in this rollout. At closest approach the baseline
  is already yawing the wrong way (`-0.248/T`, moment `-0.00773`), and the
  distributed bend is worse (`-0.605/T`, moment `-0.00568`). The problem is
  therefore not another missing mean-offset increment: an alternating
  counter-moment is undoing useful yaw exactly at the tight pass.

## Policy hypothesis written before the solver edit

Start from the reproduced speed-gated body-frame velocity-course controller,
not the prefilled `3.592L` approach hold. Preserve its zero-centered anterior
Van der Pol oscillator, `12 deg` posterior mean curvature, lag, damping, and
far-field mapping. Inside `2.5L`, use anterior joint angle only as observed beat
phase. Smoothly attenuate the oscillatory posterior carrier on the half-cycle
where `turn_request * phi1 > 0`, which is the evidence-calibrated
counter-moment half, while leaving the useful half-cycle and the anterior
carrier unchanged. Alignment or distance releases the allocation
continuously.

This is a posterior half-cycle amplitude allocation, not a larger static bend
or scalar-only steering change. It should preserve the established broad
approach and alternating wake, reduce terminal wrong-sign yaw impulse and
posterior acceleration effort, and move the tangent pass inside the `0.75L`
capture circle. Falsify it if the sub-`1L` approach or coherent alternating
wake is lost, the calibrated moment imbalance does not move toward the useful
sign, actuator-limit occupancy rises materially, or the rollout repeats a
left exit without a lower miss or visibly different terminal arc.

```text
bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and duty-ratio turning on a state-feedback CPG carrier
source_mechanism: allocate different posterior stroke amplitude to the useful and counter-turn half-cycles while retaining rhythmic propulsion
transferable_invariant: when a bounded mean turn is already saturated but measured yaw moment alternates between useful and counterproductive signs, use observed joint phase to reduce only the counter-moment posterior stroke and preserve the useful stroke
nontransferable_details: published asymmetry ratios and gains, robot linkage geometry, species-specific envelopes, dimensional cadence, clock phase, exact vortex phase, and task-specific routes
policy_translation: retain normalized full-quadrant target_body_L versus velocity_body_U course error; below a smooth normalized distance gate use the sign of turn_request times phi1 to attenuate only the posterior oscillatory carrier while leaving anterior state feedback and posterior mean curvature unchanged
falsification: reject if broad sub-1L approach or alternating 3D shedding degrades, terminal yaw moment does not shift toward the requested sign, acceleration or angle-limit occupancy rises, or closest distance and termination topology do not improve
```
