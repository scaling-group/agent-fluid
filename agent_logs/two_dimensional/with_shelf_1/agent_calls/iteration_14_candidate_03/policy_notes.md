# Multi-wake candidate diagnosis and hypothesis

## Evidence read before editing

- The common prewarm sheet shows the fish held above and downstream of four
  fully developed, interacting vortex streets, with the target inside the
  merged second-row wake. It is the same initial condition for every sampled
  policy and supplies no candidate-specific advantage.
- Every sampled released sheet is a finite target reach; there is no sampled
  failure sheet. The fish make the same sharp targetward redirect, leave a
  coherent posterior trail, sustain a leftward traverse, and enter the
  `0.75L` target circle directly. Head displacement near `-10.92L` in x and
  mean fish velocity near `-0.31U`, against mean local flow near `-0.20U`,
  show self-propulsion rather than passive advection. The inherited failure
  boundary remains the bearing-trend residual that took persistent route
  authority and exited right after `18.304` with negative progress; raw-bearing
  mean steering and the state-feedback carrier must remain intact.
- The assigned actuator-local speed-release parent reaches in `34.8590`, with
  mean distance `1.62681L`, total/mean command energy `47177/1353.36`, RMS
  relative crossflow `0.24086`, and RMS force/moment `74.24/1105.81`. Its
  released sheet has the same useful topology as the other successful samples,
  so this is a quantitative allocation regression rather than a route failure.
- Two identical sampled copies of the globally coordinated speed-release
  controller reproduce the strongest result exactly: `34.7105` arrival,
  `1.62283L` mean distance, `46986/1353.65` total/mean command energy,
  `0.24023` relative crossflow, and `68.96/1036.40` RMS force/moment. The global
  controller uses the maximum normalized speed pressure of either joint to
  attenuate both joints' optional redirect burst. Against the actuator-local
  parent it improves arrival, route integral, total effort, crossflow, and
  load, although mean effort rises slightly and both variants still touch the
  joint-speed and `30.0` acceleration limits.
- The other sampled phase-correlated moment gate reaches in `34.8535` but raises
  force/moment to `82.35/1231.74`, so joint phase alone is not an unloading
  proxy. Inherited logs also report a speed-only gate regressing arrival to
  `37.262` with higher load. The supported mechanism is therefore coordinated
  release of only the surplus response burst, compatible with assisting-sign
  moment credit—not arbitrary speed gating or scalar gait tuning.

## Candidate policy hypothesis

Replace the parent's two independent speed-pressure releases with one coupled
release computed from the maximum absolute joint speed normalized by the
carrier's endogenous `omega * amplitude` scale. Apply that release only to the
optional response-gated burst on both joints. Preserve the joint-state
traveling carrier, posterior lag, raw-bearing mean steering and reserve,
course-slip correction, base half-cycle asymmetry, and assisting-sign normalized
yaw-moment credit exactly.

The controller is a deterministic replication candidate for the strongest
sampled mechanism, not a same-worker CFD improvement claim. Expected later
evidence is target capture with the same redirect/upstream topology and
retention of the sampled `34.7105/1.62283L` arrival/mean-distance and
`68.96/1036.40` load neighborhood. Falsify global coordination if capture or
coherent leftward propulsion is lost, if the sampled dominance over the local
allocator fails to reproduce, or if a changed wake phase shows that one
joint's speed repeatedly suppresses useful partner authority.

bookshelf_consulted: true
source_domain: coupled rhythmic locomotion, sensor-modulated robotic-fish control, and organized-wake adaptive swimming
source_mechanism: preserve a coordinated traveling-bend carrier while bounded observed feedback modulates surplus maneuver authority without replacing persistent route control
transferable_invariant: a multi-joint propulsive wave is a coordinated mechanism, so envelope feedback should preserve inter-joint modulation coherence unless rollout evidence supports independent actuator release
nontransferable_details: published gains, dimensional speed thresholds, robot actuator ratings, species-specific kinematics, full-body wave envelopes, clocked phases, exact vortex phases, single-cylinder synchronization, and source-task routes
policy_translation: use the maximum two-joint speed normalized by the state-feedback carrier scale to attenuate only the extra bearing-response burst on both joints; retain normalized body-frame bearing, course response, signed yaw-moment credit, mean steering, base asymmetry, and both carriers
falsification: reject if target capture or coherent upstream propulsion is lost, if the repeated sampled route-effort-load result does not reproduce, or if held-out wake evidence shows coupled release unnecessarily removes useful authority from the slower joint
