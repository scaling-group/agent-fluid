# Whole-wave derivative projection candidate

## Evidence diagnosis

- All four sampled evaluations satisfy the experiment contract: direct uniform
  initialization, `U_infinity=[0,0,0]`, no cylinders, finite dynamics, and
  `capture` termination.  There is no sampled crash or miss; the informative
  contrast is the strongest finite rollout against the slower replicated
  capture.
- The `solver_89695d5abf83` combined sheet shows self-propelled motion along a
  target-directed arc, a coherent alternating top-down vorticity street, and
  compact three-dimensional Lambda2 structures that remain organized through
  capture.  It reaches `0.74706 L` at `18.99699 T`, score `-0.18597`, and
  distance integral `2.07455 L`.
- The `solver_5919c09e4fe2` sheet shows the same useful wake topology and no
  visible instability, but its nearly identical route closes later at
  `19.31050 T`, score `-0.21058`, and integral `2.09959 L`.
  `solver_7316a9ac5bac` reproduces that result exactly; the distinct
  posterior-spillover implementation in `solver_a850e1367983` also produces
  the same trajectory.  This isolates the winning semantic difference as the
  whole-wave pose projection rather than spillover implementation details.
- The faster rollout does not buy progress through a larger envelope: maximum
  speed is `0.9272` versus `0.9312 L/T`, peak normalized force/moment are
  `0.03068/0.01541` versus `0.03056/0.01541`, and head/tail acceleration-limit
  residence changes only from `34.18/8.17%` to `34.97/8.51%`.  The visual and
  scalar evidence therefore support cleaner route feedback while preserving
  the carrier.
- A trajectory fit over `2 T` through capture gives approximately
  `recent_yaw_rate = route - 0.681*qdot1 - 0.162*qdot2`; after the inherited
  `+0.4*qdot1` correction, the residual remains correlated `-0.925` with
  `qdot1+qdot2`.  The pose projection is whole-wave, but its derivative
  counterpart is still head-only.  No inherited optimizer log exists in this
  workspace, so this diagnosis uses the assigned parent guidance, all sampled
  solver results, and their trajectories/diagnostics.

## Policy hypothesis

Preserve the evaluated carrier, raw-body-frame burst geometry, burst response
release, pose projection, and saturation-aware steering spillover.  For
ordinary route feedback only, augment the head-joint rate common-mode with a
conservative posterior tangent-rate term `0.16*(qdot1+qdot2)`.  Keep redirect
response on the inherited head-only corrected yaw rate so the new term cannot
reinterpret or prematurely release the proven large-error burst.  If the
remaining alternating yaw/bearing-rate contamination is causal, distance
should lead the `18.99699 T` parent in the middle or late route without losing
its coherent wake or increasing its action/load envelope materially.

```text
bookshelf_consulted: true
source_domain: classical traveling-wave swimming and sensor-modulated robotic-fish CPG control
source_mechanism: posterior-lag propulsion separates a rhythmic body-wave mode from slower feedback-controlled route curvature
transferable_invariant: do not feed the observed two-joint traveling-wave common mode back as persistent target yaw or bearing motion
nontransferable_details: published gains, species envelopes, dimensional cadence, exact vortex phase, full-body waveforms, and task-specific routes
policy_translation: use normalized body-frame route observations and observed qdot1+qdot2 to reject a bounded posterior gait-rate common mode while leaving raw-geometry redirect selection and release unchanged
falsification: reject if capture is lost or delayed, middle/late closure does not improve, the arc changes sign, the alternating wake loses coherence, or speed, limit residence, force, or moment rises without compensating progress
```

