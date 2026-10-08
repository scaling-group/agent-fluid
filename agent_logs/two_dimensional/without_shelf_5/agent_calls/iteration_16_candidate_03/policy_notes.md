# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before editing

- The four current shared-prewarm sheets are byte-identical and show the fish
  held at the upper-right release pose while the staggered cylinder streets
  develop and merge through the target region. This is common initial-condition
  evidence, not a policy discriminator.
- All four current policies, released sheets, and physical metrics are exact
  `tail_lag_gain=0.75`, `tail_damping=0.65`, fraction-`0.35` replicas. From
  release, the fish turns left and down, lays down a dense alternating
  propulsive trail, enters the merged wake only late in the traverse, and
  crosses the target ring safely. Mean fish velocity `(-0.2853,-0.1198)`
  versus mean local flow `(-0.1687,-0.1692)` confirms active leftward swimming
  rather than passive advection. Every repeat reaches at `38.049`, with mean
  distance `1.802L`, energy/power `52895/3965`, relative-crossflow RMS
  `0.2249`, force/moment RMS `42.01/653.13`, joint peaks `0.496/0.521` rad,
  and both joints touching the `4.538/31.416` rate/acceleration caps.
- The inherited `tail_damping=0.70` continuation is the most informative
  failed policy hypothesis with a keyframe sheet. It preserves the safe route
  and eventual capture but is visibly behind in the middle and late frames;
  arrival/mean distance regress to `46.910/2.067L`, mean fish velocity weakens
  to `(-0.2316,-0.0967)`, and energy/power rise to `66607/5051`. Its lower
  `33.13/581.31` force/moment RMS therefore comes from trading away useful
  traverse, while its posterior peak rises to `0.569` rad and it still touches
  both actuator caps.
- The assigned-parent `tail_damping=0.625` result closes the opposite side of
  that damping test. Its five-frame sheet shows the same self-propelled route
  and an earlier `37.339` capture; leftward mean velocity and total
  energy/power improve to `-0.2908` and `52247/3947`. However, mean distance
  and score slip to `1.803L/0.07187`, the posterior peak rises from `0.521` to
  `0.565` rad, and crossflow plus force/moment RMS jump beyond the probe's
  stated rejection bounds to `0.2461` and `47.26/710.38`. Lower damping is
  thus a speed/load trade, not a durable improvement, and it also leaves the
  same acceleration cap active.
- Earlier inherited evidence already brackets steering gain, anterior
  allocation, and tail lag non-monotonically, and the unscaled mixed-feedback
  controller became unstable at `2.807`. Those axes and the observation set
  remain fixed. The compact observation JSON embeds the diagnostics used here;
  no artifact outside this Phase 2 workspace, omitted shelf, neighboring
  configuration, or repository history was consulted.

## Candidate hypothesis

Return to the replicated `tail_damping=0.65` navigation anchor and preserve
its `0.55`-period, 28-degree oscillator, lag `0.75`, gain-`1.7` bounded
body-frame bearing law, 12-degree steering bound, fraction-`0.35` allocation,
and observation set. Add one candidate-owned `1700 deg/time^2` symmetric
ceiling to the raw posterior acceleration only, leaving the anterior drive
unchanged. This is a `5.6%` reduction from the episode's repeatedly contacted
`1800 deg/time^2` hard envelope. It directly tests whether a small amount of
posterior cap relief can reduce the load/effort cost seen across the damping
bracket without changing the posterior phase target or weakening anterior
propulsion.

The later CFD rollout supports this isolated ceiling only if it preserves the
visible turn-then-diagonal capture and reduces posterior excursion,
force/moment RMS below `42.01/653.13`, or energy/power below `52895/3965`
without material navigation loss. Arrival beyond the successful lag-`0.80`
comparator's `38.362`, mean distance above `1.812L`, crossflow above `0.2249`,
loss of capture, a changed route, or any collision, exit, or instability
rejects the mechanism. Cap relief alone is not an improvement. A positive
result remains specific to the certified wake phase/start pose and would need
held-out wake phase or geometry evidence before being treated as robust.
