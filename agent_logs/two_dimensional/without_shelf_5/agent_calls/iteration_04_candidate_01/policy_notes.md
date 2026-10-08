# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before editing

- The shared prewarm sheet confirms the common initial condition: the fish is
  held at the upper-right release pose while four developed, interacting
  vortex streets fill the release-to-target corridor. This flow is identical
  for all candidates and is not controller credit.
- The sampled `steering_gain=1.7` and `1.9` sheets both show active
  self-propulsion rather than passive advection. Each fish leaves a dense
  tailbeat trail, makes an early corrective turn, crosses the developed wake
  diagonally, and reaches the target without collision, exit, or instability.
  The `1.7` rollout is the stronger finite anchor: it reaches at `39.710` with
  score `0.002860`, mean distance `1.874L`, relative-crossflow RMS `0.2265`,
  and force/moment RMS `38.40/618.59`.
- The three current `steering_gain=1.9` samples have identical controller
  contents and identical core outcome metrics, so they are repeat evidence for
  one result, not three gain settings. They preserve capture but reverse the
  prior `1.5 -> 1.7` improvement: versus `1.7`, arrival is 0.8 percent later
  at `40.034`, mean distance is 1.5 percent higher at `1.901L`, relative
  crossflow is 2.8 percent higher, and force/moment RMS are 7.6/6.3 percent
  higher. Mean command energy is slightly lower, but total command energy is
  higher (`54954.5` versus `54703.2`), so effort alone does not rescue `1.9`.
- The inherited `1.5` anchor reached at `41.316` with score `-0.041832` and
  mean distance `1.919L`. Holding every other policy field fixed therefore
  brackets a local interior optimum: a three-point quadratic places the score
  and mean-distance vertices at gains `1.724` and `1.725`, crossflow at
  `1.721`, and force/moment at `1.710/1.704`. These fits are interpolation
  hypotheses for this one certified wake snapshot, not robustness evidence.
- Inherited failures still bound the architecture choice: reversing curvature,
  slowing/reducing the gait, or combining velocity/moment feedback led to
  boundary exits or early instability. The new sample supplies no evidence to
  reopen those axes while a clean bearing-gain bracket remains available.

## Candidate hypothesis

Preserve the evaluated `0.55`-period, 28-degree oscillator, positive curvature
sign, two-joint steering distribution, and 12-degree bounded steering command.
Change only `steering_gain` from the prefilled `1.9` to `1.72`. This candidate
interpolates inside the capture-preserving `1.7`--`1.9` interval and is close
to the independently fitted score, distance, crossflow, and load vertices; it
does not add a new observation, route, coordinate, or wake/load channel.

The later CFD evaluation should falsify the interpolation if it loses capture,
scores no better than the evaluated `1.7`, arrives later than `39.710`, raises
mean distance above `1.874L`, or exceeds the `1.7` crossflow and force/moment
loads. If that occurs, later workers should restore `1.7` as the finite anchor
and test a smaller one-dimensional bracket instead of extrapolating the gain
or changing propulsion and steering together.
