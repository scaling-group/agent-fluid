# Multi-Wake Target-Policy Candidate Notes

## Evidence diagnosis before editing

- The four current shared-prewarm sheets are byte-identical and show the fish
  held at the upper-right release pose while the four staggered cylinder wakes
  develop and merge through the target region. This is common initial-condition
  evidence and does not distinguish policies.
- All four current policies and released sheets are also byte-identical
  `tail_lag_gain=0.75`, `tail_damping=0.65`, fraction-`0.35` replicas. The fish
  promptly turns left and down, leaves a dense alternating propulsive trail,
  enters the merged wake corridor, and crosses the target ring without
  collision, exit, or instability. Mean fish velocity `(-0.2853,-0.1198)`
  versus mean local flow `(-0.1687,-0.1692)` confirms active leftward
  propulsion rather than passive advection. Every repeat reaches at `38.049`,
  with mean distance `1.802L`, command energy `52895.0`, power `3965.3`,
  relative-crossflow RMS `0.2249`, force/moment RMS `42.01/653.13`, joint
  peaks `0.496/0.521` rad, and both joints touching the rate and acceleration
  caps.
- The assigned parent's `tail_damping=0.675` rollout is the most informative
  current policy-hypothesis failure. Its keyframes preserve the same active
  turn and safe diagonal capture, but the fish is visibly behind at matched
  middle and late frames. Diagnostics agree: mean velocity weakens to
  `(-0.2611,-0.1095)`, arrival/mean distance regress to `41.591/1.901L`, and
  energy/power rise to `58328.0/4399.9`. Higher damping does lower force/moment
  RMS to `40.10/637.97`, but it raises crossflow to `0.2279` and, contrary to
  its hypothesis, raises anterior/posterior peaks to `0.508/0.551` rad while
  both joints still touch the same caps. Thus extra posterior damping trades
  away useful traverse without arresting excursion.
- The inherited lag results close further phase-lag tuning: `0.70` regressed
  to `39.605/1.872L` with `55461/4197` energy/power and
  `0.2429/43.11/675.66` crossflow/loads, while the in-bracket `0.7675` test
  regressed to `38.412/1.817L` and `53566/4024`. Allocation fractions `0.30`
  and `0.45`, steering gains `1.725` and `1.9`, and the older unscaled
  mixed-feedback controller also failed their hypotheses. Those results rule
  out combining this candidate with another lag, allocation, bearing-gain, or
  unsupported observation change.
- The compact JSON files embed the wake diagnostics used above; no standalone
  local `wake_diagnostics.json` is present. No artifact outside this Phase 2
  workspace, omitted shelf, neighboring configuration, or repository history
  was consulted.

## Candidate hypothesis

Preserve the replicated `0.55`-period, 28-degree oscillator, `tail_lag_gain`
`0.75`, gain-`1.7` bounded body-frame bearing law, 12-degree steering bound,
fraction-`0.35` allocation, and observation set. Change only `tail_damping`
from `0.65` to `0.625`, the equal-size opposite direction from the failed
`0.675` test. This `3.85%` reduction is intended to strengthen posterior
traveling-bend response and active leftward velocity without changing target
curvature, anterior propulsion, or phase-lag target. It is a one-sided bracket
test, not a claim that damping response is monotone.

The later CFD rollout supports the hypothesis only if it preserves the visible
self-propelled turn-then-diagonal capture and improves arrival below `38.049`,
mean distance below `1.802L`, or effort below `52895/3965` without a material
regression in the other navigation/effort measures. Loss of capture, a changed
route, arrival no better than the `0.80` lag comparator's `38.362`, or mean
distance above `1.812L` falsifies the navigation mechanism. Because lower
damping can amplify the posterior response, crossflow or force/moment beyond
the inherited failed-extrapolation envelope `0.2429/43.11/675.66`, posterior
excursion at or above that result's `0.570` rad, or worse cap contact rejects a
nominal speed gain. Any positive result remains specific to the certified wake
phase and start pose and does not establish robustness or justify another
damping step.
