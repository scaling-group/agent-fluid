# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before editing

- The shared prewarm sheet is common initial-condition evidence: the fish is
  held at the upper-right release pose while the four staggered wakes develop
  into alternating streets that merge around the target. It establishes the
  wake presented at release but cannot distinguish controller quality.
- All three sampled gain-`1.7` rollouts are exact deterministic replicas. The
  released sheet shows active propulsion rather than passive advection: after
  an early heading correction, the fish leaves a dense tailbeat trail and
  traverses left-down through the developed wake into the `0.75L` target ring.
  Every replica reaches at `39.710`, with mean distance `1.874L`, relative-
  crossflow RMS `0.2265`, force/moment RMS `38.40/618.59`, power proxy
  `4092.50`, and maximum joint angles `0.507/0.528` rad. The replication
  satisfies the assigned parent's deterministic-repeat boundary, while the
  shared wake phase means it is not evidence of held-out robustness.
- Gain `1.9` and the inherited gain-`1.725` interpolation preserve the same
  visible self-propelled route and target capture, so their regressions are
  control-quality failures rather than route, collision, exit, or stability
  failures. Gain `1.9` is slightly flatter near capture and worsens arrival,
  mean distance, crossflow, force/moment, and power to `40.034`, `1.901L`,
  `0.2329`, `41.31/657.28`, and `4136.90`. Gain `1.725` is worse still at
  `40.832`, `1.915L`, `0.2364`, `42.50/674.61`, and `4263.51`. Its maximum
  joint angles rise to `0.526/0.556` rad even though every policy touches the
  same rate and acceleration caps. Thus neither a larger instantaneous gain
  nor a fitted tiny gain step is supported.
- The released sheets show that most visible course change occurs while the
  fish crosses alternating vortices, and the worse static gains increase
  crossflow/load without improving the path topology. The policy currently
  reacts only to instantaneous bearing even though the task contract exposes
  a windowed bearing rate. This supports one separately bounded temporal test:
  use target-bearing trend to reduce curvature when the bearing is already
  converging and reinforce it when bearing diverges. The inherited controller
  that simultaneously slowed propulsion and added unscaled flow/moment terms
  became unstable at `2.807`; it remains a boundary against changing the gait
  or introducing wake-force feedback in this candidate.

## Candidate hypothesis

Preserve the replicated `0.55`-period, 28-degree oscillator, gain-`1.7`
instantaneous bearing response, posterior phase lag, positive two-joint
steering distribution, and 12-degree outer curvature bound. Add a short
bearing-trend lead equal to one quarter of a control period times
`state.bearing_window_rate`, clamped to `+/-2` degrees before it is combined
with instantaneous bearing. The term is zero for steady bearing, uses only
body-frame target history, and cannot alter the bearing input by more than two
degrees; it therefore tests temporal steering without weakening propulsion or
recreating the failed mixed-signal controller.

The later CFD rollout should show whether the trend term avoids delayed
oversteer through alternating wakes, lowering arrival time, mean distance,
relative crossflow, and force/moment load below the replicated static anchor.
It is falsified by loss of capture or by material regression beyond `39.710`
arrival, `1.874L` mean distance, `0.2265` crossflow RMS, or `38.40/618.59`
force/moment RMS. If it does not improve those coupled measures, later workers
should restore the exact static gain-`1.7` anchor and avoid treating target-
bearing trend as beneficial until sampled rate traces justify a different
lookahead or bound.
