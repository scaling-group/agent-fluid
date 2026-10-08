# Candidate diagnosis and hypothesis

## Evidence read before the policy edit

- All four sampled rollouts are valid direct-uniform still-water evaluations:
  `U_infinity=(0,0,0)`, no prewarm, no cylinders, and capture termination.
  Consequently there is no sampled failure sheet to contrast; the most
  informative control contrast is the three replicated inherited-policy
  rollouts versus the one physically distinct yaw-response rollout.
- The inherited policy is replicated byte-for-byte in three examples. Each
  captures at `16.054512T`, crosses at `0.744345L`, has distance integral
  `1.938857L`, and follows the same wake sheet and trajectory.
- Both combined sheets show self-propulsion rather than advection: motion
  begins from quiescent fluid, a coherent alternating mid-plane wake develops
  behind the fish, and the oblique row shows compact three-dimensional
  Lambda2 structures persisting through approach. Neither sheet shows wake
  collapse or instability immediately before capture.
- The sampled yaw-response policy preserves that wake but takes a visibly
  distinct lower approach. It advances the `8/6/4/2L` crossings by
  `0.1265/0.1100/0.0935/0.1045T`, lowers distance integral from `1.938857L`
  to `1.931257L`, and improves score from `-0.055617` to `-0.048654` at the
  same 2919-step capture. Mean posterior command falls from `24.888` to
  `24.616 rad/T^2`, and full-episode posterior acceleration/speed-limit
  residence falls from `22.473/6.201%` to `21.857/5.858%`.
- The tradeoff is terminal: the yaw-response rollout first crosses at
  `0.747530L` rather than `0.744345L`, its approach-only posterior
  acceleration-limit residence is `34.054%` rather than `23.977%`, and peak
  force coefficients increase slightly even though peak moment decreases.
  This evidence supports the response mechanism as a route improvement, but
  not a claim of deeper capture or lower terminal demand.
- No inherited candidate-specific optimizer log was present in this
  workspace. The assigned parent instead records three stagnant generations
  of clamp-equivalent trajectories and directs later workers to alter feasible
  action under an evidence-conditioned gate.

## Policy hypothesis

Adopt one bounded yaw-opposition residual on the captured carrier. Predict the
repeatable beat-scale yaw from normalized anterior joint phase, subtract it
from normalized measured heading rate, and add a small posterior mean bend
only when the remaining yaw opposes a speed-reliable target redirect. Preserve
the inherited oscillator, carrier-phase redirect selector, approach law,
posterior wave allocation, and exact-boundary projection. The sampled rollout
already falsifies trajectory equivalence and supports earlier distance
milestones; the next evaluation must still reject the candidate if capture or
wake coherence is lost, if the early milestone benefit disappears, or if the
terminal limiting/load tradeoff outweighs the distance-integral gain.

```text
bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and fish turning
source_mechanism: a bounded response residual modulates mean curvature on top of a rhythmic propulsive carrier
transferable_invariant: separate repeatable carrier-scale yaw from non-carrier steering response and intervene only when the residual opposes the observed target-directed turn
nontransferable_details: published gains, clock-driven oscillator phases, species-specific kinematics, exact vortex phases, and task-specific routes
policy_translation: use normalized anterior joint position and velocity to predict carrier yaw; compare its residual with normalized body heading rate; add bounded posterior mean curvature only under body-frame target redirect and forward-speed gates
falsification: reject if capture or coherent two-view wake is lost, the 8/6/4/2L milestones cease to improve, or terminal saturation and force growth outweigh the distance-integral benefit
```
