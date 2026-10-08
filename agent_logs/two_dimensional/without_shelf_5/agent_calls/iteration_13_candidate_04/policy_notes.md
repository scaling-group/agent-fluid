# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before editing

- The shared-prewarm sheet shows the fish held at the upper-right release pose
  while four staggered cylinder streets develop and merge through the target
  region. The current sheets are identical, so this is common initial-condition
  evidence rather than controller credit.
- Three current `tail_lag_gain=0.75`, `tail_damping=0.65` samples are exact
  finite replicas and remain the strongest evidence. Their released sheets show
  active propulsion: after the initial left-down turn, the fish leaves a dense
  alternating tail trail, enters the merged wake diagonally, and crosses the
  `0.75L` target ring without collision, exit, or instability. Mean fish
  velocity `(-0.2853,-0.1198)` versus mean local flow
  `(-0.1687,-0.1692)` confirms that the leftward traverse is self-propelled.
  Each reaches at `38.049`, with mean distance `1.802L`, command energy
  `52895.0`, power `3965.3`, relative-crossflow RMS `0.2249`, force/moment RMS
  `42.01/653.13`, and joint peaks `0.496/0.521` rad. Both joints touch the
  rate and acceleration caps.
- The current `tail_lag_gain=0.80` comparator preserves the same safe route but
  reaches later at `38.362`, with mean distance `1.812L`, energy `53487.3`,
  and power `4007.1`. Its lower force/moment RMS `40.73/637.79` establishes
  that the `0.75` navigation/effort gain is a load tradeoff, not unloading.
- Two inherited, independently evaluated `tail_lag_gain=0.70` candidates give
  the same concrete negative result. Their sheets retain capture and the broad
  turn-then-diagonal topology, but the fish visibly trails the `0.75` progress
  and leaves a broader late propulsive wake. Diagnostics agree: arrival slows
  to `39.605`, mean distance rises to `1.872L`, energy/power to
  `55461.0/4196.9`, crossflow to `0.2429`, force/moment to `43.11/675.66`,
  and peaks to `0.519/0.570` rad; mean velocity weakens to
  `(-0.2744,-0.1128)`. The same actuator caps are still touched. Thus reducing
  the velocity-derived phase-lag target below `0.75` amplified rather than
  relieved posterior motion and brackets that axis between regressions at
  `0.70` and `0.80`.
- Allocation `0.30/0.45`, steering-gain `1.725/1.9`, and the inherited
  mixed-signal controller already regressed or became unstable. The evidence
  therefore does not support another allocation, gain, lag, or unscaled
  velocity/force/moment term. A separately owned existing coefficient is the
  narrowest defensible test.

## Candidate hypothesis

Preserve the replicated `0.55`-period, 28-degree gait, positive gain-`1.7`
bounded body-frame bearing law, 12-degree steering bound, fraction-`0.35`
allocation, and bracketed `tail_lag_gain=0.75`. Change only `tail_damping` from
`0.65` to `0.70`. This `7.7%` dimensionless increase acts directly against
posterior joint velocity; unlike the failed lag reduction, it does not alter
the anterior-velocity phase target or introduce a signal whose scale is
unsupported. The hypothesis is that modestly stronger posterior damping will
reduce the measured `0.521`-rad posterior overshoot, cap-driven effort, and
lateral load while retaining the established self-propelled route.

The later CFD rollout supports this candidate only if it captures, retains the
same diagonal topology, stays within the `0.80` navigation bounds (`38.362`
arrival and `1.812L` mean distance), and improves posterior peak plus at least
one effort/load measure relative to the replicated `0.75` anchor (`0.521` rad,
`52895` energy, `3965` power, `42.01/653.13` force/moment). It is falsified by
loss of capture, collision/exit/instability, slower progress than the `0.80`
comparator, unchanged posterior excursion with greater damping demand, or a
materially different route. Any positive result applies only to the certified
wake phase and start pose until held-out evidence exists.
