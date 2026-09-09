# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before editing

- The four sampled shared-prewarm sheets are byte-identical. They show the fish
  held at the upper-right release pose while the four staggered cylinder wakes
  develop and merge through the target region. This is common initial-condition
  evidence, not a controller discriminator.
- Three sampled `tail_lag_gain=0.75`, `tail_damping=0.65`, uncapped-policy
  files, released sheets, and metric sets are byte-identical. Their sheets show
  a prompt left-down turn, a dense alternating propulsive trail, late entry into
  the merged wake corridor, and a collision-free target-ring crossing. Mean
  fish velocity `(-0.2853,-0.1198)` versus mean local flow
  `(-0.1687,-0.1692)` confirms active leftward swimming rather than passive
  advection. Each reaches at `38.049`, with score `0.073801`, mean distance
  `1.802L`, energy/power `52895/3965`, relative-crossflow RMS `0.2249`,
  force/moment RMS `42.01/653.13`, and joint peaks `0.496/0.521` rad. Both
  joints touch the episode's `31.416`-rad/time-squared acceleration envelope.
- The strongest sampled finite result changes only the posterior output ceiling
  to `1700 deg/time^2`. Its five-frame sheet preserves the same self-propelled
  turn-then-diagonal topology and enters the useful wake/target region sooner,
  with no collision, exit, or instability. Diagnostics agree: arrival improves
  to `34.331`, mean distance to `1.714L`, energy/power to `45153/3390`, and
  mean velocity to `(-0.3164,-0.1322)`. Posterior excursion also falls to
  `0.509` rad. However, the candidate's stated unloading hypothesis is
  falsified: relative crossflow rises to `0.2312` and force/moment RMS jump to
  `54.48/766.14`, even though posterior acceleration is bounded at `29.671`
  rad/time squared. The ceiling is therefore a large navigation/effort gain
  coupled to a large wake-load penalty, not a safe monotone improvement.
- No sampled rollout is a semantic failure. The assigned parent's latest
  27-degree amplitude probe is the most relevant failed envelope hypothesis:
  its six-frame sheet stays on the safe route but is visibly behind the capped
  result and reaches at `38.214`; mean distance and energy/power regress to
  `1.812L` and `53078/3978`, while loads fall to `40.03/630.70`. The inherited
  damping-`0.625` probe reaches at `37.339` but leaves a stronger disturbed
  trail and raises crossflow/load RMS to `0.2461/47.26/710.38`. Together with
  the closed lag, damping, allocation, and bearing-gain brackets, this evidence
  argues for isolating the posterior ceiling rather than combining it with a
  gait or feedback change. The compact observation JSON embeds the diagnostic
  fields; no standalone local diagnostics file, omitted shelf, neighboring
  workspace, repository history, or external research was used.

## Candidate hypothesis

Preserve the replicated `0.55`-period, 28-degree oscillator,
`tail_lag_gain=0.75`, `tail_damping=0.65`, gain-`1.7` bounded body-frame
bearing law, 12-degree steering bound, fraction-`0.35` allocation, and
observation set. Add only a candidate-owned `1750 deg/time^2` symmetric ceiling
to the raw posterior acceleration. This is the midpoint between the uncapped
episode envelope (`1800`) and the sampled `1700` policy. It tests whether the
posterior-output transition can retain part of the observed navigation/effort
gain while avoiding the full load jump; it does not assume the response is
linear or that a lower acceleration maximum mechanically implies lower load.

The later CFD rollout supports this interpolation only if it preserves the
visible self-propelled turn-then-diagonal capture, improves on the uncapped
anchor in arrival (`38.049`), mean distance (`1.802L`), or energy/power
(`52895/3965`) without materially regressing the other navigation/effort
measures, and lowers force/moment from the `1700` result's `54.48/766.14`.
Loss of capture, route change, crossflow above `0.2312`, or no navigation gain
over the uncapped anchor falsifies the interpolation. Force/moment at or above
the inherited lower-damping rejection envelope `47.26/710.38` rejects the
candidate as a durable improvement even if scalar score rises. Because the
single `1700` result is unreplicated and the certified episode is nonlinear,
this one midpoint test cannot establish monotonic cap response or robustness to
held-out wake phase, geometry, or start pose.
