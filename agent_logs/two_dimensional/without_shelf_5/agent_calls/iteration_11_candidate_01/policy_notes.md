# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before editing

- The four sampled shared-prewarm sheets are byte-identical. They show the fish
  held at the upper-right release pose while the four staggered cylinder wakes
  develop and merge through the target region. This is common initial-condition
  evidence and does not distinguish controller quality.
- Three sampled `tail_lag_gain=0.80`, fraction-`0.35` rollouts are exact
  replicas. Their released sheets show an early left-down turn, a dense
  alternating tail trail, diagonal entry into the merged wake, and capture
  without collision, domain exit, or instability. Mean fish velocity
  `(-0.2829,-0.1181)` versus mean local flow `(-0.1703,-0.1656)` confirms that
  the leftward traverse is actively propelled rather than passive advection.
  They reach at `38.362`, with mean distance `1.812L`, command energy `53487.3`,
  power `4007.1`, relative-crossflow RMS `0.2244`, force/moment RMS
  `40.73/637.79`, and joint peaks `0.494/0.521` rad.
- The single sampled `tail_lag_gain=0.75` rollout is the strongest finite
  result. Its keyframes preserve the same early turn, wake-corridor topology,
  dense propulsive trail, and clean ring crossing; no new lateral loop or
  obstacle interaction is visible. Metrics show faster mean fish velocity
  `(-0.2853,-0.1198)`, arrival `38.049`, mean distance `1.802L`, command energy
  `52895.0`, and power `3965.3`. Thus the `6.25%` lag reduction improves
  navigation and effort modestly in the certified wake realization.
- The improvement is not a clean unloading mechanism. Relative-crossflow RMS
  rises slightly to `0.2249`, force/moment RMS rise to `42.01/653.13`, the
  anterior peak rises to `0.496` rad, the posterior peak remains `0.521` rad,
  and both joints still touch the same rate and acceleration caps. This
  directly falsifies the inherited hypothesis that lower phase lag would
  reduce posterior excursion or cap contact. The compact frames also show no
  visibly quieter tail wake.
- No assigned sampled rollout is a semantic failure. The inherited
  fraction-`0.30` result is the most informative negative comparator: it keeps
  the broad turn-then-diagonal capture route but slows to `39.286`, raises mean
  distance to `1.850L`, energy/power to `56145.5/4263.2`, crossflow and
  force/moment to `0.2447/42.06/662.67`, and posterior peak to `0.583` rad.
  Together with the inherited fraction-`0.45` and gain-`1.725`/`1.9`
  regressions, it argues against another allocation or bearing-gain step. The
  older mixed-signal controller's instability at `2.807` provides no scale
  evidence for adding velocity, force, or moment feedback.

## Candidate hypothesis

Change only `tail_lag_gain` from the prefilled `0.80` to the sampled `0.75` and
preserve the fraction-`0.35`, gain-`1.7`, 12-degree bounded body-frame bearing
law, `0.55`-period 28-degree oscillator, damping, and observation set. This is
an exact replication/promotion of the best measured policy, not a claim that
tail-lag response is monotone. It retains the measured self-propelled route
while testing whether the small navigation and effort improvement survives an
independent rollout.

The later CFD evaluation supports promotion only if it captures and remains
close to the sampled `38.049` arrival, `1.802L` mean distance, `52895` command
energy, and `3965` power. It is falsified by loss of capture, regression beyond
the replicated `0.80` anchors (`38.362`, `1.812L`, `53487`, `4007`), or a
materially different route. The `42.01/653.13` force/moment values are an
accepted measured tradeoff, not evidence of unloading; a repeat above that
load envelope rejects promotion even if arrival improves. Agreement remains
specific to the certified wake phase and start pose and does not justify a
further lag reduction without new evidence.
