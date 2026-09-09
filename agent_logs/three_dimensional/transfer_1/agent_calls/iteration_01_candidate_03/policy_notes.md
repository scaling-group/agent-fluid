# Candidate wake-policy notes

## Evidence diagnosis before the edit

- Evidence scope: the assigned parent guidance is the fresh-lineage guidance,
  and there are no inherited `logs/optimize` notes. The only sampled solver is
  `solver_2ce3d25ef5a2`, so its useful finite approach segment is compared with
  its own later boundary-exit failure rather than with an unavailable successful
  rollout.
- Contract check: the observation reports direct uniform initialization with
  `U_infinity=(0,0,0)`, no cylinders, and no prewarm. The motion is therefore
  self-propulsion, not ambient advection.
- Top-down row: a strong alternating vortex street develops by `t=8T` and stays
  coherent along the trajectory. The fish initially advances left/down, but
  the path bends increasingly downward while target-relative bearing grows;
  it never executes the required recovery turn toward the target.
- Oblique Lambda2 row: compact alternating three-dimensional structures follow
  the curved path without visible wake blow-up. This agrees with the diagnostic
  `unstable=false`; the failure is controlled-trajectory topology, not numerical
  instability.
- Metric cross-check: distance falls from `12.3277L` to `6.1266L` at about
  `t=17.16T`, then rises to `10.5423L` before bottom-boundary exit at `26.13T`.
  Speed reaches `0.838L/T`. Joint speed reaches the `260 deg/T` hard limit, raw
  acceleration reaches `73.44` and `125.48 rad/T^2`, and at least one raw action
  exceeds the `1800 deg/T^2` envelope on `97.8%` of logged steps.
- Policy/code cross-check: for positive target bearing the inherited controller
  creates a positive tail-mean term but simultaneously adds a negative direct
  acceleration to both joints. These steering paths oppose each other, while
  the high-cadence carrier spends nearly the whole rollout clipped. The locally
  verified plant convention is that positive joint bias produces negative yaw,
  which is the needed response to the positive body-frame bearing seen after
  the downward drift.

## Candidate hypothesis

Replace the opposing steering paths with one bounded target-vector-to-mean-
curvature mapping. Center both joint rhythms on the same signed bias, preserve
a posterior-lag traveling bend about those centers, and choose a carrier whose
nominal head velocity and acceleration fit inside the actuator envelope. For a
positive body-frame target bearing, positive joint bias should produce negative
yaw and arrest the sampled downward-crossing topology. The edit is falsified by
the same positive-bearing/downward-exit trajectory, loss of coherent thrust,
wrong-sign yaw, or persistent velocity/acceleration clipping.

```text
bookshelf_consulted: true
source_domain: robotic-fish turning and elongated-body reactive swimming
source_mechanism: bounded mean-curvature steering superposed on a posterior-lag traveling bend
transferable_invariant: preserve a directional posterior-lag wave for thrust and map body-frame target error to a bounded average bend
nontransferable_details: published gains, species-specific envelopes, dimensional cadence, exact vortex phases, and task-specific routes
policy_translation: normalize the body-frame target vector, convert its signed bearing to one bounded same-sign equilibrium bias for both joints, and oscillate about that bias with posterior state lag
falsification: reject if positive bearing does not induce negative yaw, the rollout repeats the downward boundary exit, thrust coherence collapses, or commands remain persistently clipped
```
