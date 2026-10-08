# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before editing

- The four sampled shared-prewarm sheets are byte-identical common-initial-
  condition evidence. They show the fish held at the upper-right release pose
  while the four staggered cylinder streets develop and merge through the
  target region; they do not distinguish controller quality.
- All four sampled solver candidates are byte-identical
  `tail_lag_gain=0.75`, `tail_damping=0.65` policies and produce identical
  released sheets and metrics. The fish makes an early left-down turn under a
  dense alternating tail trail, enters the merged wake corridor, and crosses
  the target ring without collision, domain exit, or instability. Mean fish
  velocity `(-0.2853,-0.1198)` versus mean local flow
  `(-0.1687,-0.1692)` confirms that the useful leftward traverse is actively
  propelled rather than passive advection. Each rollout reaches at `38.049`,
  with mean distance `1.802L`, command energy `52895.0`, power `3965.3`,
  relative-crossflow RMS `0.2249`, force/moment RMS `42.01/653.13`, and joint
  peaks `0.496/0.521` rad. The inherited independent `0.75` promotion rollout
  exactly repeats those values, so there are five distinct exact replicas at
  the certified wake phase.
- Inherited isolated lag tests bracket this anchor non-monotonically. At
  `tail_lag_gain=0.80`, the same safe route reaches at `38.362`, with mean
  distance `1.812L`, energy/power `53487/4007`, and lower loads
  `40.73/637.79`. The close `0.7675` interpolation is already worse at
  `38.412`, `1.817L`, `53566/4024`, and `42.78/659.63`. The `0.70` failed
  extrapolation is visibly behind at matched middle and late frames and
  regresses to `39.605`, `1.872L`, `55461/4197`, `0.2429` crossflow, and
  `43.11/675.66` loads. Its mean velocity weakens to
  `(-0.2744,-0.1128)`, while both current and failed cases remain finite and
  still capture.
- The `0.75` navigation/effort gain is therefore not an unloading result:
  force and moment are above the `0.80` comparator, posterior peak angle stays
  near `0.521` rad, and every tested lag value reaches both joint rate and
  acceleration caps (`4.538` and `31.416` rad-based units). The inherited
  allocation tests regress on both sides of `0.35`, the bearing-gain tests
  regress around `1.7`, and the closest lag interpolation is already negative.
  Those axes should remain fixed. The persistent posterior cap contact and
  accepted load tradeoff justify one separately bounded response-axis test,
  without adding the unscaled observations implicated in the inherited
  mixed-feedback instability.

## Candidate hypothesis

Preserve `tail_lag_gain=0.75`, the `0.55`-period 28-degree oscillator, the
gain-`1.7` bounded body-frame bearing law, 12-degree steering limit,
fraction-`0.35` allocation, and the existing observation set. Change only
`tail_damping` from `0.65` to `0.70`. This modest increase acts only on
posterior joint velocity error and tests whether the best measured phase-lag
target can be tracked with less overshoot, cap contact, and lateral load while
retaining the visible self-propelled turn and diagonal wake entry.

The later CFD rollout supports this isolated damping test only if it reaches
the target without collision, exit, or instability, preserves the same route,
and reduces posterior excursion or the `42.01/653.13` force/moment envelope
without regressing beyond the successful `0.80` navigation anchors
(`38.362`, `1.812L`, `53487`, `4007`). It is falsified if capture is lost,
arrival or mean distance crosses those bounds, cap contact is unchanged while
effort or load rises, or the fish visibly falls behind during the early turn.
Even a positive result applies only to this certified wake phase and start
pose until held-out conditions test it.
