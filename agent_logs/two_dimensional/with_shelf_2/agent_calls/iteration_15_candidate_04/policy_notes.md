# Multi-Wake Candidate Notes

## Evidence diagnosis

- The common held-fish prewarm sheet is byte-identical across all four sampled
  solvers. At release the fish begins above and downstream of the four-cylinder
  array while the developed, interacting vortex streets occupy the diagonal
  route to the target.
- All sampled releases are finite `target_reached` runs; this workspace contains
  no sampled failure keyframe sheet. The three strongest samples are exact
  policy and visual duplicates at score `0.165860`, arrival `45.221`, mean/final
  distance `1.71458/0.748543L`, upstream/lateral head displacement
  `-10.962/-4.568L`, and force/moment RMS `439/4345`. The only distinct sample
  follows the same visible diagonal, self-propelled trajectory and omits the
  near-target response-horizon cap; it reaches at `45.260` with score
  `0.165009`, mean distance `1.71529L`, and numerically similar aggregate
  crossflow and loads.
- The released sheets show a persistent traveling body wave and a curved
  diagonal approach into the interacting wake region, not passive downstream
  advection. The fish remains strongly undulatory at capture. Metrics agree:
  upstream travel is about `11L`, RMS relative crossflow is about `0.289`, and
  RMS moment remains high near `4.34e3`. Aggregate diagnostics do not establish
  the sign of a useful flow- or moment-cancellation residual.
- Inherited logs sharpen the useful boundary. With the same scaffold, gating
  optional positive posterior effort by yaw alone reached at `45.105` with
  lower `416/4183` force/moment RMS but worse `1.7191L` mean distance; adding
  joint-rate headroom reached at `45.260` with the best prior `1.7153L` mean
  distance. The sampled time-to-go cap then improved mean distance to
  `1.7146L` without a load benefit. This supports a new route-response test,
  not another propulsion gain, signed disturbance term, or distance gate on
  tail motion.

## Policy hypothesis

Preserve the zero-centered traveling bend, positive-closure posterior residual,
rate/yaw authority separation, and near-target horizon cap. Add one bounded
course-confirmation mechanism to the heading-response predictor: a heading
rate that appears to correct the bearing may reduce steering only while recent
body-frame bearing history does not show divergence. Wrong-sign heading
response and the full steering response to worsening course remain intact. The
mechanism is inactive on converging or steady courses, so it should retain the
sampled successful trajectory while preventing strong wake-induced yaw from
being mistaken for route correction.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop direction tracking and wake-interaction control
source_mechanism: sensor-confirmed modulation of a rhythmic controller while separating persistent route error from fast yaw disturbance
transferable_invariant: body yaw is useful steering only when normalized body-frame line-of-sight history confirms that target bearing is not diverging
nontransferable_details: published CPG gains, clock phase, robot or species kinematics, exact vortex phase, cylinder layout, and task-specific routes
policy_translation: smoothly reduce trust in only the apparently corrective heading-rate prediction as bearing times bearing-window-rate becomes positive; leave the joint-state traveling wave and noncorrective steering response unchanged
falsification: reject if capture or upstream propulsion is lost, if mean distance or arrival worsens without a material load reduction, or if force/moment load rises without correcting a visibly different divergence event

## Candidate boundary

This candidate cannot claim robustness because every sampled rollout uses the
same prewarm snapshot. It intentionally avoids signed local-flow, force, or
moment feedback because the available compact evidence supplies only aggregate
RMS values, and it does not treat the duplicate successful rollouts as distinct
wake-phase tests.
