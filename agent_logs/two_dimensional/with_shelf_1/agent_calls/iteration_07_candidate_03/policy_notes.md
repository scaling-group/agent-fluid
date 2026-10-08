# Multi-wake candidate diagnosis and hypothesis

## Evidence read before the policy edit

- The shared prewarm sheet shows the held fish above and downstream of four
  developed, interacting vortex streets, with the target inside the merged
  second-row wake. It is identical across all samples and therefore anchors
  wake phase and layout rather than distinguishing controllers.
- The prefilled raw-bearing reserve scheduler reaches the target in `46.035`
  with mean distance `2.0695L`. Its released sheet shows a sharp initial
  clockwise redirect followed by a coherent upstream traverse. The mean fish
  velocity `x=-0.2360` versus local flow `x=-0.1454`, regular posterior wake,
  and `-10.912L` head displacement establish active propulsion rather than
  passive advection.
- Three independently written sampled policies add the same semantic change:
  normalized body-frame course slip modifies only the steering residual while
  raw bearing continues to schedule reserved authority. Their released sheets
  are byte-identical, and their physical results match exactly: target reach
  in `45.727`, mean distance `2.05427L`, command energy `57828.7/1264.65`
  total/mean, RMS relative crossflow `0.23491`, and RMS force/moment
  `49.36/799.31`. Relative to the prefill this improves arrival, mean distance,
  and force, but raises total/mean effort and yaw moment. It also increases
  maximum joint excursions from `0.606/0.546` to `0.620/0.564` rad; both
  controllers still contact both joint-speed limits and both `30.0`
  candidate-owned acceleration limits.
- Visually, the decoupled controller straightens slightly earlier after the
  initial redirect and retains the same useful long leftward trajectory. The
  exact repeatability under the common prewarm makes this a deterministic
  one-mechanism baseline, not evidence of robustness to a changed wake phase.
- No failed keyframe sheet exists among the current sampled solver examples,
  so no visual failure claim is possible. The inherited logs provide scalar
  negative evidence: replacing the validated carrier with a slower/smaller
  curvature-equilibrium carrier stayed at least `9.238L` from the target and
  became unstable after `121.517`, with RMS relative crossflow/force/moment
  `1.138/16749.8/290421`. The present carrier, posterior lag, steering sign,
  and bounded allocator must therefore remain intact.

## Candidate policy hypothesis

Use the sampled decoupled course-response controller as the evaluated anchor,
then add one new response semantic: a bounded trend of recent body-frame
bearing. Raw bearing continues to allocate finite steering authority. Course
slip removes curvature already expressed as targetward translation. The
bearing trend modifies only the residual: a trend closing an existing error
softens further turning, while a trend opening the error reinforces it. The
trend is normalized as angular change per carrier period, so it has no clock,
world-frame route, exact wake phase, or dimensional source gain.

Expected test: preserve target reach and the coherent redirect-and-upstream
trajectory while improving on the decoupled baseline's `799.31` RMS moment or
`1264.65` mean command energy without giving back its `45.727` arrival and
`2.05427L` mean-distance advantage. Falsify the mechanism if capture is lost,
the initial redirect is weakened enough to delay arrival materially, moment
or joint excursions increase without a route benefit, the lower-exit or
unstable topology returns, or a changed wake phase later loses capture. This
candidate receives CFD evaluation only after the worker exits.

bookshelf_consulted: true
source_domain: robotic-fish closed-loop CPG direction tracking and wake-interaction control
source_mechanism: sensor-conditioned response feedback modulates a bounded steering residual around a preserved rhythmic propulsive carrier
transferable_invariant: persistent body-frame direction error should retain finite steering authority while measured error improvement continuously releases redundant curvature and measured error growth restores it
nontransferable_details: published gains, robot hardware, clocked oscillator phase, species kinematics, dimensional turn rates, exact vortex phases, and source-task routes
policy_translation: preserve the evaluated joint-state carrier and raw-bearing reservation, retain normalized body-lateral course correction, and add a bounded recent-bearing trend measured per carrier period only to the two-joint steering residual
falsification: reject if target capture or coherent upstream propulsion is lost, or if arrival, mean distance, effort, moment, or joint excursions show no compensating improvement over the replicated decoupled baseline
